From: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Subject: [PATCH V2 2/6] Documentation: devicetree: arizona: Add bindings for WM8280
Date: Wed, 26 Nov 2014 15:13:04 +0000
Message-ID: <1417014788-8311-3-git-send-email-rf@opensource.wolfsonmicro.com>
References: <1417014788-8311-1-git-send-email-rf@opensource.wolfsonmicro.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1417014788-8311-1-git-send-email-rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
---
 Documentation/devicetree/bindings/mfd/arizona.txt |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
index 7bd1273..87c878b 100644
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

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
