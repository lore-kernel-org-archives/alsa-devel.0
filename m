From: "Ted T. Logan" <tedtheologian@gmail.com>
Subject: Re: Testers wanted: New SB X-Fi driver
Date: Wed, 15 Jul 2009 13:44:33 -0500
Message-ID: <1247683473.20986.0.camel@localhost.localdomain>
References: <4A5DB59B.2010407@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qw-out-1920.google.com (qw-out-1920.google.com [74.125.92.145])
	by alsa0.perex.cz (Postfix) with ESMTP id D53B124698
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jul 2009 20:42:50 +0200 (CEST)
Received: by qw-out-1920.google.com with SMTP id 5so1323401qwf.56
	for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2009 11:42:49 -0700 (PDT)
In-Reply-To: <4A5DB59B.2010407@freenet.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Frashman <frashman@freenet.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Is there a new driver that was supposed to be referenced in this or
something?

My sb0670 still has the clicks and is unusable with this driver.

Thanks!

On Wed, 2009-07-15 at 12:55 +0200, Frashman wrote:

> Hi Takashi,
> 
> first of all, thank you for developing this driver.
> I tested it today. It works, so far.
> 
> But two annoying things. As you mentioned, I got problems, if the 
> onboard sound modules are loaded. Then i get no sound out auf my xfi.
> If I disable the loading of snd-hda-intel modules while booting, then it 
> works.
> 
> The second problem is, that SIDE and SURROUND connectors are 
> interchanged. I'm absolutly sure, it works fine under windows and the 
> connector colors are also correct.
> 
> If I run speaker-test -c8 the SIDE Speakers sounds come out of my REAR 
> (SURROUND) Speakers, while nothing is coming out of my rear speakers, if 
> i'm using speaker-test -c6
> 
> 
> Here lspci:
> 
> $ lspci
> 00:00.0 Host bridge: ATI Technologies Inc RD780 Northbridge only dual 
> slot PCI-e_GFX and HT1 K8 part
> 00:02.0 PCI bridge: ATI Technologies Inc RD790 PCI to PCI bridge 
> (external gfx0 port A)
> 00:04.0 PCI bridge: ATI Technologies Inc RD790 PCI to PCI bridge (PCI 
> express gpp port A)
> 00:0a.0 PCI bridge: ATI Technologies Inc RD790 PCI to PCI bridge (PCI 
> express gpp port F)
> 00:12.0 SATA controller: ATI Technologies Inc SB600 Non-Raid-5 SATA
> 00:13.0 USB Controller: ATI Technologies Inc SB600 USB (OHCI0)
> 00:13.1 USB Controller: ATI Technologies Inc SB600 USB (OHCI1)
> 00:13.2 USB Controller: ATI Technologies Inc SB600 USB (OHCI2)
> 00:13.3 USB Controller: ATI Technologies Inc SB600 USB (OHCI3)
> 00:13.4 USB Controller: ATI Technologies Inc SB600 USB (OHCI4)
> 00:13.5 USB Controller: ATI Technologies Inc SB600 USB Controller (EHCI)
> 00:14.0 SMBus: ATI Technologies Inc SBx00 SMBus Controller (rev 14)
> 00:14.1 IDE interface: ATI Technologies Inc SB600 IDE
> 00:14.2 Audio device: ATI Technologies Inc SBx00 Azalia (Intel HDA)
> 00:14.3 ISA bridge: ATI Technologies Inc SB600 PCI to LPC Bridge
> 00:14.4 PCI bridge: ATI Technologies Inc SBx00 PCI to PCI Bridge
> 00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
> HyperTransport Technology Configuration
> 00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
> Address Map
> 00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
> DRAM Controller
> 00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 [Athlon64/Opteron] 
> Miscellaneous Control
> 01:00.0 VGA compatible controller: ATI Technologies Inc RV770 [Radeon HD 
> 4850]
> 01:00.1 Audio device: ATI Technologies Inc HD48x0 audio
> 02:00.0 Audio device: Creative Labs X-Fi Titanium series [EMU20k2] (rev 03)
> 03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. 
> RTL8111/8168B PCI Express Gigabit Ethernet controller (rev 01)
> 04:06.0 Multimedia video controller: Brooktree Corporation Bt878 Video 
> Capture (rev 11)
> 04:06.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture 
> (rev 11)
> 04:0e.0 FireWire (IEEE 1394): Texas Instruments TSB43AB23 
> IEEE-1394a-2000 Controller (PHY/Link)
> 
> 
> 
> Thank you so far,
> Frashman
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
