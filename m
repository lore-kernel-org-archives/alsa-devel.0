From: Fredrik Smedberg <smedberg@swipnet.se>
Subject: Re: Problems with the intel8x0 driver
Date: Thu, 18 Mar 2004 22:03:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040318220330.571d7db2@localhost>
References: <20040318184100.5ddfd605@localhost>
	<s5hfzc6ca1p.wl@alsa2.suse.de>
	<20040318193915.04dfd410@localhost>
	<s5hekrqc6y7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hekrqc6y7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi!

Here is what happens if I try to start my computer with the 2.5.6-rc1 kernel + ALSA + intel8x0:
Stack:
00000042 c192e000 c192e000 c1be9400 c1be9437 c032071d 00000000 00000002
fffffffb c035ad73 c1be9000 00000001 c1be92f0 c1be9424 c1be9000 c1be9424
c1be9424 fffffffb c1be9437 c1be9400 c035b0e6 c1be9400 c19bf000 00000001

Call Trace:
[<c032071d>] snd_card_free+0x128/0x2da
[<c035ad73>] snd_intel8x0_create+0x398/0x542
[<c035b0e6>] snd_intel8x0_probe+0x1c8/0x278
[<c01738d5>] dput+0x22/0x25b
[<c0229536>] pci_device_probe_static+0x52/0x61
[<c0229580>] __pci_device_probe+0x3b/0x4e
[<c02295bf>] pci_device_probe+0x2c/0x4a
[<c02871de>] bus_match+0x3f/0x6a
[<c02872f0>] driver_attach+0x56/0x80
[<c02875cb>] bus_add_driver+0xa0/0xb3
[<c022978b>] pci_register_driver+0x6c/0x94
[<c05140c7>] alsa_card_intel8x0_init+0x15/0x43
[<c04fa8a3>] do_initcalls+0x27/0xb3
[<c0132b56>] init_workqueues+0xf/0x26
[<c01030f1>] init+0x59/0x158
[<c0103098>] init+0x0/0x158
[<c0105271>] kernel_thread_helper+0x5/0xb

Code: 8b 46 20 85 c0 74 63 8b 78 34 bb f0 7c 4a c0 c7 44 24 04 77
(0)Kernel panic: Attempted to kill init!

In other words a kernel panic...

Thanks,
Fredrik Smedberg


On Thu, 18 Mar 2004 20:04:48 +0100
Takashi Iwai <tiwai@suse.de> wrote:

> At Thu, 18 Mar 2004 19:39:15 +0100,
> Fredrik Smedberg wrote:
> > 
> > Hi!
> > 
> > The latest test I did with 2.6.5-rc1 I'm very sure I didn't compile
> > in anything in the kernel except things I needed + ALSA and I got a
> > kernel panic. No OSS included in the kernel or loaded by modules... 
> 
> could you get the kernel message with that status, if possible?
> 
> 
> Takashi
> 
> > 
> > Thanks,
> > Fredrik Smedberg
> > 
> > On Thu, 18 Mar 2004 18:57:54 +0100
> > Takashi Iwai <tiwai@suse.de> wrote:
> > 
> > > At Thu, 18 Mar 2004 18:41:00 +0100,
> > > Fredrik Smedberg wrote:
> > > > 
> > > > Hi!
> > > > 
> > > > i810: Intel ICH4 mmio at 0xfcd80400 and 0xfcd82600
> > > > i810_audio: Primary codec has ID 1
> > > > i810_audio: Audio Controller supports 6 channels.
> > > > i810_audio: Defaulting to base 2 channel mode.
> > > > i810_audio: Resetting connection 0
> > > > i810_audio: Connection 0 with codec id 1
> > >   ^^^^^^^^^^
> > > 
> > > you loaded both OSS and ALSA devices.
> > > there is a bug in OSS driver which doesn't check the return value of
> > > resource allocation.
> > > 
> > > 
> > > Takashi
> > 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
