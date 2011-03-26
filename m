From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] ASoC: Blackfin I2S: add 8-bit sample support
Date: Sat, 26 Mar 2011 03:05:08 -0400
Message-ID: <1301123108-28769-1-git-send-email-vapier@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.gentoo.org (smtp.gentoo.org [140.211.166.183])
	by alsa0.perex.cz (Postfix) with ESMTP id DA9CA1037F3
	for <alsa-devel@alsa-project.org>; Sat, 26 Mar 2011 08:04:42 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Cliff Cai <cliff.cai@analog.com>
List-Id: alsa-devel@alsa-project.org

From: Cliff Cai <cliff.cai@analog.com>

Signed-off-by: Cliff Cai <cliff.cai@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sound/soc/blackfin/bf5xx-i2s.c |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s.c b/sound/soc/blackfin/bf5xx-i2s.c
index d453b1e..37d9d3c 100644
--- a/sound/soc/blackfin/bf5xx-i2s.c
+++ b/sound/soc/blackfin/bf5xx-i2s.c
@@ -140,6 +140,10 @@ static int bf5xx_i2s_hw_params(struct snd_pcm_substream *substream,
 	bf5xx_i2s.tcr2 &= ~0x1f;
 	bf5xx_i2s.rcr2 &= ~0x1f;
 	switch (params_format(params)) {
+	case SNDRV_PCM_FORMAT_S8:
+		bf5xx_i2s->tcr2 |= 7;
+		bf5xx_i2s->rcr2 |= 7;
+		sport_handle->wdsize = 1;
 	case SNDRV_PCM_FORMAT_S16_LE:
 		bf5xx_i2s.tcr2 |= 15;
 		bf5xx_i2s.rcr2 |= 15;
@@ -266,8 +270,11 @@ static int bf5xx_i2s_resume(struct snd_soc_dai *dai)
 		SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 | \
 		SNDRV_PCM_RATE_96000)
 
-#define BF5XX_I2S_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE |\
-	SNDRV_PCM_FMTBIT_S32_LE)
+#define BF5XX_I2S_FORMATS \
+	(SNDRV_PCM_FMTBIT_S8 | \
+	 SNDRV_PCM_FMTBIT_S16_LE | \
+	 SNDRV_PCM_FMTBIT_S24_LE | \
+	 SNDRV_PCM_FMTBIT_S32_LE)
 
 static struct snd_soc_dai_ops bf5xx_i2s_dai_ops = {
 	.shutdown	= bf5xx_i2s_shutdown,
-- 
1.7.4.1
