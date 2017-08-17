From: Lin Huang <hl@rock-chips.com>
Subject: [PATCH v2 2/2] dt-bindings: sound: add dmicen property in dmic driver
Date: Thu, 17 Aug 2017 10:24:45 +0800
Message-ID: <1502936685-24414-2-git-send-email-hl@rock-chips.com>
References: <1502936685-24414-1-git-send-email-hl@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502936685-24414-1-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, arnaud.pouliquen@st.com, dgreif@chromium.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, briannorris@chromium.org, linux-kernel@vger.kernel.org, tiwai@suse.com, mka@chromium.org, dianders@chromium.org, huang lin <hl@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

From: huang lin <hl@rock-chips.com>

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
