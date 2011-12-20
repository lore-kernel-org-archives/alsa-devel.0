From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Use dai_fmt in imote2 machine driver
Date: Tue, 20 Dec 2011 16:27:28 +0800
Message-ID: <1324369648.16878.4.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 319FD2414F
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 09:27:35 +0100 (CET)
Received: by ghrr11 with SMTP id r11so4042756ghr.38
	for <alsa-devel@alsa-project.org>; Tue, 20 Dec 2011 00:27:34 -0800 (PST)
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
Cc: Mark@alsa-project.org, Brown <broonie@opensource.wolfsonmicro.com>, Jonathan Cameron <jic23@cam.ac.uk>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/imote2.c |   16 ++--------------
 1 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/pxa/imote2.c b/sound/soc/pxa/imote2.c
index 97d3aec..dc905ae 100644
--- a/sound/soc/pxa/imote2.c
+++ b/sound/soc/pxa/imote2.c
@@ -30,20 +30,6 @@ static int imote2_asoc_hw_params(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	/* set codec DAI configuration */
-	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S
-				  | SND_SOC_DAIFMT_NB_NF
-				  | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
-	/* CPU should be clock master */
-	ret = snd_soc_dai_set_fmt(cpu_dai,  SND_SOC_DAIFMT_I2S
-				  | SND_SOC_DAIFMT_NB_NF
-				  | SND_SOC_DAIFMT_CBS_CFS);
-	if (ret < 0)
-		return ret;
-
 	ret = snd_soc_dai_set_sysclk(codec_dai, 0, clk,
 				     SND_SOC_CLOCK_IN);
 	if (ret < 0)
@@ -67,6 +53,8 @@ static struct snd_soc_dai_link imote2_dai = {
 	.codec_dai_name = "wm8940-hifi",
 	.platform_name = "pxa-pcm-audio",
 	.codec_name = "wm8940-codec.0-0034",
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
+		   SND_SOC_DAIFMT_CBS_CFS,
 	.ops = &imote2_asoc_ops,
 };
 
-- 
1.7.5.4
