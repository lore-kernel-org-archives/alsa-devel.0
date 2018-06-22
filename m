From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Change codec to channel link as per hardware redesign" to the asoc tree
Date: Fri, 22 Jun 2018 15:50:30 +0100
Message-ID: <E1fWNOQ-0002et-2X@debutante>
References: <1525840011-14077-1-git-send-email-akshu.agrawal@amd.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1525840011-14077-1-git-send-email-akshu.agrawal@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Agrawal@sirena.org.uk, Akshu <Akshu.Agrawal@amd.com>
Cc: Akshu Agrawal <akshu.agrawal@amd.com>, Mark Brown <broonie@kernel.org>, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.orgMark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alexander.Deucher@amd.comakshu.agrawal@amd.comalsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Change codec to channel link as per hardware redesign

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

>From 3bec6fa3cdd338860d4b7d4110a49292646d801e Mon Sep 17 00:00:00 2001
From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Date: Thu, 21 Jun 2018 12:58:16 +0800
Subject: [PATCH] ASoC: AMD: Change codec to channel link as per hardware
 redesign

This is a correction to match acutal hardware configuration.
The hardware configuration looks like:
I2S_BT -> SPK(Max) + DMIC(Adau)
I2S_SP -> DA7219 Headset

No actual products have been shipped with previous configuration.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index ccddc6650b9c..566bd268be3a 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -148,7 +148,7 @@ static int cz_da7219_startup(struct snd_pcm_substream *substream)
 	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
 				   &constraints_rates);
 
-	machine->i2s_instance = I2S_BT_INSTANCE;
+	machine->i2s_instance = I2S_SP_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -163,7 +163,7 @@ static int cz_max_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
-	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -178,7 +178,7 @@ static int cz_dmic_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_card *card = rtd->card;
 	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
 
-	machine->i2s_instance = I2S_SP_INSTANCE;
+	machine->i2s_instance = I2S_BT_INSTANCE;
 	return da7219_clk_enable(substream);
 }
 
@@ -204,16 +204,27 @@ static const struct snd_soc_ops cz_dmic_cap_ops = {
 
 static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 	{
-		.name = "amd-da7219-play-cap",
-		.stream_name = "Playback and Capture",
+		.name = "amd-da7219-play",
+		.stream_name = "Playback",
 		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.3.auto",
+		.cpu_dai_name = "designware-i2s.1.auto",
 		.codec_dai_name = "da7219-hifi",
 		.codec_name = "i2c-DLGS7219:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.init = cz_da7219_init,
 		.dpcm_playback = 1,
+		.ops = &cz_da7219_cap_ops,
+	},
+	{
+		.name = "amd-da7219-cap",
+		.stream_name = "Capture",
+		.platform_name = "acp_audio_dma.0.auto",
+		.cpu_dai_name = "designware-i2s.2.auto",
+		.codec_dai_name = "da7219-hifi",
+		.codec_name = "i2c-DLGS7219:00",
+		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
+				| SND_SOC_DAIFMT_CBM_CFM,
 		.dpcm_capture = 1,
 		.ops = &cz_da7219_cap_ops,
 	},
@@ -221,7 +232,7 @@ static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 		.name = "amd-max98357-play",
 		.stream_name = "HiFi Playback",
 		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.1.auto",
+		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "HiFi",
 		.codec_name = "MX98357A:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
@@ -233,7 +244,7 @@ static struct snd_soc_dai_link cz_dai_7219_98357[] = {
 		.name = "dmic",
 		.stream_name = "DMIC Capture",
 		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.2.auto",
+		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "adau7002-hifi",
 		.codec_name = "ADAU7002:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-- 
2.18.0.rc2
