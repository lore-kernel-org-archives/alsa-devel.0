From: Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 5/7] ASoC: hda - add Skylake HD audio
	driver
Date: Fri, 17 Apr 2015 17:32:42 +0530
Message-ID: <20150417120242.GD30624@intel.com>
References: <1429262000-21517-1-git-send-email-vinod.koul@intel.com>
 <1429262000-21517-6-git-send-email-vinod.koul@intel.com>
 <s5hr3rjxe4l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 06724260577
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 14:07:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hr3rjxe4l.wl-tiwai@suse.de>
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

On Fri, Apr 17, 2015 at 12:06:50PM +0200, Takashi Iwai wrote:
> At Fri, 17 Apr 2015 14:43:18 +0530,
> Vinod Koul wrote:
> > 
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > This patch adds ASoC Skylake HD audio controller driver
> > 
> > Signed-off-by: Jeeja KP <jeeja.kp@intel.com>
> > Signed-off-by: Subhransu S. Prusty <subhransu.s.prusty@intel.com>
> > Signed-off-by: Vinod Koul <vinod.koul@intel.com>
> > ---
> >  include/sound/hdaudio.h |    1 +
> >  sound/soc/hda/hda_skl.c |  748 +++++++++++++++++++++++++++++++++++++++++++++++
> >  sound/soc/hda/hda_skl.h |   44 +++
> >  3 files changed, 793 insertions(+)
> >  create mode 100644 sound/soc/hda/hda_skl.c
> >  create mode 100644 sound/soc/hda/hda_skl.h
> > 
> > diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
> > index 227e71956c35..a8feb761e00d 100644
> > --- a/include/sound/hdaudio.h
> > +++ b/include/sound/hdaudio.h
> > @@ -393,6 +393,7 @@ struct hdac_stream {
> >  	bool running:1;
> >  	bool no_period_wakeup:1;
> >  	bool locked:1;
> > +	bool prepared:1;
> >  
> >  	/* timestamp */
> >  	unsigned long start_wallclk;	/* start + minimum wallclk */
> 
> OK, this chunk should be in the earlier patch.
> Or I'll apply it now independently.
> 
> 
> > diff --git a/sound/soc/hda/hda_skl.c b/sound/soc/hda/hda_skl.c
> > new file mode 100644
> > index 000000000000..8a66ef5a4ed8
> > --- /dev/null
> > +++ b/sound/soc/hda/hda_skl.c
> > @@ -0,0 +1,748 @@
> > +/*
> > + *  hda_skl.c - Implementation of primary ASoC Intel HD Audio driver
> > + *
> > + *  Copyright (C) 2015 Intel Corp
> > + *  Author: Jeeja KP <jeeja.kp@intel.com>
> > + *
> > + *  Copyright (c) 2004 Takashi Iwai <tiwai@suse.de>
> > + *                     PeiSen Hou <pshou@realtek.com.tw>
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
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/moduleparam.h>
> > +#include <linux/pci.h>
> > +#include <linux/mutex.h>
> > +#include <linux/io.h>
> > +#include <linux/pm_runtime.h>
> > +
> > +#include <linux/platform_device.h>
> > +#include <sound/core.h>
> > +#include <sound/pcm.h>
> > +#include <sound/hda_register.h>
> > +#include <sound/hdaudio.h>
> > +#include "hda_skl.h"
> > +
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_SUPPORTED_DEVICE("{Intel, PCH},");
> > +MODULE_DESCRIPTION("Intel aDSP HDA driver");
> > +
> > +/*
> > + * initialize the PCI registers
> > + */
> > +/* update bits in a PCI register byte */
> > +static void update_pci_byte(struct pci_dev *pci, unsigned int reg,
> > +			    unsigned char mask, unsigned char val)
> > +{
> > +	unsigned char data;
> > +
> > +	pci_read_config_byte(pci, reg, &data);
> > +	data &= ~mask;
> > +	data |= (val & mask);
> > +	pci_write_config_byte(pci, reg, data);
> > +}
> > +
> > +static void azx_init_pci(struct hdac_bus *chip)
> > +{
> > +	struct hda_soc_bus *hda = container_of(chip, struct hda_soc_bus, chip);
> > +
> > +	/* Clear bits 0-2 of PCI register TCSEL (at offset 0x44)
> > +	 * TCSEL == Traffic Class Select Register, which sets PCI express QOS
> > +	 * Ensuring these bits are 0 clears playback static on some HD Audio
> > +	 * codecs.
> > +	 * The PCI register TCSEL is defined in the Intel manuals.
> > +	 */
> > +	dev_dbg(chip->dev, "Clearing TCSEL\n");
> > +	update_pci_byte(hda->pci, AZX_PCIREG_TCSEL, 0x07, 0);
> > +}
> > +
> > +irqreturn_t azx_interrupt(int irq, void *dev_id)
> > +{
> > +	struct hdac_bus *chip = dev_id;
> > +	u32 status;
> > +
> > +#ifdef CONFIG_PM
> > +	if (!pm_runtime_active(chip->dev))
> > +		return IRQ_NONE;
> > +#endif
> > +
> > +	spin_lock(&chip->reg_lock);
> > +
> > +	status = snd_hdac_chip_readl(chip, INTSTS);
> > +	if (status == 0 || status == 0xffffffff) {
> > +		spin_unlock(&chip->reg_lock);
> > +		return IRQ_NONE;
> > +	}
> > +	spin_unlock(&chip->reg_lock);
> > +
> > +	return IRQ_WAKE_THREAD;
> > +}
> > +
> > +irqreturn_t azx_threaded_handler(int irq, void *dev_id)
> > +{
> > +	struct hdac_bus *chip = dev_id;
> > +	u32 status;
> > +	unsigned long cookie;
> > +
> > +	status = snd_hdac_chip_readl(chip, INTSTS);
> > +	spin_lock_irqsave(&chip->reg_lock, cookie);
> > +
> > +	snd_hdac_bus_handle_stream_irq(chip, status, &azx_position_check);
> > +
> > +	/* clear rirb int */
> > +	status = snd_hdac_chip_readb(chip, RIRBSTS);
> > +	if (status & RIRB_INT_MASK) {
> > +		if (status & RIRB_INT_RESPONSE)
> > +			snd_hdac_bus_update_rirb(chip);
> > +		snd_hdac_chip_writeb(chip, RIRBSTS, RIRB_INT_MASK);
> > +	}
> > +
> > +	spin_unlock_irqrestore(&chip->reg_lock, cookie);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> > +/* initialize SD streams, use seprate streeam tag for PB and CP */
> > +int azx_init_stream(struct hdac_bus *chip, int num_stream, int direction)
> 
> Missing static.
> 
> > +{
> > +	int i, tag;
> > +	int stream_tag = 0;
> > +
> > +	/* initialize each stream (aka device)
> > +	 * assign the starting bdl address to each stream (device)
> > +	 * and initialize
> > +	 */
> > +	for (i = 0; i < num_stream; i++) {
> > +		struct hdac_stream *hdac_stream =
> > +			devm_kzalloc(chip->dev, sizeof(*hdac_stream), GFP_KERNEL);
> 
> hdac_bus_exit() has a check of list_empty() for the stream list.
> It means that it expects that the driver cleans up the stream list
> beforehand properly.  That is, devm doesn't work well because it'll be
> performed after that...  We can get rid of the check, too, if
> preferred, of course.
Okay, i think would prefer later as devm_ eases drivers job :)
Will send patch for that

> 
> 
> > +		 if (!hdac_stream) {
> > +			dev_err(chip->dev, "kzalloc block failed");
> > +			return -ENOMEM;
> > +		}
> > +		tag = ++stream_tag;
> > +		snd_hdac_stream_init(chip, hdac_stream, i, direction, tag);
> > +		list_add_tail(&hdac_stream->list, &chip->stream_list);
> > +	}
> > +	return 0;
> > +}
> > +
> > +/* calculate runtime delay from LPIB */
> > +int azx_get_delay_from_lpib(struct hdac_bus *chip,
> > +				struct hdac_stream *azx_dev,
> > +				unsigned int pos)
> > +{
> > +	struct snd_pcm_substream *substream = azx_dev->substream;
> > +	int stream = substream->stream;
> > +	unsigned int lpib_pos = snd_hdac_stream_get_pos_lpib(azx_dev);
> > +	int delay;
> > +
> > +	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> > +		delay = pos - lpib_pos;
> > +	else
> > +		delay = lpib_pos - pos;
> > +	if (delay < 0) {
> > +		if (delay >= azx_dev->delay_negative_threshold)
> > +			delay = 0;
> > +		else
> > +			delay += azx_dev->bufsize;
> > +	}
> > +
> > +	if (delay >= azx_dev->period_bytes) {
> > +		dev_info(chip->dev,
> > +			 "Unstable LPIB (%d >= %d); disabling LPIB delay counting\n",
> > +			 delay, azx_dev->period_bytes);
> > +		delay = 0;
> > +	}
> > +
> > +	return bytes_to_frames(substream->runtime, delay);
> > +}
> > +
> > +/*
> > + * Check whether the current DMA position is acceptable for updating
> > + * periods.  Returns non-zero if it's OK.
> > + *
> > + * Many HD-audio controllers appear pretty inaccurate about
> > + * the update-IRQ timing.  The IRQ is issued before actually the
> > + * data is processed.  So, we need to process it afterwords in a
> > + * workqueue.
> > + */
> > +static int azx_position_ok(struct hdac_bus *chip, struct hdac_stream *azx_dev)
> > +{
> > +	u32 wallclk;
> > +	unsigned int pos = 0;
> > +
> > +	wallclk = snd_hdac_chip_readl(chip, WALLCLK) - azx_dev->start_wallclk;
> > +	if (wallclk < (azx_dev->period_wallclk * 2) / 3)
> > +		return -1;	/* bogus (too early) interrupt */
> > +
> > +	if (chip->use_posbuf) {
> > +		/* use the position buffer as default */
> > +		pos = snd_hdac_stream_get_pos_posbuf(azx_dev);
> > +		if (!pos || pos == (u32)-1) {
> > +			dev_info(chip->dev,
> > +				 "Invalid pos buffer, using LPIB read method instead.\n");
> > +			pos = snd_hdac_stream_get_pos_lpib(azx_dev);
> > +		}
> > +	}
> > +
> > +	if (pos >= azx_dev->bufsize)
> > +		pos = 0;
> > +
> > +	if (WARN_ONCE(!azx_dev->period_bytes,
> > +		      "hda-skl: zero azx_dev->period_bytes"))
> > +		return -1; /* this shouldn't happen! */
> > +	if (wallclk < (azx_dev->period_wallclk * 5) / 4 &&
> > +	    pos % azx_dev->period_bytes > azx_dev->period_bytes / 2)
> > +		/* NG - it's below the first next period boundary */
> > +		return chip->bdl_pos_adj ? 0 : -1;
> > +	azx_dev->start_wallclk += wallclk;
> > +	return 1; /* OK, it's fine */
> > +}
> > +
> > +/* called from IRQ */
> > +void azx_position_check(struct hdac_bus *chip, struct hdac_stream *azx_dev)
> > +{
> > +	if (azx_position_ok(chip, azx_dev) > 0)
> > +		snd_pcm_period_elapsed(azx_dev->substream);
> > +}
> > +
> > +static int azx_acquire_irq(struct hdac_bus *chip, int do_disconnect)
> > +{
> > +	struct hda_soc_bus *hda = container_of(chip, struct hda_soc_bus, chip);
> > +
> > +	if (request_threaded_irq(hda->pci->irq, azx_interrupt,
> > +			azx_threaded_handler,
> > +			hda->msi ? 0 : IRQF_SHARED,
> > +			KBUILD_MODNAME, chip)) {
> > +		dev_err(chip->dev,
> > +			"unable to grab IRQ %d, disabling device\n",
> > +			hda->pci->irq);
> > +		return -1;
> > +	}
> > +	pci_intx(hda->pci, !hda->msi);
> 
> You should keep the irq number tracking in bus->irq.  Otherwise it may
> result in a wrong free_irq() in the error paths....
ah yes missed that, will update

> 
> > +	return 0;
> > +}
> > +
> > +#ifdef CONFIG_PM_SLEEP
> > +/*
> > + * power management
> > + */
> > +static int azx_suspend(struct device *dev)
> > +{
> > +	struct pci_dev *pci = to_pci_dev(dev);
> > +	struct hdac_bus *chip  = pci_get_drvdata(pci);
> > +	struct hda_soc_bus *hda = container_of(chip, struct hda_soc_bus, chip);
> > +
> > +	snd_hdac_bus_stop_chip(chip);
> > +	snd_hdac_bus_enter_link_reset(chip);
> > +	if (pci->irq >= 0)
> 
> .... here check bus->irq.
Yup

-- 
~Vinod
