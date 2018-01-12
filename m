From: Christian Fischer <fischerc@swissphone.de>
Subject: [PATCH] ASoC: mxs-sgtl5000: add audio-routing support
Date: Fri, 12 Jan 2018 14:22:59 +0100
Message-ID: <1515763379-10182-1-git-send-email-fischerc@swissphone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail2.avectris.ch (mail2.avectris.ch [185.94.144.40])
 by alsa0.perex.cz (Postfix) with ESMTP id BD493266E07
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 14:23:12 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, tiwai@suse.com, dolinux.peng@gmail.com, lgirdwood@gmail.com, Christian Fischer <fischerc@swissphone.de>
List-Id: alsa-devel@alsa-project.org

Add dapm_widgets to machine-driver (from imx-sgtl5000).
If the "audio-routing"-property is present at probing the dapm-widgets
getting linked to the card.

Signed-off-by: Christian Fischer <fischerc@swissphone.de>
---
 .../bindings/sound/mxs-audio-sgtl5000.txt          | 33 +++++++++++++++++++---
 sound/soc/mxs/mxs-sgtl5000.c                       | 20 +++++++++++++
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt
index 601c518..4eb980b 100644
--- a/Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt
+++ b/Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt
@@ -1,10 +1,31 @@
 * Freescale MXS audio complex with SGTL5000 codec
 
 Required properties:
-- compatible: "fsl,mxs-audio-sgtl5000"
-- model: The user-visible name of this sound complex
-- saif-controllers: The phandle list of the MXS SAIF controller
-- audio-codec: The phandle of the SGTL5000 audio codec
+- compatible		: "fsl,mxs-audio-sgtl5000"
+- model			: The user-visible name of this sound complex
+- saif-controllers	: The phandle list of the MXS SAIF controller
+- audio-codec		: The phandle of the SGTL5000 audio codec
+- audio-routing		: A list of the connections between audio components.
+			  Each entry is a pair of strings, the first being the
+			  connection's sink, the second being the connection's
+			  source. Valid names could be power supplies, SGTL5000
+			  pins, and the jacks on the board:
+
+			  Power supplies:
+			   * Mic Bias
+
+			  SGTL5000 pins:
+			   * MIC_IN
+			   * LINE_IN
+			   * HP_OUT
+			   * LINE_OUT
+
+			  Board connectors:
+			   * Mic Jack
+			   * Line In Jack
+			   * Headphone Jack
+			   * Line Out Jack
+			   * Ext Spk
 
 Example:
 
@@ -14,4 +35,8 @@ sound {
 	model = "imx28-evk-sgtl5000";
 	saif-controllers = <&saif0 &saif1>;
 	audio-codec = <&sgtl5000>;
+	audio-routing =
+		"MIC_IN", "Mic Jack",
+		"Mic Jack", "Mic Bias",
+		"Headphone Jack", "HP_OUT";
 };
diff --git a/sound/soc/mxs/mxs-sgtl5000.c b/sound/soc/mxs/mxs-sgtl5000.c
index 2ed3240..b593f76 100644
--- a/sound/soc/mxs/mxs-sgtl5000.c
+++ b/sound/soc/mxs/mxs-sgtl5000.c
@@ -93,6 +93,14 @@ static struct snd_soc_dai_link mxs_sgtl5000_dai[] = {
 	},
 };
 
+static const struct snd_soc_dapm_widget mxs_sgtl5000_dapm_widgets[] = {
+	SND_SOC_DAPM_MIC("Mic Jack", NULL),
+	SND_SOC_DAPM_LINE("Line In Jack", NULL),
+	SND_SOC_DAPM_HP("Headphone Jack", NULL),
+	SND_SOC_DAPM_SPK("Line Out Jack", NULL),
+	SND_SOC_DAPM_SPK("Ext Spk", NULL),
+};
+
 static struct snd_soc_card mxs_sgtl5000 = {
 	.name		= "mxs_sgtl5000",
 	.owner		= THIS_MODULE,
@@ -141,6 +149,18 @@ static int mxs_sgtl5000_probe(struct platform_device *pdev)
 
 	card->dev = &pdev->dev;
 
+	if (of_find_property(np, "audio-routing", NULL)) {
+		card->dapm_widgets = mxs_sgtl5000_dapm_widgets;
+		card->num_dapm_widgets = ARRAY_SIZE(mxs_sgtl5000_dapm_widgets);
+
+		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
+		if (ret) {
+			dev_err(&pdev->dev, "failed to parse audio-routing (%d)\n",
+				ret);
+			return ret;
+		}
+	}
+
 	ret = devm_snd_soc_register_card(&pdev->dev, card);
 	if (ret) {
 		dev_err(&pdev->dev, "snd_soc_register_card failed (%d)\n",
-- 
2.7.4
