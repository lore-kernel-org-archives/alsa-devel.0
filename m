From: Alnie <alnieb@yahoo.com>
Subject: Re: Issues w/ Creative Labs [SB X-Fi Xtreme
	Audio]	CA0110-IBG
Date: Tue, 24 Feb 2015 18:14:44 +0000 (UTC)
Message-ID: <459561633.5298823.1424801684998.JavaMail.yahoo@mail.yahoo.com>
References: <s5hzj83coc1.wl-tiwai@suse.de>
Reply-To: Alnie <alnieb@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm11-vm5.bullet.mail.ne1.yahoo.com
 (nm11-vm5.bullet.mail.ne1.yahoo.com [98.138.91.233])
 by alsa0.perex.cz (Postfix) with ESMTP id CCE1A260464
 for <alsa-devel@alsa-project.org>; Tue, 24 Feb 2015 19:14:56 +0100 (CET)
In-Reply-To: <s5hzj83coc1.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org



I've included the following to alsa-base.conf

options snd-hda-intel single_cmd=1
options snd-hda-intel enable_msi=0

rebooted and get the following messages back...

[    4.015887] hda-intel 0000:06:00.0: Using LPIB position fix
[    4.022650] hda-intel 0000:06:00.0: get_response timeout: IRS=0x0
[    4.022655] hda-intel 0000:06:00.0: Codec #1 probe error; disabling it...
[    4.029465] hda-intel 0000:06:00.0: get_response timeout: IRS=0x0
[    4.029649] hda-intel 0000:06:00.0: get_response timeout: IRS=0x0
[    4.029829] hda-intel 0000:06:00.0: get_response timeout: IRS=0x0
[    4.030009] hda-intel 0000:06:00.0: get_response timeout: IRS=0x0
[    4.030188] hda-intel 0000:06:00.0: get_response timeout: IRS=0x0
[    4.030192] hda-intel 0000:06:00.0: no codecs initialized


-Alnie

________________________________
From: Takashi Iwai <tiwai@suse.de>
To: Alnie <alnieb@yahoo.com> 
Cc: alsa-devel@alsa-project.org 
Sent: Tuesday, February 24, 2015 7:37 AM
Subject: Re: [alsa-devel] Issues w/ Creative Labs [SB X-Fi Xtreme Audio]    CA0110-IBG


At Sun, 22 Feb 2015 20:55:55 +0000 (UTC),
Alnie wrote:
> 
> Forgot to mention I also tried 3.12, 3.10, 3.4 and 3.0 but card was non-functional and not associated with any driver.

If you get the very same error (codec probe error), try single_cmd=1
module option.  And/or enable_msi=0.


Takashi

