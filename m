From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH 2/2] dt-bindings: sound: add dmicen property in dmic driver
Date: Fri, 11 Aug 2017 15:31:29 +0800
Message-ID: <1502436689-21123-2-git-send-email-hl@rock-chips.com>
References: <1502436689-21123-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502436689-21123-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, arnaud.pouliquen@st.com, dgreif@chromium.org
Cc: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, briannorris@chromium.org, dianders@chromium.org, lgirdwood@gmail.com, Lin Huang <hl@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

there may use enable pin to control dmic start and stop,
so add this property in dt-bindings.

Signed-off-by: Lin Huang <hl@rock-chips.com>
---
 Documentation/devicetree/bindings/sound/dmic.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/dmic.txt b/Documentation/devicetree/bindings/sound/dmic.txt
index a0c58f2..54c8ef6 100644
--- a/Documentation/devicetree/bindings/sound/dmic.txt
+++ b/Documentation/devicetree/bindings/sound/dmic.txt
@@ -5,8 +5,12 @@ This device support generic PDM digital microphone.
 Required properties:
 	- compatible: should be "dmic-codec".
 
+Optional properties:
+	- dmicen-gpios: GPIO specifier for dmic to control start and stop
+
 Example node:
 
 	dmic_codec: dmic@0 {
 		compatible = "dmic-codec";
+		dmicen-gpios = <&gpio4 3 GPIO_ACTIVE_HIGH>;
 	};
-- 
2.7.4
