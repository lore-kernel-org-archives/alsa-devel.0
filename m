From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Wed, 5 Apr 2006 10:59:04 -0400
Message-ID: <d120d5000604050759k576133a9t90dd02c35fce91af__42982.1487785832$1144250614$gmane$org@mail.gmail.com>
References: <44238489.8090402@keyaccess.nl> <20060404210048.GA5694@suse.de>
	 <4432EF58.1060502@keyaccess.nl>
	 <200604042148.57286.dtor_core@ameritech.net>
	 <4433CB34.6010707@keyaccess.nl>
Reply-To: dtor_core@ameritech.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.230])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id E1BD621A
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 16:59:05 +0200 (MEST)
Received: by wproxy.gmail.com with SMTP id 69so178730wri
        for <alsa-devel@alsa-project.org>; Wed, 05 Apr 2006 07:59:04 -0700 (PDT)
In-Reply-To: <4433CB34.6010707@keyaccess.nl>
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
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Greg KH <gregkh@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>
List-Id: alsa-devel@alsa-project.org

On 4/5/06, Rene Herman <rene.herman@keyaccess.nl> wrote:
> Dmitry Torokhov wrote:
>
> > On Tuesday 04 April 2006 18:12, Rene Herman wrote:
>
> >> To Dmitry, I see you saying "probe() failing is driver's problem.
> >> The device is still there and should still be presented in sysfs.".
> >> No, at least in the case of these platform drivers (or at least
> >> these old ISA cards using the platform driver interface), a -ENODEV
> >> return from the probe() method would mean the device is _not_
> >> present (or not found at least). NODEV.
> >
> > Or you could separate device probing code from driver->probe(). BTW I
> > think that ->probe() is not the best name for that method.
>
> Right...
>
> > It really is supposed to allocate resources and initialize the device
> > so that it is ready to be used, not to verify that device is present.
> > The code that created device shoudl've done that.
>
> How do you feel about the flag that I've been proposing that a driver
> that needs to probe for its hardware could set and that says "if we
> return an error (or specifically -ENODEV I guess) the hardware's
> reallyreally not present and the device should not register"?
>
> Greg, and how do you feel about such a flag?
>
> As an alternative to the flag, how would either of you feel about either
>
> 1) adding a .discover method to struct device_driver that noone other
> than drivers for this old non generically discoverable hardware would
> set but which would make a registration fail if set and returning < 0?
>
> 2) adding that method only to platform_driver?
>
> 3) ... and after a few months when people aren't paying attention
> anymore rename .probe to .init and .discover back to .probe? ;-)
>

You need to let go of the model that driver that drives hardware also
do the device discovery and it will all fall into place. While it may
be contained in the same source module it is 2 different code chunks
(for the lack of the better word) and we should not mix them together.

> Russel, you wrote:
>
> > Note also that this patch will not do what the ALSA folk want - they
> > want to know if the device was found or whether the probe returned
> > -ENODEV. We knock -ENODEV and -ENXIO to zero in
> > driver_probe_device(), so they won't even see that.
>
> Yes, I know about the -ENODEV / -ENXIO thing. I asked for comment on
> that as well, but haven't gotten any.
>
> Anyways, the additional method would, I feel, be the conceptually
> cleanest approach. Practically speaking though, simply doing a manual
> probe and only calling platform_register() after everything is found to
> be present and accounted for is not much of a problem either.
>

Unfortunately it breaks manual driver binding/unbinding through sysfs
so I don't think it is a good long-term solution.

--
Dmitry


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
