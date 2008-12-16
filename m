From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: [PATCH] 1/2 ALSA: ca0106 support 44100Hz playback to
	spdif
Date: Wed, 17 Dec 2008 01:37:07 +1100
Message-ID: <1229438227.13074.116.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pecan2.exetel.com.au (pecan2.exetel.com.au [220.233.0.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 57E4424134
	for <alsa-devel@alsa-project.org>; Tue, 16 Dec 2008 15:37:08 +0100 (CET)
Received: from 168.78.233.220.exetel.com.au ([220.233.78.168]
	helo=[192.168.1.2]) by pecan2.exetel.com.au with esmtp (Exim 4.68)
	(envelope-from <Ben.Stanley@exemail.com.au>) id 1LCb2o-0008Pg-P6
	for alsa-devel@alsa-project.org; Wed, 17 Dec 2008 01:37:07 +1100
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
List-Id: alsa-devel@alsa-project.org

>From 241939bdf80de14e204d6fcb43d850d33bdeda20 Mon Sep 17 00:00:00 2001
From: Ben Stanley <Ben.Stanley@exemail.com.au>
Date: Tue, 16 Dec 2008 23:47:36 +1100
Subject: [PATCH] ALSA: ca0106 support 44100Hz playback to spdif

This patch provides support for playback of 44100Hz sampled material in
16 and 32 bit sample depths through the digital spdif/iec958 connection/s
available on the ca0106 card.

I have re-worked the patch to address comments from a previous review 
by Takashi [1]. In particular, I have incorporated spin-locking to address 
a race condition that Takashi was concerned about.

This code has been running on my MythTV box for the last fortnight without
apparent ills. I have re-based the code a bit for submission.

This patch is against alsa-kmirror.

[1] http://article.gmane.org/gmane.linux.alsa.devel/55825/match=takashi+ca0106+44100+spdif

Signed-off-by: Ben Stanley <Ben.Stanley@exemail.com.au>
---
 pci/ca0106/ca0106.h      |   13 ++-
 pci/ca0106/ca0106_main.c |  402 ++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 351 insertions(+), 64 deletions(-)

diff --git a/pci/ca0106/ca0106.h b/pci/ca0106/ca0106.h
index 3faccb6..2ffec74 100644
--- a/pci/ca0106/ca0106.h
+++ b/pci/ca0106/ca0106.h
@@ -1,7 +1,7 @@
 /*
  *  Copyright (c) 2004 James Courtier-Dutton <James@superbug.demon.co.uk>
  *  Driver CA0106 chips. e.g. Sound Blaster Audigy LS and Live 24bit
- *  Version: 0.0.22
+ *  Version: 0.0.23
  *
  *  FEATURES currently supported:
  *    See ca0106_main.c for features.
@@ -49,6 +49,8 @@
  *   Implement support for Line-in capture on SB Live 24bit.
  *  0.0.22
  *    Add support for mute control on SB Live 24bit (cards w/ SPI DAC)
+ *  0.0.23
+ *    Add support for playback sampling rate and format constraints.
  *
  *
  *  This code was initally based on code from ALSA's emu10k1x.c which is:
@@ -644,6 +646,8 @@
 
 #include "ca_midi.h"
 
+#define DRVNAME "snd-ca0106"
+
 struct snd_ca0106;
 
 struct snd_ca0106_channel {
@@ -659,6 +663,7 @@ struct snd_ca0106_pcm {
 	struct snd_pcm_substream *substream;
         int channel_id;
 	unsigned short running;
+	unsigned short hw_reserved;
 };
 
 struct snd_ca0106_details {
@@ -688,6 +693,7 @@ struct snd_ca0106 {
 	unsigned short model;		/* subsystem id */
 
 	spinlock_t emu_lock;
+	spinlock_t pcm_lock;
 
 	struct snd_ac97 *ac97;
 	struct snd_pcm *pcm;
@@ -707,6 +713,11 @@ struct snd_ca0106 {
 	struct snd_ca_midi midi2;
 
 	u16 spi_dac_reg[16];
+
+	unsigned char count_pb_44100_chan;
+	unsigned char count_pb_non_44100_chan;
+	unsigned char count_pb_S16_chan;
+	unsigned char count_pb_S32_chan;
 };
 
 int snd_ca0106_mixer(struct snd_ca0106 *emu);
diff --git a/pci/ca0106/ca0106_main.c b/pci/ca0106/ca0106_main.c
index 6ac1936..bc78312 100644
--- a/pci/ca0106/ca0106_main.c
+++ b/pci/ca0106/ca0106_main.c
@@ -1,7 +1,7 @@
 /*
  *  Copyright (c) 2004 James Courtier-Dutton <James@superbug.demon.co.uk>
  *  Driver CA0106 chips. e.g. Sound Blaster Audigy LS and Live 24bit
- *  Version: 0.0.25
+ *  Version: 0.0.26
  *
  *  FEATURES currently supported:
  *    Front, Rear and Center/LFE.
@@ -83,9 +83,14 @@
  *    Add support for mute control on SB Live 24bit (cards w/ SPI DAC)
  *  0.0.25
  *    Powerdown SPI DAC channels when not in use
+ *  0.0.26 Ben Stanley
+ *    Added support for output at 44100Hz rate (SPDIF only).
+ *    Implemented constraints system for output rate and format.
  *
  *  BUGS:
  *    Some stability problems when unloading the snd-ca0106 kernel module.
+ *    Some programs fail to produce sound output (tested on SPDIF). See
+ *      http://thread.gmane.org/gmane.linux.alsa.devel/55384/focus=55410
  *    --
  *
  *  TODO:
@@ -145,6 +150,7 @@
 #include <sound/core.h>
 #include <sound/initval.h>
 #include <sound/pcm.h>
+#include <sound/pcm_params.h>
 #include <sound/ac97_codec.h>
 #include <sound/info.h>
 
@@ -285,9 +291,9 @@ static struct snd_pcm_hardware snd_ca0106_playback_hw = {
 				SNDRV_PCM_INFO_MMAP_VALID |
 				SNDRV_PCM_INFO_SYNC_START,
 	.formats =		SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
-	.rates =		(SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000 |
-				 SNDRV_PCM_RATE_192000),
-	.rate_min =		48000,
+	.rates =		(SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
+				 SNDRV_PCM_RATE_96000 | SNDRV_PCM_RATE_192000),
+	.rate_min =		44100,
 	.rate_max =		192000,
 	.channels_min =		2,  //1,
 	.channels_max =		2,  //6,
@@ -319,6 +325,110 @@ static struct snd_pcm_hardware snd_ca0106_capture_hw = {
 	.fifo_size =		0,
 };
 
+static unsigned int all_spdif_playback_rates[] =
+	{44100, 48000, 96000, 192000};
+
+static int hw_rule_playback_rate(struct snd_pcm_hw_params *params,
+				 struct snd_pcm_hw_rule   *rule)
+{
+	struct snd_ca0106 *chip = rule->private;
+	int mask;
+	unsigned long flags;
+	if (snd_BUG_ON(!chip))
+		return -EINVAL;
+
+	spin_lock_irqsave(&chip->pcm_lock, flags);
+	if (chip->spdif_enable) {
+		/* Compute the mask applied to all_spdif_playback_rates */
+		if (chip->count_pb_44100_chan)
+			mask = 0x1;
+		else if (chip->count_pb_non_44100_chan)
+			mask = 0xE;
+		else
+			mask = 0xF;
+	} else {
+		/* 44100Hz is not supported for DAC.
+		   The DAC cannot be clocked at 44100, only 48000 and 96000
+		   from the CA0106 chip. The SPDIF can be clocked at 44100.
+		   It is a hardware limitation. */
+		mask = 0xE;
+	}
+	snd_printdd("snd_hw_rule_playback_rate: any_44100=%d, "
+		"any_non_44100=%d, mask=0x%X, spdif=%d\n",
+		chip->count_pb_44100_chan,
+		chip->count_pb_non_44100_chan,
+		mask, chip->spdif_enable);
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
+	return snd_interval_list(hw_param_interval(params,
+						   SNDRV_PCM_HW_PARAM_RATE),
+				 ARRAY_SIZE(all_spdif_playback_rates),
+				 all_spdif_playback_rates, mask);
+}
+
+static int hw_rule_playback_format(struct snd_pcm_hw_params *params,
+				   struct snd_pcm_hw_rule *rule)
+{
+	struct snd_ca0106 *chip = rule->private;
+	struct snd_mask fmt;
+	struct snd_mask *f = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
+	int result;
+	unsigned long flags;
+	if (snd_BUG_ON(!chip))
+		return -EINVAL;
+	snd_mask_none(&fmt);
+
+	spin_lock_irqsave(&chip->pcm_lock, flags);
+	if (chip->count_pb_S16_chan)
+		snd_mask_set(&fmt, SNDRV_PCM_FORMAT_S16_LE);
+	else if (chip->count_pb_S32_chan)
+		snd_mask_set(&fmt, SNDRV_PCM_FORMAT_S32_LE);
+	else {
+		/* No format yet chosen, so both formats are available. */
+		snd_mask_set(&fmt, SNDRV_PCM_FORMAT_S16_LE);
+		snd_mask_set(&fmt, SNDRV_PCM_FORMAT_S32_LE);
+	}
+	result = snd_mask_refine(f, &fmt);
+	snd_printdd("snd_hw_rule_playback_format: any_S16=%d, any_S32=%d, "
+		"refined_fmt=0x%X, avail_fmt=0x%X, changed=%d\n",
+		chip->count_pb_S16_chan,
+		chip->count_pb_S32_chan, f->bits[0], fmt.bits[0],
+		result);
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
+	return result;
+}
+
+void snd_ca0106_rebuild_playback_channel_counters(struct snd_ca0106 *chip,
+						  int skip_channel)
+{
+	/* Re-build the counters of rate=44100 and the formats
+	   for use in constraints processing. Does not process the
+	   current_channel (this must be dealt with in the calling context).
+	   To process all channels, set skip_channel=-1.
+	   This must be called with chip->pcm_lock held. */
+
+	int chi;
+	struct snd_ca0106_channel *pchannel;
+	struct snd_pcm_runtime *runtimei;
+
+	chip->count_pb_44100_chan = chip->count_pb_non_44100_chan = 0;
+	chip->count_pb_S16_chan = chip->count_pb_S32_chan = 0;
+	for (chi = 0; chi < 4; ++chi) {
+		if (chi == skip_channel)
+			continue;
+		pchannel = &(chip->playback_channels[chi]);
+		if (!pchannel->use || !pchannel->epcm
+			|| !pchannel->epcm->hw_reserved)
+			continue;
+		runtimei = pchannel->epcm->substream->runtime;
+		chip->count_pb_44100_chan += runtimei->rate == 44100;
+		chip->count_pb_non_44100_chan += runtimei->rate != 44100;
+		chip->count_pb_S16_chan +=
+			runtimei->format == SNDRV_PCM_FORMAT_S16_LE;
+		chip->count_pb_S32_chan +=
+			runtimei->format == SNDRV_PCM_FORMAT_S32_LE;
+	}
+}
+
 unsigned int snd_ca0106_ptr_read(struct snd_ca0106 * emu, 
 					  unsigned int reg, 
 					  unsigned int chn)
