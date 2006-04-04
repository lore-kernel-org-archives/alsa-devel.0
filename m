From: Greg KH <gregkh@suse.de>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Tue, 4 Apr 2006 14:45:22 -0700
Message-ID: <20060404214522.GA20390__45281.7917139784$1144189264$gmane$org@suse.de>
References: <44238489.8090402@keyaccess.nl> <1FQquz-2CO-00@press.kroah.org> <d120d5000604041323h448c1ccfi7e9dcedd82c385ba@mail.gmail.com> <20060404210048.GA5694@suse.de> <d120d5000604041428h65931eb6qffe1af04d91e7f31@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from aria.kroah.org (dsl093-040-174.pdx1.dsl.speakeasy.net [66.93.40.174])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C17FF163
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2006 23:46:06 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <d120d5000604041428h65931eb6qffe1af04d91e7f31@mail.gmail.com>
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

On Tue, Apr 04, 2006 at 05:28:48PM -0400, Dmitry Torokhov wrote:
> On 4/4/06, Greg KH <gregkh@suse.de> wrote:
> >
> > Hm, no, I unwound this mess, and found the following:
> >
> >  - bus_add_device() calls device_attach()
> >  - device_attach() calls bus_for_each_drv() for every driver on the bus
> >  - bus_for_each_drv() walks all drivers on the bus and calls
> >   __device_attach() for every individual driver
> >  - __device_attach() calls driver_probe_device() for that driver and device
> >  - driver_probe_device() calls down to the probe() function for the
> >   driver, passing it that driver, if match() for the bus matches this
> >   device.
> >  - if that probe() function returns -ENODEV or -ENXIO[1] then the error
> >   is ignored and 0 is returned, causing the loop to continue to try
> >   more drivers
> >  - if the probe() function returns any other error code, it is
> >   propagated up, all the way back to bus_add_device.
> 
> But why do we do that? probe() failing is driver's problem. The device
> is still there and should still be presented in sysfs. I don't think
> that we should stop if probe() fails - maybe next driver manages to
> bind itself.

The device is still there.

Ah, I see what you are saying now.  Yeah, we should still add the
default attributes for the bus and create the bus link even if some
random driver had problems.  But then, we should still propagate the
error back up, right?

If I changed the patch to do that, would it be acceptable to you?

thanks,

greg k-h


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
