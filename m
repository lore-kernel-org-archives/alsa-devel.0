From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: bcm2835: Support left/right justified
	and DSP modes" to the asoc tree
Date: Fri, 10 Nov 2017 21:28:54 +0000
Message-ID: <E1eDGr8-0004MI-Gr@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8DF8826706F
 for <alsa-devel@alsa-project.org>; Fri, 10 Nov 2017 22:28:56 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matthias Reichl <hias@horus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: bcm2835: Support left/right justified and DSP modes

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From abd4f0e1c24fd5b7241c77506006e9c0982128c0 Mon Sep 17 00:00:00 2001
From: Matthias Reichl <hias@horus.com>
Date: Wed, 8 Nov 2017 21:03:30 +0100
Subject: [PATCH] ASoC: bcm2835: Support left/right justified and DSP modes

DSP modes and left/right justified modes can be supported
on bcm2835 by configuring the frame sync polarity and
frame sync length registers and by adjusting the
channel data position registers.

Clock and frame sync polarity handling in hw_params has
been refactored to make the interaction between logical
rising/falling edge frame start and physical configuration
(changed by normal/inverted polarity modes) clearer.

Modes where the first active data bit is transmitted immediately
after frame start (eg DSP mode B with slot 0 active)
only work reliable if bcm2835 is configured as frame master.
In frame slave mode channel swap (or shift, this isn't quite
clear yet) can occur.

Currently the driver only warns if an unstable configuration
is detected but doensn't prevent using them.

Signed-off-by: Matthias Reichl <hias@horus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/bcm2835-i2s.c | 152 +++++++++++++++++++++++++++++---------------
 1 file changed, 99 insertions(+), 53 deletions(-)

diff --git a/sound/soc/bcm/bcm2835-i2s.c b/sound/soc/bcm/bcm2835-i2s.c
index 111b4ef7ce35..2e449d7173fc 100644
--- a/sound/soc/bcm/bcm2835-i2s.c
+++ b/sound/soc/bcm/bcm2835-i2s.c
@@ -344,6 +344,9 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 	unsigned int rx_mask, tx_mask;
 	unsigned int rx_ch1_pos, rx_ch2_pos, tx_ch1_pos, tx_ch2_pos;
 	unsigned int mode, format;
+	bool bit_clock_master = false;
+	bool frame_sync_master = false;
+	bool frame_start_falling_edge = false;
 	uint32_t csreg;
 	int ret = 0;
 
@@ -387,16 +390,39 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 	if (data_length > slot_width)
 		return -EINVAL;
 
-	/* Clock should only be set up here if CPU is clock master */
+	/* Check if CPU is bit clock master */
 	switch (dev->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
 	case SND_SOC_DAIFMT_CBS_CFS:
 	case SND_SOC_DAIFMT_CBS_CFM:
-		ret = clk_set_rate(dev->clk, bclk_rate);
-		if (ret)
-			return ret;
+		bit_clock_master = true;
+		break;
+	case SND_SOC_DAIFMT_CBM_CFS:
+	case SND_SOC_DAIFMT_CBM_CFM:
+		bit_clock_master = false;
 		break;
 	default:
+		return -EINVAL;
+	}
+
+	/* Check if CPU is frame sync master */
+	switch (dev->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
+	case SND_SOC_DAIFMT_CBS_CFS:
+	case SND_SOC_DAIFMT_CBM_CFS:
+		frame_sync_master = true;
+		break;
+	case SND_SOC_DAIFMT_CBS_CFM:
+	case SND_SOC_DAIFMT_CBM_CFM:
+		frame_sync_master = false;
 		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Clock should only be set up here if CPU is clock master */
+	if (bit_clock_master) {
+		ret = clk_set_rate(dev->clk, bclk_rate);
+		if (ret)
+			return ret;
 	}
 
 	/* Setup the frame format */
@@ -427,13 +453,41 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 
 		/* Setup frame sync signal for 50% duty cycle */
 		framesync_length = frame_length / 2;
+		frame_start_falling_edge = true;
+		break;
+	case SND_SOC_DAIFMT_LEFT_J:
+		if (slots & 1)
+			return -EINVAL;
+
+		odd_slot_offset = slots >> 1;
+		data_delay = 0;
+		framesync_length = frame_length / 2;
+		frame_start_falling_edge = false;
+		break;
+	case SND_SOC_DAIFMT_RIGHT_J:
+		if (slots & 1)
+			return -EINVAL;
+
+		/* Odd frame lengths aren't supported */
+		if (frame_length & 1)
+			return -EINVAL;
+
+		odd_slot_offset = slots >> 1;
+		data_delay = slot_width - data_length;
+		framesync_length = frame_length / 2;
+		frame_start_falling_edge = false;
+		break;
+	case SND_SOC_DAIFMT_DSP_A:
+		data_delay = 1;
+		framesync_length = 1;
+		frame_start_falling_edge = false;
+		break;
+	case SND_SOC_DAIFMT_DSP_B:
+		data_delay = 0;
+		framesync_length = 1;
+		frame_start_falling_edge = false;
 		break;
 	default:
-		/*
-		 * TODO
-		 * Others are possible but are not implemented at the moment.
-		 */
-		dev_err(dev->dev, "%s:bad format\n", __func__);
 		return -EINVAL;
 	}
 
