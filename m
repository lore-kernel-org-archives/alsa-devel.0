From: Akshu Agrawal <akshu.agrawal@amd.com>
Subject: [PATCH] ASoC: amd: Adds rate and channel constraints
	for capture in Stoney rt5645
Date: Mon, 18 Dec 2017 10:10:20 +0530
Message-ID: <1513572020-7689-1-git-send-email-akshu.agrawal@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM02-BL2-obe.outbound.protection.outlook.com
 (mail-bl2nam02on0067.outbound.protection.outlook.com [104.47.38.67])
 by alsa0.perex.cz (Postfix) with ESMTP id A317E267196
 for <alsa-devel@alsa-project.org>; Mon, 18 Dec 2017 05:44:46 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: tiwai@suse.de, Alexander.Deucher@amd.com, lgirdwood@gmail.com, Akshu Agrawal <akshu.agrawal@amd.com>
List-Id: alsa-devel@alsa-project.org

Constraints are added as we support 48Khz and dual channels.

Change-Id: Ib705f1101f5e2ab5c04f9526b10795a45a32debc
Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
---
 sound/soc/amd/acp-rt5645.c | 49 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/sound/soc/amd/acp-rt5645.c b/sound/soc/amd/acp-rt5645.c
index 941aed6..f3f96c6 100644
--- a/sound/soc/amd/acp-rt5645.c
+++ b/sound/soc/amd/acp-rt5645.c
@@ -40,6 +40,7 @@
 #include "../codecs/rt5645.h"
 
 #define CZ_PLAT_CLK 24000000
+#define DUAL_CHANNEL		2
 
 static struct snd_soc_jack cz_jack;
 
@@ -91,8 +92,50 @@ static int cz_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
-static struct snd_soc_ops cz_aif1_ops = {
+static const unsigned int channels[] = {
+	DUAL_CHANNEL,
+};
+
+static const unsigned int rates[] = {
+	48000,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_rates = {
+	.count = ARRAY_SIZE(rates),
+	.list  = rates,
+	.mask = 0,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
+	.count = ARRAY_SIZE(channels),
+	.list = channels,
+	.mask = 0,
+};
+
+static int cz_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	/*
+	 * On this platform for PCM device we support stereo
+	 */
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+				   &constraints_channels);
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+				   &constraints_rates);
+
+	return 0;
+}
+
+static struct snd_soc_ops cz_aif1_play_ops = {
+	.hw_params = cz_aif1_hw_params,
+};
+
+static struct snd_soc_ops cz_aif1_cap_ops = {
 	.hw_params = cz_aif1_hw_params,
+	.startup = cz_fe_startup,
 };
 
 static struct snd_soc_dai_link cz_dai_rt5650[] = {
@@ -106,7 +149,7 @@ static int cz_init(struct snd_soc_pcm_runtime *rtd)
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
 		.init = cz_init,
-		.ops = &cz_aif1_ops,
+		.ops = &cz_aif1_play_ops,
 	},
 	{
 		.name = "amd-rt5645-cap",
@@ -117,7 +160,7 @@ static int cz_init(struct snd_soc_pcm_runtime *rtd)
 		.codec_name = "i2c-10EC5650:00",
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF
 				| SND_SOC_DAIFMT_CBM_CFM,
-		.ops = &cz_aif1_ops,
+		.ops = &cz_aif1_cap_ops,
 	},
 };
 
-- 
1.9.1
