From: Ben Stanley <Ben.Stanley@exemail.com.au>
Subject: Re: [PATCH 1/2] ca0106 playback 44100Hz support
	to	SPDIF	and	playback	format & rate constraints
Date: Wed, 03 Sep 2008 03:11:07 +1000
Message-ID: <1220375467.7459.8.camel@localhost>
References: <1219415921.32652.254.camel@localhost>
	<s5h63ptf48b.wl%tiwai@suse.de> <1219502224.15980.32.camel@localhost>
	<s5h7ia5dpe0.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.po.exetel.com.au (pecan.exetel.com.au [220.233.0.17])
	by alsa0.perex.cz (Postfix) with ESMTP id C7B5024700
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Sep 2008 19:11:13 +0200 (CEST)
In-Reply-To: <s5h7ia5dpe0.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

Further to your previous comments [1], I have attempted to address the
locking issues. I have re-designed the code to simplify the locking
problems.

This is the patch against alsa-kmirror.

Signed-off-by: Ben Stanley Ben.Stanley@exemail.com.au

[1] http://thread.gmane.org/gmane.linux.alsa.devel/55527/focus=55539


---
 pci/ca0106/ca0106.h      |   13 ++-
 pci/ca0106/ca0106_main.c |  367 ++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 347 insertions(+), 33 deletions(-)

