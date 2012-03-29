From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH 2/2] ASoC: fsl: add audio routing for
	imx-sgtl5000
Date: Fri, 30 Mar 2012 00:13:03 +0800
Message-ID: <1333037583-23582-2-git-send-email-shawn.guo@linaro.org>
References: <1333037583-23582-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B6092104524
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Mar 2012 18:13:30 +0200 (CEST)
Received: by yhnn12 with SMTP id n12so1674455yhn.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Mar 2012 09:13:30 -0700 (PDT)
In-Reply-To: <1333037583-23582-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Shawn Guo <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

Add DAPM widgets and audio routing support for imx-sgtl5000 machine
driver.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 .../bindings/sound/imx-audio-sgtl5000.txt          |   25 ++++++++++++++++++++
 sound/soc/fsl/imx-sgtl5000.c                       |   13 ++++++++++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
index 421a374..d09b4e3 100644
--- a/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/imx-audio-sgtl5000.txt
@@ -5,6 +5,27 @@ Required properties:
 - model : The user-visible name of this sound complex
 - ssi-controller : The phandle of the i.MX SSI controller
 - audio-codec : The phandle of the SGTL5000 audio codec
+- audio-routing : A list of the connections between audio components.
+  Each entry is a pair of strings, the first being the connection's sink,
+  the second being the connection's source. Valid names could be power
+  supplies, SGTL5000 pins, and the jacks on the board:
+
+  Power supplies:
+   * Mic Bias
+
+  SGTL5000 pins:
+   * MIC_IN
+   * LINE_IN
+   * HP_OUT
+   * LINE_OUT
+
+  Board connectors:
+   * Mic Jack
+   * Line In Jack
+   * Headphone Jack
+   * Line Out Jack
+   * Ext Spk
+
 - mux-int-port : The internal port of the i.MX audio muxer (AUDMUX)
 - mux-ext-port : The external port of the i.MX audio muxer
 
@@ -19,6 +40,10 @@ sound {
 	model = "imx51-babbage-sgtl5000";
 	ssi-controller = <&ssi1>;
 	audio-codec = <&sgtl5000>;
+	audio-routing =
+		"Mic Jack", "Mic Bias",
+		"MIC_IN", "Mic Bias",
+		"Headphone Jack", "HP_OUT";
 	mux-int-port = <1>;
 	mux-ext-port = <3>;
 };
diff --git a/sound/soc/fsl/imx-sgtl5000.c b/sound/soc/fsl/imx-sgtl5000.c
index 3786b61..e1a7441 100644
--- a/sound/soc/fsl/imx-sgtl5000.c
+++ b/sound/soc/fsl/imx-sgtl5000.c
@@ -45,6 +45,14 @@ static int imx_sgtl5000_dai_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static const struct snd_soc_dapm_widget imx_sgtl5000_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_LINE("Line In Jack", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Line Out Jack", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
 static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -129,8 +137,13 @@ static int __devinit imx_sgtl5000_probe(struct platform_device *pdev)
 	ret = snd_soc_of_parse_card_name(&data->card, "model");
 	if (ret)
 		return ret;
+	ret = snd_soc_of_parse_audio_routing(&data->card, "audio-routing");
+	if (ret)
+		return ret;
 	data->card.num_links = 1;
 	data->card.dai_link = &data->dai;
+	data->card.dapm_widgets = imx_sgtl5000_dapm_widgets;
+	data->card.num_dapm_widgets = ARRAY_SIZE(imx_sgtl5000_dapm_widgets);
 
 	ret = snd_soc_register_card(&data->card);
 	if (ret) {
-- 
1.7.5.4
