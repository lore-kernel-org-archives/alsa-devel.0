From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/4] ASoC: Use dai_fmt in saarb machine driver
Date: Fri, 30 Dec 2011 23:41:54 +0800
Message-ID: <1325259714.4755.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 855FA103ACB
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 16:42:02 +0100 (CET)
Received: by yhjj56 with SMTP id j56so8334744yhj.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 07:42:00 -0800 (PST)
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/saarb.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/sound/soc/pxa/saarb.c b/sound/soc/pxa/saarb.c
index 2e21712..b2be225 100644
--- a/sound/soc/pxa/saarb.c
+++ b/sound/soc/pxa/saarb.c
@@ -92,15 +92,6 @@ static int saarb_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
 	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 3, 3, 2, width);
 
 	return ret;
@@ -119,6 +110,8 @@ static struct snd_soc_dai_link saarb_dai[] = {
 		.platform_name	= "pxa-pcm-audio",
 		.codec_name	= "88pm860x-codec",
 		.init		= saarb_pm860x_init,
+		.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM,
 		.ops		= &saarb_i2s_ops,
 	},
 };
-- 
1.7.5.4
