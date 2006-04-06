From: Greg KH <greg@kroah.com>
Subject: Re: patch bus_add_device-losing-an-error-return-from-the-probe-method.patch added to gregkh-2.6 tree
Date: Wed, 5 Apr 2006 18:05:15 -0700
Message-ID: <20060406010515.GB18567__39554.479570552$1144285631$gmane$org@kroah.com>
References: <44238489.8090402@keyaccess.nl> <d120d5000604041428h65931eb6qffe1af04d91e7f31@mail.gmail.com> <20060404214522.GA20390@suse.de> <200604042135.41371.dtor_core@ameritech.net> <20060405073602.GA1380@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0D2FC121
	for <alsa-devel@alsa-project.org>; Thu,  6 Apr 2006 03:06:05 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <20060405073602.GA1380@flint.arm.linux.org.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Dmitry Torokhov <dtor_core@ameritech.net>, Greg KH <gregkh@suse.de>, rene.herman@keyaccess.nl, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

On Wed, Apr 05, 2006 at 08:36:02AM +0100, Russell King wrote:
> On Tue, Apr 04, 2006 at 09:35:40PM -0400, Dmitry Torokhov wrote:
> > On Tuesday 04 April 2006 17:45, Greg KH wrote:
> > > Ah, I see what you are saying now.  Yeah, we should still add the
> > > default attributes for the bus and create the bus link even if some
> > > random driver had problems.  But then, we should still propagate the
> > > error back up, right?
> > 
> > I don't think so because device creation did not fail. Otherwise how
> > would you as a caller of device_register() distinguish between the
> > following 2 scenarios:
> > 
> >  - you got -ENOMEM (or other error code) because device creation
> >    indeed failed;
> >  - you got -ENOMEM because some odd driver could not allocate 4MB
> >    of memory.
> > 
> > IOW you trying to propagate driver error to device creation code...
> > 
> > Also result of device_register() should not depend on whether
> > driver_register() was called earlier or not.
> 
> Indeed.  Greg - this patch is bogus.

You and Dmitry are correct.  I'm dropping this patch.  The ISA drivers
just need to get used to the proper way to use the driver model (they do
not know if they have been bound to a device when the driver is loaded,
no big deal).

If there's other issues with platform devices still, without this patch
applied, please let me know.

thanks to you all for pointing out the real issues here.

greg k-h


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
