From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH v2] Add M2Tech hiFace USB-SPDIF driver
Date: Fri, 22 Feb 2013 17:12:36 +0100
Message-ID: <512798F4.1030607@gmail.com>
References: <1360537887-9427-1-git-send-email-ao2@amarulasolutions.com>
 <1360775505-13106-1-git-send-email-ao2@amarulasolutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1360775505-13106-1-git-send-email-ao2@amarulasolutions.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Antonio Ospite <ao2@amarulasolutions.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Clemens Ladisch <clemens@ladisch.de>, fchecconi@gmail.com, Pietro Cipriano <p.cipriano@m2tech.biz>, alberto@amarulasolutions.com, Michael Trimarchi <michael@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

Hi Antonio,

a couple of more things that I stumbled over.


Thanks,
Daniel


On 13.02.2013 18:11, Antonio Ospite wrote:
> Add driver for M2Tech hiFace USB-SPDIF interface and compatible devices.
> 
> M2Tech hiFace and compatible devices offer a Hi-End S/PDIF Output
> Interface, see http://www.m2tech.biz/hiface.html
> 
> The supported products are:
> 
>   * M2Tech Young
>   * M2Tech hiFace
>   * M2Tech North Star
>   * M2Tech W4S Young
>   * M2Tech Corrson
>   * M2Tech AUDIA
>   * M2Tech SL Audio
>   * M2Tech Empirical
>   * M2Tech Rockna
>   * M2Tech Pathos
>   * M2Tech Metronome
>   * M2Tech CAD
>   * M2Tech Audio Esclusive
>   * M2Tech Rotel
>   * M2Tech Eeaudio
>   * The Chord Company CHORD
>   * AVA Group A/S Vitus
> 
> Signed-off-by: Antonio Ospite <ao2@amarulasolutions.com>
> ---
> 
> Changes since v1:
> 
>   * Change the first sentence of the Kconfig entry into "Select this..."
>   * Remove a useless sentence from the Kconfig entry
>   * Don't set alsa_rt->hw.rates in hiface_pcm_open()
>   * Style cleanup, no braces needed in single statement conditional
>   * Remove the rate field from pcm_runtime
>   * Use the hiFace name with the lowercase 'h' everywhere
>   * List actually supported devices in MODULE_SUPPORTED_DEVICE()
>   * Cosmetics, align values in the rates array
>   * Use an explicit switch instead of the rate_value array in
>     hiface_pcm_set_rate()
>   * Use usb_make_path() when building card->longname
>   * Use again the implicit mechanism to allocate the card private data
>   * Downgrade a pr_info to pr_debug in hiface_chip_probe()
>   * Make device_table const
>   * Rename PCM_MAX_PACKET_SIZE to PCM_PACKET_SIZE
>   * Rename MAX_BUFSIZE to PCM_BUFFER_SIZE
>   * Cosmetics, align symbolic constant values
>   * Add SNDRV_PCM_RATE_KNOT only when needed
>   * Declare memcpy_swahw32() as static
>   * Protect snd_pcm_stop() with snd_pcm_stream_lock_irq()
>   * Make hiface_pcm_playback() not returning anything
>   * Move the period elapsed check into hiface_pcm_playback()
>   * Handle the case of failing URBs in hiface_pcm_out_urb_handler()
>   * Fix a couple of checkpatch.pl issues
> 
> The incremental changes can be seen individually at
> https://github.com/panicking/snd-usb-asyncaudio/commits/master
> Commits from Feb. 10th and later.
> 
> Thanks,
>    Antonio
> 
>  sound/usb/Kconfig         |   31 +++
>  sound/usb/Makefile        |    2 +-
>  sound/usb/hiface/Makefile |    2 +
>  sound/usb/hiface/chip.h   |   34 +++
>  sound/usb/hiface/chip.c   |  329 +++++++++++++++++++++++
>  sound/usb/hiface/pcm.h    |   24 ++
>  sound/usb/hiface/pcm.c    |  638 +++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 1059 insertions(+), 1 deletion(-)
>  create mode 100644 sound/usb/hiface/Makefile
>  create mode 100644 sound/usb/hiface/chip.h
>  create mode 100644 sound/usb/hiface/chip.c
>  create mode 100644 sound/usb/hiface/pcm.h
>  create mode 100644 sound/usb/hiface/pcm.c
> 
> diff --git a/sound/usb/Kconfig b/sound/usb/Kconfig
> index 225dfd7..de9408b 100644
> --- a/sound/usb/Kconfig
> +++ b/sound/usb/Kconfig
> @@ -115,5 +115,36 @@ config SND_USB_6FIRE
>            and further help can be found at
>            http://sixfireusb.sourceforge.net
>  
> +config SND_USB_HIFACE
> +        tristate "M2Tech hiFace USB-SPDIF driver"
> +        select SND_PCM
> +        help
> +	  Select this option to include support for M2Tech hiFace USB-SPDIF
> +	  interface.
> +
> +	  This driver supports the original M2Tech hiFace and some other
> +	  compatible devices. The supported products are:
> +
> +	    * M2Tech Young
> +	    * M2Tech hiFace
> +	    * M2Tech North Star
> +	    * M2Tech W4S Young
> +	    * M2Tech Corrson
> +	    * M2Tech AUDIA
> +	    * M2Tech SL Audio
> +	    * M2Tech Empirical
> +	    * M2Tech Rockna
> +	    * M2Tech Pathos
> +	    * M2Tech Metronome
> +	    * M2Tech CAD
> +	    * M2Tech Audio Esclusive
> +	    * M2Tech Rotel
> +	    * M2Tech Eeaudio
> +	    * The Chord Company CHORD
> +	    * AVA Group A/S Vitus
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called snd-usb-hiface.
> +
>  endif	# SND_USB
>  
> diff --git a/sound/usb/Makefile b/sound/usb/Makefile
> index ac256dc..abe668f 100644
> --- a/sound/usb/Makefile
> +++ b/sound/usb/Makefile
> @@ -23,4 +23,4 @@ obj-$(CONFIG_SND_USB_UA101) += snd-usbmidi-lib.o
>  obj-$(CONFIG_SND_USB_USX2Y) += snd-usbmidi-lib.o
>  obj-$(CONFIG_SND_USB_US122L) += snd-usbmidi-lib.o
>  
> -obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/
> +obj-$(CONFIG_SND) += misc/ usx2y/ caiaq/ 6fire/ hiface/
> diff --git a/sound/usb/hiface/Makefile b/sound/usb/hiface/Makefile
> new file mode 100644
> index 0000000..463b136
> --- /dev/null
> +++ b/sound/usb/hiface/Makefile
> @@ -0,0 +1,2 @@
> +snd-usb-hiface-objs := chip.o pcm.o
> +obj-$(CONFIG_SND_USB_HIFACE) += snd-usb-hiface.o
> diff --git a/sound/usb/hiface/chip.h b/sound/usb/hiface/chip.h
> new file mode 100644
> index 0000000..cd615a0
> --- /dev/null
> +++ b/sound/usb/hiface/chip.h
> @@ -0,0 +1,34 @@
> +/*
> + * Linux driver for M2Tech hiFace compatible devices
> + *
> + * Copyright 2012-2013 (C) M2TECH S.r.l and Amarula Solutions B.V.
> + *
> + * Authors:  Michael Trimarchi <michael@amarulasolutions.com>
> + *           Antonio Ospite <ao2@amarulasolutions.com>
> + *
> + * The driver is based on the work done in TerraTec DMX 6Fire USB
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef HIFACE_CHIP_H
> +#define HIFACE_CHIP_H
> +
> +#include <linux/usb.h>
> +#include <sound/core.h>
> +
> +struct pcm_runtime;
> +
> +struct hiface_chip {
> +	struct usb_device *dev;
> +	struct snd_card *card;
> +	int intf_count; /* number of registered interfaces */
> +	int index; /* index in module parameter arrays */
> +	bool shutdown;
> +
> +	struct pcm_runtime *pcm;
> +};
> +#endif /* HIFACE_CHIP_H */
> diff --git a/sound/usb/hiface/chip.c b/sound/usb/hiface/chip.c
> new file mode 100644
> index 0000000..f1293a5
> --- /dev/null
> +++ b/sound/usb/hiface/chip.c
> @@ -0,0 +1,329 @@
> +/*
> + * Linux driver for M2Tech hiFace compatible devices
> + *
> + * Copyright 2012-2013 (C) M2TECH S.r.l and Amarula Solutions B.V.
> + *
> + * Authors:  Michael Trimarchi <michael@amarulasolutions.com>
> + *           Antonio Ospite <ao2@amarulasolutions.com>
> + *
> + * The driver is based on the work done in TerraTec DMX 6Fire USB
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <sound/initval.h>
> +
> +#include "chip.h"
> +#include "pcm.h"
> +
> +MODULE_AUTHOR("Michael Trimarchi <michael@amarulasolutions.com>");
> +MODULE_AUTHOR("Antonio Ospite <ao2@amarulasolutions.com>");
> +MODULE_DESCRIPTION("M2Tech hiFace USB-SPDIF audio driver");
> +MODULE_LICENSE("GPL v2");
> +MODULE_SUPPORTED_DEVICE("{{M2Tech,Young},"
> +			 "{M2Tech,hiFace},"
> +			 "{M2Tech,North Star},"
> +			 "{M2Tech,W4S Young},"
> +			 "{M2Tech,Corrson},"
> +			 "{M2Tech,AUDIA},"
> +			 "{M2Tech,SL Audio},"
> +			 "{M2Tech,Empirical},"
> +			 "{M2Tech,Rockna},"
> +			 "{M2Tech,Pathos},"
> +			 "{M2Tech,Metronome},"
> +			 "{M2Tech,CAD},"
> +			 "{M2Tech,Audio Esclusive},"
> +			 "{M2Tech,Rotel},"
> +			 "{M2Tech,Eeaudio},"
> +			 "{The Chord Company,CHORD},"
> +			 "{AVA Group A/S,Vitus}}");
> +
> +static int index[SNDRV_CARDS] = SNDRV_DEFAULT_IDX; /* Index 0-max */
> +static char *id[SNDRV_CARDS] = SNDRV_DEFAULT_STR; /* Id for card */
> +static bool enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP; /* Enable this card */
> +
> +#define DRIVER_NAME "snd-usb-hiface"
> +#define CARD_NAME "hiFace"
> +
> +module_param_array(index, int, NULL, 0444);
> +MODULE_PARM_DESC(index, "Index value for " CARD_NAME " soundcard.");
> +module_param_array(id, charp, NULL, 0444);
> +MODULE_PARM_DESC(id, "ID string for " CARD_NAME " soundcard.");
> +module_param_array(enable, bool, NULL, 0444);
> +MODULE_PARM_DESC(enable, "Enable " CARD_NAME " soundcard.");
> +
> +static struct hiface_chip *chips[SNDRV_CARDS] = SNDRV_DEFAULT_PTR;
> +
> +static DEFINE_MUTEX(register_mutex);
> +
> +struct hiface_vendor_quirk {
> +	const char *device_name;
> +	u8 extra_freq;
> +};
> +
> +static int hiface_chip_create(struct usb_device *device, int idx,
> +			      const struct hiface_vendor_quirk *quirk,
> +			      struct hiface_chip **rchip)
> +{
> +	struct snd_card *card = NULL;
> +	struct hiface_chip *chip;
> +	int ret;
> +	int len;
> +
> +	*rchip = NULL;
> +
> +	/* if we are here, card can be registered in alsa. */
> +	ret = snd_card_create(index[idx], id[idx], THIS_MODULE, sizeof(*chip), &card);
> +	if (ret < 0) {
> +		snd_printk(KERN_ERR "cannot create alsa card.\n");
> +		return ret;
> +	}
> +
> +	strcpy(card->driver, DRIVER_NAME);
> +
> +	if (quirk && quirk->device_name)
> +		strcpy(card->shortname, quirk->device_name);
> +	else
> +		strcpy(card->shortname, "M2Tech generic audio");

Use strncpy() or strlcpy() please, even if you're sure.

> +
> +	strlcat(card->longname, card->shortname, sizeof(card->longname));
> +	len = strlcat(card->longname, " at ", sizeof(card->longname));
> +	if (len < sizeof(card->longname))
> +		usb_make_path(device, card->longname + len,
> +			      sizeof(card->longname) - len);
> +
> +	chip = card->private_data;
> +	chip->dev = device;
> +	chip->index = idx;
> +	chip->card = card;
> +
> +	*rchip = chip;
> +	return 0;
> +}
> +
> +static int hiface_chip_probe(struct usb_interface *intf,
> +			     const struct usb_device_id *usb_id)
> +{
> +	const struct hiface_vendor_quirk *quirk = (struct hiface_vendor_quirk *)usb_id->driver_info;
> +	int ret;
> +	int i;
> +	struct hiface_chip *chip;
> +	struct usb_device *device = interface_to_usbdev(intf);
> +
> +	pr_debug("Probe " DRIVER_NAME " driver.\n");

As Clemens said, you should drop this.

> +
> +	ret = usb_set_interface(device, 0, 0);
> +	if (ret != 0) {
> +		snd_printk(KERN_ERR "can't set first interface for " CARD_NAME " device.\n");
> +		return -EIO;
> +	}
> +
> +	/* check whether the card is already registered */
> +	chip = NULL;
> +	mutex_lock(&register_mutex);
> +	for (i = 0; i < SNDRV_CARDS; i++) {
> +		if (chips[i] && chips[i]->dev == device) {
> +			if (chips[i]->shutdown) {
> +				snd_printk(KERN_ERR CARD_NAME " device is in the shutdown state, cannot create a card instance\n");
> +				ret = -ENODEV;
> +				goto err;
> +			}
> +			chip = chips[i];
> +			break;
> +		}
> +	}
> +	if (!chip) {
> +		/* it's a fresh one.
> +		 * now look for an empty slot and create a new card instance
> +		 */
> +		for (i = 0; i < SNDRV_CARDS; i++)
> +			if (enable[i] && !chips[i]) {
> +				ret = hiface_chip_create(device, i, quirk,
> +							 &chip);
> +				if (ret < 0)
> +					goto err;
> +
> +				snd_card_set_dev(chip->card, &intf->dev);
> +				break;
> +			}
> +		if (!chip) {
> +			snd_printk(KERN_ERR "no available " CARD_NAME " audio device\n");
> +			ret = -ENODEV;
> +			goto err;
> +		}
> +	}

The generic driver does the above in order to group multiple interfaces
on one device into one snd_card. It's needed because it is probed on
interface level.

Your driver seems to operate on device-level only, so you can drop this.

> +	ret = hiface_pcm_init(chip, quirk ? quirk->extra_freq : 0);
> +	if (ret < 0)
> +		goto err_chip_destroy;
> +
> +	ret = snd_card_register(chip->card);
> +	if (ret < 0) {
> +		snd_printk(KERN_ERR "cannot register " CARD_NAME " card\n");

Not sure, but I think it might be better to use dev_{err,info,dgb} here,
so the logging can be grouped to individual devices. Takashi, any
opinion on that?

> +		goto err_chip_destroy;
> +	}
> +
> +	chips[chip->index] = chip;
> +	chip->intf_count++;
> +
> +	mutex_unlock(&register_mutex);
> +
> +	usb_set_intfdata(intf, chip);
> +	return 0;
> +
> +err_chip_destroy:
> +	snd_card_free(chip->card);
> +err:
> +	mutex_unlock(&register_mutex);
> +	return ret;
> +}
> +
> +static void hiface_chip_disconnect(struct usb_interface *intf)
> +{
> +	struct hiface_chip *chip;
> +	struct snd_card *card;
> +
> +	pr_debug("%s: called.\n", __func__);

See above, and there a more places below ...

> +
> +	chip = usb_get_intfdata(intf);
> +	if (!chip)
> +		return;
> +
> +	card = chip->card;
> +	chip->intf_count--;
> +	if (chip->intf_count <= 0) {
> +		/* Make sure that the userspace cannot create new request */
> +		snd_card_disconnect(card);
> +
> +		mutex_lock(&register_mutex);
> +		chips[chip->index] = NULL;
> +		mutex_unlock(&register_mutex);
> +
> +		chip->shutdown = true;
> +		hiface_pcm_abort(chip);
> +		snd_card_free_when_closed(card);
> +	}
> +}
> +
> +static const struct usb_device_id device_table[] = {
> +	{
> +		USB_DEVICE(0x04b4, 0x0384),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "Young",
> +			.extra_freq = 1,
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x04b4, 0x930b),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "hiFace",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x04b4, 0x931b),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "North Star",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x04b4, 0x931c),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "W4S Young",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x04b4, 0x931d),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "Corrson",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x04b4, 0x931e),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "AUDIA",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x04b4, 0x931f),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "SL Audio",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x04b4, 0x9320),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "Empirical",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x04b4, 0x9321),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "Rockna",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x249c, 0x9001),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "Pathos",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x249c, 0x9002),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "Metronome",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x249c, 0x9006),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "CAD",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x249c, 0x9008),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "Audio Esclusive",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x249c, 0x931c),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "Rotel",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x249c, 0x932c),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "Eeaudio",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x245f, 0x931c),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "CHORD",
> +		}
> +	},
> +	{
> +		USB_DEVICE(0x25c6, 0x9002),
> +		.driver_info = (unsigned long)&(const struct hiface_vendor_quirk) {
> +			.device_name = "Vitus",
> +		}
> +	},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(usb, device_table);
> +
> +static struct usb_driver hiface_usb_driver = {
> +	.name = DRIVER_NAME,
> +	.probe = hiface_chip_probe,
> +	.disconnect = hiface_chip_disconnect,
> +	.id_table = device_table,
> +};
> +
> +module_usb_driver(hiface_usb_driver);
> diff --git a/sound/usb/hiface/pcm.h b/sound/usb/hiface/pcm.h
> new file mode 100644
> index 0000000..77edd7c
> --- /dev/null
> +++ b/sound/usb/hiface/pcm.h
> @@ -0,0 +1,24 @@
> +/*
> + * Linux driver for M2Tech hiFace compatible devices
> + *
> + * Copyright 2012-2013 (C) M2TECH S.r.l and Amarula Solutions B.V.
> + *
> + * Authors:  Michael Trimarchi <michael@amarulasolutions.com>
> + *           Antonio Ospite <ao2@amarulasolutions.com>
> + *
> + * The driver is based on the work done in TerraTec DMX 6Fire USB
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#ifndef HIFACE_PCM_H
> +#define HIFACE_PCM_H
> +
> +struct hiface_chip;
> +
> +int hiface_pcm_init(struct hiface_chip *chip, u8 extra_freq);
> +void hiface_pcm_abort(struct hiface_chip *chip);
> +#endif /* HIFACE_PCM_H */
> diff --git a/sound/usb/hiface/pcm.c b/sound/usb/hiface/pcm.c
> new file mode 100644
> index 0000000..d0c3c58
> --- /dev/null
> +++ b/sound/usb/hiface/pcm.c
> @@ -0,0 +1,638 @@
> +/*
> + * Linux driver for M2Tech hiFace compatible devices
> + *
> + * Copyright 2012-2013 (C) M2TECH S.r.l and Amarula Solutions B.V.
> + *
> + * Authors:  Michael Trimarchi <michael@amarulasolutions.com>
> + *           Antonio Ospite <ao2@amarulasolutions.com>
> + *
> + * The driver is based on the work done in TerraTec DMX 6Fire USB
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/slab.h>
> +#include <sound/pcm.h>
> +
> +#include "pcm.h"
> +#include "chip.h"
> +
> +#define OUT_EP          0x2
> +#define PCM_N_URBS      8
> +#define PCM_PACKET_SIZE 4096
> +#define PCM_BUFFER_SIZE (2 * PCM_N_URBS * PCM_PACKET_SIZE)
> +
> +struct pcm_urb {
> +	struct hiface_chip *chip;
> +
> +	struct urb instance;
> +	struct usb_anchor submitted;
> +	u8 *buffer;
> +};
> +
> +struct pcm_substream {
> +	spinlock_t lock;
> +	struct snd_pcm_substream *instance;
> +
> +	bool active;
> +	snd_pcm_uframes_t dma_off;    /* current position in alsa dma_area */
> +	snd_pcm_uframes_t period_off; /* current position in current period */
> +};
> +
> +enum { /* pcm streaming states */
> +	STREAM_DISABLED, /* no pcm streaming */
> +	STREAM_STARTING, /* pcm streaming requested, waiting to become ready */
> +	STREAM_RUNNING,  /* pcm streaming running */
> +	STREAM_STOPPING
> +};
> +
> +struct pcm_runtime {
> +	struct hiface_chip *chip;
> +	struct snd_pcm *instance;
> +
> +	struct pcm_substream playback;
> +	bool panic; /* if set driver won't do anymore pcm on device */
> +
> +	struct pcm_urb out_urbs[PCM_N_URBS];
> +
> +	struct mutex stream_mutex;
> +	u8 stream_state; /* one of STREAM_XXX */
> +	u8 extra_freq;
> +	wait_queue_head_t stream_wait_queue;
> +	bool stream_wait_cond;
> +};
> +
> +static const unsigned int rates[] = { 44100, 48000, 88200, 96000, 176400, 192000,
> +				      352800, 384000 };
> +static const struct snd_pcm_hw_constraint_list constraints_extra_rates = {
> +	.count = ARRAY_SIZE(rates),
> +	.list = rates,
> +	.mask = 0,
> +};
> +
> +static const struct snd_pcm_hardware pcm_hw = {
> +	.info = SNDRV_PCM_INFO_MMAP |
> +		SNDRV_PCM_INFO_INTERLEAVED |
> +		SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +		SNDRV_PCM_INFO_PAUSE |
> +		SNDRV_PCM_INFO_MMAP_VALID |
> +		SNDRV_PCM_INFO_BATCH,
> +
> +	.formats = SNDRV_PCM_FMTBIT_S32_LE,
> +
> +	.rates = SNDRV_PCM_RATE_44100 |
> +		SNDRV_PCM_RATE_48000 |
> +		SNDRV_PCM_RATE_88200 |
> +		SNDRV_PCM_RATE_96000 |
> +		SNDRV_PCM_RATE_176400 |
> +		SNDRV_PCM_RATE_192000,
> +
> +	.rate_min = 44100,
> +	.rate_max = 192000, /* changes in hiface_pcm_open to support extra rates */
> +	.channels_min = 2,
> +	.channels_max = 2,
> +	.buffer_bytes_max = PCM_BUFFER_SIZE,
> +	.period_bytes_min = PCM_PACKET_SIZE,
> +	.period_bytes_max = PCM_BUFFER_SIZE,
> +	.periods_min = 2,
> +	.periods_max = 1024
> +};
> +
> +/* message values used to change the sample rate */
> +#define HIFACE_SET_RATE_REQUEST 0xb0
> +
> +#define HIFACE_RATE_44100  0x43
> +#define HIFACE_RATE_48000  0x4b
> +#define HIFACE_RATE_88200  0x42
> +#define HIFACE_RATE_96000  0x4a
> +#define HIFACE_RATE_176400 0x40
> +#define HIFACE_RATE_192000 0x48
> +#define HIFACE_RATE_352000 0x58
> +#define HIFACE_RATE_384000 0x68
> +
> +static int hiface_pcm_set_rate(struct pcm_runtime *rt, unsigned int rate)
> +{
> +	struct usb_device *device = rt->chip->dev;
> +	u16 rate_value;
> +	int ret;
> +
> +	/* We are already sure that the rate is supported here thanks to
> +	 * ALSA constraints
> +	 */
> +	switch (rate) {
> +	case 44100:
> +		rate_value = HIFACE_RATE_44100;
> +		break;
> +	case 48000:
> +		rate_value = HIFACE_RATE_48000;
> +		break;
> +	case 88200:
> +		rate_value = HIFACE_RATE_88200;
> +		break;
> +	case 96000:
> +		rate_value = HIFACE_RATE_96000;
> +		break;
> +	case 176400:
> +		rate_value = HIFACE_RATE_176400;
> +		break;
> +	case 192000:
> +		rate_value = HIFACE_RATE_192000;
> +		break;
> +	case 352000:
> +		rate_value = HIFACE_RATE_352000;
> +		break;
> +	case 384000:
> +		rate_value = HIFACE_RATE_384000;
> +		break;
> +	default:
> +		snd_printk(KERN_ERR "Unsupported rate %d\n", rate);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * USBIO: Vendor 0xb0(wValue=0x0043, wIndex=0x0000)
> +	 * 43 b0 43 00 00 00 00 00
> +	 * USBIO: Vendor 0xb0(wValue=0x004b, wIndex=0x0000)
> +	 * 43 b0 4b 00 00 00 00 00
> +	 * This control message doesn't have any ack from the
> +	 * other side
> +	 */
> +	ret = usb_control_msg(device, usb_sndctrlpipe(device, 0),
> +				HIFACE_SET_RATE_REQUEST,
> +				USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_OTHER,
> +				rate_value, 0, NULL, 0, 100);
> +	if (ret < 0) {
> +		snd_printk(KERN_ERR "Error setting samplerate %d.\n", rate);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct pcm_substream *hiface_pcm_get_substream(
> +		struct snd_pcm_substream *alsa_sub)
> +{
> +	struct pcm_runtime *rt = snd_pcm_substream_chip(alsa_sub);
> +
> +	if (alsa_sub->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		return &rt->playback;
> +
> +	pr_debug("Error getting pcm substream slot.\n");
> +	return NULL;
> +}
> +
> +/* call with stream_mutex locked */
> +static void hiface_pcm_stream_stop(struct pcm_runtime *rt)
> +{
> +	int i, time;
> +
> +	if (rt->stream_state != STREAM_DISABLED) {
> +		rt->stream_state = STREAM_STOPPING;
> +
> +		for (i = 0; i < PCM_N_URBS; i++) {
> +			time = usb_wait_anchor_empty_timeout(
> +					&rt->out_urbs[i].submitted, 100);
> +			if (!time)
> +				usb_kill_anchored_urbs(
> +					&rt->out_urbs[i].submitted);
> +			usb_kill_urb(&rt->out_urbs[i].instance);
> +		}
> +
> +		rt->stream_state = STREAM_DISABLED;
> +	}
> +}
> +
> +/* call with stream_mutex locked */
> +static int hiface_pcm_stream_start(struct pcm_runtime *rt)
> +{
> +	int ret = 0, i;
> +
> +	if (rt->stream_state == STREAM_DISABLED) {
> +		/* submit our out urbs zero init */
> +		rt->stream_state = STREAM_STARTING;
> +		for (i = 0; i < PCM_N_URBS; i++) {
> +			memset(rt->out_urbs[i].buffer, 0, PCM_PACKET_SIZE);
> +			usb_anchor_urb(&rt->out_urbs[i].instance,
> +				       &rt->out_urbs[i].submitted);
> +			ret = usb_submit_urb(&rt->out_urbs[i].instance,
> +					GFP_ATOMIC);
> +			if (ret) {
> +				hiface_pcm_stream_stop(rt);
> +				return ret;
> +			}
> +		}
> +
> +		/* wait for first out urb to return (sent in in urb handler) */
> +		wait_event_timeout(rt->stream_wait_queue, rt->stream_wait_cond,
> +				HZ);
> +		if (rt->stream_wait_cond) {
> +			pr_debug("%s: Stream is running wakeup event\n",
> +				 __func__);
> +			rt->stream_state = STREAM_RUNNING;
> +		} else {
> +			hiface_pcm_stream_stop(rt);
> +			return -EIO;
> +		}
> +	}
> +	return ret;
> +}
> +
> +
> +/* The hardware wants word-swapped 32-bit values */
> +static void memcpy_swahw32(u8 *dest, u8 *src, unsigned int n)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < n / 4; i++)
> +		((u32 *)dest)[i] = swahw32(((u32 *)src)[i]);
> +}
> +
> +/* call with substream locked */
> +/* returns true if a period elapsed */
> +static bool hiface_pcm_playback(struct pcm_substream *sub,
> +		struct pcm_urb *urb)
> +{
> +	struct snd_pcm_runtime *alsa_rt = sub->instance->runtime;
> +	u8 *source;
> +	unsigned int pcm_buffer_size;
> +
> +	WARN_ON(alsa_rt->format != SNDRV_PCM_FORMAT_S32_LE);
> +
> +	pcm_buffer_size = snd_pcm_lib_buffer_bytes(sub->instance);
> +
> +	if (sub->dma_off + PCM_PACKET_SIZE <= pcm_buffer_size) {
> +		pr_debug("%s: (1) buffer_size %#x dma_offset %#x\n", __func__,
> +			 (unsigned int) pcm_buffer_size,
> +			 (unsigned int) sub->dma_off);
> +
> +		source = alsa_rt->dma_area + sub->dma_off;
> +		memcpy_swahw32(urb->buffer, source, PCM_PACKET_SIZE);
> +	} else {
> +		/* wrap around at end of ring buffer */
> +		unsigned int len;
> +
> +		pr_debug("%s: (2) buffer_size %#x dma_offset %#x\n", __func__,
> +			 (unsigned int) pcm_buffer_size,
> +			 (unsigned int) sub->dma_off);
> +
> +		len = pcm_buffer_size - sub->dma_off;
> +
> +		source = alsa_rt->dma_area + sub->dma_off;
> +		memcpy_swahw32(urb->buffer, source, len);
> +
> +		source = alsa_rt->dma_area;
> +		memcpy_swahw32(urb->buffer + len, source,
> +			       PCM_PACKET_SIZE - len);
> +	}
> +	sub->dma_off += PCM_PACKET_SIZE;
> +	if (sub->dma_off >= pcm_buffer_size)
> +		sub->dma_off -= pcm_buffer_size;
> +
> +	sub->period_off += PCM_PACKET_SIZE;
> +	if (sub->period_off >= alsa_rt->period_size) {
> +		sub->period_off %= alsa_rt->period_size;
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static void hiface_pcm_out_urb_handler(struct urb *usb_urb)
> +{
> +	struct pcm_urb *out_urb = usb_urb->context;
> +	struct pcm_runtime *rt = out_urb->chip->pcm;
> +	struct pcm_substream *sub;
> +	bool do_period_elapsed = false;
> +	unsigned long flags;
> +	int ret;
> +
> +	pr_debug("%s: called.\n", __func__);
> +
> +	if (rt->panic || rt->stream_state == STREAM_STOPPING)
> +		return;
> +
> +	if (unlikely(usb_urb->status == -ENOENT ||	/* unlinked */
> +		     usb_urb->status == -ENODEV ||	/* device removed */
> +		     usb_urb->status == -ECONNRESET ||	/* unlinked */
> +		     usb_urb->status == -ESHUTDOWN)) {	/* device disabled */
> +		goto out_fail;
> +	}
> +
> +	if (rt->stream_state == STREAM_STARTING) {
> +		rt->stream_wait_cond = true;
> +		wake_up(&rt->stream_wait_queue);
> +	}
> +
> +	/* now send our playback data (if a free out urb was found) */
> +	sub = &rt->playback;
> +	spin_lock_irqsave(&sub->lock, flags);
> +	if (sub->active)
> +		do_period_elapsed = hiface_pcm_playback(sub, out_urb);
> +	else
> +		memset(out_urb->buffer, 0, PCM_PACKET_SIZE);
> +
> +	spin_unlock_irqrestore(&sub->lock, flags);
> +
> +	if (do_period_elapsed)
> +		snd_pcm_period_elapsed(sub->instance);
> +
> +	ret = usb_submit_urb(&out_urb->instance, GFP_ATOMIC);
> +	if (ret < 0)
> +		goto out_fail;
> +
> +	return;
> +
> +out_fail:
> +	rt->panic = true;
> +}
> +
> +static int hiface_pcm_open(struct snd_pcm_substream *alsa_sub)
> +{
> +	struct pcm_runtime *rt = snd_pcm_substream_chip(alsa_sub);
> +	struct pcm_substream *sub = NULL;
> +	struct snd_pcm_runtime *alsa_rt = alsa_sub->runtime;
> +	int ret;
> +
> +	pr_debug("%s: called.\n", __func__);
> +
> +	if (rt->panic)
> +		return -EPIPE;
> +
> +	mutex_lock(&rt->stream_mutex);
> +	alsa_rt->hw = pcm_hw;
> +
> +	if (alsa_sub->stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		sub = &rt->playback;
> +
> +	if (!sub) {
> +		mutex_unlock(&rt->stream_mutex);
> +		pr_err("Invalid stream type\n");
> +		return -EINVAL;
> +	}
> +
> +	if (rt->extra_freq) {
> +		alsa_rt->hw.rates |= SNDRV_PCM_RATE_KNOT;
> +		alsa_rt->hw.rate_max = 384000;
> +
> +		/* explicit constraints needed as we added SNDRV_PCM_RATE_KNOT */
> +		ret = snd_pcm_hw_constraint_list(alsa_sub->runtime, 0,
> +						 SNDRV_PCM_HW_PARAM_RATE,
> +						 &constraints_extra_rates);
> +		if (ret < 0) {
> +			mutex_unlock(&rt->stream_mutex);
> +			return ret;
> +		}
> +	}
> +
> +	sub->instance = alsa_sub;
> +	sub->active = false;
> +	mutex_unlock(&rt->stream_mutex);
> +	return 0;
> +}
> +
> +static int hiface_pcm_close(struct snd_pcm_substream *alsa_sub)
> +{
> +	struct pcm_runtime *rt = snd_pcm_substream_chip(alsa_sub);
> +	struct pcm_substream *sub = hiface_pcm_get_substream(alsa_sub);
> +	unsigned long flags;
> +
> +	if (rt->panic)
> +		return 0;
> +
> +	pr_debug("%s: called.\n", __func__);
> +
> +	mutex_lock(&rt->stream_mutex);
> +	if (sub) {
> +		/* deactivate substream */
> +		spin_lock_irqsave(&sub->lock, flags);
> +		sub->instance = NULL;
> +		sub->active = false;
> +		spin_unlock_irqrestore(&sub->lock, flags);
> +
> +		/* all substreams closed? if so, stop streaming */
> +		if (!rt->playback.instance)
> +			hiface_pcm_stream_stop(rt);
> +	}
> +	mutex_unlock(&rt->stream_mutex);
> +	return 0;
> +}
> +
> +static int hiface_pcm_hw_params(struct snd_pcm_substream *alsa_sub,
> +		struct snd_pcm_hw_params *hw_params)
> +{
> +	pr_debug("%s: called.\n", __func__);
> +	return snd_pcm_lib_malloc_pages(alsa_sub,
> +			params_buffer_bytes(hw_params));
> +}
> +
> +static int hiface_pcm_hw_free(struct snd_pcm_substream *alsa_sub)
> +{
> +	pr_debug("%s: called.\n", __func__);
> +	return snd_pcm_lib_free_pages(alsa_sub);
> +}
> +
> +static int hiface_pcm_prepare(struct snd_pcm_substream *alsa_sub)
> +{
> +	struct pcm_runtime *rt = snd_pcm_substream_chip(alsa_sub);
> +	struct pcm_substream *sub = hiface_pcm_get_substream(alsa_sub);
> +	struct snd_pcm_runtime *alsa_rt = alsa_sub->runtime;
> +	int ret;
> +
> +	pr_debug("%s: called.\n", __func__);
> +
> +	if (rt->panic)
> +		return -EPIPE;
> +	if (!sub)
> +		return -ENODEV;
> +
> +	mutex_lock(&rt->stream_mutex);
> +
> +	sub->dma_off = 0;
> +	sub->period_off = 0;
> +
> +	if (rt->stream_state == STREAM_DISABLED) {
> +
> +		ret = hiface_pcm_set_rate(rt, alsa_rt->rate);
> +		if (ret) {
> +			mutex_unlock(&rt->stream_mutex);
> +			return ret;
> +		}
> +		ret = hiface_pcm_stream_start(rt);
> +		if (ret) {
> +			mutex_unlock(&rt->stream_mutex);
> +			return ret;
> +		}
> +	}
> +	mutex_unlock(&rt->stream_mutex);
> +	return 0;
> +}
> +
> +static int hiface_pcm_trigger(struct snd_pcm_substream *alsa_sub, int cmd)
> +{
> +	struct pcm_substream *sub = hiface_pcm_get_substream(alsa_sub);
> +	struct pcm_runtime *rt = snd_pcm_substream_chip(alsa_sub);
> +	unsigned long flags;
> +
> +	pr_debug("%s: called.\n", __func__);
> +
> +	if (rt->panic)
> +		return -EPIPE;
> +	if (!sub)
> +		return -ENODEV;
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
> +		spin_lock_irqsave(&sub->lock, flags);
> +		sub->active = true;
> +		spin_unlock_irqrestore(&sub->lock, flags);
> +		return 0;
> +
> +	case SNDRV_PCM_TRIGGER_STOP:
> +	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> +		spin_lock_irqsave(&sub->lock, flags);
> +		sub->active = false;
> +		spin_unlock_irqrestore(&sub->lock, flags);
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static snd_pcm_uframes_t hiface_pcm_pointer(struct snd_pcm_substream *alsa_sub)
> +{
> +	struct pcm_substream *sub = hiface_pcm_get_substream(alsa_sub);
> +	struct pcm_runtime *rt = snd_pcm_substream_chip(alsa_sub);
> +	unsigned long flags;
> +	snd_pcm_uframes_t dma_offset;
> +
> +	if (rt->panic || !sub)
> +		return SNDRV_PCM_STATE_XRUN;
> +
> +	spin_lock_irqsave(&sub->lock, flags);
> +	dma_offset = sub->dma_off;
> +	spin_unlock_irqrestore(&sub->lock, flags);
> +	return bytes_to_frames(alsa_sub->runtime, dma_offset);
> +}
> +
> +static struct snd_pcm_ops pcm_ops = {
> +	.open = hiface_pcm_open,
> +	.close = hiface_pcm_close,
> +	.ioctl = snd_pcm_lib_ioctl,
> +	.hw_params = hiface_pcm_hw_params,
> +	.hw_free = hiface_pcm_hw_free,
> +	.prepare = hiface_pcm_prepare,
> +	.trigger = hiface_pcm_trigger,
> +	.pointer = hiface_pcm_pointer,
> +};
> +
> +static int hiface_pcm_init_urb(struct pcm_urb *urb,
> +			       struct hiface_chip *chip,
> +			       unsigned int ep,
> +			       void (*handler)(struct urb *))
> +{
> +	urb->chip = chip;
> +	usb_init_urb(&urb->instance);
> +
> +	urb->buffer = kzalloc(PCM_PACKET_SIZE, GFP_KERNEL);
> +	if (!urb->buffer)
> +		return -ENOMEM;
> +
> +	usb_fill_bulk_urb(&urb->instance, chip->dev,
> +			  usb_sndbulkpipe(chip->dev, ep), (void *)urb->buffer,
> +			  PCM_PACKET_SIZE, handler, urb);
> +	init_usb_anchor(&urb->submitted);
> +
> +	return 0;
> +}
> +
> +void hiface_pcm_abort(struct hiface_chip *chip)
> +{
> +	struct pcm_runtime *rt = chip->pcm;
> +
> +	if (rt) {
> +		rt->panic = true;
> +
> +		if (rt->playback.instance) {
> +			snd_pcm_stream_lock_irq(rt->playback.instance);
> +			snd_pcm_stop(rt->playback.instance,
> +					SNDRV_PCM_STATE_XRUN);
> +			snd_pcm_stream_unlock_irq(rt->playback.instance);
> +		}
> +		mutex_lock(&rt->stream_mutex);
> +		hiface_pcm_stream_stop(rt);
> +		mutex_unlock(&rt->stream_mutex);
> +	}
> +}
> +
> +static void hiface_pcm_destroy(struct hiface_chip *chip)
> +{
> +	struct pcm_runtime *rt = chip->pcm;
> +	int i;
> +
> +	for (i = 0; i < PCM_N_URBS; i++)
> +		kfree(rt->out_urbs[i].buffer);
> +
> +	kfree(chip->pcm);
> +	chip->pcm = NULL;
> +}
> +
> +static void hiface_pcm_free(struct snd_pcm *pcm)
> +{
> +	struct pcm_runtime *rt = pcm->private_data;
> +
> +	pr_debug("%s: called.\n", __func__);
> +
> +	if (rt)
> +		hiface_pcm_destroy(rt->chip);
> +}
> +
> +int hiface_pcm_init(struct hiface_chip *chip, u8 extra_freq)
> +{
> +	int i;
> +	int ret;
> +	struct snd_pcm *pcm;
> +	struct pcm_runtime *rt;
> +
> +	rt = kzalloc(sizeof(*rt), GFP_KERNEL);
> +	if (!rt)
> +		return -ENOMEM;
> +
> +	rt->chip = chip;
> +	rt->stream_state = STREAM_DISABLED;
> +	if (extra_freq)
> +		rt->extra_freq = 1;
> +
> +	init_waitqueue_head(&rt->stream_wait_queue);
> +	mutex_init(&rt->stream_mutex);
> +	spin_lock_init(&rt->playback.lock);
> +
> +	for (i = 0; i < PCM_N_URBS; i++)
> +		hiface_pcm_init_urb(&rt->out_urbs[i], chip, OUT_EP,
> +				hiface_pcm_out_urb_handler);
> +
> +	ret = snd_pcm_new(chip->card, "USB-SPDIF Audio", 0, 1, 0, &pcm);
> +	if (ret < 0) {
> +		kfree(rt);
> +		pr_err("Cannot create pcm instance\n");
> +		return ret;
> +	}
> +
> +	pcm->private_data = rt;
> +	pcm->private_free = hiface_pcm_free;
> +
> +	strcpy(pcm->name, "USB-SPDIF Audio");
> +	snd_pcm_set_ops(pcm, SNDRV_PCM_STREAM_PLAYBACK, &pcm_ops);
> +
> +	snd_pcm_lib_preallocate_pages_for_all(pcm,
> +					SNDRV_DMA_TYPE_CONTINUOUS,
> +					snd_dma_continuous_data(GFP_KERNEL),
> +					PCM_BUFFER_SIZE, PCM_BUFFER_SIZE);
> +	rt->instance = pcm;
> +
> +	chip->pcm = rt;
> +	return 0;
> +}
> 
