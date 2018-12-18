From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sdm845: set jack only for a specific backend" to the asoc tree
Date: Tue, 18 Dec 2018 15:30:32 +0000 (GMT)
Message-ID: <20181218153032.AA3191125500@debutante.sirena.org.uk>
References: <1544781703-9585-1-git-send-email-rohitkr@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1544781703-9585-1-git-send-email-rohitkr@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rohit kumar <rohitkr@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, plai@codeaurora.org, bgoswami@codeaurora.org, asishb@codeaurora.org, lgirdwood@gmail.combroonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com, srinivas.kandagatla@linaro.orgalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sdm845: set jack only for a specific backend

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

>From d62805014ee8632e117fd061c18ff15ba90b9f61 Mon Sep 17 00:00:00 2001
From: Rohit kumar <rohitkr@codeaurora.org>
Date: Fri, 14 Dec 2018 15:31:43 +0530
Subject: [PATCH] ASoC: sdm845: set jack only for a specific backend

Headset codec is connected over PRIMARY_MI2S interface. Call
set_jack for codec associated with Primary Mi2s interface.
Also, set_jack to NULL when jack is freed.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/sdm845.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 1db8ef668223..6f66a58e23ca 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -158,17 +158,24 @@ static int sdm845_snd_hw_params(struct snd_pcm_substream *substream,
 	return ret;
 }
 
+static void sdm845_jack_free(struct snd_jack *jack)
+{
+	struct snd_soc_component *component = jack->private_data;
+
+	snd_soc_component_set_jack(component, NULL, NULL);
+}
+
 static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct snd_soc_component *component;
-	struct snd_soc_dai_link *dai_link = rtd->dai_link;
 	struct snd_soc_card *card = rtd->card;
+	struct snd_soc_dai *codec_dai = rtd->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct sdm845_snd_data *pdata = snd_soc_card_get_drvdata(card);
-	int i, rval;
+	struct snd_jack *jack;
+	int rval;
 
 	if (!pdata->jack_setup) {
-		struct snd_jack *jack;
-
 		rval = snd_soc_card_jack_new(card, "Headset Jack",
 				SND_JACK_HEADSET |
 				SND_JACK_HEADPHONE |
@@ -190,16 +197,22 @@ static int sdm845_dai_init(struct snd_soc_pcm_runtime *rtd)
 		pdata->jack_setup = true;
 	}
 
-	for (i = 0 ; i < dai_link->num_codecs; i++) {
-		struct snd_soc_dai *dai = rtd->codec_dais[i];
+	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX:
+		jack  = pdata->jack.jack;
+		component = codec_dai->component;
 
-		component = dai->component;
-		rval = snd_soc_component_set_jack(
-				component, &pdata->jack, NULL);
+		jack->private_data = component;
+		jack->private_free = sdm845_jack_free;
+		rval = snd_soc_component_set_jack(component,
+						  &pdata->jack, NULL);
 		if (rval != 0 && rval != -ENOTSUPP) {
 			dev_warn(card->dev, "Failed to set jack: %d\n", rval);
 			return rval;
 		}
+		break;
+	default:
+		break;
 	}
 
 	return 0;
-- 
2.19.0.rc2
