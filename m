From: Daniel Mack <zonque@gmail.com>
Subject: [PATCH 4/5] ALSA: ASoC: McASP: make AHCLK direction
	configurable
Date: Thu,  4 Oct 2012 15:08:41 +0200
Message-ID: <1349356122-14794-5-git-send-email-zonque@gmail.com>
References: <1349356122-14794-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id A178726163C
 for <alsa-devel@alsa-project.org>; Thu,  4 Oct 2012 15:09:12 +0200 (CEST)
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

Add a .set_sysclk function to pass the direction of the clock down to
the driver. Only enable AHCLKX in the PDIR register when the CPU is
driving the clock.

This also removes the modification of the AHCLKXE/AHCLKRE bits in the
hw_params callback, and users must set the desired configuration using
snd_soc_dai_set_sysclk(), which this patch also does for the only user
in mainline (davinci-evm).

Signed-off-by: Daniel Mack <zonque@gmail.com>
Cc: Hebbar, Gururaja <gururaja.hebbar@ti.com>
Cc: Matt Porter <mporter@ti.com>
---
 sound/soc/davinci/davinci-evm.c   |  5 +++++
 sound/soc/davinci/davinci-mcasp.c | 26 ++++++++++++++++++++------
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-evm.c
index 6fac5af..d55e647 100644
--- a/sound/soc/davinci/davinci-evm.c
+++ b/sound/soc/davinci/davinci-evm.c
@@ -71,6 +71,11 @@ static int evm_hw_params(struct snd_pcm_substream *substream,
 	if (ret < 0)
 		return ret;
 
+	/* set the CPU system clock */
+	ret = snd_soc_dai_set_sysclk(cpu_dai, 0, sysclk, SND_SOC_CLOCK_OUT);
+	if (ret < 0)
+		return ret;
+
 	return 0;
 }
 
diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index ab9773d..48e347f 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -486,8 +486,7 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_set_bits(base + DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
 		mcasp_set_bits(base + DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_set_bits(base + DAVINCI_MCASP_PDIR_REG,
-				ACLKX | AHCLKX | AFSX);
+		mcasp_set_bits(base + DAVINCI_MCASP_PDIR_REG, ACLKX | AFSX);
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
 		/* codec is clock master and frame slave */
@@ -584,6 +583,24 @@ static int davinci_mcasp_set_clkdiv(struct snd_soc_dai *dai, int div_id, int div
 	return 0;
 }
 
+static int davinci_mcasp_set_sysclk(struct snd_soc_dai *dai, int clk_id,
+				    unsigned int freq, int dir)
+{
+	struct davinci_audio_dev *dev = snd_soc_dai_get_drvdata(dai);
+
+	if (dir == SND_SOC_CLOCK_OUT) {
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
+		mcasp_set_bits(dev->base + DAVINCI_MCASP_PDIR_REG, AHCLKX);
+	} else {
+		mcasp_clr_bits(dev->base + DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
+		mcasp_clr_bits(dev->base + DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
+		mcasp_clr_bits(dev->base + DAVINCI_MCASP_PDIR_REG, AHCLKX);
+	}
+
+	return 0;
+}
+
 static int davinci_config_channel_size(struct davinci_audio_dev *dev,
 				       int channel_size)
 {
@@ -739,8 +756,6 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
 	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/* bit stream is MSB first  with no delay */
 		/* DSP_B mode */
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_AHCLKXCTL_REG,
-				AHCLKXE);
 		mcasp_set_reg(dev->base + DAVINCI_MCASP_TXTDM_REG, mask);
 		mcasp_set_bits(dev->base + DAVINCI_MCASP_TXFMT_REG, TXORD);
 
@@ -756,8 +771,6 @@ static void davinci_hw_param(struct davinci_audio_dev *dev, int stream)
 		/* bit stream is MSB first with no delay */
 		/* DSP_B mode */
 		mcasp_set_bits(dev->base + DAVINCI_MCASP_RXFMT_REG, RXORD);
-		mcasp_set_bits(dev->base + DAVINCI_MCASP_AHCLKRCTL_REG,
-				AHCLKRE);
 		mcasp_set_reg(dev->base + DAVINCI_MCASP_RXTDM_REG, mask);
 
 		if ((dev->tdm_slots >= 2) && (dev->tdm_slots <= 32))
@@ -919,6 +932,7 @@ static const struct snd_soc_dai_ops davinci_mcasp_dai_ops = {
 	.hw_params	= davinci_mcasp_hw_params,
 	.set_fmt	= davinci_mcasp_set_dai_fmt,
 	.set_clkdiv	= davinci_mcasp_set_clkdiv,
+	.set_sysclk	= davinci_mcasp_set_sysclk,
 };
 
 #define DAVINCI_MCASP_PCM_FMTS (SNDRV_PCM_FMTBIT_S8 | \
-- 
1.7.11.4
