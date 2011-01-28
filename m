From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Problem with VIA VT1708S and git versions of
	alsa-driver.
Date: Fri, 28 Jan 2011 08:47:27 +0800
Message-ID: <AANLkTim95ynONz5N27J4EOBR93ROsoWdZajovDCaWX9f@mail.gmail.com>
References: <AANLkTikaYCybUxW7dE3tizYZztT8pVo6Jeg-mh=e0NqZ@mail.gmail.com>
	<AANLkTi=UTy8tdLqL-90UJOXtU=Ks1+ZZrGV2nCbw=xjD@mail.gmail.com>
	<AANLkTinYcRqMwH2FSUjXiOxZg4x09q673FL9m15YvXEa@mail.gmail.com>
	<AANLkTik8HayTEADWn74PJ0NgjGunamsSAZpy_GanuZo3@mail.gmail.com>
	<AANLkTimz3iiXPhEarEUY1Gw5GxrTuv+UXgKKZS3ObzuS@mail.gmail.com>
	<AANLkTi=S20cpKy-CObvKB-OLDKbQ7FBhFrbnd448B+sO@mail.gmail.com>
	<AANLkTikyjZvD+ptCcgBrN2av-jQmKWOekbzvfXYAdpOV@mail.gmail.com>
	<AANLkTim_A5m2MryxmkEHtcc3gNFWTaRW8J3=dZC6wd67@mail.gmail.com>
	<AANLkTinUWD9Oq2iAbn_nc5E+M=y4yXx4u0Eff9jYSGyk@mail.gmail.com>
	<AANLkTimcAUn=+1B3=LJbD7dBBZ3NvaeX_q+_sHP6QhB3@mail.gmail.com>
	<AANLkTimiwTcnCnGECN8jpzY2VaMTmpcHBx-qmFDmwxSY@mail.gmail.com>
	<AANLkTi=14Q53BtcafboP=qz2-9AEcnnE3UD+HTwoGtbe@mail.gmail.com>
	<AANLkTimQ+evOVnG78UWPhCORKo2VvXyzVO8BhTrzSnVG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id E55B11037FB
	for <alsa-devel@alsa-project.org>; Fri, 28 Jan 2011 01:47:32 +0100 (CET)
Received: by ewy19 with SMTP id 19so1242438ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 27 Jan 2011 16:47:29 -0800 (PST)
In-Reply-To: <AANLkTimQ+evOVnG78UWPhCORKo2VvXyzVO8BhTrzSnVG@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/1/27 Mark Goldstein <goldstein.mark@gmail.com>

> On Thu, Jan 27, 2011 at 11:09 AM, Raymond Yau
> <superquad.vortex2@gmail.com> wrote:
> > 2011/1/27 Mark Goldstein <goldstein.mark@gmail.com>
> >
> >> Hi,
> >>
> >> I've renewed my experiments after long break (sorry, had to do other
> >> stuff and since released version 1.0.23 worked for me, I reverted to
> >> that version).
> >>
> >> I still have not tried hda-emulator, but I made some progress.
> >>
> >> 1) I compiled the git version (snapshot from Jan 20) for OpenSUSE 11.1
> >> with test kernel 2.6.32.28.
> >> I saw the same behavior as before:
> >> - Line control does nothing;
> >> - Front Mic control actually changes volume of Line In;
> >> - Neither Front nor Rear Mic work at all; (Answering to Raymond's
> >> question regarding Mic Boost - I have "Rear Mic" control, but Mic
> >> Boost).
> >>
> >> 2) I decided to compare patch.via.c from version 1.0.23 that works for
> >> me and git version.
> >> It appears to me that the clue could be found in the function
> >> vt1708S_auto_create_analog_input_ctls. The one in 1.0.23 uses explicit
> >> control indexes, while the function from git version calls
> >> vt_auto_create_analog_input_ctls, passing it the array of indexes:
> >> static hda_nid_t pin_idxs[] = { 0x1f, 0x1a, 0x1b, 0x1e, 0, 0xff };
> >>
> >> Comparing the indexes used in  vt1708S_auto_create_analog_input_ctls
> >> with those used for other codec and with version from 1.0.23, I
> >> started suspecting that the order of indexes is wrong. I changed the
> >> array like this:
> >> static hda_nid_t pin_idxs[] = { 0, 0x1f, 0x1a, 0x1b, 0x1e, 0xff };
> >> After re-compiling the version I've got much better behavior:
> >> - Line control (index 1b) works correctly now;
> >> - Front Mic control (index 0x1e) actually controls Rear Mic and this
> >> Rear Mic works;
> >> - Front mic still does not work;
> >> - Rear Mic control (index 0x1a) seems not working and there is still
> >> Mic Boost, not Rear Mic Boost.
> >>
> >>
> > Do you mean that regiession is caused by this patch ?
> >
> >
> http://git.alsa-project.org/?p=alsa-kernel.git;a=commitdiff;h=f3268512c3a5dea587cfe875b8bca98d9e164cd9;hp=73413b120d5d6eb6c98451bbc19acf43e0e300ae
>
> Yes, looks very probable. Additional confirmation to this is that I
> noticed the problem at the beginning of September after installing git
> version; this patch is dated by Aug 30th.
>
> > it seem vt_auto_create_analog_input_ctls() try to assign stereo mixer as
> the
> > first item of the imux(s) node 0x17 and 0x1e
> >
> > assign those playback volume of those input pins in to stereo mixer for
> node
> > 0x16
> >
> > but it should assign auto_pin_cfg_labels[] according to the imux node
> 0x17
> > and 0x1e
>
> Is the order of controls in hda_nid_t_pin_idxs fixed, or depends on
> specific codec?
>
> In any case, I will probably try to temporary replace the
> vt1708S_auto_create_analog_input_ctls by the one from 1.0.23 and see
> if this will fix the issue.
>

