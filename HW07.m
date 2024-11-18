%% HW07
close all; clear; clc;

%% The step responses
p3 = [3, 5, 10, 20, 50, 10e6];
p = 5.4 + p3;
K = 15.08 + 5.4 * p3;
z = (20.48 * p3) ./ (15.08 + 5.4 * p3);

s = tf('s');
sys_numer = K .* (s + z);
sys_denom = s^3 + (1 + p) * s^2 + (p + K) * s + (K .* z);

% sys = sys_numer / sys_denom;

fig = figure(Name = "Step Response");
hold on;
for i = 1:length(p3)
    sys = sys_numer(i) / sys_denom(i);
    step(sys);
end
hold off;
lines = findobj(gcf, 'Type', 'line');
set(lines, 'LineWidth', 2);  % Set all lines to a thicker width of 2
grid on;
title("");
ylabel("The step response")
% axis([-inf, 2, -inf, inf]);
legend_labels = arrayfun(@(x) sprintf('$p\\_3=%.1f$', x), p3, 'UniformOutput', false);
lgd = legend(legend_labels, 'Interpreter', 'latex');
set(fig, "position", [200, 50, 1000, 550]);
%saveas(fig, "HW07/Fig/Step_Response.png");

fig2 = figure(Name = "Impulse Response");
hold on;
for i = 1:length(p3)
    sys = sys_numer(i) / sys_denom(i);
    impulse(sys);
end
hold off;
lines = findobj(gcf, 'Type', 'line');
set(lines, 'LineWidth', 2);  % Set all lines to a thicker width of 2
grid on;
title("");
ylabel("The impulse response")
% axis([-inf, 2, -inf, inf]);
legend_labels = arrayfun(@(x) sprintf('$p\\_3=%.1f$', x), p3, 'UniformOutput', false);
lgd = legend(legend_labels, 'Interpreter', 'latex');
set(fig2, "position", [300, 50, 1000, 550]);
%saveas(fig2, "HW07/Fig/Impulse_Response.png");

%% Final
i = 4;
sys_final = sys_numer(i) / sys_denom(i);
info = stepinfo(sys);
