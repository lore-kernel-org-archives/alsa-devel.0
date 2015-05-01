From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v3 8/8] Documentation: Add WM8998/WM1814 device tree bindings
Date: Fri,  1 May 2015 16:15:19 +0100
Message-ID: <1430493319-23808-9-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, broonie@kernel.org, linus.walleij@linaro.org, gnurou@gmail.com, cw00.choi@samsung.com
Cc: myungjoo.ham@samsung.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 Documentation/devicetree/bindings/mfd/arizona.txt |   13 +++++++++----
 1 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
index 7665aa9..64fa3b2 100644
--- a/Documentation/devicetree/bindings/mfd/arizona.txt
+++ b/Documentation/devicetree/bindings/mfd/arizona.txt
@@ -10,6 +10,9 @@ Required properties:
         "wlf,wm5110"
         "wlf,wm8280"
         "wlf,wm8997"
+        "wlf,wm8998"
+        "wlf,wm1814"
+
   - reg : I2C slave address when connected using I2C, chip select number when
     using SPI.
 
@@ -31,10 +34,10 @@ Required properties:
     as covered in Documentation/devicetree/bindings/regulator/regulator.txt
 
   - DBVDD2-supply, DBVDD3-supply : Additional databus power supplies (wm5102,
-    wm5110, wm8280)
+    wm5110, wm8280, wm8998, wm1814)
 
   - SPKVDDL-supply, SPKVDDR-supply : Speaker driver power supplies (wm5102,
-    wm5110, wm8280)
+    wm5110, wm8280, wm8998, wm1814)
 
   - SPKVDD-supply : Speaker driver power supply (wm8997)
 
@@ -53,8 +56,10 @@ Optional properties:
     of input signals. Valid values are 0 (Differential), 1 (Single-ended) and
     2 (Digital Microphone). If absent, INn_MODE registers set to 0 by default.
     If present, values must be specified less than or equal to the number of
-    input singals. If values less than the number of input signals, elements
-    that has not been specifed are set to 0 by default.
+    input signals. If values less than the number of input signals, elements
+    that have not been specified are set to 0 by default. Entries are:
+    <IN1, IN2, IN3, IN4> (wm5102, wm5110, wm8280, wm8997)
+    <IN1A, IN2A, IN1B, IN2B> (wm8998, wm1814)
 
   - wlf,dmic-ref : DMIC reference voltage source for each input, can be
     selected from either MICVDD or one of the MICBIAS's, defines
-- 
1.7.2.5
