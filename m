From: "Felipe F. Tonello" <eu@felipetonello.com>
Subject: [PATCH] ASoC: fsl-asoc-card: add cs4271 and cs4272
	support
Date: Thu, 28 Jan 2016 10:52:35 +0000
Message-ID: <1453978355-23620-1-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f49.google.com (mail-wm0-f49.google.com [74.125.82.49])
 by alsa0.perex.cz (Postfix) with ESMTP id D58E326047B
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2016 11:51:44 +0100 (CET)
Received: by mail-wm0-f49.google.com with SMTP id 128so4871969wmz.1
 for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2016 02:51:44 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

add cs4271 and cs42727 support for fsl-asoc-card

Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
---
 .../devicetree/bindings/sound/imx-audio-cs427x.txt | 47 ++++++++++++++++++++++
 sound/soc/fsl/Kconfig                              |  4 +-
 sound/soc/fsl/fsl-asoc-card.c                      |  7 ++++
 3 files changed, 56 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt b/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt
new file mode 100644
index 000000000000..295f60b19418
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/imx-audio-cs427x.txt
@@ -0,0 +1,47 @@
+Freescale i.MX audio complex with CS4271 or CS4272 codec
+
+Required properties:
+
+  - compatible		: "fsl,imx-audio-cs427x"
+
+  - model		: The user-visible name of this sound complex
+
+  - ssi-controller	: The phandle of the i.MX SSI controller
+
+  - audio-codec	: The phandle of the CS4271 audio codec
+
+  - audio-routing	: A list of the connections between audio components.
+			  Each entry is a pair of strings, the first being the
+			  connection's sink, the second being the connection's
+			  source. Valid names could be power supplies, CS427x
+			  pins, and the jacks on the board:
+
+			  Board connectors:
+			   * Mic Jack
+			   * Headphone Jack
+
+  - mux-int-port	: The internal port of the i.MX audio muxer (AUDMUX)
+
+  - mux-ext-port	: The external port of the i.MX audio muxer
+
+Note: The AUDMUX port numbering should start at 1, which is consistent with
+hardware manual.
+
+Example:
+
+sound {
+	compatible = "fsl,imx6-rex-cs427x",
+		"fsl,imx-audio-cs427x";
+	model = "audio-cs427x";
+	ssi-controller = <&ssi1>;
+	audio-codec = <&cs4271>;
+	audio-routing =
+		"Mic Jack", "AINA",
+		"Mic Jack", "AINB",
+		"Headphone Jack", "AOUTA+",
+		"Headphone Jack", "AOUTA-",
+		"Headphone Jack", "AOUTB+",
+		"Headphone Jack", "AOUTB-";
+	mux-int-port = <1>;
+	mux-ext-port = <3>;
+};
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
index 14dfdee05fd5..35aabf9dc503 100644
--- a/sound/soc/fsl/Kconfig
+++ b/sound/soc/fsl/Kconfig
@@ -292,8 +292,8 @@ config SND_SOC_FSL_ASOC_CARD
 	select SND_SOC_FSL_SSI
 	help
 	 ALSA SoC Audio support with ASRC feature for Freescale SoCs that have
-	 ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888
-	 and SGTL5000.
+	 ESAI/SAI/SSI and connect with external CODECs such as WM8962, CS42888,
+	 CS4271, CS4272 and SGTL5000.
 	 Say Y if you want to add support for Freescale Generic ASoC Sound Card.
 
 endif # SND_IMX_SOC
diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index 562b3bd22d9a..56b6b07d1922 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -28,6 +28,8 @@
 #include "../codecs/wm8962.h"
 #include "../codecs/wm8960.h"
 
+#define CS427x_SYSCLK_MCLK 0
+
 #define RX 0
 #define TX 1
 
@@ -528,6 +530,10 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->cpu_priv.sysclk_dir[RX] = SND_SOC_CLOCK_OUT;
 		priv->cpu_priv.slot_width = 32;
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBS_CFS;
+	} else if (of_device_is_compatible(np, "fsl,imx-audio-cs427x")) {
+		codec_dai_name = "cs4271-hifi";
+		priv->codec_priv.mclk_id = CS427x_SYSCLK_MCLK;
+		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
 	} else if (of_device_is_compatible(np, "fsl,imx-audio-sgtl5000")) {
 		codec_dai_name = "sgtl5000";
 		priv->codec_priv.mclk_id = SGTL5000_SYSCLK;
@@ -681,6 +687,7 @@ fail:
 static const struct of_device_id fsl_asoc_card_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-ac97", },
 	{ .compatible = "fsl,imx-audio-cs42888", },
+	{ .compatible = "fsl,imx-audio-cs427x", },
 	{ .compatible = "fsl,imx-audio-sgtl5000", },
 	{ .compatible = "fsl,imx-audio-wm8962", },
 	{ .compatible = "fsl,imx-audio-wm8960", },
-- 
2.7.0
