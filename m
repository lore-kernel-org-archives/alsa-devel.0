From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 1/2] ASoC: Blackfin I2S: use dai state rather
	than local counter
Date: Wed, 23 Sep 2009 11:51:04 -0400
Message-ID: <1253721065-2785-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id 6121C103886
	for <alsa-devel@alsa-project.org>;
	Wed, 23 Sep 2009 17:51:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Barry Song <barry.song@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Barry Song <barry.song@analog.com>

Since the active field of the dai already tells us the stream activity,
the local counter variable is redundant and can be replaced.

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-i2s.c |   15 +--------------
 1 files changed, 1 insertions(+), 14 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 876abad..66e7333 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -49,7 +49,6 @@ struct bf5xx_i2s_port {
 	u16 rcr1;
 	u16 tcr2;
 	u16 rcr2;
-	int counter;
 	int configured;
 };
 
@@ -133,16 +132,6 @@ static int bf5xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	return ret;
 }
 
-static int bf5xx_i2s_startup(struct snd_pcm_substream *substream,
-			     struct snd_soc_dai *dai)
-{
-	pr_debug("%s enter\n", __func__);
-
-	/*this counter is used for counting how many pcm streams are opened*/
-	bf5xx_i2s.counter++;
-	return 0;
-}
-
 static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 				struct snd_pcm_hw_params *params,
 				struct snd_soc_dai *dai)
@@ -201,9 +190,8 @@ static void bf5xx_i2s_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	pr_debug("%s enter\n", __func__);
-	bf5xx_i2s.counter--;
 	/* No active stream, SPORT is allowed to be configured again. */
-	if (!bf5xx_i2s.counter)
+	if (!dai->active)
 		bf5xx_i2s.configured = 0;
 }
 
@@ -288,7 +276,6 @@ static int bf5xx_i2s_resume(struct snd_soc_dai *dai)
 	SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_ops bf5xx_i2s_dai_ops = {
-	.startup	= bf5xx_i2s_startup,
 	.shutdown	= bf5xx_i2s_shutdown,
 	.hw_params	= bf5xx_i2s_hw_params,
 	.set_fmt	= bf5xx_i2s_set_dai_fmt,
-- 
1.6.5.rc1
