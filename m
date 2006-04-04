From: Greg KH <gregkh@suse.de>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Tue, 4 Apr 2006 14:15:05 -0700
Message-ID: <20060404211505.GA7760@suse.de>
References: <44238489.8090402@keyaccess.nl> <1FQquz-2CO-00@press.kroah.org> <d120d5000604041323h448c1ccfi7e9dcedd82c385ba@mail.gmail.com> <20060404210048.GA5694@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from aria.kroah.org (dsl093-040-174.pdx1.dsl.speakeasy.net [66.93.40.174])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id DDAE0219
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2006 23:15:49 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20060404210048.GA5694@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: dtor_core@ameritech.net
Cc: rene.herman@keyaccess.nl, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 04, 2006 at 02:00:48PM -0700, Greg KH wrote:
> On Tue, Apr 04, 2006 at 04:23:43PM -0400, Dmitry Torokhov wrote:
> > On 4/4/06, gregkh@suse.de <gregkh@suse.de> wrote:
> > >
> > > --- gregkh-2.6.orig/drivers/base/bus.c
> > > +++ gregkh-2.6/drivers/base/bus.c
> > > @@ -372,14 +372,17 @@ int bus_add_device(struct device * dev)
> > >
> > >        if (bus) {
> > >                pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
> > > -               device_attach(dev);
> > > +               error = device_attach(dev);
> > > +               if (error < 0)
> > > +                       goto exit;
> > 
> > I do not believe that this is correct. The fact that _some_ driver
> > failed to attach to a device does not necessarily mean that device
> > itself does not exist. While this assuption might work for platform
> > devices it won't work for other busses.
> 
> Hm, no, I unwound this mess, and found the following:
> 
>  - bus_add_device() calls device_attach()
>  - device_attach() calls bus_for_each_drv() for every driver on the bus
>  - bus_for_each_drv() walks all drivers on the bus and calls
>    __device_attach() for every individual driver
>  - __device_attach() calls driver_probe_device() for that driver and device
>  - driver_probe_device() calls down to the probe() function for the
>    driver, passing it that driver, if match() for the bus matches this
>    device.
>  - if that probe() function returns -ENODEV or -ENXIO[1] then the error
>    is ignored and 0 is returned, causing the loop to continue to try
>    more drivers
>  - if the probe() function returns any other error code, it is
>    propagated up, all the way back to bus_add_device.
>  - if the probe() function returns 0, the device is bound to the driver,
>    and it returns 0.  Hm, looks like we continue to loop here too, we
>    could probably stop now that we have bound a driver to the device.
> 
> So, I'm pretty sure that this is safe and should work just fine.  To be
> sure, let me go reboot my box with this change on it after I finish this
> email :)

Yup, things still seem to work properly for me.  The patch will show up
in the next -mm for others to beat on...

thanks,

greg k-h


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
