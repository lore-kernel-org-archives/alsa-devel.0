From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: snd_hda_intel/snd_hda_codec_hdmi module
	load/unload race
Date: Fri, 16 Dec 2016 08:40:54 -0800
Message-ID: <20161216164054.GA11727@kroah.com>
References: <1481749250.8172.5.camel@intel.com> <s5hr359bf7r.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 by alsa0.perex.cz (Postfix) with ESMTP id BC3A32675B3
 for <alsa-devel@alsa-project.org>; Fri, 16 Dec 2016 17:40:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hr359bf7r.wl-tiwai@suse.de>
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
Cc: imre.deak@intel.com, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 15, 2016 at 12:32:08PM +0100, Takashi Iwai wrote:
> On Wed, 14 Dec 2016 22:00:50 +0100,
> Imre Deak wrote:
> > 
> > Hi,
> > 
> > I got the trace below while trying to unload (unbind) snd_hda_intel, while
> > its still loading the HDMI codec driver. IIUC what happens is:
> > 
> > Task1                                    Task2                                    Task3
> > modprobe snd_hda_intel
> >   schedule(azx_probe_work)
> > unbind snd_hda_intel via sysfs
> >   device_release_driver()
> >     device_lock(snd_hda_intel)
> >     azx_remove()
> >       cancel_work_sync(azx_probe_work)
> >                                          azx_probe_work()
> >                                            request_module(snd-hda-codec-hdmi)
> >                                                                                   hdmi_driver_init()
> >                                                                                     __driver_attach()
> >                                                                                       device_lock(snd_hda_intel)
> > 
> > Deadlock, since azx_probe_work() will never finish and the snd_hda_intel device
> > lock will never get released.
> 
> This is indeed nasty.  The deadlock happens when the driver core takes
> the parent's device lock.
> 
> static int __driver_attach(struct device *dev, void *data)
> {
> ....
> 	if (dev->parent)	/* Needed for USB */
> 		device_lock(dev->parent);
> 	device_lock(dev);
> 	if (!dev->driver)
> 		driver_probe_device(drv, dev);
> 
> I vaguely remember of some other issue due to the device_lock of the
> parent device.  And, I guess a similar deadlock may happen not only
> with HD-audio driver but also in general with every driver using async
> probe.
> 
> Greg, any good way to avoid such a deadlock?  Can we make the parent
> device lock conditional somehow?

Ick, messy.  I don't want to make the parent lock conditional, as it's
needed.  Shouldn't the cancel_work_sync() prevent the request_module()
from running?  Seems like you need to serialize your probe_work
somehow...

I don't see a way to handle this in the driver core, and no:

> --- a/sound/hda/hdac_device.c
> +++ b/sound/hda/hdac_device.c
> @@ -44,7 +44,7 @@ int snd_hdac_device_init(struct hdac_device *codec, struct hdac_bus *bus,
>  
>  	dev = &codec->dev;
>  	device_initialize(dev);
> -	dev->parent = bus->dev;
> +	// dev->parent = bus->dev;
>  	dev->bus = &snd_hda_bus_type;
>  	dev->release = default_release;
>  	dev->groups = hdac_dev_attr_groups;
> 
> ... but it's obviously ugly :)

That's not a good solution either :)

thanks,

greg k-h