@@ -442,6 +496,15 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 	bcm2835_i2s_calc_channel_pos(&tx_ch1_pos, &tx_ch2_pos,
 		tx_mask, slot_width, data_delay, odd_slot_offset);
 
+	/*
+	 * Transmitting data immediately after frame start, eg
+	 * in left-justified or DSP mode A, only works stable
+	 * if bcm2835 is the frame clock master.
+	 */
+	if ((!rx_ch1_pos || !tx_ch1_pos) && !frame_sync_master)
+		dev_warn(dev->dev,
+			"Unstable slave config detected, L/R may be swapped");
+
 	/*
 	 * Set format for both streams.
 	 * We cannot set another frame length
@@ -472,62 +535,38 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 	mode |= BCM2835_I2S_FLEN(frame_length - 1);
 	mode |= BCM2835_I2S_FSLEN(framesync_length);
 
-	/* Master or slave? */
-	switch (dev->fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBS_CFS:
-		/* CPU is master */
-		break;
-	case SND_SOC_DAIFMT_CBM_CFS:
-		/*
-		 * CODEC is bit clock master
-		 * CPU is frame master
-		 */
+	/* CLKM selects bcm2835 clock slave mode */
+	if (!bit_clock_master)
 		mode |= BCM2835_I2S_CLKM;
-		break;
-	case SND_SOC_DAIFMT_CBS_CFM:
-		/*
-		 * CODEC is frame master
-		 * CPU is bit clock master
-		 */
+
+	/* FSM selects bcm2835 frame sync slave mode */
+	if (!frame_sync_master)
 		mode |= BCM2835_I2S_FSM;
+
+	/* CLKI selects normal clocking mode, sampling on rising edge */
+        switch (dev->fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+	case SND_SOC_DAIFMT_NB_IF:
+		mode |= BCM2835_I2S_CLKI;
 		break;
-	case SND_SOC_DAIFMT_CBM_CFM:
-		/* CODEC is master */
-		mode |= BCM2835_I2S_CLKM;
-		mode |= BCM2835_I2S_FSM;
+	case SND_SOC_DAIFMT_IB_NF:
+	case SND_SOC_DAIFMT_IB_IF:
 		break;
 	default:
-		dev_err(dev->dev, "%s:bad master\n", __func__);
 		return -EINVAL;
 	}
 
-	/*
-	 * Invert clocks?
-	 *
-	 * The BCM approach seems to be inverted to the classical I2S approach.
-	 */
+	/* FSI selects frame start on falling edge */
 	switch (dev->fmt & SND_SOC_DAIFMT_INV_MASK) {
 	case SND_SOC_DAIFMT_NB_NF:
-		/* None. Therefore, both for BCM */
-		mode |= BCM2835_I2S_CLKI;
-		mode |= BCM2835_I2S_FSI;
-		break;
-	case SND_SOC_DAIFMT_IB_IF:
-		/* Both. Therefore, none for BCM */
+	case SND_SOC_DAIFMT_IB_NF:
+		if (frame_start_falling_edge)
+			mode |= BCM2835_I2S_FSI;
 		break;
 	case SND_SOC_DAIFMT_NB_IF:
-		/*
-		 * Invert only frame sync. Therefore,
-		 * invert only bit clock for BCM
-		 */
-		mode |= BCM2835_I2S_CLKI;
-		break;
-	case SND_SOC_DAIFMT_IB_NF:
-		/*
-		 * Invert only bit clock. Therefore,
-		 * invert only frame sync for BCM
-		 */
-		mode |= BCM2835_I2S_FSI;
+	case SND_SOC_DAIFMT_IB_IF:
+		if (!frame_start_falling_edge)
+			mode |= BCM2835_I2S_FSI;
 		break;
 	default:
 		return -EINVAL;
@@ -563,6 +602,13 @@ static int bcm2835_i2s_hw_params(struct snd_pcm_substream *substream,
 	dev_dbg(dev->dev, "sampling rate: %d bclk rate: %d\n",
 		params_rate(params), bclk_rate);
 
+	dev_dbg(dev->dev, "CLKM: %d CLKI: %d FSM: %d FSI: %d frame start: %s edge\n",
+		!!(mode & BCM2835_I2S_CLKM),
+		!!(mode & BCM2835_I2S_CLKI),
+		!!(mode & BCM2835_I2S_FSM),
+		!!(mode & BCM2835_I2S_FSI),
+		(mode & BCM2835_I2S_FSI) ? "falling" : "rising");
+
 	return ret;
 }
 
-- 
2.15.0
