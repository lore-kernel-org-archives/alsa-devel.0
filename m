From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH 1/2] ASoC: AMD: Change codec to channel link as
	per hardware redesign
Date: Thu, 21 Jun 2018 12:58:16 +0800
Message-ID: <1529557112-5525-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690078.outbound.protection.outlook.com [40.107.69.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 451DB2676B2
 for <alsa-devel@alsa-project.org>; Thu, 21 Jun 2018 06:59:18 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, djkurtz@chromium.org, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda, Vijendar" <Vijendar.Mukunda@amd.com>, Alex Deucher <alexander.deucher@amd.com>, "Agrawal,
 Akshu" <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>

This is a correction to match acutal hardware configuration.
The hardware configuration looks like:
I2S_BT -> SPK(Max) + DMIC(Adau)
I2S_SP -> DA7219 Headset

No actual products have been shipped with previous configuration.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index ccddc66..566bd26 100644
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
 
@@ -204,16 +204,27 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 
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
@@ -221,7 +232,7 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 		.name = "amd-max98357-play",
 		.stream_name = "HiFi Playback",
 		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.1.auto",
+		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "HiFi",
 		.codec_name = "MX98357A:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
@@ -233,7 +244,7 @@ static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
 		.name = "dmic",
 		.stream_name = "DMIC Capture",
 		.platform_name = "acp_audio_dma.0.auto",
-		.cpu_dai_name = "designware-i2s.2.auto",
+		.cpu_dai_name = "designware-i2s.3.auto",
 		.codec_dai_name = "adau7002-hifi",
 		.codec_name = "ADAU7002:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
-- 
1.9.1
