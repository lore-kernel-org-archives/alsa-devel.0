From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Problems with Hercules DJ Console and the usb-audio
 driver
Date: Wed, 14 Sep 2005 18:15:30 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0509141729220.16662-100000@studcom.urz.uni-halle.de>
References: <20050914132346.GA18354@nittionio.nu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050914132346.GA18354@nittionio.nu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Daniel Svensson <nano@nittionio.nu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Daniel Svensson wrote:
> So a resume of changes to minimal support for this device.
>
> 1. Classify the MIDI interface as standard MIDI interface.

The driver already did this, but a recent reorganization did not
handle this case correctly.

This has now been fixed in CVS.

> 2. Ignore mixer errors.

I'll add another quirk for this to the driver.

> 3. Disable CONFIG_USB_BANDWIDTH

The USB bandwidth code is broken for all devices.

> Is it perhaps possible to have Rear Left/Right on the same element?
> Currently they're all named 'PCM', Front, Rear, Center, Woofer would be
> good names.

The hardware has only one mixer control with six channels, so we
cannot use different names for these.

The 2+2+1+1 controls in alsamixer are based on a wrong assumption by
alsamixer, but it's hard to fix this because currently there isn't an
interfacve to pass this information to the application.

The abstract mixer layer (being written) should fix both problems.

> Does Capture need to be working before support enters ALSA or that
> can wait?

What has capture to do with this?  Doesn't it work?


Regards,
Clemens



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
