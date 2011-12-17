From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/2] ASoC: Use dai_fmt in snappercl15 machine
	driver
Date: Sat, 17 Dec 2011 15:41:11 +0800
Message-ID: <1324107671.27184.4.camel@phoenix>
References: <1324107412.27184.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gx0-f179.google.com (mail-gx0-f179.google.com
	[209.85.161.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D98DD24452
	for <alsa-devel@alsa-project.org>; Sat, 17 Dec 2011 08:41:18 +0100 (CET)
Received: by ggnv5 with SMTP id v5so3352753ggn.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2011 23:41:18 -0800 (PST)
In-Reply-To: <1324107412.27184.1.camel@phoenix>
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
Cc: Mika Westerberg <mika.westerberg@iki.fi>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Alexander Sverdlin <subaparts@yandex.ru>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/ep93xx/snappercl15.c |   12 ++----------
 1 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/sound/soc/ep93xx/snappercl15.c b/sound/soc/ep93xx/snappercl15.c
index 33901d6..e97cd57 100644
--- a/sound/soc/ep93xx/snappercl15.c
+++ b/sound/soc/ep93xx/snappercl15.c
@@ -33,16 +33,6 @@ static int snappercl15_hw_params(struct snd_pcm_substream *substream,
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int err;
 
-	err = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_IF |
-				  SND_SOC_DAIFMT_CBS_CFS);
-
-	err = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S | 
-				  SND_SOC_DAIFMT_NB_IF |		  
-				  SND_SOC_DAIFMT_CBS_CFS);
-	if (err)
-		return err;
-
 	err = snd_soc_dai_set_sysclk(codec_dai, 0, CODEC_CLOCK, 
 				     SND_SOC_CLOCK_IN);
 	if (err)
@@ -96,6 +86,8 @@ static struct snd_soc_dai_link snappercl15_dai = {
 	.codec_name	= "tlv320aic23-codec.0-001a",
 	.platform_name	=  "ep93xx-pcm-audio",
 	.init		= snappercl15_tlv320aic23_init,
+	.dai_fmt	= SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
+			  SND_SOC_DAIFMT_CBS_CFS,
 	.ops		= &snappercl15_ops,
 };
 
-- 
1.7.5.4
