From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Remove export of s3c_pcm_dai
Date: Wed, 14 Dec 2011 19:13:26 +0800
Message-ID: <1323861206.16636.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BF6A245E6
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 12:13:40 +0100 (CET)
Received: by wgbdr1 with SMTP id dr1so1086694wgb.20
	for <alsa-devel@alsa-project.org>; Wed, 14 Dec 2011 03:13:38 -0800 (PST)
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
Cc: Sangbeom Kim <sbkim73@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Liam Girdwood <lrg@ti.com>, Jaswinder Singh <jassi.brar@samsung.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We don't need to export s3c_pcm_dai after multi-component patch.
Thus remove export of s3c_pcm_dai and make it static.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/samsung/pcm.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/sound/soc/samsung/pcm.c b/sound/soc/samsung/pcm.c
index beef63f..786811d 100644
--- a/sound/soc/samsung/pcm.c
+++ b/sound/soc/samsung/pcm.c
@@ -478,7 +478,7 @@ static const struct snd_soc_dai_ops s3c_pcm_dai_ops = {
 		.formats	= SNDRV_PCM_FMTBIT_S16_LE,	\
 	}
 
-struct snd_soc_dai_driver s3c_pcm_dai[] = {
+static struct snd_soc_dai_driver s3c_pcm_dai[] = {
 	[0] = {
 		.name	= "samsung-pcm.0",
 		S3C_PCM_DAI_DECLARE,
@@ -488,7 +488,6 @@ struct snd_soc_dai_driver s3c_pcm_dai[] = {
 		S3C_PCM_DAI_DECLARE,
 	},
 };
-EXPORT_SYMBOL_GPL(s3c_pcm_dai);
 
 static __devinit int s3c_pcm_dev_probe(struct platform_device *pdev)
 {
-- 
1.7.5.4
