From: "Matt Hirsch" <matthew.hirsch@gmail.com>
Subject: Re: snd-hda-intel auto detect incorrect
Date: Thu, 12 Jul 2007 17:12:41 -0400
Message-ID: <975d09800707121412n1d054f04mdce84d22e8ade28e@mail.gmail.com>
References: <975d09800707110901p42e133f7u3df3df985548d494@mail.gmail.com>
	<s5hejjdn3dw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by alsa0.perex.cz (Postfix) with ESMTP id 8C3F91037FB
	for <alsa-devel@alsa-project.org>;
	Thu, 12 Jul 2007 23:12:43 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so62360ana
	for <alsa-devel@alsa-project.org>; Thu, 12 Jul 2007 14:12:42 -0700 (PDT)
In-Reply-To: <s5hejjdn3dw.wl%tiwai@suse.de>
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

> At Wed, 11 Jul 2007 12:01:57 -0400,
> Matt Hirsch wrote:
> >
> > I have an hp pavilion tx 1000 laptop running fedora 7.  The auto
> > detect feature of the snd-hda-intel dirver doesn't work on my sound
> > card.  As requested in Documentation/sound/alsa/ALSA-Configuration.txt
> > I am forwarding the following to the developer mailing list:
> >
> > #uname -a
> > Linux laptop 2.6.21-1.3228.fc7 #1 SMP Tue Jun 12 14:56:37 EDT 2007
> > x86_64 x86_64 x86_64 GNU/Linux
> >
> > # lspci -s 00:10.1
> > 00:10.1 Audio device: nVidia Corporation MCP51 High Definition Audio (rev a2)
> >
> > # lspci -s 00:10.1 -nv
> > 00:10.1 0403: 10de:026c (rev a2)
> >        Subsystem: 103c:30bf
> >        Flags: bus master, 66MHz, fast devsel, latency 0, IRQ 17
> >        Memory at c0000000 (32-bit, non-prefetchable) [size=16K]
> >        Capabilities: [44] Power Management version 2
> >        Capabilities: [50] Message Signalled Interrupts: Mask+ 64bit+
> > Queue=0/0 Enable-
> >        Capabilities: [6c] HyperTransport: MSI Mapping
> >
> > # yum list alsa-\*
> > Installed Packages
> > alsa-lib.x86_64                          1.0.14-0.4.rc3.fc7     installed
> > alsa-lib.i386                            1.0.14-0.4.rc3.fc7     installed
> > alsa-utils.x86_64                        1.0.14-0.7.rc2.fc7     installed
> >
> > With no options I get the following log message and the audio doesn't work:
> >  kernel: hda_codec: Unknown model for ALC660VD/ALC861VD, trying
> > auto-probe from BIOS...
> >
> > When loading the module as follows, the audio works:
> > modprobe snd-hda-intel model=3stack
> >
> > I believe the card was detected as 3stack-dig, as the alsamixer
> > options match when either no option or model=3stack-dig are given.
> >
> > Hope this helped.
>
> Thanks for the information.
> To be sure, could you check the latest ALSA HG version (or daily
> snapshot, available at
>         ftp://ftp.suse.com/pub/projects/alsa/snapshot/driver/
> ) and other model options whether any of them matches better?

I built and installed alsa-driver-hg20070712.tar.bz2.  The new
options, as compared to my previous version are 3stack-660-digout,
lenovo, and dallas.  So with the new driver, the following produce
sound: 3stack, 3stack-660, 3stack-660-digout and lenovo.

One point I neglected to mention in my previous post (and this is
still true) - neither of the two headphone jacks on the front work
with any of these models, and the mute LED turns on when the module is
loaded (whether or not the card is actually muted).

> Now we have more model options for ALC861VD/660VD, as found in
> ALSA-Configuration.txt.  Also, please attach the contents of
> /proc/asound/card0/codec#* files.
>

Sure.  The second of these is a software modem, I believe.

codec#0:
Codec: Realtek ALC861-VD
Address: 0
Vendor Id: 0x10ec0862
Subsystem Id: 0x103c30bf
Revision Id: 0x100001
No Modem Function Group found
Default PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x02 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x40 0x40]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x03 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x00 0x00]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x04 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x00 0x00]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x05 [Audio Output] wcaps 0x1d: Stereo Amp-Out
  Amp-Out caps: ofs=0x40, nsteps=0x40, stepsize=0x03, mute=0
  Amp-Out vals:  [0x00 0x00]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Node 0x06 [Audio Output] wcaps 0x211: Stereo Digital
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x1e]: 16 20 24 32
    formats [0x1]: PCM
Node 0x07 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x08 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x09 [Audio Input] wcaps 0x10011b: Stereo Amp-In
  Amp-In caps: ofs=0x09, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x00 0x00]
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0x6]: 16 20
    formats [0x1]: PCM
  Connection: 1
     0x22
Node 0x0a [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x0b [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x0a 0x0a] [0x00 0x00] [0x00 0x00] [0x17
0x17] [0x80 0x80]
  Connection: 6
     0x18 0x19 0x1a 0x1b 0x1c 0x1d
Node 0x0c [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Connection: 2
     0x02 0x0b
Node 0x0d [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x03 0x0b
Node 0x0e [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x04 0x0b
Node 0x0f [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80]
  Connection: 2
     0x05 0x0b
Node 0x10 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x11 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x12 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x13 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x14 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081003c: IN OUT HP EAPD Detect
  Pin Default 0x99130110: [Fixed] Speaker at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0c
Node 0x15 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0810034: IN OUT EAPD Detect
  Pin Default 0x02014020: [Jack] Line Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0d
Node 0x16 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0834: IN OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0e
Node 0x17 [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0834: IN OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0f
Node 0x18 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x081734: IN OUT Detect
  Pin Default 0x02a19830: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 1
     0x0e
Node 0x19 [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x02 0x02] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x08173c: IN OUT HP Detect
  Pin Default 0x99a3013f: [Fixed] Mic at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x24: IN
  Connection: 2
     0x0c* 0x0f
Node 0x1a [Pin Complex] wcaps 0x40018d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0834: IN OUT Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0d
Node 0x1b [Pin Complex] wcaps 0x40018f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=0x00, nsteps=0x03, stepsize=0x27, mute=0
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x08173c: IN OUT HP Detect
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 2
     0x0c* 0x0f
Node 0x1c [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
Node 0x1d [Pin Complex] wcaps 0x400000: Mono
  Pincap 0x0820: IN
  Pin Default 0x411111f0: [N/A] Speaker at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x20: IN
Node 0x1e [Pin Complex] wcaps 0x400300: Mono Digital
  Pincap 0x0810: OUT
  Pin Default 0x99430140: [Fixed] SPDIF Out at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x06
Node 0x1f [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x20 [Vendor Defined Widget] wcaps 0xf00040: Mono
Node 0x21 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x22 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-In vals:  [0x00 0x00] [0x00 0x00] [0x00 0x00] [0x80 0x80] [0x00
0x00] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80]
  Connection: 11
     0x18 0x19 0x1a 0x1b 0x1c 0x1d 0x14 0x15 0x16 0x17 0x0b
Node 0x23 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x24 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x25 [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x26 [Vendor Defined Widget] wcaps 0xf00000: Mono

codec#1:
Codec: Motorola Si3054
Address: 1
Vendor Id: 0x10573055
Subsystem Id: 0x103c30bf
Revision Id: 0x100700
Modem Function Group: 0x1


>
> Takashi
>
