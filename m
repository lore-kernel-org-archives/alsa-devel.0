From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Intel HDA / ALC662 analog surround problem
Date: Sat, 28 Feb 2015 10:31:56 +0800
Message-ID: <CAN8cciaUw6RWgE859mNvvoDmeZ-ovPnu-21L6=YXJu+kxExeTg@mail.gmail.com>
References: <CAN8cciZ4=UXVLFgykv2V67e9+K5OwnYo3tq-cDUDJd2xgqszBw@mail.gmail.com>
 <54f0bf96.460db348.bm000@wupperonline.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com
 [209.85.214.182])
 by alsa0.perex.cz (Postfix) with ESMTP id 952B12651A3
 for <alsa-devel@alsa-project.org>; Sat, 28 Feb 2015 03:31:57 +0100 (CET)
Received: by mail-ob0-f182.google.com with SMTP id nt9so21806258obb.13
 for <alsa-devel@alsa-project.org>; Fri, 27 Feb 2015 18:31:56 -0800 (PST)
In-Reply-To: <54f0bf96.460db348.bm000@wupperonline.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?UTF-8?B?SW5nbyBCcsO8Y2ts?= <ib@wupperonline.de>
Cc: tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

>
> >> > [    0.655493] sound hdaudioC1D0: autoconfig: line_outs=1
(0x14/0x0/0x0/0x0/0x0) type:line
> >> > [    0.655494] sound hdaudioC1D0:    speaker_outs=1
(0x15/0x0/0x0/0x0/0x0)
> >> > [    0.655495] sound hdaudioC1D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
> >> > [    0.655496] sound hdaudioC1D0:    mono: mono_out=0x0
> >> > [    0.655496] sound hdaudioC1D0:    dig-out=0x1e/0x0
> >> > [    0.655497] sound hdaudioC1D0:    inputs:
> >> > [    0.655498] sound hdaudioC1D0:      Front Mic=0x19
> >> > [    0.655499] sound hdaudioC1D0:      Rear Mic=0x18
> >> > [    0.655499] sound hdaudioC1D0:      Line=0x1a
> >>
> >> > This is a known bug of hda_generic.c for those desktop with internal
> >> > speaker and three audio jacks at rear panel (e.g. those lenovo
> >> > thinkcenter with alc66x codec)
> >>
> >> > The driver prefer to assign volume control/dac to headphone, line
out and
> >> > internal speaker instead of line out and the other two multi io jacks
>
> Thanks to your kind help, I was able to try out several things.
>
> First I tried the multi_io hint
>
>   echo "multi_io = yes" > /sys/class/sound/hwC1D0/hints
>   echo 1 > /sys/class/sound/hwC1D0/reconfig
>
> without success.
>
> Then I tried init_verbs
>
>   echo "0x15 0x707 0" > /sys/class/sound/hwC1D0/init_verbs
>   echo 1 > /sys/class/sound/hwC1D0/reconfig
>
> again without success.

Dynamic reconfig work if you want to change unconnected pin complex to
connected pin complex, the driver seem did not disable unsolicited event
when user change connected jack to unconnected.

>
> I went without early patching.
>
> > or You need to increase BAD_MULTI_IO from 0x120 to 0x4120 since
> > BAD_NO_DAC 0x4000 for the driver to select config with mio=1
>
> This was successful! But, although I'm very happy with the result and
> although I don't mind adding this to my private kernel patches, I'm
wondering
> whether there isn't a better way, i.e. a way that could help others using
the
> same or a similar motherboard.

using hda-emu or debug version of alsa-driver

==> lo_type=0, wired=1, mio=1, badness=0x352
multi_outs = 14/0/0/0 : 2/0/0/0 (type LO)
  out path: depth=3 '02:0c:14'
hp_outs = 1b/0/0/0 : 2/0/0/0
  hp  path: depth=3 '02:0c:1b'
spk_outs = 15/0/0/0 : 3/0/0/0
  spk path: depth=3 '03:0d:15'
==> lo_type=0, wired=1, mio=0, badness=0x120
multi_outs = 14/0/0/0 : 2/0/0/0 (type LO)
  out path: depth=3 '02:0c:14'
hp_outs = 1b/0/0/0 : 4/0/0/0
  hp  path: depth=3 '04:0e:1b'
spk_outs = 15/0/0/0 : 3/0/0/0
  spk path: depth=3 '03:0d:15'
send: NID=0x18, VERB=0xf00(get_parameters), PARM=0x12(amp_out_cap)
receive: 0x80000000
==> lo_type=0, wired=0, mio=1, badness=0x4112
multi_outs = 14/0/0/0 : 2/3/4/0 (type LO)
  out path: depth=3 '02:0c:14'
