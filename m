From: "Brian Hinz" <bphinz@hotmail.com>
Subject: Re: stac9200 speaker/hp not detected
Date: Sun, 08 Jul 2007 12:54:54 -0400
Message-ID: <BAY105-F2172380B630AD7CB2FFC6CC8070@phx.gbl>
References: <s5h4pkj6t5j.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc3-s38.bay0.hotmail.com (bay0-omc3-s38.bay0.hotmail.com
	[65.54.246.238])
	by alsa0.perex.cz (Postfix) with ESMTP id B0B63103823
	for <alsa-devel@alsa-project.org>;
	Sun,  8 Jul 2007 18:54:59 +0200 (CEST)
In-Reply-To: <s5h4pkj6t5j.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

OK, after a few days of familiarizing myself with the hda and stac9200 
specs, I think I see what's going on.  I tossed out the pin config settings 
from the windows driver and simply derived a set based on the stac9200 
datasheet and my best guesses as to how the hardware is actually configured. 
  At this point, dmesg shows:

line_outs=0 (0x0/0x0/0x0/0x0/0x0)
speaker_outs=1 (0xe/0x0/0x0/0x0/0x0)
hp_outs=1 (0xd/0x0/0x0/0x0/0x0)
inputs: mic=0x10, fmic=0x0, line=0x0, fline=0x0, cd=0x0, aux=0x0

which corresponds at least to the number of external ports. Still no sound, 
BUT, /proc/asound/card0/codec#0 shows something interesting (heh, actually 
it's shown it all along, ignorance is bliss I guess...):

...
Node 0x08 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN EAPD Detect
  Pin Default 0x40c001fd: [N/A] SPDIF In at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
...

the DigInPin is showing EAPD control.  I wasn't sure about the meaning of 
the "Power: 0x0" line in /proc/asound/card0/codec#0 so I put some debug 
statements into patch_sigmatel.c to dump the DigInPin power state and EAPD 
registers:

[ 5701.644000] hda_codec: DigInPin PwrState: 00000033
[ 5701.644000] hda_codec: EAPD Config: 00000000

According to the stac9200 datasheet, a PwrState of 0x3 means that the node 
is powered down.  A value of 0 on the EAPD pin means power down the external 
amp, and a 1 means power up the amp if PwrState is < 0x2. If PwrState >= 
0x2, Pin47 is tri-stated.  And Pin47 is ... GPIO3 (AKA: SPDIF_IN,  EAPD)!  
The stac9200 datasheet also states that "an external pull-down is required 
if EAPD must be low when Pin Widget is powered down."

So I assume that I need to reconfigure this pin to drive a 1 and power up 
the external amp, but what is the correct way to do this?  Does the pin 
config matter much, or do I just need to set the PwrState bits?  I see that 
in stac92xx_enable_eapd GPIO0 is configured as CMOS before it's enabled.  
Since GPIO3 is a digital I/O I obviously don't have to do that.  Any 
suggestions before I take the red pill?

Attached is my latest /proc/asound/card0/codec#0

Thanks,
-brian

Codec: SigmaTel STAC9200
Address: 0
Vendor Id: 0x83847690
Subsystem Id: 0x107b0205
Revision Id: 0x102201
No Modem Function Group found
Default PCM:
    rates [0x7e0]: 44100 48000 88200 96000 176400 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
Node 0x02 [Audio Output] wcaps 0xd0401: Stereo
  Power: 0x0
Node 0x03 [Audio Input] wcaps 0x1d0541: Stereo
  Power: 0x0
  Connection: 1
     0x0a
Node 0x04 [Audio Input] wcaps 0x140311: Stereo Digital
  PCM:
    rates [0x160]: 44100 48000 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
  Connection: 1
     0x08
Node 0x05 [Audio Output] wcaps 0x40211: Stereo Digital
  PCM:
    rates [0x1e0]: 44100 48000 88200 96000
    bits [0xe]: 16 20 24
    formats [0x5]: PCM AC3
Node 0x06 [Vendor Defined Widget] wcaps 0xf30201: Stereo Digital
Node 0x07 [Audio Selector] wcaps 0x300901: Stereo
  Connection: 3
     0x02* 0x08 0x0a
Node 0x08 [Pin Complex] wcaps 0x430681: Stereo Digital
  Pincap 0x0810024: IN EAPD Detect
  Pin Default 0x40c001fd: [N/A] SPDIF In at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x09 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x404001fe: [N/A] SPDIF Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 2
     0x05* 0x0a
Node 0x0a [Audio Selector] wcaps 0x30090d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x0f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x0d 0x0d]
  Connection: 1
     0x0c
Node 0x0b [Audio Selector] wcaps 0x300105: Stereo Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 1
     0x07
Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Amp-Out caps: ofs=0x00, nsteps=0x04, stepsize=0x27, mute=0
  Amp-Out vals:  [0x04 0x04]
  Connection: 5
     0x10* 0x0f 0x0e 0x0d 0x12
Node 0x0d [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x042110f1: [Jack] HP Out at Ext Right
    Conn = 1/8, Color = Black
  Pin-ctls: 0xc0: OUT HP
  Connection: 1
     0x0b
Node 0x0e [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x90100110: [Fixed] Speaker at Int N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x0b
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT Detect
  Pin Default 0x400101ff: [N/A] Line Out at Ext N/A
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0b
Node 0x10 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x04a110f2: [Jack] Mic at Ext Right
    Conn = 1/8, Color = Black
  Pin-ctls: 0x24: IN
  Connection: 1
     0x0b
Node 0x11 [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00]
  Pincap 0x0810: OUT
  Pin Default 0x401001f3: [N/A] Speaker at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x13
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x409001f4: [N/A] Aux at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x13 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x07
Node 0x14 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]




>From: Takashi Iwai <tiwai@suse.de>
>To: "Brian Hinz" <bphinz@hotmail.com>
>CC: alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] stac9200 speaker/hp not detected
>Date: Thu, 05 Jul 2007 12:28:56 +0200
>
>At Wed, 04 Jul 2007 15:08:15 -0400,
>Brian Hinz wrote:
> >
> > I found the stac9200 datasheet and went through it, comparing it to the
> > windows ini file and I don't see any obvious issues - everything looks 
>like
> > it's muxed right, except for the fact that there is physically no spdif 
>jack
> > on this particular machine.  The GPIO stuff looks like maybe it's mic 
>boost
> > or something, but what are these init verbs?
>
>GPIO can be used for different purposes depending on the
>implementation.  But, I'm not sure whether the missing GPIO setup is
>the culprit or not.  Anyway, you can set spec->gpio_mute in
>patch_9200().
>
>If it doesn't help, try to change the pin config.  You can ignore the
>first two pins for 0x08 and 0x09, which are for SPDIF I/O.  The rest
>are analog pins and can be configured flexibly.  The value 0x90110010
>corresponds to a built-in speaker, for example.
>
>
>Takashi
