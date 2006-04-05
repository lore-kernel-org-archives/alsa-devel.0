From: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Wed, 5 Apr 2006 08:36:02 +0100
Message-ID: <20060405073602.GA1380__28852.1080547527$1144223085$gmane$org@flint.arm.linux.org.uk>
References: <44238489.8090402@keyaccess.nl> <d120d5000604041428h65931eb6qffe1af04d91e7f31@mail.gmail.com> <20060404214522.GA20390@suse.de> <200604042135.41371.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk [212.18.232.186])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B8C5C170
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 09:36:14 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <200604042135.41371.dtor_core@ameritech.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Greg KH <gregkh@suse.de>, rene.herman@keyaccess.nl, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 04, 2006 at 09:35:40PM -0400, Dmitry Torokhov wrote:
> On Tuesday 04 April 2006 17:45, Greg KH wrote:
> > Ah, I see what you are saying now.  Yeah, we should still add the
> > default attributes for the bus and create the bus link even if some
> > random driver had problems.  But then, we should still propagate the
> > error back up, right?
> 
> I don't think so because device creation did not fail. Otherwise how
> would you as a caller of device_register() distinguish between the
> following 2 scenarios:
> 
>  - you got -ENOMEM (or other error code) because device creation
>    indeed failed;
>  - you got -ENOMEM because some odd driver could not allocate 4MB
>    of memory.
> 
> IOW you trying to propagate driver error to device creation code...
> 
> Also result of device_register() should not depend on whether
> driver_register() was called earlier or not.

Indeed.  Greg - this patch is bogus.

When device_register() returns a negative number, many device drivers
assume (correctly) that the device was _not_ registered and they will
take whatever cleanup action is necessary to free the memory associated
with that device, believing that sysfs never used it.

If we start propagating driver probe error codes up through device_register()
we then have a big headache.  Is this -ENOMEM error a result of not being
able to register the struct device, or is it because something failed in
the driver.

This will also impact hotplug and PCMCIA.  For example, you have a device
driver loaded, but are short on memory, and you insert a PCMCIA device.
That creates a struct device.  Let's say that the driver fails to allocate
enough memory, and returns -ENOMEM.  With this patch, that'll kill off
the struct device.  Now, when the device is pulled, we could end up calling
driver_unregister on an unregistered struct device.

The expectations by current subsystems is that struct device registration
does _NOT_ depend on the currently loaded set of device drivers not
returning errors.

The thing is that this is all corner case stuff - you can apply this patch
and apparantly have a working system.  It's the corner cases where some
driver returns a failure which are the problem case.

Note also that this patch will not do what the ALSA folk want - they want
to know if the device was found or whether the probe returned -ENODEV.
We knock -ENODEV and -ENXIO to zero in driver_probe_device(), so they
won't even see that.

There is also no 1:1 relationship between platform device drivers and
platform devices.  You can have multiple platform devices driven by one
platform device driver.  See the plethora of platform devices in the
ARM sub-tree.  Or serial sub-tree.

So, all round this patch seems wrong.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
