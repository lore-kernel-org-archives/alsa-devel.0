From: John Stile <john@stilen.com>
Subject: Re: snd-hda-intel support for SPDIF-in wiht
	vt1708	card?
Date: Tue, 18 Dec 2007 08:28:06 -0800
Message-ID: <1197995286.9405.23.camel@genx.localdomain>
References: <1197916048.14752.132.camel@genx.localdomain>
	<s5hir2wxig4.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mother.stilen.com (dsl027-182-089.sfo1.dsl.speakeasy.net
	[216.27.182.89]) by alsa0.perex.cz (Postfix) with ESMTP id E7184244EB
	for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2007 17:28:30 +0100 (CET)
In-Reply-To: <s5hir2wxig4.wl%tiwai@suse.de>
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

On Tue, 2007-12-18 at 14:04 +0100, Takashi Iwai wrote:
> At Mon, 17 Dec 2007 10:27:27 -0800,
> John Stile wrote:
> > 
> > I am trying to use a Via VT1708 audio card ( uses the snd-hda-intel.ko
> > driver) to record from SPDIF-in.
> > 
> > An off-list reply to my posting to alsa-users list suggested that
> > snd-hda-intel.ko might not support SPDIF-in with the VT1708 card, which
> > brought me here.
> > 
> > Can someone who works on the Intel HDA driver tell me if it supports
> > SPDIF-in on the VT1708 audio card?
> 
> It should be, but not tested well, I guess.
> 
> The driver enables the SPDIF-in capability when BIOS sets the pin
> information properly.  Check /proc/asound/card0/codec#* file whether
> you have any (activated) input pin node that supports SPDIF-in.
> 
> 
> Takashi
Thank you for your reply!
The output of your command is below.
  spdif-out=Node 0x25
  spdif-in=Node 0x26
Neither labeled inactive,
but spdif-in doesn't list a "Connection" line.
I have the latest bios: 1.03 (2007/08/23) (a beta bios is available).
Do I try the beta bios?

pico ~ # cat /proc/asound/card0/codec#0
Codec: VIA VIA VT1708
Address: 0
Vendor Id: 0x11061708
Subsystem Id: 0x11060300
Revision Id: 0x100700
No Modem Function Group found
Default PCM:
    rates [0x0]:
    bits [0x0]:
    formats [0x0]:
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
Node 0x10 [Audio Output] wcaps 0x411: Stereo
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power: 0x0
Node 0x11 [Audio Output] wcaps 0x411: Stereo
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power: 0x0
Node 0x12 [Audio Output] wcaps 0x411: Stereo
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power: 0x0
Node 0x13 [Audio Output] wcaps 0x411: Stereo
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power: 0x0
Node 0x14 [Audio Output] wcaps 0x211: Stereo Digital
  PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xa]: 16 24
    formats [0x5]: PCM AC3
Node 0x15 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x14, stepsize=0x06, mute=1
  Amp-In vals:  [0x14 0x14]
  PCM:
    rates [0x440]: 48000 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power: 0x0
  Connection: 1
     0x18
Node 0x16 [Audio Input] wcaps 0x100311: Stereo Digital
  PCM:
    rates [0x1f0]: 32000 44100 48000 88200 96000
    bits [0xa]: 16 24
    formats [0x5]: PCM AC3
  Connection: 1
     0x26
Node 0x17 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x06, mute=1
  Amp-In vals:  [0x1b 0x1b] [0x00 0x00] [0x04 0x04] [0x1b 0x1b] [0x00
0x00] [0x80 0x80]
  Connection: 6
     0x10 0x24 0x1d 0x1e 0x21 0x13
Node 0x18 [Audio Selector] wcaps 0x300101: Stereo
  Connection: 5
     0x17 0x24 0x1d* 0x1e 0x21
Node 0x19 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x11
Node 0x1a [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x12
Node 0x1b [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x00 0x00]
  Connection: 1
     0x13
Node 0x1c [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x081c: OUT HP Detect
  Pin Default 0x410110f2: [N/A] Line Out at Ext Rear
    Conn = 1/8, Color = Black
  Pin-ctls: 0x00:
  Connection: 1
     0x19
Node 0x1d [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x08334: IN OUT Detect
  Pin Default 0x01a19026: [Jack] Mic at Ext Rear
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x21: IN
  Connection: 1
     0x1a
Node 0x1e [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x08334: IN OUT Detect
  Pin Default 0x0181302e: [Jack] Line In at Ext Rear
    Conn = 1/8, Color = Blue
  Pin-ctls: 0x20: IN
  Connection: 1
     0x19
Node 0x1f [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x17 0x17]
  Pincap 0x081c: OUT HP Detect
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x17
Node 0x20 [Pin Complex] wcaps 0x40010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x1b, nsteps=0x1b, stepsize=0x06, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x081c: OUT HP Detect
  Pin Default 0x422140f0: [N/A] HP Out at Ext Front
    Conn = 1/8, Color = Green
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x17
Node 0x21 [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x08334: IN OUT Detect
  Pin Default 0x42a190f0: [N/A] Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x00:
  Connection: 1
     0x1b
Node 0x22 [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x0814: OUT Detect
  Pin Default 0x410160f1: [N/A] Line Out at Ext Rear
    Conn = 1/8, Color = Orange
  Pin-ctls: 0x00:
  Connection: 1
     0x1a
Node 0x23 [Pin Complex] wcaps 0x400101: Stereo
  Pincap 0x0814: OUT Detect
  Pin Default 0x410120f4: [N/A] Line Out at Ext Rear
    Conn = 1/8, Color = Grey
  Pin-ctls: 0x00:
  Connection: 1
     0x1b
Node 0x24 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x593301f7: [N/A] CD at Int ATAPI
    Conn = ATAPI, Color = Unknown
  Pin-ctls: 0x00:
Node 0x25 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x074411f0: [Jack] SPDIF Out at Ext Rear Panel
    Conn = RCA, Color = Black
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x14
Node 0x26 [Pin Complex] wcaps 0x400201: Stereo Digital
  Pincap 0x0810030: IN OUT EAPD
  Pin Default 0x07c421f0: [Jack] SPDIF In at Ext Rear Panel
    Conn = RCA, Color = Grey
  Pin-ctls: 0x00:
Node 0x27 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Amp-In caps: ofs=0x00, nsteps=0x14, stepsize=0x06, mute=1
  Amp-In vals:  [0x14 0x14]
  PCM:
    rates [0x440]: 48000 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power: 0x0
  Connection: 1
     0x21