diff --git a/pci/ca0106/ca0106.h b/pci/ca0106/ca0106.h
index 74175fc..bf502b5 100644
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
@@ -684,6 +689,7 @@ struct snd_ca0106 {
 	unsigned short model;		/* subsystem id */
 
 	spinlock_t emu_lock;
+	spinlock_t pcm_lock;
 
 	struct snd_ac97 *ac97;
 	struct snd_pcm *pcm;
@@ -703,6 +709,11 @@ struct snd_ca0106 {
 	struct snd_ca_midi midi2;
 
 	u16 spi_dac_reg[16];
+
+	unsigned short count_pb_44100_chan;
+	unsigned short count_pb_non_44100_chan;
+	unsigned short count_pb_S16_chan;
+	unsigned short count_pb_S32_chan;
 };
 
 int snd_ca0106_mixer(struct snd_ca0106 *emu);
diff --git a/pci/ca0106/ca0106_main.c b/pci/ca0106/ca0106_main.c
index a7d8966..806f34c 100644
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
@@ -319,6 +325,93 @@ static struct snd_pcm_hardware snd_ca0106_capture_hw = {
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
+	if (snd_BUG_ON(!chip))
+		return -EINVAL;
+
+	spin_lock(&chip->pcm_lock);
+	if (chip->spdif_enable) {
+		if (snd_BUG_ON(chip->count_pb_44100_chan &&
+			 chip->count_pb_non_44100_chan)) {
+			spin_unlock(&chip->pcm_lock);
+			return -EINVAL;
+		}
+		if (snd_BUG_ON(chip->count_pb_44100_chan +
+			 chip->count_pb_non_44100_chan > 4)) {
+			spin_unlock(&chip->pcm_lock);
+			return -EINVAL;
+		}
+		/* Compute the mask applied to all_spdif_playback_rates */
+		if (chip->count_pb_44100_chan)
+			mask = 0x1;
+		else if (chip->count_pb_non_44100_chan)
+			mask = 0xE;
+		else
+			mask = 0xF;
+	} else {
+		/* 44100Hz is not supported for DAC (FIXME Why?) */
+		mask = 0xE;
+	}
+	snd_printdd("snd_hw_rule_playback_rate: any_44100=%d, "
+		"any_non_44100=%d, mask=0x%X, spdif=%d\n",
+		chip->count_pb_44100_chan,
+		chip->count_pb_non_44100_chan,
+		mask, chip->spdif_enable);
+	spin_unlock(&chip->pcm_lock);
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
+	struct snd_mask fmt, *f = hw_param_mask(
+					params, SNDRV_PCM_HW_PARAM_FORMAT);
+	int result;
+	if (snd_BUG_ON(!chip))
+		return -EINVAL;
+	snd_mask_none(&fmt);
+
+	spin_lock(&chip->pcm_lock);
+	if (snd_BUG_ON(chip->count_pb_S16_chan &&
+		 chip->count_pb_S32_chan)) {
+		spin_unlock(&chip->pcm_lock);
+		return -EINVAL;
+	}
+	if (snd_BUG_ON(chip->count_pb_S16_chan +
+		 chip->count_pb_S32_chan > 4)) {
+		spin_unlock(&chip->pcm_lock);
+		return -EINVAL;
+	}
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
+	spin_unlock(&chip->pcm_lock);
+	return result;
+}
+
 unsigned int snd_ca0106_ptr_read(struct snd_ca0106 * emu, 
 					  unsigned int reg, 
 					  unsigned int chn)
@@ -509,10 +602,24 @@ static int snd_ca0106_pcm_open_playback_channel(struct snd_pcm_substream *substr
         //printk("open:channel_id=%d, chip=%p, channel=%p\n",channel_id, chip, channel);
         //channel->interrupt = snd_ca0106_pcm_channel_interrupt;
 	channel->epcm = epcm;
-	if ((err = snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
+	err = snd_pcm_hw_constraint_integer(
+			runtime, SNDRV_PCM_HW_PARAM_PERIODS);
+	if (err < 0)
                 return err;
-	if ((err = snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64)) < 0)
+	err = snd_pcm_hw_constraint_step(
+			runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 64);
+	if (err < 0)
                 return err;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_RATE,
+			hw_rule_playback_rate, (void *)chip,
+			SNDRV_PCM_HW_PARAM_RATE, -1);
+	if (err < 0)
+		return err;
+	err = snd_pcm_hw_rule_add(runtime, 0, SNDRV_PCM_HW_PARAM_FORMAT,
+		       hw_rule_playback_format, (void *)chip,
+			SNDRV_PCM_HW_PARAM_FORMAT, -1);
+	if (err < 0)
+		return err;
 	snd_pcm_set_sync(substream);
 
 	if (chip->details->spi_dac && channel_id != PCM_FRONT_CHANNEL) {
@@ -647,6 +754,55 @@ static int snd_ca0106_pcm_hw_params_playback(struct snd_pcm_substream *substream
 /* hw_free callback */
 static int snd_ca0106_pcm_hw_free_playback(struct snd_pcm_substream *substream)
 {
+	struct snd_ca0106 *chip = snd_pcm_substream_chip(substream);
+	struct snd_pcm_runtime *runtime = substream->runtime, *runtimei;
+	struct snd_ca0106_pcm *epcm = runtime->private_data;
+	struct snd_ca0106_channel *pchannel;
+	int channel = epcm->channel_id, chi;
+
+	spin_lock(&chip->pcm_lock);
+	epcm->hw_reserved = 0;
+	chip->count_pb_44100_chan = chip->count_pb_non_44100_chan = 0;
+	chip->count_pb_S16_chan = chip->count_pb_S32_chan = 0;
+	for (chi = 0; chi < 4; ++chi) {
+		if (chi == channel)
+			continue;
+		pchannel = &(chip->playback_channels[chi]);
+		if (!pchannel->use)
+			continue;
+		if (snd_BUG_ON(!pchannel->epcm)) {
+			spin_unlock(&chip->pcm_lock);
+			return -EINVAL;
+		}
+		if (!pchannel->epcm->hw_reserved)
+			continue;
+		if (snd_BUG_ON(!pchannel->epcm->substream)) {
+			spin_unlock(&chip->pcm_lock);
+			return -EINVAL;
+		}
+		if (snd_BUG_ON(!pchannel->epcm->substream->runtime)) {
+			spin_unlock(&chip->pcm_lock);
+			return -EINVAL;
+		}
+		runtimei = pchannel->epcm->substream->runtime;
+		chip->count_pb_44100_chan += runtimei->rate == 44100;
+		chip->count_pb_non_44100_chan += runtimei->rate != 44100;
+		chip->count_pb_S16_chan +=
+			runtimei->format == SNDRV_PCM_FORMAT_S16_LE;
+		chip->count_pb_S32_chan +=
+			runtimei->format == SNDRV_PCM_FORMAT_S32_LE;
+	}
+	snd_BUG_ON(chip->count_pb_44100_chan && chip->count_pb_non_44100_chan);
+	snd_BUG_ON(chip->count_pb_44100_chan +
+		chip->count_pb_non_44100_chan > 4);
+	snd_BUG_ON(chip->count_pb_S16_chan && chip->count_pb_S32_chan);
+	snd_BUG_ON(chip->count_pb_S16_chan + chip->count_pb_S32_chan > 4);
+	snd_printdd(KERN_DEBUG DRVNAME ": free_playback: any_44100=%d, "
+		"any_non_44100=%d, spdif=%d.\n",
+		chip->count_pb_44100_chan, chip->count_pb_non_44100_chan,
+		emu->spdif_enable);
+	spin_unlock(&chip->pcm_lock);
+
 	return snd_pcm_lib_free_pages(substream);
 }
 
@@ -668,53 +824,196 @@ static int snd_ca0106_pcm_hw_free_capture(struct snd_pcm_substream *substream)
 static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 {
 	struct snd_ca0106 *emu = snd_pcm_substream_chip(substream);
-	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_pcm_runtime *runtime = substream->runtime, *runtimei;
 	struct snd_ca0106_pcm *epcm = runtime->private_data;
-	int channel = epcm->channel_id;
+	struct snd_ca0106_channel *pchannel;
+	int channel = epcm->channel_id, chi;
+	unsigned short count_pb_44100_chan, count_pb_non_44100_chan;
+	unsigned short count_pb_S16_chan, count_pb_S32_chan;
 	u32 *table_base = (u32 *)(emu->buffer.area+(8*16*channel));
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
+	spin_lock(&emu->pcm_lock);
+	emu->count_pb_44100_chan = emu->count_pb_non_44100_chan = 0;
+	emu->count_pb_S16_chan = emu->count_pb_S32_chan = 0;
+	for (chi = 0; chi < 4; ++chi) {
+		if (chi == channel)
+			continue;
+		pchannel = &(emu->playback_channels[chi]);
+		if (!pchannel->use)
+			continue;
+		if (snd_BUG_ON(!pchannel->epcm)) {
+			spin_unlock(&emu->pcm_lock);
+			return -EINVAL;
+		}
+		if (!pchannel->epcm->hw_reserved)
+			continue;
+		if (snd_BUG_ON(!pchannel->epcm->substream)) {
+			spin_unlock(&emu->pcm_lock);
+			return -EINVAL;
+		}
+		if (snd_BUG_ON(!pchannel->epcm->substream->runtime)) {
+			spin_unlock(&emu->pcm_lock);
+			return -EINVAL;
+		}
+		runtimei = pchannel->epcm->substream->runtime;
+		emu->count_pb_44100_chan += runtimei->rate == 44100;
+		emu->count_pb_non_44100_chan += runtimei->rate != 44100;
+		emu->count_pb_S16_chan +=
+			runtimei->format == SNDRV_PCM_FORMAT_S16_LE;
+		emu->count_pb_S32_chan +=
+			runtimei->format == SNDRV_PCM_FORMAT_S32_LE;
+		/* Rate can be set per channel. */
+		/* reg40 control host to fifo */
+		/* reg71 controls DAC rate. */
+		switch (runtimei->rate) {
+		case 44100:
+			/* We only support 44100 to spdif, not to DAC.
+			   (FIXME WHY?)*/
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
+			printk(KERN_ERR DRVNAME
+				": prepare_playback: "
+				"Bad sampling frequency %d.\n",
+				runtimei->rate);
+		}
+	}
+	snd_BUG_ON(emu->count_pb_44100_chan && emu->count_pb_non_44100_chan);
+	snd_BUG_ON(emu->count_pb_44100_chan +
+		emu->count_pb_non_44100_chan > 4);
+	snd_BUG_ON(emu->count_pb_S16_chan && emu->count_pb_S32_chan);
+	snd_BUG_ON(emu->count_pb_S16_chan + emu->count_pb_S32_chan > 4);
+
+	count_pb_44100_chan =
+		emu->count_pb_44100_chan + runtime->rate == 44100;
+	count_pb_non_44100_chan =
+		emu->count_pb_non_44100_chan + runtime->rate != 44100;
+	count_pb_S16_chan = emu->count_pb_S16_chan +
+		runtime->format == SNDRV_PCM_FORMAT_S16_LE;
+	count_pb_S32_chan = emu->count_pb_S32_chan +
+		runtime->format == SNDRV_PCM_FORMAT_S32_LE;
+	snd_BUG_ON(count_pb_44100_chan + count_pb_non_44100_chan > 4);
+	snd_BUG_ON(count_pb_S16_chan + count_pb_S32_chan > 4);
+
 	/* Rate can be set per channel. */
 	/* reg40 control host to fifo */
 	/* reg71 controls DAC rate. */
 	switch (runtime->rate) {
 	case 44100:
-		reg40_set = 0x10000 << (channel<<1);
-		reg71_set = 0x01010000; 
-		break;
-        case 48000:
-		reg40_set = 0;
-		reg71_set = 0; 
+		/* We only support 44100 to spdif, not to DAC.
+		   (FIXME WHY?)*/
+		if (emu->spdif_enable) {
+			/* When using 44100, *all* channels
+			   must be set to that rate. */
+			reg40_set |= 0x550000;
+			reg71_set |= 0x1 << reg71_shift;
+			break;
+		} else {
+			printk(KERN_ERR DRVNAME
+				"prepare_playback: "
+				"44100Hz is invalid for DAC.\n");
+		}
+	case 48000:
+		/* reg40_set &= !(0x1 << (channel<<1)); */
+		/* reg71_set &= !(0x1 << reg71_shift); */
 		break;
 	case 96000:
-		reg40_set = 0x20000 << (channel<<1);
-		reg71_set = 0x02020000; 
+		reg40_set |= 0x20000 << (channel<<1);
+		reg71_set |= 0x2 << reg71_shift;
 		break;
 	case 192000:
-		reg40_set = 0x30000 << (channel<<1);
-		reg71_set = 0x03030000; 
+		reg40_set |= 0x30000 << (channel<<1);
+		reg71_set |= 0x3 << reg71_shift;
 		break;
 	default:
-		reg40_set = 0;
-		reg71_set = 0; 
-		break;
+		spin_unlock(&emu->pcm_lock);
+		printk(KERN_ERR DRVNAME
+			": prepare_playback: Bad sampling frequency %dHz.\n",
+			runtime->rate);
+		return -EINVAL;
 	}
-	/* Format is a global setting */
-	/* FIXME: Only let the first channel accessed set this. */
+	if (count_pb_44100_chan && count_pb_non_44100_chan) {
+		spin_unlock(&emu->pcm_lock);
+		printk(KERN_ERR DRVNAME
+			"prepare_playback: requested sampling rate %dHz"
+			" conflicts with other selected sampling rates.\n",
+			runtime->rate);
+		return -EINVAL;
+	}
+	if (count_pb_S16_chan && count_pb_S32_chan) {
+		spin_unlock(&emu->pcm_lock);
+		printk(KERN_ERR DRVNAME
+			"prepare_playback: requested sample format %d"
+			" conflicts with other selected sample formats.\n",
+			runtime->format);
+		return -EINVAL;
+	}
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
+	/* Format is a global setting. */
+	/* Only the first channel accessed can set this
+	   (enforced by constraints). */
 	switch (runtime->format) {
 	case SNDRV_PCM_FORMAT_S16_LE:
 		hcfg_set = 0;
@@ -726,6 +1025,7 @@ static int snd_ca0106_pcm_prepare_playback(struct snd_pcm_substream *substream)
 		hcfg_set = 0;
 		break;
 	}
+	spin_unlock(&emu->pcm_lock);
 	hcfg = inl(emu->port + HCFG) ;
 	hcfg = (hcfg & ~hcfg_mask) | hcfg_set;
 	outl(hcfg, emu->port + HCFG);
@@ -1336,6 +1636,7 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
 	chip->irq = -1;
 
 	spin_lock_init(&chip->emu_lock);
+	spin_lock_init(&chip->pcm_lock);
   
 	chip->port = pci_resource_start(pci, 0);
 	if ((chip->res_port = request_region(chip->port, 0x20,
@@ -1364,8 +1665,8 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
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
@@ -1379,7 +1680,9 @@ static int __devinit snd_ca0106_create(int dev, struct snd_card *card,
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
