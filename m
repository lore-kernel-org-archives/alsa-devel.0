From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 5/5] ALSA: ASoC: McASP: set format parameters
	in dependence of the DAI format
Date: Thu,  4 Oct 2012 15:08:42 +0200
Message-ID: <1349356122-14794-6-git-send-email-zonque@gmail.com>
References: <1349356122-14794-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 070BF261675
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 15:09:13 +0200 (CEST)
In-Reply-To: <1349356122-14794-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Matt Porter <mporter@ti.com>, "Hebbar, Gururaja" <gururaja.hebbar@ti.com>, broonie@opensource.wolfsonmicro.com, lrg@ti.com, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

The FSDUR flag configures whether the frame clock uses a high phase of
only one bit or a full word. This has to be set depending on the DAI
format.

For other modes than DSP_B, the FSXDLY/FSRDLY fields have to be set to
1.

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Hebbar, Gururaja <gururaja.hebbar@ti.com>
Cc: Matt Porter <mporter@ti.com>
---
 sound/soc/davinci/davinci-mcasp.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 48e347f..8fac32a 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -477,6 +477,23 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
 	void __iomem *base = dev->base;
 
+	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
+	case SND_SOC_DAIFMT_DSP_B:
+	case SND_SOC_DAIFMT_AC97:
+		mcasp_clr_bits(dev->base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
+		mcasp_clr_bits(dev->base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
+		break;
+	default:
+		/* configure a full-word SYNC pulse (LRCLK) */
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
+
+		/* make 1st data bit occur one ACLK cycle after the frame sync */
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, FSXDLY(1));
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_RXFMT_REG, FSRDLY(1));
+		break;
+	}
+
 	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 		/* codec is clock and frame slave */
@@ -765,8 +782,6 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
 		else
 			printk(KERN_ERR "playback tdm slot %d not supported\n",
 				dev->tdm_slots);
-
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
 	} else {
 		/* bit stream is MSB first with no delay */
 		/* DSP_B mode */
@@ -779,8 +794,6 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
 		else
 			printk(KERN_ERR "capture tdm slot %d not supported\n",
 				dev->tdm_slots);
-
-		mcasp_clr_bits(dev->base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
 	}
 }
 
-- 
1.7.11.4
