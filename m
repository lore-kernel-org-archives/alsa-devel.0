From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 4/7] ASoC: hda - add Skylake platform
	driver
Date: Fri, 17 Apr 2015 17:21:20 +0530
Message-ID: <20150417115120.GC30624@intel.com>
References: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
 <1429262000-21517-5-git-send-email-vinod.koul@intel.com>
 <s5hsibzxekr.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id E809D26053E
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 13:56:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hsibzxekr.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Jeeja KP <jeeja.kp@intel.com>, alsa-devel@alsa-project.org, broonie@kernel.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 17, 2015 at 11:57:08AM +0200, Takashi Iwai wrote:
> At Fri, 17 Apr 2015 14:43:17 +0530,
> Vinod Koul wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > Defines SoC cpu dais, DMA driver ops and
> > implements ALSA operations for SKL.
> > 
> > Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  sound/soc/hda/hda_skl_pcm.c |  498 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 498 insertions(+)
> >  create mode 100644 sound/soc/hda/hda_skl_pcm.c
> > 
> > diff --git a/sound/soc/hda/hda_skl_pcm.c b/sound/soc/hda/hda_skl_pcm.c
> > new file mode 100644
> > index 000000000000..a9d908257eaf
> > --- /dev/null
> > +++ b/sound/soc/hda/hda_skl_pcm.c
> > @@ -0,0 +1,498 @@
> > +/*
> > + *  hda_skl_pcm.c -ASOC HDA Platform driver file implementing PCM functionality
> > + *
> > + *  Copyright (C) 2015 Intel Corp
> > + *  Author:  Jeeja KP <jeeja.kp@intel.com>
> > + *
> > + *  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > + *
> > + *  This program is free software; you can redistribute it and/or modify
> > + *  it under the terms of the GNU General Public License as published by
> > + *  the Free Software Foundation; version 2 of the License.
> > + *
> > + *  This program is distributed in the hope that it will be useful, but
> > + *  WITHOUT ANY WARRANTY; without even the implied warranty of
> > + *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> > + *  General Public License for more details.
> > + *
> > + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > + *
> > + */
> > +#include <linux/pci.h>
> > +#include <sound/core.h>
> > +#include <sound/pcm.h>
> > +#include <sound/pcm_params.h>
> > +#include <sound/soc.h>
> > +#include "hda_skl.h"
> > +
> > +static struct snd_pcm_hardware azx_pcm_hw = {
> > +	.info =			(SNDRV_PCM_INFO_MMAP |
> > +				 SNDRV_PCM_INFO_INTERLEAVED |
> > +				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
> > +				 SNDRV_PCM_INFO_MMAP_VALID |
> > +				 /* No full-resume yet implemented */
> > +				 /* SNDRV_PCM_INFO_RESUME |*/
> > +				 SNDRV_PCM_INFO_PAUSE |
> > +				 SNDRV_PCM_INFO_SYNC_START |
> > +				 SNDRV_PCM_INFO_HAS_WALL_CLOCK | /* legacy */
> > +				 SNDRV_PCM_INFO_HAS_LINK_ATIME |
> > +				 SNDRV_PCM_INFO_NO_PERIOD_WAKEUP),
> > +	.formats =		SNDRV_PCM_FMTBIT_S16_LE,
> > +	.rates =		SNDRV_PCM_RATE_48000,
> > +	.rate_min =		48000,
> > +	.rate_max =		48000,
> > +	.channels_min =		2,
> > +	.channels_max =		2,
> > +	.buffer_bytes_max =	AZX_MAX_BUF_SIZE,
> > +	.period_bytes_min =	128,
> > +	.period_bytes_max =	AZX_MAX_BUF_SIZE / 2,
> > +	.periods_min =		2,
> > +	.periods_max =		AZX_MAX_FRAG,
> > +	.fifo_size =		0,
> > +};
> > +static inline
> > +struct hdac_stream *get_azx_dev(struct snd_pcm_substream *substream)
> > +{
> > +	return substream->runtime->private_data;
> > +}
> > +
> > +static struct hdac_bus *get_chip_ctx(struct snd_pcm_substream *substream)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
> > +	struct device *dev = rtd->cpu_dai->dev;
> > +	struct hdac_bus *chip = dev_get_drvdata(dev);
> > +	return chip;
> > +}
> > +
> > +static int substream_alloc_pages(struct hdac_bus *chip,
> > +				 struct snd_pcm_substream *substream,
> > +				 size_t size)
> > +{
> > +	struct hdac_stream *azx_dev = get_azx_dev(substream);
> > +	int ret;
> > +
> > +	azx_dev->bufsize = 0;
> > +	azx_dev->period_bytes = 0;
> > +	azx_dev->format_val = 0;
> > +	ret = snd_pcm_lib_malloc_pages(substream, size);
> > +	if (ret < 0)
> > +		return ret;
> > +	return 0;
> > +}
> > +
> > +static int substream_free_pages(struct hdac_bus *chip,
> > +				struct snd_pcm_substream *substream)
> > +{
> > +	return snd_pcm_lib_free_pages(substream);
> > +}
> > +
> > +void soc_hda_set_pcm_constrains(struct hdac_bus *bus,
> > +				 struct snd_pcm_runtime *runtime)
> 
> Missing static.
> 
> > +{
> > +	snd_pcm_hw_constraint_integer(runtime, SNDRV_PCM_HW_PARAM_PERIODS);
> > +
> > +	/* avoid wrap-around with wall-clock */
> > +	snd_pcm_hw_constraint_minmax(runtime, SNDRV_PCM_HW_PARAM_BUFFER_TIME,
> > +				     20,
> > +				     178000000);
> > +
> > +}
> > +
> > +static int soc_hda_pcm_open(struct snd_pcm_substream *substream,
> > +		struct snd_soc_dai *dai)
> > +{
> > +	struct hdac_bus *chip = dev_get_drvdata(dai->dev);
> > +	struct hdac_stream *azx_dev;
> > +	struct snd_pcm_runtime *runtime = substream->runtime;
> > +	struct soc_hda_dma_params *dma_params;
> > +
> > +	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
> > +	azx_dev = snd_hdac_stream_assign(chip, substream);
> > +	if (azx_dev == NULL)
> > +		return -EBUSY;
> > +
> > +	soc_hda_set_pcm_constrains(chip, runtime);
> > +
> > +	/* disable WALLCLOCK timestamps for capture streams
> > +	*  until we figure out how to handle digital inputs
> > +	*/
> > +	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
> > +		runtime->hw.info &= ~SNDRV_PCM_INFO_HAS_WALL_CLOCK; /* legacy */
> > +		runtime->hw.info &= ~SNDRV_PCM_INFO_HAS_LINK_ATIME;
> > +	}
> > +
> > +	runtime->private_data = azx_dev;
> > +
> > +	dma_params = kzalloc(sizeof(*dma_params), GFP_KERNEL);
> 
> Missing NULL check.
> 
> > +	dma_params->stream_tag = azx_dev->stream_tag;
> > +	snd_soc_dai_set_dma_data(dai, substream, (void *)dma_params);
> > +
> > +	dev_dbg(dai->dev, "stream tag set in dma params=%d\n",
> > +				 dma_params->stream_tag);
> > +	snd_pcm_set_sync(substream);
> > +	return 0;
> > +}
> > +static int soc_hda_pcm_prepare(struct snd_pcm_substream *substream,
> > +		struct snd_soc_dai *dai)
> > +{
> > +	struct snd_soc_pcm_runtime *rtd = snd_pcm_substream_chip(substream);
> > +	struct hdac_stream *azx_dev = get_azx_dev(substream);
> > +	unsigned int format_val;
> > +	int err;
> > +	struct soc_hda_dma_params *dma_params;
> > +	struct snd_soc_dai *codec_dai = rtd->codec_dai;
> > +
> > +	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
> > +	if (azx_dev->prepared) {
> 
> Oh, I didn't add prepared flag in hdac_stream.  If your driver needs
> it, too, I'll put this flag into core, too (as it's used in legacy
> driver, too).
OK will drop the prepared flag for next patch

> 
> > +		dev_dbg(dai->dev, "already stream is prepared - returning\n");
> > +		return 0;
> > +	}
> > +
> > +	dma_params  = (struct soc_hda_dma_params *)
> > +			snd_soc_dai_get_dma_data(codec_dai, substream);
> > +	format_val = dma_params->format;
> > +
> > +	dev_dbg(dai->dev, "stream_tag=%d formatvalue=%d\n",
> > +				azx_dev->stream_tag, format_val);
> > +	snd_hdac_stream_reset(azx_dev);
> > +
> > +	err = snd_hdac_stream_set_params(azx_dev, format_val);
> > +
> > +	if (err < 0)
> > +		return err;
> > +	snd_hdac_stream_setup(azx_dev);
> > +	azx_dev->prepared = 1;
> > +	return err;
> > +}
> > +
> > +static int soc_hda_pcm_hw_params(struct snd_pcm_substream *substream,
> > +				struct snd_pcm_hw_params *params,
> > +				struct snd_soc_dai *dai)
> > +{
> > +	struct hdac_bus *chip = dev_get_drvdata(dai->dev);
> > +	int ret;
> > +	struct snd_pcm_runtime *runtime = substream->runtime;
> > +
> > +	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
> > +	ret = substream_alloc_pages(chip, substream,
> > +					  params_buffer_bytes(params));
> > +
> > +	memset(substream->runtime->dma_area, 0, params_buffer_bytes(params));
> 
> Do check error before memset.  The buffer might be not allocated.
> 
> > +
> > +	dev_dbg(dai->dev, "format_val, rate=%d, ch=%d, format=%d\n",
> > +			runtime->rate, runtime->channels, runtime->format);
> > +
> > +	return ret;
> > +}
> > +
> > +static void soc_hda_pcm_close(struct snd_pcm_substream *substream,
> > +		struct snd_soc_dai *dai)
> > +{
> > +	struct hdac_stream *azx_dev = get_azx_dev(substream);
> > +	struct soc_hda_dma_params *dma_params;
> > +
> > +	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
> > +	snd_hdac_stream_release(azx_dev);
> > +	dma_params  = (struct soc_hda_dma_params *)
> > +			snd_soc_dai_get_dma_data(dai, substream);
> > +	kfree(dma_params);
> > +}
> > +
> > +static int soc_hda_pcm_hw_free(struct snd_pcm_substream *substream,
> > +		struct snd_soc_dai *dai)
> > +{
> > +	struct hdac_bus *chip = dev_get_drvdata(dai->dev);
> > +	struct hdac_stream *azx_dev = get_azx_dev(substream);
> > +
> > +	dev_dbg(dai->dev, "%s: %s\n", __func__, dai->name);
> > +
> > +	snd_hdac_stream_cleanup(azx_dev);
> > +
> > +	azx_dev->prepared = 0;
> > +
> > +	return substream_free_pages(chip, substream);
> > +}
> > +
> > +static struct snd_soc_dai_ops hda_pcm_dai_ops = {
> > +	.startup = soc_hda_pcm_open,
> > +	.shutdown = soc_hda_pcm_close,
> > +	.prepare = soc_hda_pcm_prepare,
> > +	.hw_params = soc_hda_pcm_hw_params,
> > +	.hw_free = soc_hda_pcm_hw_free,
> > +};
> > +
> > +static struct snd_soc_dai_driver soc_hda_platform_dai[] = {
> > +{
> > +	.name = "System Pin",
> > +	.ops = &hda_pcm_dai_ops,
> > +	.playback = {
> > +		.stream_name = "System Playback",
> > +		.channels_min = 2,
> > +		.channels_max = 2,
> > +		.rates = SNDRV_PCM_RATE_48000,
> > +		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +	},
> > +	.capture = {
> > +		.stream_name = "System Capture",
> > +		.channels_min = 1,
> > +		.channels_max = 2,
> > +		.rates = SNDRV_PCM_RATE_48000,
> > +		.formats = SNDRV_PCM_FMTBIT_S16_LE,
> > +	},
> > +},
> > +};
> > +
> > +static int soc_hda_platform_open(struct snd_pcm_substream *substream)
> > +{
> > +	struct snd_pcm_runtime *runtime;
> > +	struct snd_soc_pcm_runtime *rtd = substream->private_data;
> > +	struct snd_soc_dai_link *dai_link = rtd->dai_link;
> > +
> > +	dev_dbg(rtd->cpu_dai->dev, "In %s:%s\n", __func__,
> > +					dai_link->cpu_dai_name);
> > +
> > +	runtime = substream->runtime;
> > +	snd_soc_set_runtime_hwparams(substream, &azx_pcm_hw);
> > +	return 0;
> > +}
> > +
> > +static int soc_hda_platform_pcm_trigger(struct snd_pcm_substream *substream,
> > +					int cmd)
> > +{
> > +	struct hdac_bus *chip = get_chip_ctx(substream);
> > +	struct hdac_stream *azx_dev;
> > +	struct snd_pcm_substream *s;
> > +	int rstart = 0, start, nsync = 0, sbits = 0;
> > +	unsigned long cookie;
> > +
> > +	azx_dev = get_azx_dev(substream);
> > +
> > +	dev_dbg(chip->dev, "In %s cmd=%d\n", __func__, cmd);
> > +
> > +	if (!azx_dev->prepared)
> > +		return -EPIPE;
> > +
> > +	switch (cmd) {
> > +	case SNDRV_PCM_TRIGGER_START:
> > +		rstart = 1;
> > +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> > +	case SNDRV_PCM_TRIGGER_RESUME:
> > +		start = 1;
> > +		break;
> > +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> > +	case SNDRV_PCM_TRIGGER_SUSPEND:
> > +	case SNDRV_PCM_TRIGGER_STOP:
> > +		start = 0;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	snd_pcm_group_for_each_entry(s, substream) {
> > +		if (s->pcm->card != substream->pcm->card)
> > +			continue;
> > +		azx_dev = get_azx_dev(s);
> > +		sbits |= 1 << azx_dev->index;
> > +		nsync++;
> > +		snd_pcm_trigger_done(s, substream);
> > +	}
> > +
> > +	spin_lock_irqsave(&chip->reg_lock, cookie);
> > +
> > +	/* first, set SYNC bits of corresponding streams */
> > +	snd_hdac_stream_sync_trigger(azx_dev, start, sbits, 0);
> 
> The second argument must be true here...
> 
> > +	snd_pcm_group_for_each_entry(s, substream) {
> > +		if (s->pcm->card != substream->pcm->card)
> > +			continue;
> > +		azx_dev = get_azx_dev(s);
> > +		if (start)
> > +			snd_hdac_stream_start(azx_dev, rstart);
> 
> I think it's start.
> 
> > +		else
> > +			snd_hdac_stream_clear(azx_dev);
> > +	}
> > +	spin_unlock_irqrestore(&chip->reg_lock, cookie);
> > +	snd_hdac_stream_sync(azx_dev, start, sbits);
> > +	spin_lock_irqsave(&chip->reg_lock, cookie);
> > +
> > +	/* reset SYNC bits */
> > +	snd_hdac_stream_sync_trigger(azx_dev, start, sbits, 0);
> 
> .... and false here.
> 
> > +
> > +	if (start)
> > +		snd_hdac_stream_timecounter_init(azx_dev, sbits);
> > +	spin_unlock_irqrestore(&chip->reg_lock, cookie);
> > +	return 0;
> > +}
> > +
> > +unsigned int azx_get_position(struct hdac_stream *azx_dev, int codec_delay)
> 
> Missing static.
Thanks for the quick review, will send updated one after Mark reviews :)

-- 
~Vinod
