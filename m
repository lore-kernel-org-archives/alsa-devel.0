From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
Subject: Re: [RFC] add bus driver model support for ad hoc
	AC97 drivers
Date: Wed, 26 Jan 2005 16:39:42 +0000
Message-ID: <1106757581.3998.1692.camel@cearnarfon>
References: <Pine.LNX.4.61.0501261051150.16341@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0501261051150.16341@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nicolas Pitre <nico@cam.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Nicolas,

I was about to suggest a similar feature...

I have other touch and battery drivers that can use this model. I'll
port them from the OSS style plugin and give them a test. I don't see
any problems.

It will also be useful for AC97 codecs that have additional I2S/SSP
ADC's and DAC's that are controlled via the AC97 interface.

Liam


On Wed, 2005-01-26 at 16:26, Nicolas Pitre wrote:
> I would like to know what people think of the following patch.  It 
> allows for a codec on an AC97 bus to be shared with other drivers which 
> are completely unrelated to audio.  It registers a new bus type, and 
> whenever a codec instance is created then a device for it is also 
> registered with the driver model using that bus type.  This allows, for 
> example, to use the extra features of the UCB1400 like the touchscreen 
> interface and the additional GPIOs and ADCs available on that chip for 
> battery monitoring.  I have a working UCB1400 touchscreen driver here 
> that simply registers with the driver model happily working alongside 
> with audio features using this.
> 
> 
> Index: linux-2.6/sound/pci/ac97/ac97_bus.c
> ===================================================================
> --- /dev/null
> +++ linux-2.6/sound/pci/ac97/ac97_bus.c
> @@ -0,0 +1,80 @@
> +/*
> + * Linux driver model AC97 bus interface
> + *
> + * Author:	Nicolas Pitre
> + * Created:	Jan 14, 2005
> + * Copyright:	(C) MontaVista Software Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/device.h>
> +#include <linux/string.h>
> +
> +#include <sound/driver.h>
> +#include <sound/core.h>
> +#include <sound/ac97_codec.h>
> +
> +
> +static int ac97_bus_match(struct device *dev, struct device_driver *drv)
> +{
> +	return (strncmp(drv->name, dev->bus_id, BUS_ID_SIZE) == 0);
> +}
> +
> +static int ac97_bus_suspend(struct device *dev, pm_message_t state)
> +{
> +	int ret = 0;
> +
> +	if (dev->driver && dev->driver->suspend) {
> +		ret = dev->driver->suspend(dev, state, SUSPEND_DISABLE);
> +		if (ret == 0)
> +			ret = dev->driver->suspend(dev, state, SUSPEND_SAVE_STATE);
> +		if (ret == 0)
> +			ret = dev->driver->suspend(dev, state, SUSPEND_POWER_DOWN);
> +	}
> +	return ret;
> +}
> +
> +static int ac97_bus_resume(struct device *dev)
> +{
> +	int ret = 0;
> +
> +	if (dev->driver && dev->driver->resume) {
> +		ret = dev->driver->resume(dev, RESUME_POWER_ON);
> +		if (ret == 0)
> +			ret = dev->driver->resume(dev, RESUME_RESTORE_STATE);
> +		if (ret == 0)
> +			ret = dev->driver->resume(dev, RESUME_ENABLE);
> +	}
> +	return ret;
> +}
> +
> +struct bus_type ac97_bus_type = {
> +	.name		= "ac97",
> +	.match		= ac97_bus_match,
> +	.suspend	= ac97_bus_suspend,
> +	.resume		= ac97_bus_resume,
> +};
> +
> +static int __init ac97_bus_init(void)
> +{
> +	return bus_register(&ac97_bus_type);
> +}
> +
> +subsys_initcall(ac97_bus_init);
> +
> +static void __exit ac97_bus_exit(void)
> +{
> +	bus_unregister(&ac97_bus_type);
> +}
> +
> +module_exit(ac97_bus_exit);
> +
> +EXPORT_SYMBOL(ac97_bus_type);
> +
> +MODULE_LICENSE("GPL");
> Index: linux-2.6/sound/pci/ac97/Makefile
> ===================================================================
> --- linux-2.6.orig/sound/pci/ac97/Makefile
> +++ linux-2.6/sound/pci/ac97/Makefile
> @@ -12,7 +12,7 @@
>  snd-ak4531-codec-objs := ak4531_codec.o
>  
>  # Toplevel Module Dependency
> -obj-$(CONFIG_SND_AC97_CODEC) += snd-ac97-codec.o
> +obj-$(CONFIG_SND_AC97_CODEC) += snd-ac97-codec.o ac97_bus.o
>  obj-$(CONFIG_SND_ENS1370) += snd-ak4531-codec.o
>  
>  obj-m := $(sort $(obj-m))
> Index: linux-2.6/sound/pci/ac97/ac97_codec.c
> ===================================================================
> --- linux-2.6.orig/sound/pci/ac97/ac97_codec.c
> +++ linux-2.6/sound/pci/ac97/ac97_codec.c
> @@ -1039,6 +1039,8 @@
>  {
>  	if (ac97) {
>  		snd_ac97_proc_done(ac97);
> +		if (ac97->dev.bus)
> +			device_unregister(&ac97->dev);
>  		if (ac97->bus) {
>  			ac97->bus->codec[ac97->num] = NULL;
>  			if (ac97->bus->shared_type) {
> @@ -2110,6 +2112,12 @@
>  		snd_ac97_free(ac97);
>  		return err;
>  	}
> +	ac97->dev.bus = &ac97_bus_type;
> +	ac97->dev.parent = ac97->bus->card->dev;
> +	ac97->dev.platform_data = ac97;
> +	strncpy(ac97->dev.bus_id, snd_ac97_get_short_name(ac97), BUS_ID_SIZE);
> +	if ((err = device_register(&ac97->dev)) < 0)
> +		return err;
>  	*rac97 = ac97;
>  
>  	if (bus->shared_type) {
> Index: linux-2.6/include/sound/ac97_codec.h
> ===================================================================
> --- linux-2.6.orig/include/sound/ac97_codec.h
> +++ linux-2.6/include/sound/ac97_codec.h
> @@ -26,6 +26,7 @@
>   */
>  
>  #include <linux/bitops.h>
> +#include <linux/device.h>
>  #include "pcm.h"
>  #include "control.h"
>  #include "info.h"
> @@ -508,6 +509,7 @@
>  		} ad18xx;
>  		unsigned int dev_flags;		/* device specific */
>  	} spec;
> +	struct device dev;
>  };
>  
>  /* conditions */
> @@ -580,4 +582,7 @@
>  int snd_ac97_pcm_close(struct ac97_pcm *pcm);
>  int snd_ac97_pcm_double_rate_rules(snd_pcm_runtime_t *runtime);
>  
> +/* for ad hoc drivers... */
> +extern struct bus_type ac97_bus_type;
> +
>  #endif /* __SOUND_AC97_CODEC_H */
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
> 
> ________________________________________________________________________
> This email has been scanned for all viruses by the MessageLabs Email
> Security System. 
> ________________________________________________________________________



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
