From: Matt Flax <flatmax@ieee.org>
Subject: SiS audio chip Re: usb Duo no device ? using
Date: Sun, 27 Jul 2003 22:46:19 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030727124619.GA20798@mffm.ee.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Matt Flax <flatmax@pgb.unsw.edu.au>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

midisport-firmware
Reply-To: Matt Flax <flatmax@pgb.unsw.edu.au>
In-Reply-To: <s5hbrvjvuw7.wl@alsa2.suse.de>

Hi,

Well, lspci gives me the following info :
00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] 
SiS7012 PCI Audio Accelerator (rev a0)
        Subsystem: CLEVO/KAPOK Computer: Unknown device 0400
        Flags: medium devsel, IRQ 255
        I/O ports at 1c00 [disabled]
        I/O ports at 1800 [disabled]
        Capabilities: [48] Power Management version 2

Although the bios reports a SiS7018.

I gave up on getting this chip working till the new kernel 2.4.21 came 
out, and it still doesn't work. It must have something to do will a 
badly supported SiS chipset in the kernel.
I am at a bit of a loss with this audio chip.... both trident and 
intel8x0 drivers fail to operate the chip.

Matt

On Fri, Jul 25, 2003 at 11:05:28AM +0200, Takashi Iwai wrote:
> At Fri, 25 Jul 2003 16:10:10 +1000,
> Matt Flax wrote:
> > 
> > Hmmm,
> > 
> > Right you are. There is no midi !
> > 
> > I have to use the usb-ohci driver as I have a laptop with a SiS chipset.
> > I can't use the onboard sound card 'cause the chipset is not supported 
> > properly. Its a SiS 7018 audio chip onboard. 
>  
> SIS7018 is supported by snd-trident driver.
> did you try that?
> 
> 
> Takashi

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
