From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/4] ASoC: Use dai_fmt in tavorevb3 machine
	driver
Date: Fri, 30 Dec 2011 23:43:44 +0800
Message-ID: <1325259824.4755.8.camel@phoenix>
References: <1325259714.4755.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 518BF103B25
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 16:43:51 +0100 (CET)
Received: by ghbz2 with SMTP id z2so3415116ghb.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 07:43:50 -0800 (PST)
In-Reply-To: <1325259714.4755.6.camel@phoenix>
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
 sound/soc/pxa/tavorevb3.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/pxa/tavorevb3.c b/sound/soc/pxa/tavorevb3.c
index 4bef12c..46ac1fe 100644
--- a/sound/soc/pxa/tavorevb3.c
+++ b/sound/soc/pxa/tavorevb3.c
@@ -92,16 +92,6 @@ static int evb3_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
-	if (ret < 0)
-		return ret;
-
 	ret = snd_soc_dai_set_tdm_slot(cpu_dai, 3, 3, 2, width);
 	return ret;
 }
@@ -119,6 +109,8 @@ static struct snd_soc_dai_link evb3_dai[] = {
 		.platform_name	= "pxa-pcm-audio",
 		.codec_name	= "88pm860x-codec",
 		.init		= evb3_pm860x_init,
+		.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+				  SND_SOC_DAIFMT_CBM_CFM,
 		.ops		= &evb3_i2s_ops,
 	},
 };
-- 
1.7.5.4
