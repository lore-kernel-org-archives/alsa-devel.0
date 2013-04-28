From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v2] Add M2Tech hiFace USB-SPDIF driver
Date: Sun, 28 Apr 2013 22:59:48 +0200
Message-ID: <20130428225948.06b5af2767e8711df9aa3cde@studenti.unina.it>
References: <1360537887-9427-1-git-send-email-ao2@amarulasolutions.com>
 <1360775505-13106-1-git-send-email-ao2@amarulasolutions.com>
 <512798F4.1030607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <512798F4.1030607@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Antonio Ospite <ao2@amarulasolutions.com>, Clemens Ladisch <clemens@ladisch.de>, fchecconi@gmail.com, Pietro Cipriano <p.cipriano@m2tech.biz>, alberto@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

On Fri, 22 Feb 2013 17:12:36 +0100
Daniel Mack <zonque@gmail.com> wrote:

> Hi Antonio,
> 
> a couple of more things that I stumbled over.
> 

Thanks, some comments inlined below.

> 
> 
> On 13.02.2013 18:11, Antonio Ospite wrote:
> > Add driver for M2Tech hiFace USB-SPDIF interface and compatible devices.
> > 
> > M2Tech hiFace and compatible devices offer a Hi-End S/PDIF Output
> > Interface, see http://www.m2tech.biz/hiface.html
> > 
> > The supported products are:
> > 
> >   * M2Tech Young
> >   * M2Tech hiFace
> >   * M2Tech North Star
> >   * M2Tech W4S Young
> >   * M2Tech Corrson
> >   * M2Tech AUDIA
> >   * M2Tech SL Audio
> >   * M2Tech Empirical
> >   * M2Tech Rockna
> >   * M2Tech Pathos
> >   * M2Tech Metronome
> >   * M2Tech CAD
> >   * M2Tech Audio Esclusive
> >   * M2Tech Rotel
> >   * M2Tech Eeaudio
> >   * The Chord Company CHORD
> >   * AVA Group A/S Vitus
> > 
> > Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
> > ---
> > 
> > Changes since v1:
> > 
> >   * Change the first sentence of the Kconfig entry into "Select this..."
> >   * Remove a useless sentence from the Kconfig entry
> >   * Don't set alsa_rt->hw.rates in hiface_pcm_open()
> >   * Style cleanup, no braces needed in single statement conditional
> >   * Remove the rate field from pcm_runtime
> >   * Use the hiFace name with the lowercase 'h' everywhere
> >   * List actually supported devices in MODULE_SUPPORTED_DEVICE()
> >   * Cosmetics, align values in the rates array
> >   * Use an explicit switch instead of the rate_value array in
> >     hiface_pcm_set_rate()
> >   * Use usb_make_path() when building card->longname
> >   * Use again the implicit mechanism to allocate the card private data
> >   * Downgrade a pr_info to pr_debug in hiface_chip_probe()
> >   * Make device_table const
> >   * Rename PCM_MAX_PACKET_SIZE to PCM_PACKET_SIZE
> >   * Rename MAX_BUFSIZE to PCM_BUFFER_SIZE
> >   * Cosmetics, align symbolic constant values
> >   * Add SNDRV_PCM_RATE_KNOT only when needed
> >   * Declare memcpy_swahw32() as static
> >   * Protect snd_pcm_stop() with snd_pcm_stream_lock_irq()
> >   * Make hiface_pcm_playback() not returning anything
> >   * Move the period elapsed check into hiface_pcm_playback()
> >   * Handle the case of failing URBs in hiface_pcm_out_urb_handler()
> >   * Fix a couple of checkpatch.pl issues
> > 
> > The incremental changes can be seen individually at
> > https://github.com/panicking/snd-usb-asyncaudio/commits/master
> > Commits from Feb. 10th and later.
> > 
> > Thanks,
> >    Antonio
> > 
> >  sound/usb/Kconfig         |   31 +++
> >  sound/usb/Makefile        |    2 +-
> >  sound/usb/hiface/Makefile |    2 +
> >  sound/usb/hiface/chip.h   |   34 +++
> >  sound/usb/hiface/chip.c   |  329 +++++++++++++++++++++++
> >  sound/usb/hiface/pcm.h    |   24 ++
> >  sound/usb/hiface/pcm.c    |  638 +++++++++++++++++++++++++++++++++++++++++++++
> >  7 files changed, 1059 insertions(+), 1 deletion(-)
> >  create mode 100644 sound/usb/hiface/Makefile
> >  create mode 100644 sound/usb/hiface/chip.h
> >  create mode 100644 sound/usb/hiface/chip.c
> >  create mode 100644 sound/usb/hiface/pcm.h
> >  create mode 100644 sound/usb/hiface/pcm.c
> > 
> > diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
> > index 225dfd7..de9408b 100644
> > --- a/sound/usb/Kconfig
> > +++ b/sound/usb/Kconfig
> > @@ -115,5 +115,36 @@ config SND_USB_6FIRE
> >            and further help can be found at
> >            http://sixfireusb.sourceforge.net
> >  
> > +config SND_USB_HIFACE
> > +        tristate "M2Tech hiFace USB-SPDIF driver"
> > +        select SND_PCM
> > +        help
> > +	  Select this option to include support for M2Tech hiFace USB-SPDIF
> > +	  interface.
> > +
> > +	  This driver supports the original M2Tech hiFace and some other
> > +	  compatible devices. The supported products are:
> > +
> > +	    * M2Tech Young
> > +	    * M2Tech hiFace
> > +	    * M2Tech North Star
> > +	    * M2Tech W4S Young
> > +	    * M2Tech Corrson
> > +	    * M2Tech AUDIA
> > +	    * M2Tech SL Audio
> > +	    * M2Tech Empirical
> > +	    * M2Tech Rockna
> > +	    * M2Tech Pathos
> > +	    * M2Tech Metronome
> > +	    * M2Tech CAD
> > +	    * M2Tech Audio Esclusive
> > +	    * M2Tech Rotel
> > +	    * M2Tech Eeaudio
> > +	    * The Chord Company CHORD
> > +	    * AVA Group A/S Vitus
> > +
> > +	  To compile this driver as a module, choose M here: the module
> > +	  will be called snd-usb-hiface.
> > +
> >  endif	# SND_USB
> >  
> > diff --git a/sound/usb/Makefile b/sound/usb/Makefile
> > index ac256dc..abe668f 100644
> > --- a/sound/usb/Makefile
> > +++ b/sound/usb/Makefile
> > @@ -23,4 +23,4 @@ obj-$(CONFIG_SND_USB_UA101) += snd-usbmidi-lib.o
> >  obj-$(CONFIG_SND_USB_USX2Y) += snd-usbmidi-lib.o
> >  obj-$(CONFIG_SND_USB_US122L) += snd-usbmidi-lib.o
> >  
> > -obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/
> > +obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/ hiface/
> > diff --git a/sound/usb/hiface/Makefile b/sound/usb/hiface/Makefile
> > new file mode 100644
> > index 0000000..463b136
> > --- /dev/null
> > +++ b/sound/usb/hiface/Makefile
> > @@ -0,0 +1,2 @@
> > +snd-usb-hiface-objs := chip.o pcm.o
> > +obj-$(CONFIG_SND_USB_HIFACE) += snd-usb-hiface.o
> > diff --git a/sound/usb/hiface/chip.h b/sound/usb/hiface/chip.h
> > new file mode 100644
> > index 0000000..cd615a0
> > --- /dev/null
> > +++ b/sound/usb/hiface/chip.h
> > @@ -0,0 +1,34 @@
> > +/*
> > + * Linux driver for M2Tech hiFace compatible devices
> > + *
> > + * Copyright 2012-2013 (C) M2TECH S.r.l and Amarula Solutions B.V.
> > + *
> > + * Authors:  Michael Trimarchi <michael@amarulasolutions.com>
> > + *           Antonio Ospite <ao2@amarulasolutions.com>
> > + *
> > + * The driver is based on the work done in TerraTec DMX 6Fire USB
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#ifndef HIFACE_CHIP_H
> > +#define HIFACE_CHIP_H
> > +
> > +#include <linux/usb.h>
> > +#include <sound/core.h>
> > +
> > +struct pcm_runtime;
> > +
> > +struct hiface_chip {
> > +	struct usb_device *dev;
> > +	struct snd_card *card;
> > +	int intf_count; /* number of registered interfaces */
> > +	int index; /* index in module parameter arrays */
> > +	bool shutdown;
> > +
> > +	struct pcm_runtime *pcm;
> > +};
> > +#endif /* HIFACE_CHIP_H */
> > diff --git a/sound/usb/hiface/chip.c b/sound/usb/hiface/chip.c
> > new file mode 100644
> > index 0000000..f1293a5
> > --- /dev/null
> > +++ b/sound/usb/hiface/chip.c
> > @@ -0,0 +1,329 @@
> > +/*
> > + * Linux driver for M2Tech hiFace compatible devices
> > + *
> > + * Copyright 2012-2013 (C) M2TECH S.r.l and Amarula Solutions B.V.
> > + *
> > + * Authors:  Michael Trimarchi <michael@amarulasolutions.com>
> > + *           Antonio Ospite <ao2@amarulasolutions.com>
> > + *
> > + * The driver is based on the work done in TerraTec DMX 6Fire USB
> > + *
> > + * This program is free software; you can redistribute it and/or modify
> > + * it under the terms of the GNU General Public License as published by
> > + * the Free Software Foundation; either version 2 of the License, or
> > + * (at your option) any later version.
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <sound/initval.h>
> > +
> > +#include "chip.h"
> > +#include "pcm.h"
> > +
> > +MODULE_AUTHOR("Michael Trimarchi <michael@amarulasolutions.com>");
> > +MODULE_AUTHOR("Antonio Ospite <ao2@amarulasolutions.com>");
> > +MODULE_DESCRIPTION("M2Tech hiFace USB-SPDIF audio driver");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_SUPPORTED_DEVICE("{{M2Tech,Young},"
> > +			 "{M2Tech,hiFace},"
> > +			 "{M2Tech,North Star},"
> > +			 "{M2Tech,W4S Young},"
> > +			 "{M2Tech,Corrson},"
> > +			 "{M2Tech,AUDIA},"
> > +			 "{M2Tech,SL Audio},"
> > +			 "{M2Tech,Empirical},"
> > +			 "{M2Tech,Rockna},"
> > +			 "{M2Tech,Pathos},"
> > +			 "{M2Tech,Metronome},"
> > +			 "{M2Tech,CAD},"
> > +			 "{M2Tech,Audio Esclusive},"
> > +			 "{M2Tech,Rotel},"
> > +			 "{M2Tech,Eeaudio},"
> > +			 "{The Chord Company,CHORD},"
> > +			 "{AVA Group A/S,Vitus}}");
> > +
> > +static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
> > +static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for card */
> > +static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP; /* Enable this card */
> > +
> > +#define DRIVER_NAME "snd-usb-hiface"
> > +#define CARD_NAME "hiFace"
> > +
> > +module_param_array(index, int, NULL, 0444);
> > +MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
> > +module_param_array(id, charp, NULL, 0444);
> > +MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
> > +module_param_array(enable, bool, NULL, 0444);
> > +MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
> > +
> > +static struct hiface_chip *chips[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
> > +
> > +static DEFINE_MUTEX(register_mutex);
> > +
> > +struct hiface_vendor_quirk {
> > +	const char *device_name;
> > +	u8 extra_freq;
> > +};
> > +
> > +static int hiface_chip_create(struct usb_device *device, int idx,
> > +			      const struct hiface_vendor_quirk *quirk,
> > +			      struct hiface_chip **rchip)
> > +{
> > +	struct snd_card *card = NULL;
> > +	struct hiface_chip *chip;
> > +	int ret;
> > +	int len;
> > +
> > +	*rchip = NULL;
> > +
> > +	/* if we are here, card can be registered in alsa. */
> > +	ret = snd_card_create(index[idx], id[idx], THIS_MODULE, sizeof(*chip), &card);
> > +	if (ret < 0) {
> > +		snd_printk(KERN_ERR "cannot create alsa card.\n");
> > +		return ret;
> > +	}
> > +
> > +	strcpy(card->driver, DRIVER_NAME);
> > +
> > +	if (quirk && quirk->device_name)
> > +		strcpy(card->shortname, quirk->device_name);
> > +	else
> > +		strcpy(card->shortname, "M2Tech generic audio");
> 
> Use strncpy() or strlcpy() please, even if you're sure.
>

Will do.

> > +
> > +	strlcat(card->longname, card->shortname, sizeof(card->longname));
> > +	len = strlcat(card->longname, " at ", sizeof(card->longname));
> > +	if (len < sizeof(card->longname))
> > +		usb_make_path(device, card->longname + len,
> > +			      sizeof(card->longname) - len);
> > +
> > +	chip = card->private_data;
> > +	chip->dev = device;
> > +	chip->index = idx;
> > +	chip->card = card;
> > +
> > +	*rchip = chip;
> > +	return 0;
> > +}
> > +
> > +static int hiface_chip_probe(struct usb_interface *intf,
> > +			     const struct usb_device_id *usb_id)
> > +{
> > +	const struct hiface_vendor_quirk *quirk = (struct hiface_vendor_quirk *)usb_id->driver_info;
> > +	int ret;
> > +	int i;
> > +	struct hiface_chip *chip;
> > +	struct usb_device *device = interface_to_usbdev(intf);
> > +
> > +	pr_debug("Probe " DRIVER_NAME " driver.\n");
> 
> As Clemens said, you should drop this.
>

OK, the USB enumeration messages are enough, I see.

> > +
> > +	ret = usb_set_interface(device, 0, 0);
> > +	if (ret != 0) {
> > +		snd_printk(KERN_ERR "can't set first interface for " CARD_NAME " device.\n");
> > +		return -EIO;
> > +	}
> > +
> > +	/* check whether the card is already registered */
> > +	chip = NULL;
> > +	mutex_lock(&register_mutex);
> > +	for (i = 0; i < SNDRV_CARDS; i++) {
> > +		if (chips[i] && chips[i]->dev == device) {
> > +			if (chips[i]->shutdown) {
> > +				snd_printk(KERN_ERR CARD_NAME " device is in the shutdown state, cannot create a card instance\n");
> > +				ret = -ENODEV;
> > +				goto err;
> > +			}
> > +			chip = chips[i];
> > +			break;
> > +		}
> > +	}
> > +	if (!chip) {
> > +		/* it's a fresh one.
> > +		 * now look for an empty slot and create a new card instance
> > +		 */
> > +		for (i = 0; i < SNDRV_CARDS; i++)
> > +			if (enable[i] && !chips[i]) {
> > +				ret = hiface_chip_create(device, i, quirk,
> > +							 &chip);
> > +				if (ret < 0)
> > +					goto err;
> > +
> > +				snd_card_set_dev(chip->card, &intf->dev);
> > +				break;
> > +			}
> > +		if (!chip) {
> > +			snd_printk(KERN_ERR "no available " CARD_NAME " audio device\n");
> > +			ret = -ENODEV;
> > +			goto err;
> > +		}
> > +	}
> 
> The generic driver does the above in order to group multiple interfaces
> on one device into one snd_card. It's needed because it is probed on
> interface level.
> 
> Your driver seems to operate on device-level only, so you can drop this.
>

For the first loop I agree, it's not strictly necessary to check if the
device was registered already if there is only one "sound card" per
device, but the second loop is still needed in some form in order to
respect the "enable" option. I'll simplify that part, thanks.

BTW looking at how caiaq/device.c does it, I noticed that the
snd_card_used[] array is only read but never written, unless I am
missing anything :)

> > +	ret = hiface_pcm_init(chip, quirk ? quirk->extra_freq : 0);
> > +	if (ret < 0)
> > +		goto err_chip_destroy;
> > +
> > +	ret = snd_card_register(chip->card);
> > +	if (ret < 0) {
> > +		snd_printk(KERN_ERR "cannot register " CARD_NAME " card\n");
> 
> Not sure, but I think it might be better to use dev_{err,info,dgb} here,
> so the logging can be grouped to individual devices. Takashi, any
> opinion on that?
>

Will do, thanks.

Regards,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
