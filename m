From: "Agrawal, Akshu" <Akshu.Agrawal@amd.com>
Subject: [PATCH] ASoC: AMD: Add delay before starting to capture
Date: Thu, 3 Jan 2019 10:18:13 +0000
Message-ID: <1546510559-17798-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-eopbgr750082.outbound.protection.outlook.com [40.107.75.82])
 by alsa0.perex.cz (Postfix) with ESMTP id F0414267B9A
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2019 11:18:16 +0100 (CET)
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel@alsa-project.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, "djkurtz@chromium.org" <djkurtz@chromium.org>, Mark Brown <broonie@kernel.org>, Wei Yongjun <weiyongjun1@huawei.com>, "Mukunda,
 Vijendar" <Vijendar.Mukunda@amd.com>, "Deucher,
 Alexander" <Alexander.Deucher@amd.com>, "Agrawal,
 Akshu" <Akshu.Agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

On capture through dmic we observe a glitch at the start of record.
This is because we start capturing even before dmic is ready to send
out data. The glitch seen last for ~20msec.

Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index a5daad9..72b1cf4 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -44,6 +44,8 @@
 
 #define CZ_PLAT_CLK 48000000
 #define DUAL_CHANNEL		2
+#define ADAU7002_DELAY_MS  20
+
 
 static struct snd_soc_jack cz_jack;
 static struct clk *da7219_dai_clk;
@@ -213,6 +215,7 @@ static int cz_dmic0_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_card *card = rtd->card;
 	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+	int ret;
 
 	/*
 	 * On this platform for PCM device we support stereo
@@ -225,7 +228,17 @@ static int cz_dmic0_startup(struct snd_pcm_substream *substream)
 				   &constraints_rates);
 
 	machine->cap_i2s_instance = I2S_BT_INSTANCE;
-	return da7219_clk_enable(substream);
+	ret = da7219_clk_enable(substream);
+	if (ret)
+		return ret;
+	/*
+	 * On some platforms, it takes ~20 msec for PDM DMICs and ADAU7002
+	 * to settle and start producing proper audio data.
+	 */
+	msleep(ADAU7002_DELAY_MS);
+	/* Delay in frames for 48Khz, 16bit, 2 channel */
+	runtime->delay = ADAU7002_DELAY_MS * 48;
+	return 0;
 }
 
 static int cz_dmic1_startup(struct snd_pcm_substream *substream)
@@ -234,6 +247,7 @@ static int cz_dmic1_startup(struct snd_pcm_substream *substream)
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_card *card = rtd->card;
 	struct acp_platform_info *machine = snd_soc_card_get_drvdata(card);
+	int ret;
 
 	/*
 	 * On this platform for PCM device we support stereo
@@ -247,7 +261,17 @@ static int cz_dmic1_startup(struct snd_pcm_substream *substream)
 
 	machine->cap_i2s_instance = I2S_SP_INSTANCE;
 	machine->capture_channel = CAP_CHANNEL0;
-	return da7219_clk_enable(substream);
+	ret = da7219_clk_enable(substream);
+	if (ret)
+		return ret;
+	/*
+	 * On some platforms, it takes ~20 msec for PDM DMICs and ADAU7002
+	 * to settle and start producing proper audio data.
+	 */
+	msleep(ADAU7002_DELAY_MS);
+	/* Delay in frames for 48Khz, 16bit, 2 channel */
+	runtime->delay = ADAU7002_DELAY_MS * 48;
+	return 0;
 }
 
 static void cz_dmic_shutdown(struct snd_pcm_substream *substream)
-- 
1.9.1
