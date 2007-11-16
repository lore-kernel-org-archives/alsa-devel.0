From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: No sound on Intel DQ965GF motherboard
Date: Thu, 15 Nov 2007 22:39:07 -0800
Message-ID: <1195195147.6392.15.camel@razman.gruemaster.com>
References: <20071116061042.C5E9D830734@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 853432488C
	for <alsa-devel@alsa-project.org>; Fri, 16 Nov 2007 07:39:09 +0100 (CET)
In-Reply-To: <20071116061042.C5E9D830734@snark.thyrsus.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Interesting that you would post a link to one of my responses on
linuxquestions.org.

I still have my DP965LT, and I usually update my audio driver whenever
there is a significant change to the tip for my specific audio codec.
Couple of things to check.  First, is the audio disabled in bios?  Does
audio work if you use the latest daily snapshot of alsa-driver from
ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/ ?

If either of these fixes the issue, then it is definitely an Ubuntu
issue.  This doesn't surprise me, as they have pre-production patches in
their sound driver from Intel.  These patches may be contributing to the
issue (I haven't verified yet).

Also, if this doesn't fix the problem, can you send a link generated
from running http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh
It has a lot of detailed information about your audio configuration.

I looked at the driver code, and your specific system is listed (I
should know - I added it 8/2006).

Tobin

On Fri, 2007-11-16 at 01:10 -0500, Eric S. Raymond wrote:

> Thank you, alsa developers, for the prompt resolution of my previous
> sound issue with the Thinkpad X61.  Unfortunately, I've now turned up
> an apparently different problem on very similar hardware.
> 
> Sound doesn't work on my DQ965GF motherboard under Ubuntu 7.10.
> Here's what I've found out about it.  I'm writing in hope that someone
> on the ALSA devel list can suggest diagnostics to pin down the problem
> exactly.
> 
> The device has PCI ID [8086:284b] (rev 02).  It is an Intel 82801H.
> 
> This appears to be an Ubuntu-specific error.  At
> http://www.linuxquestions.org/questions/linux-hardware-18/intel-dq965gf-mobo-front-sound-jacks-not-working-510302/
> I found a post implying that at least the rear jacks on the mobo are
> active under Fedora Core 6.  I have therefore filed an Ubuntu bug at
> https://bugs.launchpad.net/ubuntu/+bug/162410 but seen no response.
> 
> This also appears to be a very hardware-configuration-specific error.
> I have an Intel HDA audio device on my X61 laptop with PCI ID
> [8086:284b] (rev 03), another 82801H, that works just fine under
> Ubuntu 7.10 (the alsa version is nominally 1.0.14 but some 1.10.15
> fixes, including the right one, were backported).  Note the 03 as
> opposed to 02 subrev.
> 
> aplay -l, which is supposed to list sound playback devices, returns no
> listing on the DQ965GF.  As a check, on the X61 where it works it
> returns this:
> 
>     card 0: Intel [HDA Intel], device 0: AD198x Analog [AD198x Analog]
>       Subdevices: 1/1
>       Subdevice #0: subdevice #0
> 
> lsmod also returns suggestively different results.  On the laptop, its
> output includes this line.
> 
>     snd_hda_intel         337192  1
> 
> On the DQ965GF, here are the sound device lines:
> 
>     snd_hda_intel         337192  0 
>     snd_usb_audio          96640  1 
>     snd_pcm_oss            50048  0 
>     snd_mixer_oss          20096  1 snd_pcm_oss
>     snd_pcm                94344  3 snd_hda_intel,snd_usb_audio,snd_pcm_oss
>     snd_usb_lib            20352  1 snd_usb_audio
>     snd_seq_dummy           5380  0 
>     snd_seq_oss            36864  0 
>     snd_seq_midi           11008  0 
>     snd_seq_midi_event      9984  2 snd_seq_oss,snd_seq_midi
>     snd_seq                62496  6 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq_midi_event
>     snd_timer              27272  2 snd_pcm,snd_seq
>     snd_rawmidi            29824  2 snd_usb_lib,snd_seq_midi
>     snd_seq_device         10260  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi,snd_seq,snd_rawmidi
>     snd_hwdep              12168  1 snd_usb_audio
>     snd                    69288  13 snd_hda_intel,snd_usb_audio,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_seq_oss,snd_seq,snd_timer,snd_rawmidi,snd_seq_device,snd_hwdep
>     soundcore              10272  1 snd
>     snd_page_alloc         12560  2 snd_hda_intel,snd_pcm
>     usbcore               161584  8 usbhid,snd_usb_audio,snd_usb_lib,xpad,gspca,ehci_hcd,uhci_hcd
> 
> Note that snd_hda_intel has no users and that snd_usb_audio has 1.
> 
> On the DQ965GF, the Sound Preferences tab on my Gnome toolbar thinks
> the sound device is "USB Device 0x46d:0x8ad (ALsa mixer)".  I don't
> know what tool GNOME is running to determine this.
> 
> This arch-linux thread gave me some insight:
> http://bugs.archlinux.org/task/6617
> 
> It appears the snd_usb_audio driver is a red herring, or at least a
> separate bug.  I checked, and my dmesg log does indeed say "hda-intel:
> no codecs found!" on boot, which suggests that snd_hda_intel is
> loading and then failing to initialize properly, accounting for the
> usage count of 0.
> 
> I tried reverting the kernel patch mentioned in the arch thread (e.g. 
> recompiling the snd_hda_intel driver with #define AZX_MAX_CODECS 4)
> but this did *not* solve the problem. 
> 
> Any suggestions would be appreciated.  I need my music back!

-- 
Tobin Davis  


I call them as I see them.  If I can't see them, I make them up.
		-- Biff Barf
