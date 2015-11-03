From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v3 2/5] mfd: arizona: Update DT bindings to add CS47L24 and WM1831
Date: Tue, 3 Nov 2015 15:08:33 +0000
Message-ID: <1446563316-28878-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1446563316-28878-1-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1446563316-28878-1-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, linus.walleij@linaro.org, broonie@kernel.org
Cc: patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This updates the Arizona MFD device tree bindings to add the
Cirrus Logic CS47L24 and WM1831 codecs. Note that unlike all the
other codecs the DCVDD-supply and MICVDD-supply are mandatory.

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 Documentation/devicetree/bindings/mfd/arizona.txt | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
index 18be0cb..84e1af5 100644
--- a/Documentation/devicetree/bindings/mfd/arizona.txt
+++ b/Documentation/devicetree/bindings/mfd/arizona.txt
@@ -1,4 +1,4 @@
-Wolfson Arizona class audio SoCs
+Cirrus Logic/Wolfson Microelectronics Arizona class audio SoCs
 
 These devices are audio SoCs with extensive digital capabilites and a range
 of analogue I/O.
@@ -6,12 +6,14 @@ of analogue I/O.
 Required properties:
 
   - compatible : One of the following chip-specific strings:
+        "cirrus,cs47l24"
         "wlf,wm5102"
         "wlf,wm5110"
         "wlf,wm8280"
         "wlf,wm8997"
         "wlf,wm8998"
         "wlf,wm1814"
+        "wlf,wm1831"
 
   - reg : I2C slave address when connected using I2C, chip select number when
     using SPI.
@@ -41,6 +43,10 @@ Required properties:
 
   - SPKVDD-supply : Speaker driver power supply (wm8997)
 
+  - DCVDD-supply : Main power supply (cs47l24, wm1831)
+
+  - MICVDD-supply : Microphone power supply (cs47l24, wm1831)
+
 Optional properties:
 
   - wlf,reset : GPIO specifier for the GPIO controlling /RESET
@@ -69,6 +75,7 @@ Optional properties:
   - DCVDD-supply, MICVDD-supply : Power supplies, only need to be specified if
     they are being externally supplied. As covered in
     Documentation/devicetree/bindings/regulator/regulator.txt
+    (wm5102, wm5110, wm8280, wm8997, wm8998, wm1814)
 
 Also see child specific device properties:
   Regulator - ../regulator/arizona-regulator.txt
-- 
1.9.1
