From: Dirk Aust <dirk_aust@gmx.de>
Subject: Re: SiS audio chip Re: usb Duo no device ? using
Date: Sun, 27 Jul 2003 14:26:52 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200307271426.52291.dirk_aust@gmx.de>
References: <20030727124619.GA20798@mffm.ee.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030727124619.GA20798@mffm.ee.unsw.edu.au>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello all,
I have the same chip, but it mostly works with the intel8x0 driver and the 
lspci reports for 2.4.20 and 2.4.21:

00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS] SiS7012 
PCI Audio Accelerator (rev a0)

The controller ist part of an SIS655 chipset on a Gigabyte SQ800 board.

The only problem I have is that it seems not to cooperate fully with lavrec 
from the mjpegtools package, you can get it from: mjpegtools.sourceforge.net

recording sound works only if root uses the tools without mmap2. 

(no, it's no rights problem with the device files!!)

Am Sonntag, 27. Juli 2003 14:46 schrieb Matt Flax:
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
> >
> > Matt Flax wrote:
> > > Hmmm,
> > >
> > > Right you are. There is no midi !
> > >
> > > I have to use the usb-ohci driver as I have a laptop with a SiS
> > > chipset. I can't use the onboard sound card 'cause the chipset is not
> > > supported properly. Its a SiS 7018 audio chip onboard.
> >
> > SIS7018 is supported by snd-trident driver.
> > did you try that?
> >
> >
> > Takashi



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
