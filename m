From: Martin Langer <martin-langer@gmx.de>
Subject: Re: Using the usx2y driver under Fedora Core 5.
Date: Tue, 16 May 2006 14:42:52 +0200
Message-ID: <20060516124252.GA5210@tuba>
References: <Pine.LNX.4.63.0605160318130.13214@goblin.caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id DF0DD22F
	for <alsa-devel@alsa-project.org>; Tue, 16 May 2006 14:38:34 +0200 (MEST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0605160318130.13214@goblin.caltech.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Shepherd <mcs@astro.caltech.edu>
Cc: Karsten Wiese <annabellesgarden@yahoo.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, May 16, 2006 at 03:39:20AM -0700, Martin Shepherd wrote:

> I'm not sure if you are the appropriate person to send this to. If
> not, could you please tell me whom I should contact.

I think alsa-devel is a good choice. Well, let's knock at the doors of 
the alsa headquarter now :)

> I've just got my Tascam US-122 box working with the us2xy driver,
> under Fedora Core 5. Since FC5 doesn't come with /sbin/hotplug etc,
> and the installation procedure of the alsa-firmware package from
> alsa-project.org, incorrectly assumes that hotplug is there, I decided
> to try to figure out how to configure udev to auto-load both the first
> and second stage firmware of the US-122, without needing to install
> the obsolete hotplug facility. This worked, and having done so, I now
> don't have to do anything except plug in the USB cable of the US-122
> into my latop, and wait a few seconds for the USB LED on the US-122 to
> light, before I can use the box.
> 
> In case you are interested, I have documented everything that I did,
> at the following URL.
> 
>  http://www.astro.caltech.edu/~mcs/tascam_us122/index.html
> 
> Obviously it would be nice to get the UDEV configuration into the
> standard ALSA build procedure (to be used when /sbin/hotplug is
> absent, and /etc/udev/rules.d is present). Is this something that you
> would like to do, or is there somebody else that I should contact? If
> the best thing would be for me to put together a patch against the
> alsa code, could you tell me how I should go about submitting this?

Please send further questions/patches to the alsa-devel mailling list. 
( I'm a little bit out of sync with the latest alsa development at the 
moment, especially UDEV. )

For me it's a nice idea. We should add some US-224/428 support, too. 
Which means to add some ID's and an us428control command. But 
unfortunately I have no 224/428 for testing, only a 122 and I just read 
that it's already known to work.


Martin


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
