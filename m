From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Use dai_fmt in hx4700 machine driver
Date: Tue, 20 Dec 2011 16:13:26 +0800
Message-ID: <1324368806.16878.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id CF66B2412D
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 09:13:37 +0100 (CET)
Received: by ghrr11 with SMTP id r11so4039367ghr.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 00:13:35 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Philipp Zabel <philipp.zabel@gmail.com>, Dmitry Artamonow <mad_soft@inbox.ru>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/hx4700.c |   16 ++--------------
 1 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/pxa/hx4700.c b/sound/soc/pxa/hx4700.c
index 03ef9f3..8260207 100644
--- a/sound/soc/pxa/hx4700.c
+++ b/sound/soc/pxa/hx4700.c
@@ -65,20 +65,6 @@ static int hx4700_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int ret = 0;
 
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai,
-			SND_SOC_DAIFMT_MSB | SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai,
-			SND_SOC_DAIFMT_MSB | SND_SOC_DAIFMT_NB_NF |
-			SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
 	/* set the I2S system clock as output */
 	ret = snd_soc_dai_set_sysclk(cpu_dai, PXA2XX_I2S_SYSCLK, 0,
 			SND_SOC_CLOCK_OUT);
@@ -175,6 +161,8 @@ static struct snd_soc_dai_link hx4700_dai = {
 	.platform_name = "pxa-pcm-audio",
 	.codec_name = "ak4641.0-0012",
 	.init = hx4700_ak4641_init,
+	.dai_fmt = SND_SOC_DAIFMT_MSB | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &hx4700_ops,
 };
 
-- 
1.7.5.4
