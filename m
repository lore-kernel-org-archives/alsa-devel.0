From: Chaithrika U S <chaithrika@ti.com>
Subject: [PATCH] ASoC: DaVinci: Fixes to McASP configuration
Date: Tue, 15 Sep 2009 18:13:29 -0400
Message-ID: <1253052809-24547-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id E61051037FF
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Sep 2009 14:53:47 +0200 (CEST)
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
Cc: khilman@deeprootsystems.com, Chaithrika U S <chaithrika@ti.com>, davinci-linux-open-source@linux.davincidsp.com, broonie@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

McASP register settings are not correct for DSP mode of operation.
There is a channel swap initally. This patch provides fixes to
the register values for proper working.

Tested on DA830/OMAP-L137 EVM, DM6467 EVM.

Signed-off-by: Chaithrika U S <chaithrika@ti.com>
---
Applies to ALSA GIT tree on branch topic/asoc at
http://git.kernel.org/?p=linux/kernel/git/tiwai/sound-2.6.git;a=shortlog;
h=topic/asoc

 sound/soc/davinci/davinci-mcasp.c |   24 ++++++++++++++++++++++--
 1 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index eca22d7..7a06c0a 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -512,34 +512,49 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 				       int channel_size)
 {
 	u32 fmt = 0;
+	u32 mask, rotate;
 
 	switch (channel_size) {
 	case DAVINCI_AUDIO_WORD_8:
 		fmt = 0x03;
+		rotate = 6;
+		mask = 0x000000ff;
 		break;
 
 	case DAVINCI_AUDIO_WORD_12:
 		fmt = 0x05;
+		rotate = 5;
+		mask = 0x00000fff;
 		break;
 
 	case DAVINCI_AUDIO_WORD_16:
 		fmt = 0x07;
+		rotate = 4;
+		mask = 0x0000ffff;
 		break;
 
 	case DAVINCI_AUDIO_WORD_20:
 		fmt = 0x09;
+		rotate = 3;
+		mask = 0x000fffff;
 		break;
 
 	case DAVINCI_AUDIO_WORD_24:
 		fmt = 0x0B;
+		rotate = 2;
+		mask = 0x00ffffff;
 		break;
 
 	case DAVINCI_AUDIO_WORD_28:
 		fmt = 0x0D;
+		rotate = 1;
+		mask = 0x0fffffff;
 		break;
 
 	case DAVINCI_AUDIO_WORD_32:
 		fmt = 0x0F;
+		rotate = 0;
+		mask = 0xffffffff;
 		break;
 
 	default:
@@ -550,6 +565,13 @@ static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 					RXSSZ(fmt), RXSSZ(0x0F));
 	mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG,
 					TXSSZ(fmt), TXSSZ(0x0F));
+	mcasp_mod_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, TXROT(rotate),
+							TXROT(7));
+	mcasp_mod_bits(dev->base + DAVINCI_MCASP_RXFMT_REG, RXROT(rotate),
+							RXROT(7));
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, mask);
+	mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG, mask);
+
 	return 0;
 }
 
@@ -638,7 +660,6 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
 			printk(KERN_ERR "playback tdm slot %d not supported\n",
 				dev->tdm_slots);
 
-		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXMASK_REG, 0xFFFFFFFF);
 		mcasp_clr_bits(dev->base + DAVINCI_MCASP_TXFMCTL_REG, FSXDUR);
 	} else {
 		/* bit stream is MSB first with no delay */
@@ -655,7 +676,6 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
 			printk(KERN_ERR "capture tdm slot %d not supported\n",
 				dev->tdm_slots);
 
-		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXMASK_REG, 0xFFFFFFFF);
 		mcasp_clr_bits(dev->base + DAVINCI_MCASP_RXFMCTL_REG, FSRDUR);
 	}
 }
-- 
1.5.6