@@ -393,7 +503,7 @@ int snd_ca0106_i2c_write(struct snd_ca0106 *emu,
 	int status;
 	int retry;
 	if ((reg > 0x7f) || (value > 0x1ff)) {
-		snd_printk(KERN_ERR "i2c_write: invalid values.\n");
+		snd_printk(KERN_ERR DRVNAME "i2c_write: invalid values.\n");
 		return -EINVAL;
 	}
 
@@ -463,7 +573,20 @@ static void snd_ca0106_intr_disable(struct snd_ca0106 *emu, unsigned int intrenb
 
 static void snd_ca0106_pcm_free_substream(struct snd_pcm_runtime *runtime)
 {
+	struct snd_ca0106_pcm *epcm = runtime->private_data;
+	struct snd_ca0106 *chip = epcm->emu;
+	/* FIXME how to tell which case to use? */
+	/* struct snd_ca0106_channel *channel =
+		&(chip->playback_channels[epcm->channel_id]); */
+	/* struct snd_ca0106_channel *channel =
+		&(chip->capture_channels[epcm->channel_id]); */
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->pcm_lock, flags);
 	kfree(runtime->private_data);
+	runtime->private_data = 0;
+	/* *channel = 0; */
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
 }
 
 static const int spi_dacd_reg[] = {
@@ -487,19 +610,21 @@ static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substr
         struct snd_ca0106_channel *channel = &(chip->playback_channels[channel_id]);
 	struct snd_ca0106_pcm *epcm;
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned long flags;
 	int err;
 
 	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
 
 	if (epcm == NULL)
 		return -ENOMEM;
+	spin_lock_irqsave(&chip->pcm_lock, flags);
 	epcm->emu = chip;
 	epcm->substream = substream;
         epcm->channel_id=channel_id;
-  
+
 	runtime->private_data = epcm;
 	runtime->private_free = snd_ca0106_pcm_free_substream;
-  
+
 	runtime->hw = snd_ca0106_playback_hw;
 
         channel->emu = chip;
@@ -509,10 +634,24 @@ static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substr
         //printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
         //channel->interrupt = snd_ca0106_pcm_channel_interrupt;
 	channel->epcm = epcm;
-	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
-                return err;
-	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
-                return err;
+	err = snd_pcm_hw_constraint_integer(runtime,
+			SNDRV_PCM_HW_PARAM_PERIODS);
+	if (err < 0)
+		goto error;
+	err = snd_pcm_hw_constraint_step(runtime,
+			0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64);
+	if (err < 0)
+		goto error;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+			hw_rule_playback_rate, (void *)chip,
+			SNDRV_PCM_HW_PARAM_RATE, -1);
+	if (err < 0)
+		goto error;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FORMAT,
+		       hw_rule_playback_format, (void *)chip,
+			SNDRV_PCM_HW_PARAM_FORMAT, -1);
+	if (err < 0)
+		goto error;
 	snd_pcm_set_sync(substream);
 
 	if (chip->details->spi_dac && channel_id != PCM_FRONT_CHANNEL) {
@@ -522,9 +661,12 @@ static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substr
 		chip->spi_dac_reg[reg] &= ~spi_dacd_bit[channel_id];
 		err = snd_ca0106_spi_write(chip, chip->spi_dac_reg[reg]);
 		if (err < 0)
-			return err;
+			goto error;
 	}
