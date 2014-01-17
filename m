From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [pulseaudio-discuss] Need help with audio gain on
 an Intel HDA equipt ASUS M2N-SLI Deluxe
Date: Fri, 17 Jan 2014 17:17:21 +0800
Message-ID: <CAN8cciapM0GAY4vCq1jb6Yi33oXQouf1AC9qZ7gapxN7x6Ramg@mail.gmail.com>
References: <201401150017.59498.gheskett@wdtv.com>
 <2406669.07WltcfjcV@t520.axxite.internal>
 <CAN8cciZLRy6DE_K9v2eVGxpdF_=aL+d+dXRRpbXEgXdgxB=seQ@mail.gmail.com>
 <4778001.iHKCPN2j5A@t520.axxite.internal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com
 [209.85.213.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D2FF26507F
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 10:17:22 +0100 (CET)
Received: by mail-ig0-f182.google.com with SMTP id uy17so1065606igb.3
 for <alsa-devel@alsa-project.org>; Fri, 17 Jan 2014 01:17:21 -0800 (PST)
In-Reply-To: <4778001.iHKCPN2j5A@t520.axxite.internal>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: axel.braun@gmx.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

2014/1/16 Axel Braun <axel.braun@gmx.de>

> Am Donnerstag, 16. Januar 2014, 16:23:19 schrieb Raymond Yau:
> > Any hint you could give me?
> >
> > post the output of alsa-info.sh , there is a bug in alsa-driver which
> treat
> > dock headphone and headphone to support surround 4.0
>
> /sys/class/sound/hwC0D0/init_pin_configs:
0x19 0x04211040
0x1a 0x61a19050
0x1b 0x04a11060
0x1c 0x6121401f
0x1d 0x40f001f0
0x1e 0x40f001f0
0x1f 0x90170110
0x20 0x40f001f0
0x22 0x40f001f0
0x23 0x90a60170

/sys/class/sound/hwC0D0/driver_pin_configs:
0x19 0x042110ff
0x1a 0x21a190f0
0x1c 0x212140ff

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_conexant.c?id=ca201c096269ee2d40037fea96a59fd0695888c4

it was using auto but now the driver modify the dock headphone , dock mic
and headphone pin default.
there are also changes in the thinkpad_acpi module too.

https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/patch_conexant.c?id=2fd3f170e5ba04acc60ee94b2c76ee166727c734


do this thinkpad support headset or headphone ?

it is strange that speaker volume is at max but amp out  vals at node 0x11
is 0x3d instead of 0x4a (0dB)

Simple mixer control 'Master',0
  Capabilities: pvolume pvolume-joined pswitch pswitch-joined
  Playback channels: Mono
  Limits: Playback 0 - 74
  Mono: Playback 61 [82%] [-13.00dB] [on]
Simple mixer control 'Headphone',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 74
  Mono:
  Front Left: Playback 0 [0%] [-74.00dB] [off]
  Front Right: Playback 0 [0%] [-74.00dB] [off]
Simple mixer control 'Speaker',0
  Capabilities: pvolume pswitch
  Playback channels: Front Left - Front Right
  Limits: Playback 0 - 74
  Mono:
  Front Left: Playback 74 [100%] [0.00dB] [on]
  Front Right: Playback 74 [100%] [0.00dB] [on]


Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
  Control: name="Speaker Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Speaker Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="CX20590 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
  Amp-Out vals:  [0x3d 0x3d]
  Converter: stream=8, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=D0, actual=D0
Node 0x11 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x4a, nsteps=0x4a, stepsize=0x03, mute=1
  Amp-Out vals:  [0x80 0x80]
  Converter: stream=8, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 D3cold EPSS
  Power: setting=D0, actual=D0
