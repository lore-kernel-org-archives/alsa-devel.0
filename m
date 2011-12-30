From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 4/4] ASoC: Use dai_fmt in z2 machine driver
Date: Fri, 30 Dec 2011 23:44:37 +0800
Message-ID: <1325259877.4755.9.camel@phoenix>
References: <1325259714.4755.6.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 25632103B25
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 16:44:44 +0100 (CET)
Received: by ggnv5 with SMTP id v5so8898850ggn.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 07:44:43 -0800 (PST)
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
 sound/soc/pxa/z2.c |   14 ++------------
 1 files changed, 2 insertions(+), 12 deletions(-)

diff --git a/sound/soc/pxa/z2.c b/sound/soc/pxa/z2.c
index d6807e0..e8f15ce 100644
--- a/sound/soc/pxa/z2.c
+++ b/sound/soc/pxa/z2.c
@@ -56,18 +56,6 @@ static int z2_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	/* set cpu DAI configuration */
-	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
-		SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
 	/* set the codec system clock for DAC and ADC */
 	ret = snd_soc_dai_set_sysclk(codec_dai, WM8750_SYSCLK, clk,
 		SND_SOC_CLOCK_IN);
@@ -196,6 +184,8 @@ static struct snd_soc_dai_link z2_dai = {
 	.platform_name = "pxa-pcm-audio",
 	.codec_name	= "wm8750.0-001b",
 	.init		= z2_wm8750_init,
+	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+			  SND_SOC_DAIFMT_CBS_CFS,
 	.ops		= &z2_ops,
 };
 
-- 
1.7.5.4
