From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: mxs-sgtl5000: add audio-routing
	support" to the asoc tree
Date: Fri, 12 Jan 2018 21:24:17 +0000
Message-ID: <E1ea6oD-0004hk-Fw@debutante>
References: <1515763379-10182-1-git-send-email-fischerc@swissphone.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D7D4266B67
 for <alsa-devel@alsa-project.org>; Fri, 12 Jan 2018 22:24:21 +0100 (CET)
In-Reply-To: <1515763379-10182-1-git-send-email-fischerc@swissphone.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Fischer <fischerc@swissphone.de>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, dolinux.peng@gmail.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: mxs-sgtl5000: add audio-routing support

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 949293d45d6b0951e2dfdfd670a9c0092b10fd27 Mon Sep 17 00:00:00 2001
From: Christian Fischer <fischerc@swissphone.de>
Date: Fri, 12 Jan 2018 14:22:59 +0100
Subject: [PATCH] ASoC: mxs-sgtl5000: add audio-routing support

Add dapm_widgets to machine-driver (from imx-sgtl5000).
If the "audio-routing"-property is present at probing the dapm-widgets
getting linked to the card.

Signed-off-by: Christian Fischer <fischerc@swissphone.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/mxs-audio-sgtl5000.txt          | 33 +++++++++++++++++++---
 sound/soc/mxs/mxs-sgtl5000.c                       | 20 +++++++++++++
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/mxs-audio-sgtl5000.txt
index 601c518eddaa..4eb980bd0287 100644
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
index 2ed3240cc682..b593f76212e0 100644
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
2.15.1