multi_ios(2) = 1a/18 : 3/4
  mio path: depth=3 '03:0d:1a'
  mio path: depth=3 '04:0e:18'
hp_outs = 1b/0/0/0 : 2/0/0/0
  hp  path: depth=3 '02:0c:1b'
spk_outs = 15/0/0/0 : 0/0/0/0
==> lo_type=0, wired=0, mio=0, badness=0x4120
multi_outs = 14/0/0/0 : 2/0/0/0 (type LO)
  out path: depth=3 '02:0c:14'
hp_outs = 1b/0/0/0 : 3/0/0/0
  hp  path: depth=3 '03:0d:1b'
spk_outs = 15/0/0/0 : 0/0/0/0
==> restoring best_cfg
==> Best config: lo_type=0, wired=1, mio=0
multi_outs = 14/0/0/0 : 2/0/0/0 (type LO)
  out path: depth=3 '02:0c:14'
hp_outs = 1b/0/0/0 : 4/0/0/0
  hp  path: depth=3 '04:0e:1b'
spk_outs = 15/0/0/0 : 3/0/0/0
  spk path: depth=3 '03:0d:15'

The current driver select config with smallest badness but it does not
contain

multi_outs = 14/0/0/0 : 2/3/4/0 (type LO)
  out path: depth=3 '02:0c:14'
multi_ios(2) = 1a/18 : 3/4
  mio path: depth=3 '03:0d:1a'
  mio path: depth=3 '04:0e:18'


You need an ad hoc check of increasing the badness due to multi io cannot
be assigned  for those realtek alc66x codecs with 3stack and internal
speaker

>
> > The driver seem to avoid the playback volume control shared by internal
> > speaker, headphone and line out, this may mean that you need a suitable
> > name for this volume control
>
> I don't get the meaning of that. Will I miss a volume control or do I have
> one with an inappropriate name?
assign different DAC to headphone and line out allow the driver to support
independent headphone for those 2+2 and 7.1+2 channels HDA codecs

http://www.intel.com/support/motherboards/desktop/sb/CS-034206.htm


http://www.realtek.com.tw/products/productsView.aspx?Langid=1&PNid=14&PFid=24&Level=4&Conn=3
Seem only those four channel codecs support 2+2 and 10 channels codecs
7.1+2

* Independent HP
  When this enum control is enabled, the headphone output is routed
  from an individual stream (the third PCM such as hw:0,2) instead of
  the primary stream.



> >
https://git.kernel.org/cgit/linux/kernel/git/tiwai/sound.git/commit/sound/pci/hda/hda_generic.c?id=03ad6a8c93b6df2d65c305b5b5f9474068b45bfb
> >
> > This patch has side effect on your configuration with three DAC as it
> > create "Master playback volume" at node 0x02 and "Speaker+LO Playback
> > switch at node 0x14 line out jack
>
> This patch further improves things. I have now the following new controls:
>
>   Headphone    (isn't new, but now only a toggle control, no volume
control)

This is because HP, Line Out and internal speaker sharing the same DAC and
volume control since the other two DAC are used by retasked output jacks


Node 0x02 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Master Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Device: name="ALC662 rev3 Analog", type="Audio", device=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
Node 0x03 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Surround Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
Node 0x04 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Center Playback Volume", index=0, device=0
    ControlAmp: chs=1, dir=Out, idx=0, ofs=0
  Control: name="LFE Playback Volume", index=0, device=0
    ControlAmp: chs=2, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x57, nsteps=0x57, stepsize=0x02, mute=0
  Amp-Out vals:  [0x00 0x00]
  Converter: stream=0, channel=0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0

>   Speaker+LO   toogle control


Node 0x14 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Speaker+LO Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Line Out Jack", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x80 0x80]
  Pincap 0x0001003c: IN OUT HP EAPD Detect
  EAPD 0x2: EAPD
  Pin Default 0x01014010: [Jack] Line Out at Ext Rear
    Conn = 1/8, Color = Green
    DefAssociation = 0x1, Sequence = 0x0
  Pin-ctls: 0x40: OUT
  Unsolicited: tag=02, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x0c


>   Surround     volume control
>   Center       volume control
>   LFE          volume control
>   Channel Mode allowing 2ch, 4ch, 6ch
>

> >> > Do "pcm playback volume" affect the volume after you change channel
mode
> >> > from 2ch to 6 ch so that mic and line in jacks are retasked as
output ?
>
> The master volume control affects the line out volume (which is named PCM,
> btw), but no other output. Muting the master, however, affects all
outputs.
>
> After changing to 4ch or 6ch, the PCM (line out) volume control acts as a
> "master" for surround and center/lfe.
>

Seem "master playback volume" is not the correct name when using surround
5.1 and your config lost the virtual master playback volume
