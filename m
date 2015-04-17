From: Inha Song <ideal.song@samsung.com>
Subject: [alsa-devel] [PATCH 2/2] mfd: arizona: Update DT binding to support
 hpdet channel
Date: Fri, 17 Apr 2015 17:32:59 +0900
Message-ID: <1429259579-16563-3-git-send-email-ideal.song@samsung.com>
References: <1429259579-16563-1-git-send-email-ideal.song@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1429259579-16563-1-git-send-email-ideal.song@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, cw00.choi@samsung.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, rf@opensource.wolfsonmicro.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, Inha Song <ideal.song@samsung.com>
List-Id: alsa-devel@alsa-project.org

This patch add device tree bindings for the pdata needed to configure
the Accessory Detect Mode select when Headphone detection.

Signed-off-by: Inha Song <ideal.song@samsung.com>
---
 Documentation/devicetree/bindings/mfd/arizona.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
index 7bd1273..e7cb939 100644
--- a/Documentation/devicetree/bindings/mfd/arizona.txt
+++ b/Documentation/devicetree/bindings/mfd/arizona.txt
@@ -49,6 +49,10 @@ Optional properties:
     input singals. If values less than the number of input signals, elements
     that has not been specifed are set to 0 by default.
 
+  - wlf,hpdet-channel : Headphone detection channel, this filed to be used the
+    ACCDET_MODE bits in the ACCESSORY_DETECT_MODE_1 register. The valid values
+    are 0 for HPDETL and 1 for HPDETR.
+
   - DCVDD-supply, MICVDD-supply : Power supplies, only need to be specified if
     they are being externally supplied. As covered in
     Documentation/devicetree/bindings/regulator/regulator.txt
-- 
2.0.0.390.gcb682f8
