From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH 3/5] ASoC: Blackfin: tweak how we initialize
	the SPORT
Date: Tue,  2 Jun 2009 00:18:55 -0400
Message-ID: <1243916337-29953-3-git-send-email-vapier@gentoo.org>
References: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id BBD1724179
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Jun 2009 06:19:07 +0200 (CEST)
In-Reply-To: <1243916337-29953-1-git-send-email-vapier@gentoo.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Treat the configured field as a boolean rather than using a counter where
we only check one value so the process is more reliable.

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-i2s.c |   18 ++++--------------
 1 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index 9648244..1c07696 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -49,7 +49,7 @@ struct bf5xx_i2s_port {
 	u16 rcr1;
 	u16 tcr2;
 	u16 rcr2;
-	int counter;
+	int configured;
 };
 
 static struct bf5xx_i2s_port bf5xx_i2s;
@@ -132,16 +132,6 @@ static int bf5xx_i2s_set_dai_fmt(struct snd_soc_dai *cpu_dai,
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
@@ -168,7 +158,7 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	if (bf5xx_i2s.counter == 1) {
+	if (!bf5xx_i2s.configured) {
 		/*
 		 * TX and RX are not independent,they are enabled at the
 		 * same time, even if only one side is running. So, we
@@ -190,6 +180,7 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 			pr_err("SPORT is busy!\n");
 			return -EBUSY;
 		}
+		bf5xx_i2s.configured = 1;
 	}
 
 	return 0;
@@ -199,7 +190,7 @@ static void bf5xx_i2s_shutdown(struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai)
 {
 	pr_debug("%s enter\n", __func__);
-	bf5xx_i2s.counter--;
+	bf5xx_i2s.configured = 0;
 }
 
 static int bf5xx_i2s_probe(struct platform_device *pdev,
@@ -288,7 +279,6 @@ static int bf5xx_i2s_resume(struct platform_device *pdev,
 	SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_ops bf5xx_i2s_dai_ops = {
-	.startup	= bf5xx_i2s_startup,
 	.shutdown	= bf5xx_i2s_shutdown,
 	.hw_params	= bf5xx_i2s_hw_params,
 	.set_fmt	= bf5xx_i2s_set_dai_fmt,
-- 
1.6.3.1