-	return 0;
+	err = 0;
+error:
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
+	return err;
 }
 
 /* close callback */
@@ -532,8 +674,12 @@ static int snd_ca0106_pcm_close_playback(struct snd_pcm_substream *substream)
 {
 	struct snd_ca0106 *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-        struct snd_ca0106_pcm *epcm = runtime->private_data;
+	struct snd_ca0106_pcm *epcm;
+	unsigned long flags;
+	spin_lock_irqsave(&chip->pcm_lock, flags);
+	epcm = runtime->private_data;
 	chip->playback_channels[epcm->channel_id].use = 0;
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
 
 	if (chip->details->spi_dac && epcm->channel_id != PCM_FRONT_CHANNEL) {
 		const int reg = spi_dacd_reg[epcm->channel_id];
@@ -574,6 +720,7 @@ static int snd_ca0106_pcm_open_capture_channel(struct snd_pcm_substream *substre
         struct snd_ca0106_channel *channel = &(chip->capture_channels[channel_id]);
 	struct snd_ca0106_pcm *epcm;
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	unsigned long flags;
 	int err;
 
 	epcm = kzalloc(sizeof(*epcm), GFP_KERNEL);
@@ -584,10 +731,11 @@ static int snd_ca0106_pcm_open_capture_channel(struct snd_pcm_substream *substre
 	epcm->emu = chip;
 	epcm->substream = substream;
         epcm->channel_id=channel_id;
-  
+
+	spin_lock_irqsave(&chip->pcm_lock, flags);
 	runtime->private_data = epcm;
 	runtime->private_free = snd_ca0106_pcm_free_substream;
-  
+
 	runtime->hw = snd_ca0106_capture_hw;
 
         channel->emu = chip;
@@ -596,13 +744,16 @@ static int snd_ca0106_pcm_open_capture_channel(struct snd_pcm_substream *substre
 	channel->use = 1;
         //printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
         //channel->interrupt = snd_ca0106_pcm_channel_interrupt;
-        channel->epcm = epcm;
+	channel->epcm = epcm;
 	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
-                return err;
+		goto error;
 	//snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, &hw_constraints_capture_period_sizes);
 	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
-                return err;
-	return 0;
+		goto error;
+	err = 0;
+error:
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
+	return err;
 }
 
 /* close callback */
@@ -610,9 +761,13 @@ static int snd_ca0106_pcm_close_capture(struct snd_pcm_substream *substream)
 {
 	struct snd_ca0106 *chip = snd_pcm_substream_chip(substream);
 	struct snd_pcm_runtime *runtime = substream->runtime;
-        struct snd_ca0106_pcm *epcm = runtime->private_data;
+	struct snd_ca0106_pcm *epcm;
+	unsigned long flags;
+	spin_lock_irqsave(&chip->pcm_lock, flags);
+	epcm = runtime->private_data;
 	chip->capture_channels[epcm->channel_id].use = 0;
 	/* FIXME: maybe zero others */
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
 	return 0;
 }
 
@@ -647,6 +802,24 @@ static int snd_ca0106_pcm_hw_params_playback(struct snd_pcm_substream *substream
 /* hw_free callback */
 static int snd_ca0106_pcm_hw_free_playback(struct snd_pcm_substream *substream)
 {
+	struct snd_ca0106 *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime;
+	struct snd_ca0106_pcm *epcm;
+	unsigned long flags;
+
+	spin_lock_irqsave(&chip->pcm_lock, flags);
+	runtime = substream->runtime;
+	epcm = runtime->private_data;
+	epcm->hw_reserved = 0;
+
+	snd_ca0106_rebuild_playback_channel_counters(chip, epcm->channel_id);
+
+	snd_printdd(KERN_DEBUG DRVNAME ": free_playback: any_44100=%d, "
+		"any_non_44100=%d, spdif=%d.\n",
+		chip->count_pb_44100_chan, chip->count_pb_non_44100_chan,
+		emu->spdif_enable);
+	spin_unlock_irqrestore(&chip->pcm_lock, flags);
+
 	return snd_pcm_lib_free_pages(substream);
 }
 
@@ -668,53 +841,149 @@ static int snd_ca0106_pcm_hw_free_capture(struct snd_pcm_substream *substream)
 static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 {
 	struct snd_ca0106 *emu = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_ca0106_pcm *epcm = runtime->private_data;
-	int channel = epcm->channel_id;
-	u32 *table_base = (u32 *)(emu->buffer.area+(8*16*channel));
+	struct snd_pcm_runtime *runtime = substream->runtime, *runtimei;
+	struct snd_ca0106_pcm *epcm;
+	struct snd_ca0106_channel *pchannel;
+	int channel, chi;
+	unsigned char count_pb_44100_chan, count_pb_non_44100_chan;
+	unsigned char count_pb_S16_chan, count_pb_S32_chan;
+	u32 *table_base;
 	u32 period_size_bytes = frames_to_bytes(runtime, runtime->period_size);
 	u32 hcfg_mask = HCFG_PLAYBACK_S32_LE;
 	u32 hcfg_set = 0x00000000;
 	u32 hcfg;
-	u32 reg40_mask = 0x30000 << (channel<<1);
+	u32 reg40_mask = 0xFF0000;
 	u32 reg40_set = 0;
 	u32 reg40;
-	/* FIXME: Depending on mixer selection of SPDIF out or not, select the spdif rate or the DAC rate. */
-	u32 reg71_mask = 0x03030000 ; /* Global. Set SPDIF rate. We only support 44100 to spdif, not to DAC. */
+	u32 reg71_mask;
+	u32 reg71_shift;
 	u32 reg71_set = 0;
 	u32 reg71;
 	int i;
+	unsigned long flags;
 	
-        //snd_printk("prepare:channel_number=%d, rate=%d, format=0x%x, channels=%d, buffer_size=%ld, period_size=%ld, periods=%u, frames_to_bytes=%d\n",channel, runtime->rate, runtime->format, runtime->channels, runtime->buffer_size, runtime->period_size, runtime->periods, frames_to_bytes(runtime, 1));
-        //snd_printk("dma_addr=%x, dma_area=%p, table_base=%p\n",runtime->dma_addr, runtime->dma_area, table_base);
-	//snd_printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",emu->buffer.addr, emu->buffer.area, emu->buffer.bytes);
+	/* FIXME CLEAN UP IF spdif_enable IS CHANGED WHILE CHANNELS ARE OPENED
+	 * OR PREVENT THIS FROM HAPPENING. */
+	if (emu->spdif_enable)
+		reg71_shift = 24; /* SPDIF Output Rate */
+	else
+		reg71_shift = 16; /* I2S Output Rate */
+	reg71_mask = 0x3 << reg71_shift;
+
+	/*printk(KERN_DEBUG DRVNAME ": prepare_playback: "
+		"channel_number=%d, rate=%d, format=0x%x, channels=%d, "
+		"buffer_size=%ld,period_size=%ld, periods=%u, "
+		"frames_to_bytes=%d\n",
+		channel, runtime->rate, runtime->format, runtime->channels,
+		runtime->buffer_size, runtime->period_size, runtime->periods,
+		frames_to_bytes(runtime, 1));*/
+	/*printk("dma_addr=%x, dma_area=%p, table_base=%p\n",
+		runtime->dma_addr,runtime->dma_area, table_base);*/
+	/*printk("dma_addr=%x, dma_area=%p, dma_bytes(size)=%x\n",
+		emu->buffer.addr,emu->buffer.area, emu->buffer.bytes);*/
+	/* We are forced to build the settings for all the channels. */
+	spin_lock_irqsave(&emu->pcm_lock, flags);
+	epcm = runtime->private_data;
+	channel = epcm->channel_id;
+
+	snd_ca0106_rebuild_playback_channel_counters(emu, channel);
+
+	/* Determine the effects of the new settings for validation.
+	   Note that nothing is recorded permanently
+	   until the new settings are validated. */
+	count_pb_44100_chan =
+		emu->count_pb_44100_chan + runtime->rate == 44100;
+	count_pb_non_44100_chan =
+		emu->count_pb_non_44100_chan + runtime->rate != 44100;
+	count_pb_S16_chan = emu->count_pb_S16_chan +
+		runtime->format == SNDRV_PCM_FORMAT_S16_LE;
+	count_pb_S32_chan = emu->count_pb_S32_chan +
+		runtime->format == SNDRV_PCM_FORMAT_S32_LE;
+
 	/* Rate can be set per channel. */
 	/* reg40 control host to fifo */
 	/* reg71 controls DAC rate. */
-	switch (runtime->rate) {
-	case 44100:
-		reg40_set = 0x10000 << (channel<<1);
-		reg71_set = 0x01010000; 
-		break;
-        case 48000:
-		reg40_set = 0;
-		reg71_set = 0; 
-		break;
-	case 96000:
-		reg40_set = 0x20000 << (channel<<1);
-		reg71_set = 0x02020000; 
-		break;
-	case 192000:
-		reg40_set = 0x30000 << (channel<<1);
-		reg71_set = 0x03030000; 
-		break;
-	default:
-		reg40_set = 0;
-		reg71_set = 0; 
-		break;
+	for (chi = 0; chi < 4; ++chi) {
+		pchannel = &(emu->playback_channels[chi]);
+		if (!pchannel->use || !pchannel->epcm)
+			continue;
+		if (!pchannel->epcm->hw_reserved && chi != channel)
+			continue;
+		runtimei = pchannel->epcm->substream->runtime;
+		/* Rate can be set per channel. */
+		/* reg40 control host to fifo */
+		/* reg71 controls DAC rate. */
+		switch (runtimei->rate) {
+		case 44100:
+			/* 44100Hz is not supported for DAC. The DAC cannot be
+			clocked at 44100, only 48000 and 96000 from the CA0106
+			chip. The SPDIF can be clocked at 44100.
+			It is a hardware limitation. */
+			if (emu->spdif_enable) {
+				/* When using 44100, *all* channels
+				   must be set to that rate. */
+				reg40_set |= 0x550000;
+				reg71_set |= 0x1 << reg71_shift;
+				break;
+			} else {
+				printk(KERN_ERR DRVNAME
+					"prepare_playback: "
+					"44100Hz is invalid for DAC.\n");
+			}
+		case 48000:
+			/* reg40_set &= !(0x1 << (chi<<1)); */
+			/* reg71_set &= !(0x1 << reg71_shift); */
+			break;
+		case 96000:
+			reg40_set |= 0x20000 << (chi<<1);
+			reg71_set |= 0x2 << reg71_shift;
+			break;
+		case 192000:
+			reg40_set |= 0x30000 << (chi<<1);
+			reg71_set |= 0x3 << reg71_shift;
+			break;
+		default:
+			spin_unlock_irqrestore(&emu->pcm_lock, flags);
+			printk(KERN_ERR DRVNAME
+				": prepare_playback: "
+				"Bad sampling frequency %dHz.\n",
+				runtime->rate);
+			return -EINVAL;
+		}
 	}
-	/* Format is a global setting */
-	/* FIXME: Only let the first channel accessed set this. */
+	if (count_pb_44100_chan && count_pb_non_44100_chan) {
+		spin_unlock_irqrestore(&emu->pcm_lock, flags);
+		printk(KERN_ERR DRVNAME
+			"prepare_playback: requested sampling rate %dHz"
+			" conflicts with other selected sampling rates.\n",
+			runtime->rate);
+		return -EINVAL;
+	}
+	if (count_pb_S16_chan && count_pb_S32_chan) {
+		spin_unlock_irqrestore(&emu->pcm_lock, flags);
+		printk(KERN_ERR DRVNAME
+			"prepare_playback: requested sample format %d"
+			" conflicts with other selected sample formats.\n",
+			runtime->format);
+		return -EINVAL;
+	}
+	/* Requested sample rate and format are now validated.
+	   Commit the change. */
+	emu->count_pb_44100_chan = count_pb_44100_chan;
+	emu->count_pb_non_44100_chan = count_pb_non_44100_chan;
+	emu->count_pb_S16_chan = count_pb_S16_chan;
+	emu->count_pb_S32_chan = count_pb_S32_chan;
+	epcm->hw_reserved = 1;
+
+	snd_printdd(KERN_DEBUG DRVNAME ": prepare_playback: any_44100=%d, "
+		"any_non_44100=%d, spdif=%d.\n",
+		emu->count_pb_44100_chan, emu->count_pb_non_44100_chan,
+		emu->spdif_enable);
+	spin_unlock_irqrestore(&emu->pcm_lock, flags);
+
+	/* Format is a global setting. */
+	/* Only the first channel accessed can set this
+	   (enforced by constraints). */
 	switch (runtime->format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		hcfg_set = 0;
@@ -736,10 +1005,13 @@ static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 	reg71 = (reg71 & ~reg71_mask) | reg71_set;
 	snd_ca0106_ptr_write(emu, 0x71, 0, reg71);
 
-	/* FIXME: Check emu->buffer.size before actually writing to it. */
-        for(i=0; i < runtime->periods; i++) {
-		table_base[i*2] = runtime->dma_addr + (i * period_size_bytes);
-		table_base[i*2+1] = period_size_bytes << 16;
+	table_base = (u32 *)(emu->buffer.area+(8*16*channel));
+	if (!snd_BUG_ON(8*16*channel+runtime->periods*2 > emu->buffer.bytes)) {
+		for (i = 0; i < runtime->periods; i++) {
+			table_base[i*2] = runtime->dma_addr +
+				(i * period_size_bytes);
+			table_base[i*2+1] = period_size_bytes << 16;
+		}
 	}
  
 	snd_ca0106_ptr_write(emu, PLAYBACK_LIST_ADDR, channel, emu->buffer.addr+(8*16*channel));
@@ -1335,6 +1607,7 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
 	chip->irq = -1;
 
 	spin_lock_init(&chip->emu_lock);
+	spin_lock_init(&chip->pcm_lock);
   
 	chip->port = pci_resource_start(pci, 0);
 	if ((chip->res_port = request_region(chip->port, 0x20,
@@ -1351,8 +1624,9 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
 		return -EBUSY;
 	}
 	chip->irq = pci->irq;
-  
- 	/* This stores the periods table. */ 
+
+	/* This stores the periods table. FIXME Only the first 512 bytes
+	   appear to be used (for playback buffers) */
 	if(snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, snd_dma_pci_data(pci), 1024, &chip->buffer) < 0) {
 		snd_ca0106_free(chip);
 		return -ENOMEM;
@@ -1363,8 +1637,8 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
 	pci_read_config_dword(pci, PCI_SUBSYSTEM_VENDOR_ID, &chip->serial);
 	pci_read_config_word(pci, PCI_SUBSYSTEM_ID, &chip->model);
 #if 1
-	printk(KERN_INFO "snd-ca0106: Model %04x Rev %08x Serial %08x\n", chip->model,
-	       pci->revision, chip->serial);
+	printk(KERN_INFO DRVNAME ": Model %04x Rev %08x Serial %08x\n",
+		chip->model, pci->revision, chip->serial);
 #endif
 	strcpy(card->driver, "CA0106");
 	strcpy(card->shortname, "CA0106");
@@ -1378,7 +1652,9 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
 	}
 	chip->details = c;
 	if (subsystem[dev]) {
-		printk(KERN_INFO "snd-ca0106: Sound card name=%s, subsystem=0x%x. Forced to subsystem=0x%x\n",
+		printk(KERN_INFO DRVNAME
+			": Sound card name=%s, subsystem=0x%x. "
+			"Forced to subsystem=0x%x\n",
                         c->name, chip->serial, subsystem[dev]);
 	}
 
-- 
1.5.4.3
