From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/2] ASoC: Use dai_fmt in afeb9260 machine
	driver
Date: Sun, 29 Jan 2012 16:52:02 +0800
Message-ID: <1327827122.7085.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 9BB3A24577
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2012 09:52:14 +0100 (CET)
Received: by dadz14 with SMTP id z14so2878959dad.38
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2012 00:52:12 -0800 (PST)
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
Cc: Sergey Lapin <slapin@ossfans.org>, Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>, Mark@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/atmel/snd-soc-afeb9260.c |   23 ++---------------------
 1 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/sound/soc/atmel/snd-soc-afeb9260.c b/sound/soc/atmel/snd-soc-afeb9260.c
index 4ca667d..cb0130c 100644
--- a/sound/soc/atmel/snd-soc-afeb9260.c
+++ b/sound/soc/atmel/snd-soc-afeb9260.c
@@ -46,29 +46,8 @@ static int afeb9260_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	int err;
 
-	/* Set codec DAI configuration */
-	err = snd_soc_dai_set_fmt(codec_dai,
-				  SND_SOC_DAIFMT_I2S|
-				  SND_SOC_DAIFMT_NB_IF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (err < 0) {
-		printk(KERN_ERR "can't set codec DAI configuration\n");
-		return err;
-	}
-
-	/* Set cpu DAI configuration */
-	err = snd_soc_dai_set_fmt(cpu_dai,
-				  SND_SOC_DAIFMT_I2S |
-				  SND_SOC_DAIFMT_NB_IF |
-				  SND_SOC_DAIFMT_CBM_CFM);
-	if (err < 0) {
-		printk(KERN_ERR "can't set cpu DAI configuration\n");
-		return err;
-	}
-
 	/* Set the codec system clock for DAC and ADC */
 	err =
 	    snd_soc_dai_set_sysclk(codec_dai, 0, CODEC_CLOCK, SND_SOC_CLOCK_IN);
@@ -129,6 +108,8 @@ static struct snd_soc_dai_link afeb9260_dai = {
 	.platform_name = "atmel_pcm-audio",
 	.codec_name = "tlv320aic23-codec.0-001a",
 	.init = afeb9260_tlv320aic23_init,
+	.dai_fmt = SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
+		   SND_SOC_DAIFMT_CBM_CFM,
 	.ops = &afeb9260_ops,
 };
 
-- 
1.7.5.4
