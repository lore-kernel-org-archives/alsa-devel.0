From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Major reworks on patch_via.c (TESTERS WANTED)
Date: Tue, 5 Jul 2011 17:20:38 +0800
Message-ID: <CAN8cciYdMO2kje20RzCcLtO4qkWiHzSGrAARn-AU81LRixv-mQ@mail.gmail.com>
References: <s5hvcw04k50.wl%tiwai@suse.de> <s5h8vsu0wkr.wl%tiwai@suse.de>
	<201107042137.46835.phoenix.diablo@gmail.com>
	<s5h1uy5guyb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 0B83E1038F0
	for <alsa-devel@alsa-project.org>;
	Tue,  5 Jul 2011 11:20:39 +0200 (CEST)
Received: by fxh2 with SMTP id 2so6288229fxh.9
	for <alsa-devel@alsa-project.org>; Tue, 05 Jul 2011 02:20:38 -0700 (PDT)
In-Reply-To: <s5h1uy5guyb.wl%tiwai@suse.de>
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

2011/7/5 Takashi Iwai <tiwai@suse.de>:
> At Mon, 4 Jul 2011 21:37:46 +0200,
> Jan Binder wrote:
>
>> * Independent HP worked, when I could turn it on in alsamixer and correc=
tly
>> produced sound with aplay -Dhw:0,2,0 . I could not always reliably enable
>> Independent HP in alsamixer, sometimes it would not change status ans ap=
lay
>> claimed that hw:0,2,0 was busy.
>
> This is intentional. =A0The switching is racy, so it can't be changed
> safely when the multi-channel PCM is opened/used.
>
>> * Headphone automute (muting rear line out when headphones are plugged i=
n, if
>> I understand correctly) does not seem to work in any setting.
>
> See above.
>

The second ADC can only be connected to Mic at Front Panel ,

It seem that this is a prefect candidate to create device 2 for this
ADC instead of subdevice 1 so that user can use device 2 for the front
panel hp and mic



Node 0x14 [Audio Input] wcaps 0x10051b: Stereo Amp-In
  Control: name=3D"Capture Volume", index=3D1, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Capture Switch", index=3D1, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x14, stepsize=3D0x06, mute=3D1
  Amp-In vals:  [0x00 0x00]
  Converter: stream=3D2, channel=3D0
  SDI-Select: 0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xa]: 16 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x1e


Node 0x1e [Pin Complex] wcaps 0x400581: Stereo
  Pincap 0x00002334: IN OUT Detect
    Vref caps: HIZ 50 100
  Pin Default 0x02a19038: [Jack] Mic at Ext Front
    Conn =3D 1/8, Color =3D Pink
    DefAssociation =3D 0x3, Sequence =3D 0x8
  Pin-ctls: 0x21: IN VREF_50
  Unsolicited: tag=3D20, enabled=3D1
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 1
     0x27



APLAY

**** List of PLAYBACK Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: VT1708B 8-Ch Analog [VT1708B 8-Ch Analog]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 1: VT1708B 8-Ch Digital [VT1708B 8-Ch Digit=
al]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: SB [HDA ATI SB], device 2: VT1708B 8-Ch HP [VT1708B 8-Ch HP]
  Subdevices: 1/1
  Subdevice #0: subdevice #0

ARECORD

**** List of CAPTURE Hardware Devices ****
card 0: SB [HDA ATI SB], device 0: VT1708B 8-Ch Analog [VT1708B 8-Ch Analog]
  Subdevices: 2/2
  Subdevice #0: subdevice #0
  Subdevice #1: subdevice #1
