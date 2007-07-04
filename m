From: "Brian Hinz" <bphinz@hotmail.com>
Subject: Re: stac9200 speaker/hp not detected
Date: Wed, 04 Jul 2007 15:08:15 -0400
Message-ID: <BAY105-F309EE6462F1B1F083AC6D1C8030@phx.gbl>
References: <s5hved08qn7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc1-s40.bay0.hotmail.com (bay0-omc1-s40.bay0.hotmail.com
	[65.54.246.112])
	by alsa0.perex.cz (Postfix) with ESMTP id DB85D1038B6
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jul 2007 21:08:19 +0200 (CEST)
In-Reply-To: <s5hved08qn7.wl%tiwai@suse.de>
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

I found the stac9200 datasheet and went through it, comparing it to the 
windows ini file and I don't see any obvious issues - everything looks like 
it's muxed right, except for the fact that there is physically no spdif jack 
on this particular machine.  The GPIO stuff looks like maybe it's mic boost 
or something, but what are these init verbs?

<snip>
InitVerbs                    = hex: 0x03, 0xa0, 0x43, 0x01
<snip>

Here's the output from /proc/asound/card0/codec#0:

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
  Pin Default 0x400000fe: [N/A] Line Out at Ext N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Power: 0x0
Node 0x09 [Pin Complex] wcaps 0x400301: Stereo Digital
  Pincap 0x0810: OUT
  Pin Default 0x00451030: [Jack] SPDIF Out at Ext N/A
    Conn = Optical, Color = Black
  Pin-ctls: 0x40: OUT
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
  Pin Default 0x400100f0: [N/A] Line Out at Ext N/A
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x0b
Node 0x0e [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x083f: IN OUT HP Detect
  Pin Default 0x90110010: [Fixed] Speaker at Int N/A
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x0b
Node 0x0f [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x0837: IN OUT Detect
  Pin Default 0x400100f1: [N/A] Line Out at Ext N/A
    Conn = 1/8, Color = Unknown
  Pin-ctls: 0x20: IN
  Connection: 1
     0x0b
Node 0x10 [Pin Complex] wcaps 0x400181: Stereo
  Pincap 0x081737: IN OUT Detect
  Pin Default 0x02a1902e: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
  Pin-ctls: 0x24: IN
  Connection: 1
     0x0b
Node 0x11 [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals:  [0x00]
  Pincap 0x0810: OUT
  Pin Default 0x500000f2: [N/A] Line Out at Int N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x00:
  Connection: 1
     0x13
Node 0x12 [Pin Complex] wcaps 0x400001: Stereo
  Pincap 0x0820: IN
  Pin Default 0x500000f3: [N/A] Line Out at Int N/A
    Conn = Unknown, Color = Unknown
  Pin-ctls: 0x20: IN
Node 0x13 [Audio Mixer] wcaps 0x200100: Mono
  Connection: 1
     0x07
Node 0x14 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
  Amp-Out caps: ofs=0x03, nsteps=0x03, stepsize=0x17, mute=1
  Amp-Out vals:  [0x00]

dmesg:

[  493.668000] ALSA 
/home/bphinz/alsa/alsa-hg/alsa-driver/pci/hda/hda_codec.c:1810: hda_codec: 
model 'm4' is selected
[  493.668000] ALSA 
/home/bphinz/alsa/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2339: autoconfig: 
line_outs=1 (0xe/0x0/0x0/0x0/0x0)
[  493.668000] ALSA 
/home/bphinz/alsa/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2343:    
speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[  493.668000] ALSA 
/home/bphinz/alsa/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2347:    hp_outs=0 
(0x0/0x0/0x0/0x0/0x0)
[  493.668000] ALSA 
/home/bphinz/alsa/alsa-hg/alsa-driver/pci/hda/hda_codec.c:2355:    inputs: 
mic=0x0, fmic=0x10, line=0x0, fline=0x0, cd=0x0, aux=0x0
[  493.796000] ALSA 
/home/bphinz/alsa/alsa-hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:244: 
si3054: cannot initialize. EXT MID = 0000
[  493.796000] ALSA 
/home/bphinz/alsa/alsa-hg/alsa-driver/pci/hda/../../alsa-kernel/pci/hda/patch_si3054.c:256: 
Link Frame Detect(FDT) is not ready (line status: 0000)

Thanks,
-brian

>From: Takashi Iwai <tiwai@suse.de>
>To: "Brian Hinz" <bphinz@hotmail.com>
>CC: alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] stac9200 speaker/hp not detected
>Date: Wed, 04 Jul 2007 11:27:56 +0200
>
>At Wed, 04 Jul 2007 05:25:39 -0400,
>Brian Hinz wrote:
> >
> > Hi Takashi,
> >
> > Sorry, I recompiled the driver from the hg sources and hadn't re-run
> > alsamixer to unmute.  It still doesn't work though - any suggestions?
>
>Attach the latest information, then.
>
>
>Takashi
>
> >
> > Thanks,
> > -brian
> >
> >
> > >From: Takashi Iwai <tiwai@suse.de>
> > >To: "Brian Hinz" <bphinz@hotmail.com>
> > >CC: alsa-devel@alsa-project.org
> > >Subject: Re: [alsa-devel] stac9200 speaker/hp not detected
> > >Date: Wed, 04 Jul 2007 10:43:12 +0200
> > >
> > >At Tue, 03 Jul 2007 23:08:42 -0400,
> > >Brian Hinz wrote:
> > > >
> > > > This laptop has only an internal speaker, a headphone out, and a mic 
>in
> > > > (unless there are other outs enabled when the dock is connected).  
>The
> > > > windows INI seems to be setting some gpio bits but I don't 
>understand
> > >how to
> > > > map the ini syntax into the alsa driver (or if it needs to be...)
> > >
> > >Might be needed, but...
> > >
> > > > Node 0x0b [Audio Selector] wcaps 0x300105: Stereo Amp-Out
> > > >   Amp-Out caps: N/A
> > > >   Amp-Out vals:  [0x80 0x80]
> > > >   Connection: 1
> > > >      0x07
> > >
> > >You didn't unmute "Master" mixer switch?
> > >
> > >
> > >Takashi
> >
> >
