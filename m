From: Matt Flax <flatmax@ieee.org>
Subject: Re: SiS audio chip Re: usb Duo no device ? using
Date: Thu, 14 Aug 2003 02:02:51 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030813160251.GB10356@mffm.ee.unsw.edu.au>
References: <20030727124619.GA20798@mffm.ee.unsw.edu.au>
Reply-To: Matt Flax <flatmax@pgb.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from smtp3.unsw.edu.au (smtp3.unsw.EDU.AU [149.171.96.70])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA12580
	for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2003 16:57:02 +0200
Received: from smtp.unsw.edu.au (antivirus-01.services.comms.unsw.EDU.AU [149.171.193.80])
	by smtp3.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h7DEuvl22516
	for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2003 00:56:57 +1000 (EST)
Received: from maillationax ([149.171.36.140])
	by smtp.unsw.edu.au (8.11.2/8.11.2) with ESMTP id h7DEutF22485
	for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2003 00:56:57 +1000 (EST)
Received: from flatmax by maillationax with local (Exim 3.36 #1 (Debian))
	id 19my5L-0002jQ-00
	for <alsa-devel@alsa-project.org>; Thu, 14 Aug 2003 02:02:51 +1000
Content-Disposition: inline
In-Reply-To: <20030727124619.GA20798@mffm.ee.unsw.edu.au>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: core sound <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hello,

Just to let you all know that I tried the Debian testing (2) release of 
linux 2.6.0 and the intel8x0 driver now loads and lets me alter the 
mixer settings. This is using ALSA from the 2.6 kernel.
I can also use aplay to play, but for the moment there is no sound.
I will look into that further when the 2.6 comes out of testing.

It seems that it was the bios issue with the SiS chipset.

Matt

On Sun, Jul 27, 2003 at 10:46:19PM +1000, Matt Flax wrote:
> midisport-firmware
> Reply-To: Matt Flax <flatmax@pgb.unsw.edu.au>
> In-Reply-To: <s5hbrvjvuw7.wl@alsa2.suse.de>
> 
> Hi,
> 
> Well, lspci gives me the following info :
> 00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
> SiS7012 PCI Audio Accelerator (rev a0)
>         Subsystem: CLEVO/KAPOK Computer: Unknown device 0400
>         Flags: medium devsel, IRQ 255
>         I/O ports at 1c00 [disabled]
>         I/O ports at 1800 [disabled]
>         Capabilities: [48] Power Management version 2
> 
> Although the bios reports a SiS7018.
> 
> I gave up on getting this chip working till the new kernel 2.4.21 came 
> out, and it still doesn't work. It must have something to do will a 
> badly supported SiS chipset in the kernel.
> I am at a bit of a loss with this audio chip.... both trident and 
> intel8x0 drivers fail to operate the chip.
> 
> Matt
> 
> On Fri, Jul 25, 2003 at 11:05:28AM +0200, Takashi Iwai wrote:
> > At Fri, 25 Jul 2003 16:10:10 +1000,
> > Matt Flax wrote:
> > > 
> > > Hmmm,
> > > 
> > > Right you are. There is no midi !
> > > 
> > > I have to use the usb-ohci driver as I have a laptop with a SiS chipset.
> > > I can't use the onboard sound card 'cause the chipset is not supported 
> > > properly. Its a SiS 7018 audio chip onboard. 
> >  
> > SIS7018 is supported by snd-trident driver.
> > did you try that?
> > 
> > 
> > Takashi
> 
> -- 
> http://mffm.ee.unsw.edu.au
> 
> WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
> FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
> Vector Bass                : http://mffmvectorbass.sourceforge.net/
> Multimedia Time Code       : http://mffmtimecode.sourceforge.net/
> 
> 
> -------------------------------------------------------
> This SF.Net email sponsored by: Free pre-built ASP.NET sites including
> Data Reports, E-commerce, Portals, and Forums are available now.
> Download today and enter to win an XBOX or Visual Studio .NET.
> http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel

-- 
http://flatmax.org

WSOLA TimeScale Audio Mod  : http://mffmtimescale.sourceforge.net/
FFTw C++                   : http://mffmfftwrapper.sourceforge.net/
Vector Bass                : http://mffmvectorbass.sourceforge.net/
Multimedia Time Code       : http://mffmtimecode.sourceforge.net/


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
