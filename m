From: "Andrew Paprocki" <andrew@ishiboo.com>
Subject: Re: Realtek ALC883 support on Albatron KI690-AM2
	motherboard
Date: Sat, 12 Jan 2008 23:51:23 -0500
Message-ID: <76366b180801122051r158d450brd674a01a27322b43@mail.gmail.com>
References: <76366b180712021308n4d5fd0fk5906c8928795b0c3@mail.gmail.com>
	<s5hr6i3dcch.wl%tiwai@suse.de>
	<76366b180712141432t516582bl5411dfc6dc2ab860@mail.gmail.com>
	<s5hodcoxkvu.wl%tiwai@suse.de> <s5hmys8xjtb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D79B248C9
	for <alsa-devel@alsa-project.org>; Sun, 13 Jan 2008 05:51:24 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so1173934rvb.32
	for <alsa-devel@alsa-project.org>; Sat, 12 Jan 2008 20:51:23 -0800 (PST)
In-Reply-To: <s5hmys8xjtb.wl%tiwai@suse.de>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

I finally got the hardware set up again to test the patch. I noticed
that it was already applied to hg, so I just used the latest hg code
to test. With the new code the 2nd device was always failing with an
-EBUSY error. I poked around adding some printk's and noticed that the
device count wasn't being incremented for subsequent cards. I fixed it
and submitted the patch. With that modification it appears to be
working now:

$ modprobe snd_hda_intel
ACPI: PCI Interrupt 0000:00:14.2[A] -> GSI 16 (level, low) -> IRQ 16
hda_codec: Unknown model for ALC883, trying auto-probe from BIOS...
ACPI: PCI Interrupt 0000:01:05.2[B] -> GSI 19 (level, low) -> IRQ 18

$ aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: ALC883 Analog [ALC883 Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 1: ALC883 Digital [ALC883 Digital]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 1: HDMI [HDA ATI HDMI], device 0: ATI HDMI [ATI HDMI]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

$ cat /proc/asound/card1/codec#0
Codec: Generic 1002 ATI RS690/780 HDMI
Address: 0
Vendor Id: 0x1002791a
Subsystem Id: 0x791a00
Revision Id: 0x100000
No Modem Function Group found
Default PCM:
    rates [0x70]: 32000 44100 48000
    bits [0x2]: 16
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x201: Stereo Digital
Node 0x03 [Pin Complex] wcaps 0x400381: Stereo Digital
  Pincap 0x0814: OUT Detect
  Pin Default 0x18560010: [Jack] Digital Out at Int HDMI
    Conn = Digital, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x02

Thanks,
-Andrew

On Dec 18, 2007 7:34 AM, Takashi Iwai <tiwai@suse.de> wrote:
> > Right now, snd-hda-intel driver is designed for a single device.
> > I wrote it so because I thought the device is only for on-board.
> > But now, ATI ships the graphic card with the extra sound
> > controller, and this conflicts.
> >
> > So, we need a major change in the driver code to allow multiple
> > devices.  OK, I'll hack it so that it can go to 2.6.25 kernel...
>
> The below is a quick hack to support multiple cards.
>
> Could you give it a try?
>
>
> Takashi
