From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 2/6 V2] Documentation: devicetree: arizona: Add bindings
	for WM8280
Date: Fri, 14 Nov 2014 10:04:37 +0000
Message-ID: <20141114100437.GA12913@opensource.wolfsonmicro.com>
References: <1415901046-3391-1-git-send-email-rf@opensource.wolfsonmicro.com> <1415901046-3391-3-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1415901046-3391-3-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org, lgirdwood@gmail.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, linus.walleij@linaro.org, gnurou@gmail.com, broonie@kernel.org, tiwai@suse.de
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, sameo@linux.intel.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, robh+dt@kernel.org, galak@codeaurora.org, ckeepax@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 Documentation/devicetree/bindings/mfd/arizona.txt |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
index 7bd1273..dc81b71 100644
--- a/Documentation/devicetree/bindings/mfd/arizona.txt
+++ b/Documentation/devicetree/bindings/mfd/arizona.txt
@@ -8,6 +8,7 @@ Required properties:
   - compatible : One of the following chip-specific strings:
         "wlf,wm5102"
         "wlf,wm5110"
+        "wlf,wm8280"
         "wlf,wm8997"
   - reg : I2C slave address when connected using I2C, chip select number when
     using SPI.
@@ -26,10 +27,16 @@ Required properties:
   - #gpio-cells : Must be 2. The first cell is the pin number and the
     second cell is used to specify optional parameters (currently unused).
 
-  - AVDD-supply, DBVDD1-supply, DBVDD2-supply, DBVDD3-supply (wm5102, wm5110),
-    CPVDD-supply, SPKVDDL-supply (wm5102, wm5110), SPKVDDR-supply (wm5102,
-    wm5110), SPKVDD-supply (wm8997) : Power supplies for the device, as covered
-    in Documentation/devicetree/bindings/regulator/regulator.txt
+  - AVDD-supply, DBVDD1-supply, CPVDD-supply : Power supplies for the device,
+    as covered in Documentation/devicetree/bindings/regulator/regulator.txt
+  
+  - DBVDD2-supply, DBVDD3-supply : Additional databus power supplies (wm5102,
+    wm5110, wm8280)
+
+  - SPKVDDL-supply, SPKVDDR-supply : Speaker driver power supplies (wm5102,
+    wm5110, wm8280)
+  
+  - SPKVDD-supply : Speaker driver power supply (wm8997)
 
 Optional properties:
 
-- 
1.7.2.5
