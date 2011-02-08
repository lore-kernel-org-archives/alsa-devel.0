From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: issue with AD1989A HDA codec and alsamixer
Date: Tue, 8 Feb 2011 17:18:09 +0800
Message-ID: <AANLkTi=MuthQ5p-rVsTU-PhN16n+ReRFm4qyuyHKBvBA@mail.gmail.com>
References: <AANLkTin8tsrNrcoYaPvQz0uO=OtD-tow1Ds0i8WTJyh7@mail.gmail.com>
	<AANLkTinec0di98dMdyNoANXBoLG_uRJ+NghEyboCuMUa@mail.gmail.com>
	<AANLkTim-Vq6bhd=nHOVkToMSuT9R1n3nnQi-J4bzZNc_@mail.gmail.com>
	<AANLkTikRJtbkSewNxEC_SqapNXQookdcHit4cDDix_s7@mail.gmail.com>
	<AANLkTinoF-RqGFo7w57E8C+L5=zKH_hQ+0G0defh0WX-@mail.gmail.com>
	<AANLkTikugTHmj5aKZqXSi3g50gkqLDXiWmTshBbd9TGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 567F9243F3
	for <alsa-devel@alsa-project.org>; Tue,  8 Feb 2011 10:18:10 +0100 (CET)
Received: by eyg24 with SMTP id 24so2606657eyg.38
	for <alsa-devel@alsa-project.org>; Tue, 08 Feb 2011 01:18:10 -0800 (PST)
In-Reply-To: <AANLkTikugTHmj5aKZqXSi3g50gkqLDXiWmTshBbd9TGQ@mail.gmail.com>
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

2011/2/7 Vincent Meserette <vmeserette@aldebaran-robotics.com>

>
> I found from where came my problem with the capture gains by adding some
> logs in the hda_codec.c file.
> When I set one of the capture gain, the put_vol_mute function well write =
in
> the AMP_GAIN_MUTE verb of the corresponding ADC selector (0x0c, 0x0d or 0=
x0e
> widget) but the mute bit is always set to 1.
> Indeed, the value associated to the AMP_GAIN_MUTE verb is formated as fol=
ow
> :
> bits  0 to 6 : gain
> bit 7 : mute
> bits 8 to 11 : index
> bit 12 : set right amp
> bit 13 : set left amp
> bit 14 : set input amp
> bit 15 : set output amp
>
> and alsa sets the value of this register from a080 / b080 to a0b6 / b0b6
> when i change the gain from -58.5 dB to 22.5dB
>
> Do you know how alsa and thus the alsamixer determine the minimum and
> maximum values for the capture gain, and how to say to alsa the the gain =
is
> only a 7bits step value ?
>

Take a look at HDA Specification 7.3.4.10 Amplifier Capabilities

StepSize (7 bits) indicates the size of each step in the gain range. Each
individual step may be 0-32 dB specified in 0.25-dB steps. A value of 0
indicates 0.25-dB steps, while a value of 127d indicates a 32-dB step.
NumSteps (7 bits) indicates the number of steps in the gain range. There may
be from 1 to 128 steps in the amplifier gain range. (0d means 1 step, 127d
means 128 steps). A value of 0 (1 step) means that the gain is fixed and may
not be changed.
Offset (7 bits) indicates which step is 0 dB. If there are two or more
steps, one of the step values must correspond to a value of 0 dB. The
=93Offset=94 value reflects the value which, if programmed in to the Amplif=
ier
Gain control, would result in a gain of 0 dB.
Mute Capable (1 bit) reports if the respective amplifier is capable of
muting. Muting implies a =96infinity gain (no sound passes), but the actual
performance is determined by the hardware.


Node 0x0c [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name=3D"Capture Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Capture Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Input Source", index=3D0, device=3D0
  Amp-Out caps: ofs=3D0x27, nsteps=3D0x36, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0x25 0x25]
  Connection: 10
     0x38 0x39* 0x3a 0x3b 0x3c 0x18 0x24 0x25 0x3d 0x20
Node 0x0d [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name=3D"Capture Volume", index=3D1, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Capture Switch", index=3D1, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Input Source", index=3D1, device=3D0
  Amp-Out caps: ofs=3D0x27, nsteps=3D0x36, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0xa7 0xa7]
  Connection: 10
     0x38 0x39* 0x3a 0x3b 0x3c 0x18 0x24 0x25 0x3d 0x20
Node 0x0e [Audio Selector] wcaps 0x30010d: Stereo Amp-Out
  Control: name=3D"Capture Volume", index=3D2, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Capture Switch", index=3D2, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Input Source", index=3D2, device=3D0
  Amp-Out caps: ofs=3D0x27, nsteps=3D0x36, stepsize=3D0x05, mute=3D1
  Amp-Out vals:  [0xa7 0xa7]
  Connection: 10
     0x38 0x39* 0x3a 0x3b 0x3c 0x18 0x24 0x25 0x3d 0x20
