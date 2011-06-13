From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Clean up some coding style nits in the
	bf5xx-i2s-pcm driver
Date: Mon, 13 Jun 2011 17:52:11 +0100
Message-ID: <1307983931-5149-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B5ABE24558
	for <alsa-devel@alsa-project.org>;
	Mon, 13 Jun 2011 18:52:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mike Frysinger <vapier@gentoo.org>, Liam Girdwood <lrg@ti.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/blackfin/bf5xx-i2s-pcm.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index a611483..819d3bd 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -169,7 +169,7 @@ static int bf5xx_pcm_open(struct snd_pcm_substream *substream)
 
 	snd_soc_set_runtime_hwparams(substream, &bf5xx_pcm_hardware);
 
-	ret = snd_pcm_hw_constraint_integer(runtime, \
+	ret = snd_pcm_hw_constraint_integer(runtime,
 			SNDRV_PCM_HW_PARAM_PERIODS);
 	if (ret < 0)
 		goto out;
@@ -307,8 +307,8 @@ static int __devexit bfin_i2s_soc_platform_remove(struct platform_device *pdev)
 
 static struct platform_driver bfin_i2s_pcm_driver = {
 	.driver = {
-			.name = "bfin-i2s-pcm-audio",
-			.owner = THIS_MODULE,
+		.name = "bfin-i2s-pcm-audio",
+		.owner = THIS_MODULE,
 	},
 
 	.probe = bfin_i2s_soc_platform_probe,
-- 
1.7.5.4