Either [Audio Input] nodes connect directly to input pin [Pin complex]
or connected to [Audio Selector] which has a connection list

Node 0x13 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Device: name="VT1708S Analog", type="Audio", device=0
  Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x93 0x93]
  Converter: stream=1, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x17


ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: Intel [HDA Intel], device 0: VT1708S Analog [VT1708S Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1


dsnoop does work properlry when there is more than on subdevices since
dmix/dsnoop must use subdevice 0


This mean that the subdevice 1 is only connected to mic at front panel

Node 0x14 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name="Capture Volume", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Capture Switch", index=1, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Amp-In caps: ofs=0x0b, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80]
  Converter: stream=0, channel=0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 1
     0x1e

Node 0x1e [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name="Front Mic Boost Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Smart 5.1", index=0, device=0
  Amp-Out caps: ofs=0x00, nsteps=0x00, stepsize=0x00, mute=1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000233c: IN OUT HP Detect
    Vref caps: HIZ 50 100
  Pin Default 0x02a19038: [Jack] Mic at Ext Front
    Conn = 1/8, Color = Pink
    DefAssociation = 0x3, Sequence = 0x8
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=04, enabled=1
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 2
     0x16 0x25*

Auto parsing give you a list of input pins , mic, cd ,aux, ...

Just need the "stereo mixer" node 0x16 and the list of input pins to build
the enum item list of Input Source with the position of those input pin in
the connection list of [Audio selector] to change the amp in values

Node 0x17 [Audio Selector] wcaps 0x300501: Stereo
  Control: name="Input Source", index=0, device=0
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 6
     0x1f 0x1a* 0x1b 0x1e 0x1d 0x16


the list of input pins can also be used to create those "Playback Volume"
controls and "mute" switches with the position of those input in in the
connection list of the strereo mixer [Audio Mixer]


Node 0x16 [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Control: name="Master Front Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Master Front Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=2, ofs=0
  Control: name="Front Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=4, ofs=0
  Control: name="Front Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=4, ofs=0
  Control: name="Line Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=3, ofs=0
  Control: name="Line Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=3, ofs=0
  Control: name="CD Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="CD Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x0f 0x14] [0x17 0x17] [0x80 0x80] [0x1b 0x1b] [0x9b 0x9b]
[0x97 0x97] [0x97 0x97]
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
  Connection: 7
     0x10 0x1f 0x1a 0x1b 0x1e 0x1d 0x25




**** List of PLAYBACK Hardware Devices ****
card 0: Intel [HDA Intel], device 0: VT1708S Analog [VT1708S Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1

The independent headpone seem share with "side' channel since vt1708s only
has 8 channels

Node 0x25 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name="Side Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Headphone Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x2a, nsteps=0x2a, stepsize=0x05, mute=0
  Amp-Out vals:  [0x24 0x24]
  Converter: stream=0, channel=0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=D0, actual=D0
