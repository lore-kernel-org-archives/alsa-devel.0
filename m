From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: HD-audio regression after commit
	34588709af61be1550b4e2bcee5c85d0ac4f34d4
Date: Wed, 16 Jan 2013 20:37:16 +0800
Message-ID: <CAN8ccibSJWt_4w=gwKpwWjFaEKCrFyF8EyvQuv3m7zQXat5bCQ@mail.gmail.com>
References: <CA+S_cwraM+wofw5Nz_d0ctOget5dY-0nr5pRHCzOJtLX+JM2TA@mail.gmail.com>
 <CAN8ccia1N-eseNR2dET=ghXuyK0E0gXaakehW3VAN8u1UxUQ8Q@mail.gmail.com>
 <20130114133122.52cadb99@gmail.com> <s5h7gngc4lt.wl%tiwai@suse.de>
 <20130114135947.1f0bbbf4@gmail.com> <s5h1udndihf.wl%tiwai@suse.de>
 <20130114172354.1f47f49b@gmail.com>
 <CAN8cciaoAt75sRUtLM6Ov4VGBQ1pFgPwO-EZT88q6d1gm-JggQ@mail.gmail.com>
 <20130115095325.7aa2dfdd@gmail.com>
 <CAN8cciYrMSBhpp-9QjHdE8aVMHh_JwHswwfPfjtGY6OB_E4NcQ@mail.gmail.com>
 <20130116094941.0e1170b2@gmail.com> <s5hwqvd33va.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f174.google.com (mail-ie0-f174.google.com
 [209.85.223.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 16FB9262625
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 13:37:19 +0100 (CET)
Received: by mail-ie0-f174.google.com with SMTP id c11so2298006ieb.5
 for <alsa-devel@alsa-project.org>; Wed, 16 Jan 2013 04:37:18 -0800 (PST)
In-Reply-To: <s5hwqvd33va.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: basinilya@gmail.com, =?UTF-8?B?TWFub2xvIETDrWF6?= <diaz.manolo@gmail.com>, alsa-devel@alsa-project.org, Miro Hodak <mhodak127@gmail.com>
List-Id: alsa-devel@alsa-project.org

> > >
> > >Seen many ad1988 controls are missing ?
> > >
> > >1) rear Mic, line , front Mic  playback volume and switch
> > >2) CD playback switch
> > >3) input mix in input source
> > >4) analog loopback mix volume and mute switch
> >
> > I can confirm both: no sound after resume and missing controls.
> > Attached are captures from the mixer control list using linux stable
> > and sound unstable, both with BIOS autoprobe.
>
> Give alsa-info.sh outputs before and after suspend, instead.
>

Is there any special reason to use alt_capture_device since the input
sources of three ADC of ad1988/1989 are same ?

Ones of ADC of some realtek codec has more input source than the other ADCs

**** List of CAPTURE Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: AD1989B Analog [AD1989B Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 2: AD1989B Analog [AD1989B Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1


Node 0x21 [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Analog Mix Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Analog Mix Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Amp-Out caps: ofs=0x1f, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-Out vals:  [0x1f 0x1f]
  Connection: 1
     0x20

The input source "mix" from node 0x20 audio mixer

Simple mixer control 'Input Source',0
  Capabilities: cenum
  Items: 'Front Mic' 'Rear Mic' 'Line' 'CD' 'Mix'
  Item0: 'Front Mic'

Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name="Capture Volume", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Capture Switch", index=0, device=0
    ControlAmp: chs=3, dir=Out, idx=0, ofs=0
  Control: name="Input Source", index=0, device=0
  Amp-Out caps: ofs=0x27, nsteps=0x36, stepsize=0x05, mute=1
  Amp-Out vals:  [0x2f 0x2f]
  Connection: 11
     0x38 0x39* 0x3a 0x3b 0x3c 0x18 0x24 0x25 0x3d 0x20 0x1f

Node 0x20 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
  Control: name="Front Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Front Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=0, ofs=0
  Control: name="Rear Mic Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=4, ofs=0
  Control: name="Rear Mic Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=4, ofs=0
  Control: name="Line Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="Line Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=1, ofs=0
  Control: name="CD Playback Volume", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=6, ofs=0
  Control: name="CD Playback Switch", index=0, device=0
    ControlAmp: chs=3, dir=In, idx=6, ofs=0
  Amp-In caps: ofs=0x17, nsteps=0x1f, stepsize=0x05, mute=1
  Amp-In vals:  [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
[0x80 0x80] [0x80 0x80] [0x80 0x80]
  Connection: 8
     0x39 0x33 0x38 0x3d 0x34 0x3b 0x18 0x1a