>       From: Alnie <alnieb@yahoo.com>
>  To: Takashi Iwai <tiwai@suse.de> 
> Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org> 
>  Sent: Sunday, February 22, 2015 12:47 PM
>  Subject: Re: [alsa-devel] Issues w/ Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
>    
> I can't seem to find a kernel that works with this card. Maybe the reports of this particular card working were misinterpretations on my part. Today I compiled kernel 3.13.11 and 3.14.1 (w/ no DKMS installed). With 3.13.11 the card is not associated with any driver. In 3.14.1 it is associated with a driver but I get the following...
> [    4.641296] hda-intel 0000:06:00.0: Using LPIB position fix[    5.656133] hda-intel 0000:06:00.0: Codec #1 probe error; disabling it...
> [   10.680052] hda-intel 0000:06:00.0: no codecs initialized
> Any advice? Thank you.
> -Alnie
> 
> 
> 
>  
> 
>      From: Takashi Iwai <tiwai@suse.de>
>  To: Alnie <alnieb@yahoo.com> 
> Cc: alsa-devel@alsa-project.org 
>  Sent: Monday, February 16, 2015 11:52 AM
>  Subject: Re: [alsa-devel] Issues w/ Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
>    
> At Mon, 16 Feb 2015 11:03:50 -0800,
> Alnie wrote:
> > 
> > By default the version of Mint I'm using has 3.13.0-37 loaded. I just 
> > tried some previous versions of the kernel (3.13.0-27, 3.13.0-32 & 
> > 3.13.0-36) and the same issues came up, although with -36, there was no 
> > output in dmesg in regards to probing DKMS, and no driver was 
> > associated. I also tried each kernel with the daily drivers removed as 
> > well, and the card was recognized but non functional (no driver 
> > associated). Also, in case hardware malfunction is considered, this card 
> > seems to work fine in windows for me. Thank you.
> 
> Then try the older kernels.  At best, build the kernel by yourself and
> avoid DKMS.  When you find any working version, you'll be asked for
> git bisection or a test patch, so the manual kernel build would be
> required in anyway.
> 
> 
> Takashi
> 
> > 
> > On 02/16/2015 08:05 AM, Takashi Iwai wrote:
> > > At Sun, 15 Feb 2015 13:33:55 -0800,
> > > Alnie wrote:
> > >> I am having a problem getting this card working in Mint 17.1 (64bit). I
> > >> have found reports from others around the net claiming to have this card
> > >> working (around 2010/2011 mostly). I also tried xubuntu with the same
> > >> results. On a fresh distro when I install the card, it is recognized but
> > >> isn't associated with any driver, if I install the 3.16 kernel or the
> > >> alsa-daily repo it becomes associated with a driver but I get the
> > >> following errors from dmesg...
> > >>
> > >> [    3.713183] snd_hda_intel 0000:06:00.0: Probing card using HDA DKMS, version 0.201502151246~ubuntu14.04.1
> > >> [    3.720010] snd_hda_intel 0000:06:00.0: CORB reset timeout#1, CORBRP = 0
> > >> [    4.744035] snd_hda_intel 0000:06:00.0: Codec #1 probe error; disabling it...
> > >> [    4.748009] snd_hda_intel 0000:06:00.0: CORB reset timeout#1, CORBRP = 0
> > >> [    9.772075] snd_hda_intel 0000:06:00.0: no AFG or MFG node found
> > >> [    9.772100] snd_hda_intel 0000:06:00.0: no codecs initialized
> > >>
> > >> and here is my lspci output...
> > >>
> > >> 05:00.0 PCI bridge: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG PCI to PCIe Bridge (prog-if 00 [Normal decode])
> > >>      Physical Slot: 3
> > >>      Flags: bus master, fast devsel, latency 0
> > >>      Bus: primary=05, secondary=06, subordinate=0c, sec-latency=36
> > >>      Memory behind bridge: f4300000-f43fffff
> > >>      Capabilities: [50] Power Management version 3
> > >>      Capabilities: [60] MSI: Enable- Count=1/16 Maskable- 64bit+
> > >>      Capabilities: [80] Subsystem: Creative Labs Device 0040
> > >>      Capabilities: [90] Express PCI-Express to PCI/PCI-X Bridge, MSI 00
> > >>      Capabilities: [100] Advanced Error Reporting
> > >>
> > >> 06:00.0 Audio device: Creative Labs [SB X-Fi Xtreme Audio] CA0110-IBG
> > >>      Subsystem: Creative Labs SB1040
> > >>      Flags: bus master, fast Back2Back, medium devsel, latency 32, IRQ 19
> > >>      Memory at f4300000 (32-bit, non-prefetchable) [size=16K]
> > >>      Capabilities: [dc] Power Management version 3
> > >>      Kernel driver in use: snd_hda_intel
> > >>
> > >> thank you for any advice & feedback on this.
> > > Could you try 3.13 kernel or older once?  I have also another bug
> > > report indicating a similar problem (no codec found, but with a
> > > totally different system), and the reporter mentioned that the
> > > regression happened between 3.13 and 3.14.
> > >
> > >
> > > Takashi
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
> > 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
>    
> 
> [2  <text/html; UTF-8 (quoted-printable)>]
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
