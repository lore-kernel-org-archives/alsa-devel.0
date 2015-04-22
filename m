From: Inha Song <ideal.song@samsung.com>
Subject: [alsa-devel] [PATCH v3 2/2] mfd: arizona: Update DT binding to support
 hpdet channel
Date: Wed, 22 Apr 2015 20:23:21 +0900
Message-ID: <1429701801-25287-3-git-send-email-ideal.song@samsung.com>
References: <1429701801-25287-1-git-send-email-ideal.song@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1429701801-25287-1-git-send-email-ideal.song@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: lee.jones@linaro.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, cw00.choi@samsung.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, rf@opensource.wolfsonmicro.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, Inha Song <ideal.song@samsung.com>
List-Id: alsa-devel@alsa-project.org

This patch add device tree bindings for the pdata needed to configure
the Accessory Detect Mode select when Headphone detection.

Signed-off-by: Inha Song <ideal.song@samsung.com>
---
 Documentation/devicetree/bindings/mfd/arizona.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
index 7bd1273..401b0b8 100644
--- a/Documentation/devicetree/bindings/mfd/arizona.txt
+++ b/Documentation/devicetree/bindings/mfd/arizona.txt
@@ -49,6 +49,12 @@ Optional properties:
     input singals. If values less than the number of input signals, elements
     that has not been specifed are set to 0 by default.
 
+  - wlf,hpdet-channel : Headphone detection channel.
+	1 or ARIZONA_ACCDET_MODE_HPL - Headphone detect mode is set to HPDETL
+	2 or ARIZONA_ACCDET_MODE_HPR - Headphone detect mode is set to HPDETR
+	If this node is not mentioned or if the value is unknown, then
+	headphone detection mode is set to HPDETL.
+
   - DCVDD-supply, MICVDD-supply : Power supplies, only need to be specified if
     they are being externally supplied. As covered in
     Documentation/devicetree/bindings/regulator/regulator.txt
-- 
2.0.0.390.gcb682f8
