From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 7/7] ASoC: Intel: Allow byt-5640 machine driver
	and SST core go to suspend
Date: Thu,  8 May 2014 16:07:27 +0300
Message-ID: <1399554447-16297-8-git-send-email-jarkko.nikula@linux.intel.com>
References: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 8D2222654F6
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 15:08:34 +0200 (CEST)
In-Reply-To: <1399554447-16297-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Since there is no support for compressed audio in Baytrail ADSP firmware
there is no need to leave it on during suspend since ALSA PCM buffers are
too small for leaving ADSP on for playing or recording.

Implement PM callbacks to Baytrail byt-rt5640.c machine driver that call
snd_soc_suspend and snd_soc_resume functions and unset the ignore_suspend
fields in DAI links.

This makes soc-core and ALSA core gracefully suspend and resume active
stream and call sst_byt_pcm_trigger() during suspend-resume cycle.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-rt5640.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/byt-rt5640.c b/sound/soc/intel/byt-rt5640.c
index eff97c8e5218..9061616f0f45 100644
--- a/sound/soc/intel/byt-rt5640.c
+++ b/sound/soc/intel/byt-rt5640.c
@@ -124,7 +124,6 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,
 		.init = byt_rt5640_init,
-		.ignore_suspend = 1,
 		.ops = &byt_rt5640_ops,
 	},
 	{
@@ -137,7 +136,6 @@ static struct snd_soc_dai_link byt_rt5640_dais[] = {
 		.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
 			   SND_SOC_DAIFMT_CBS_CFS,
 		.init = NULL,
-		.ignore_suspend = 1,
 		.ops = &byt_rt5640_ops,
 	},
 };
@@ -152,6 +150,17 @@ static struct snd_soc_card byt_rt5640_card = {
 	.num_dapm_routes = ARRAY_SIZE(byt_rt5640_audio_map),
 };
 
+#ifdef CONFIG_PM_SLEEP
+static const struct dev_pm_ops byt_rt5640_pm_ops = {
+	.suspend = snd_soc_suspend,
+	.resume = snd_soc_resume,
+};
+
+#define BYT_RT5640_PM_OPS	(&byt_rt5640_pm_ops)
+#else
+#define BYT_RT5640_PM_OPS	NULL
+#endif
+
 static int byt_rt5640_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card = &byt_rt5640_card;
@@ -177,6 +186,7 @@ static struct platform_driver byt_rt5640_audio = {
 	.driver = {
 		.name = "byt-rt5640",
 		.owner = THIS_MODULE,
+		.pm = BYT_RT5640_PM_OPS,
 	},
 };
 module_platform_driver(byt_rt5640_audio)
-- 
2.0.0.rc0
