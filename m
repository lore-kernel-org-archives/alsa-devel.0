From: Matt Flax <flatmax@ieee.org>
Subject: Re: usb Duo no device ? using midisport-firmware
Date: Fri, 25 Jul 2003 16:10:10 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030725061010.GA6669@mffm.ee.unsw.edu.au>
References: <20030724070100.GA647@mffm.ee.unsw.edu.au> <Pine.HPX.4.33n.0307240939540.9204-100000@studcom.urz.uni-halle.de>
Reply-To: Matt Flax <flatmax@pgb.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.unsw.edu.au (smtp3.unsw.EDU.AU [149.171.96.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id HAA01615
	for <alsa-devel@alsa-project.org>; Fri, 25 Jul 2003 07:07:20 +0200
Content-Disposition: inline
In-Reply-To: <Pine.HPX.4.33n.0307240939540.9204-100000@studcom.urz.uni-halle.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hmmm,

Right you are. There is no midi !

I have to use the usb-ohci driver as I have a laptop with a SiS chipset.
I can't use the onboard sound card 'cause the chipset is not supported 
properly. Its a SiS 7018 audio chip onboard. 

>From this page you can see that the core logic are SiS M650+ SiS 962
chips :
http://www.clevo.com.tw/products/D400.asp

So back to the usb-audio ...

On Thu, Jul 24, 2003 at 09:59:00AM +0200, Clemens Ladisch wrote:
> Matt Flax wrote:
> > I am having trouble with the usb driver for the M-Audio Duo usb
> > external sound card. I use kernel 2.4.21-2-686 on a Debian system.
> > alsa-driver-0.9.5
> >
> > In order to do this I used Clemens Ladisch's  midisport-firmware driver
> 
> You don't need this to use the Duo, the loader is for MIDI devices
> only.
> 
> > I get the following message in /var/log/syslog :
> > localhost kernel: ALSA usbaudio.c:686: cannot submit datapipe for urb 0,
> > err = -22
> >
> > dmesg prints out the following :
> > usb.c: USB disconnect on device 00:03.0-1 address 3
> > hub.c: new USB device 00:03.0-1, assigned address 4
> > usb_control/bulk_msg: timeout
> > usb_control/bulk_msg: timeout
> > usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 809 ret -110
> > usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 809 ret -12
> > usb_control/bulk_msg: timeout
> > usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 9 ret -110
> > usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 18 ret -110
> > usb_control/bulk_msg: timeout
> > usb_control/bulk_msg: timeout
> > usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 18 ret -110
> > usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 18 ret -110
> > usb_control/bulk_msg: timeout
> > usbdevfs: USBDEVFS_CONTROL failed dev 4 rqt 128 rq 6 len 809 ret -110
> > ALSA usbaudio.c:686: cannot submit datapipe for urb 0, err = -22
> > ALSA usbaudio.c:686: cannot submit datapipe for urb 0, err = -22
> >
> > The last two lines are from trying aply with a wav file.
> 
> Please try to use the latest CVS version of ALSA, there have been some
> fixes in the USB Audio driver.
> 
> If you're using the uhci driver, try usb-uhci instead.
> 
> 
> HTH
> Clemens
> 

-- 
http://mffm.ee.unsw.edu.au

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
