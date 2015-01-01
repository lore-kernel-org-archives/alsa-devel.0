From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: boardwell: Drop unnecessary
	snd_soc_dapm_enable() calls
Date: Thu,  1 Jan 2015 11:30:35 +0100
Message-ID: <1420108235-30798-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-118.synserver.de (smtp-out-118.synserver.de
 [212.40.185.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 06CED26049E
 for <alsa-devel@alsa-project.org>; Thu,  1 Jan 2015 11:30:38 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

DAPM widgets are enabled by default, there is no need to enable them unless
they have previously been explicitly disabled.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/intel/broadwell.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/intel/broadwell.c b/sound/soc/intel/broadwell.c
index 7cf95d5..9cf7d01 100644
--- a/sound/soc/intel/broadwell.c
+++ b/sound/soc/intel/broadwell.c
@@ -140,8 +140,6 @@ static struct snd_soc_ops broadwell_rt286_ops = {
 
 static int broadwell_rtd_init(struct snd_soc_pcm_runtime *rtd)
 {
-	struct snd_soc_codec *codec = rtd->codec;
-	struct snd_soc_dapm_context *dapm = &codec->dapm;
 	struct sst_pdata *pdata = dev_get_platdata(rtd->platform->dev);
 	struct sst_hsw *broadwell = pdata->dsp;
 	int ret;
@@ -155,14 +153,6 @@ static int broadwell_rtd_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	/* always connected - check HP for jack detect */
-	snd_soc_dapm_enable_pin(dapm, "Headphone Jack");
-	snd_soc_dapm_enable_pin(dapm, "Speaker");
-	snd_soc_dapm_enable_pin(dapm, "Mic Jack");
-	snd_soc_dapm_enable_pin(dapm, "Line Jack");
-	snd_soc_dapm_enable_pin(dapm, "DMIC1");
-	snd_soc_dapm_enable_pin(dapm, "DMIC2");
-
 	return 0;
 }
 
-- 
1.8.0
