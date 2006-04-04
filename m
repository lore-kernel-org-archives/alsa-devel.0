From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Tue, 4 Apr 2006 17:28:48 -0400
Message-ID: <d120d5000604041428h65931eb6qffe1af04d91e7f31__8803.08334385536$1144192532$gmane$org@mail.gmail.com>
References: <44238489.8090402@keyaccess.nl> <1FQquz-2CO-00@press.kroah.org>
	 <d120d5000604041323h448c1ccfi7e9dcedd82c385ba@mail.gmail.com>
	 <20060404210048.GA5694@suse.de>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.229])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 024FA197
	for <alsa-devel@alsa-project.org>; Tue,  4 Apr 2006 23:28:59 +0200 (MEST)
Received: by wproxy.gmail.com with SMTP id 69so22813wri
        for <alsa-devel@alsa-project.org>; Tue, 04 Apr 2006 14:28:58 -0700 (PDT)
In-Reply-To: <20060404210048.GA5694@suse.de>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Greg KH <gregkh@suse.de>
Cc: rene.herman@keyaccess.nl, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On 4/4/06, Greg KH <gregkh@suse.de> wrote:
>
> Hm, no, I unwound this mess, and found the following:
>
>  - bus_add_device() calls device_attach()
>  - device_attach() calls bus_for_each_drv() for every driver on the bus
>  - bus_for_each_drv() walks all drivers on the bus and calls
>   __device_attach() for every individual driver
>  - __device_attach() calls driver_probe_device() for that driver and devi=
ce
>  - driver_probe_device() calls down to the probe() function for the
>   driver, passing it that driver, if match() for the bus matches this
>   device.
>  - if that probe() function returns -ENODEV or -ENXIO[1] then the error
>   is ignored and 0 is returned, causing the loop to continue to try
>   more drivers
>  - if the probe() function returns any other error code, it is
>   propagated up, all the way back to bus_add_device.

But why do we do that? probe() failing is driver's problem. The device
is still there and should still be presented in sysfs. I don't think
that we should stop if probe() fails - maybe next driver manages to
bind itself.

>  - if the probe() function returns 0, the device is bound to the driver,
>   and it returns 0.  Hm, looks like we continue to loop here too, we
>   could probably stop now that we have bound a driver to the device.
>

Could it be that logic is simply reversed?

> So, I'm pretty sure that this is safe and should work just fine.  To be
> sure, let me go reboot my box with this change on it after I finish this
> email :)
>
> Does that help?
>
> thanks,
>
> greg k-h
>
> [1] - stupid agp drivers (or some other video drivers) require this.  I
>    need to go fix them up so they don't do this, if they haven't been
>    fixed already...
>


--
Dmitry


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
