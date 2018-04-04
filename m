From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: CX20724 headset button detect
Date: Wed, 04 Apr 2018 17:29:23 +0100
Message-ID: <1522859362.7862.62.camel@infradead.org>
References: <1522841412.7862.15.camel@infradead.org>
 <s5hmuyjf0md.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3031888938668775828=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from twosheds.infradead.org (twosheds.infradead.org [90.155.92.209])
 by alsa0.perex.cz (Postfix) with ESMTP id ED93626718D
 for <alsa-devel@alsa-project.org>; Wed,  4 Apr 2018 18:29:29 +0200 (CEST)
In-Reply-To: <s5hmuyjf0md.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Andrew Duggan <aduggan@synaptics.com>, David Henningsson <david.henningsson@canonical.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============3031888938668775828==
Content-Type: multipart/signed; micalg="sha-256"; protocol="application/x-pkcs7-signature"; boundary="=-k7WtYrdagGUdPnA6HXGK"


--=-k7WtYrdagGUdPnA6HXGK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2018-04-04 at 17:32 +0200, Takashi Iwai wrote:
> On Wed, 04 Apr 2018 13:30:12 +0200,
> David Woodhouse wrote:
> >=20
> >=20
> > I have an HP EliteBook 850 G3 with CX20724:
> >=20
> > =C2=A0hdaudioC0D0: CX20724: BIOS auto-probing.
> > =C2=A0hdaudioC0D0: action: 0 gpio_led: 0
> > =C2=A0hdaudioC0D0: autoconfig for CX20724: line_outs=3D1 (0x16/0x0/0x0/=
0x0/0x0) type:line
> > =C2=A0hdaudioC0D0:=C2=A0=C2=A0=C2=A0=C2=A0speaker_outs=3D1 (0x17/0x0/0x=
0/0x0/0x0)
> > =C2=A0hdaudioC0D0:=C2=A0=C2=A0=C2=A0=C2=A0hp_outs=3D1 (0x1d/0x0/0x0/0x0=
/0x0)
> > =C2=A0hdaudioC0D0:=C2=A0=C2=A0=C2=A0=C2=A0mono: mono_out=3D0x0
> > =C2=A0hdaudioC0D0:=C2=A0=C2=A0=C2=A0=C2=A0inputs:
> > =C2=A0hdaudioC0D0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Mic=3D0x19
> > =C2=A0hdaudioC0D0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Internal Mic=3D0x=
1a
> > =C2=A0hdaudioC0D0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Line=3D0x18
> > =C2=A0hdaudioC0D0: Enable sync_write for stable communication
> > =C2=A0hdaudioC0D0: action: 1 gpio_led: 0
> > =C2=A0hdaudioC0D0: action: 2 gpio_led: 0
> > =C2=A0...
> > =C2=A0input: HDA Intel PCH Mic as /devices/pci0000:00/0000:00:1f.3/soun=
d/card0/input21
> >=20
> > The CX20724 datasheet=C2=B9 suggests that it supports headset button ev=
ents
> > =E2=80=94 at least 'Function A' when the mic pin is shorted to ground, =
if not
> > the other functions.
> >=20
> > But it isn't working. Only the jack insertion is reported through the
> > corresponding input device, not the button press. I added a printk into
> > snd_hda_jack_unsol_event(), and it isn't even being invoked at all for
> > the button presses; only insertion/removal.
> >=20
> > How do we make this work?
> >
> > =C2=B9 https://www.tonymacx86.com/attachments/datasheet_cx20724-pdf.203=
615/
>
>
> Unfortunately, there is no standard definition for the headset button
> handling in HD-audio spec, and each vendor implements in own way
> without disclosure.
> For example, the datasheet you gave also doesn't shed any light how
> it's triggered (the headset button widget NID is empty and no more
> information).
>=20
> So at this moment, only Conexant people can answer to this question
> properly, sorry.

Thanks. I think that would be "Synaptics people" now... Andrew, is
there any chance you could find a better datasheet for this part
please? I see mention of a 'BIOS guide' in what we have so far.

Alternatively=E2=80=A6 David, in=C2=A0https://bugs.launchpad.net/ubuntu/+bu=
g/1198030
you added code which touches registers in the vendor-specific 0x1C NID.
Do you have access to something I haven't been able to find, and does
it say anything about headset button detection?


> Maybe you can try to enable the GPIO unsolicited event and see whether
> any unsolicited event is generated.=C2=A0=C2=A0Though, the datasheet says=
 it's
> something else individual, but who knows.

Hm... forgive my ignorance; how do I do that? FWIW here's the content
of /proc/asound/card0/codec#0:

Codec: Conexant CX20724
Address: 0
AFG Function Id: 0x1 (unsol 1)
Vendor Id: 0x14f150f4
Subsystem Id: 0x103c814d
Revision Id: 0x100109
No Modem Function Group found
Default PCM:
=C2=A0=C2=A0=C2=A0=C2=A0rates [0x140]: 48000 96000
=C2=A0=C2=A0=C2=A0=C2=A0bits [0xa]: 16 24
=C2=A0=C2=A0=C2=A0=C2=A0formats [0x1]: PCM
Default Amp-In caps: N/A
Default Amp-Out caps: N/A
State of AFG node 0x01:
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 D3cold S3D3cold CLKSTOP EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
GPIO: io=3D7, o=3D0, i=3D0, unsolicited=3D1, wake=3D1
=C2=A0 IO[0]: enable=3D1, dir=3D1, wake=3D0, sticky=3D0, data=3D0, unsol=3D=
0
=C2=A0 IO[1]: enable=3D1, dir=3D1, wake=3D0, sticky=3D0, data=3D0, unsol=3D=
0
=C2=A0 IO[2]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D=
0
=C2=A0 IO[3]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D=
0
=C2=A0 IO[4]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D=
0
=C2=A0 IO[5]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D=
0
=C2=A0 IO[6]: enable=3D0, dir=3D0, wake=3D0, sticky=3D0, data=3D0, unsol=3D=
0
Node 0x10 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
=C2=A0 Control: name=3D"Speaker+LO Playback Volume", index=3D0, device=3D0
=C2=A0=C2=A0=C2=A0=C2=A0ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
=C2=A0 Control: name=3D"Speaker+LO Playback Switch", index=3D0, device=3D0
=C2=A0=C2=A0=C2=A0=C2=A0ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
=C2=A0 Device: name=3D"CX20724 Analog", type=3D"Audio", device=3D0
=C2=A0 Amp-Out caps: ofs=3D0x4a, nsteps=3D0x4a, stepsize=3D0x03, mute=3D1
=C2=A0 Amp-Out vals:=C2=A0=C2=A0[0x80 0x80]
=C2=A0 Converter: stream=3D1, channel=3D0
=C2=A0 PCM:
=C2=A0=C2=A0=C2=A0=C2=A0rates [0x540]: 48000 96000 192000
=C2=A0=C2=A0=C2=A0=C2=A0bits [0xa]: 16 24
=C2=A0=C2=A0=C2=A0=C2=A0formats [0x1]: PCM
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
Node 0x11 [Audio Output] wcaps 0xc1d: Stereo Amp-Out R/L
=C2=A0 Control: name=3D"Headphone Playback Volume", index=3D0, device=3D0
=C2=A0=C2=A0=C2=A0=C2=A0ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
=C2=A0 Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
=C2=A0=C2=A0=C2=A0=C2=A0ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
=C2=A0 Amp-Out caps: ofs=3D0x4a, nsteps=3D0x4a, stepsize=3D0x03, mute=3D1
=C2=A0 Amp-Out vals:=C2=A0=C2=A0[0x3d 0x3d]
=C2=A0 Converter: stream=3D1, channel=3D0
=C2=A0 PCM:
=C2=A0=C2=A0=C2=A0=C2=A0rates [0x540]: 48000 96000 192000
=C2=A0=C2=A0=C2=A0=C2=A0bits [0xa]: 16 24
=C2=A0=C2=A0=C2=A0=C2=A0formats [0x1]: PCM
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
Node 0x12 [Beep Generator Widget] wcaps 0x70000c: Mono Amp-Out
=C2=A0 Control: name=3D"Beep Playback Volume", index=3D0, device=3D0
=C2=A0=C2=A0=C2=A0=C2=A0ControlAmp: chs=3D1, dir=3DOut, idx=3D0, ofs=3D0
=C2=A0 Control: name=3D"Beep Playback Switch", index=3D0, device=3D0
=C2=A0=C2=A0=C2=A0=C2=A0ControlAmp: chs=3D1, dir=3DOut, idx=3D0, ofs=3D0
=C2=A0 Amp-Out caps: ofs=3D0x07, nsteps=3D0x07, stepsize=3D0x0f, mute=3D0
=C2=A0 Amp-Out vals:=C2=A0=C2=A0[0x03]
Node 0x13 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
=C2=A0 Control: name=3D"Capture Volume", index=3D0, device=3D0
=C2=A0=C2=A0=C2=A0=C2=A0ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
=C2=A0 Control: name=3D"Capture Switch", index=3D0, device=3D0
=C2=A0=C2=A0=C2=A0=C2=A0ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
=C2=A0 Device: name=3D"CX20724 Analog", type=3D"Audio", device=3D0
=C2=A0 Amp-In caps: ofs=3D0x4a, nsteps=3D0x50, stepsize=3D0x03, mute=3D1
=C2=A0 Amp-In vals:=C2=A0=C2=A0[0x50 0x50] [0x50 0x50] [0x50 0x50] [0x80 0x=
80] [0x80 0x80] [0x80 0x80] [0x80 0x80]
=C2=A0 Converter: stream=3D1, channel=3D0
=C2=A0 SDI-Select: 0
=C2=A0 PCM:
=C2=A0=C2=A0=C2=A0=C2=A0rates [0x140]: 48000 96000
=C2=A0=C2=A0=C2=A0=C2=A0bits [0xa]: 16 24
=C2=A0=C2=A0=C2=A0=C2=A0formats [0x1]: PCM
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
=C2=A0 Connection: 7
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x18 0x19* 0x1a 0x15 0x1d 0x1e 0x1f
Node 0x14 [Audio Input] wcaps 0x100d1b: Stereo Amp-In R/L
=C2=A0 Amp-In caps: ofs=3D0x4a, nsteps=3D0x50, stepsize=3D0x03, mute=3D1
=C2=A0 Amp-In vals:=C2=A0=C2=A0[0x4a 0x4a] [0x4a 0x4a] [0x4a 0x4a]
=C2=A0 Converter: stream=3D0, channel=3D0
=C2=A0 SDI-Select: 0
=C2=A0 PCM:
=C2=A0=C2=A0=C2=A0=C2=A0rates [0x140]: 48000 96000
=C2=A0=C2=A0=C2=A0=C2=A0bits [0xa]: 16 24
=C2=A0=C2=A0=C2=A0=C2=A0formats [0x1]: PCM
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
=C2=A0 Connection: 3
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x1a* 0x15 0x1f
Node 0x15 [Vendor Defined Widget] wcaps 0xf0050b: Stereo Amp-In
=C2=A0 Amp-In caps: ofs=3D0x4a, nsteps=3D0x4a, stepsize=3D0x03, mute=3D1
=C2=A0 Amp-In vals:=C2=A0=C2=A0[0x4a 0x4a] [0x4a 0x4a]
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
=C2=A0 Connection: 2
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x10* 0x11
Node 0x16 [Pin Complex] wcaps 0x400581: Stereo
=C2=A0 Pincap 0x0001001c: OUT HP EAPD Detect
=C2=A0 EAPD 0x0:
=C2=A0 Pin Default 0x40f001f0: [N/A] Other at Ext N/A
=C2=A0=C2=A0=C2=A0=C2=A0Conn =3D Unknown, Color =3D Unknown
=C2=A0=C2=A0=C2=A0=C2=A0DefAssociation =3D 0xf, Sequence =3D 0x0
=C2=A0=C2=A0=C2=A0=C2=A0Misc =3D NO_PRESENCE
=C2=A0 Pin-ctls: 0x40: OUT
=C2=A0 Unsolicited: tag=3D02, enabled=3D1
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
=C2=A0 Connection: 2
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x10* 0x11
Node 0x17 [Pin Complex] wcaps 0x400501: Stereo
=C2=A0 Pincap 0x00010010: OUT EAPD
=C2=A0 EAPD 0x0:
=C2=A0 Pin Default 0x91170110: [Fixed] Speaker at Int Rear
=C2=A0=C2=A0=C2=A0=C2=A0Conn =3D Analog, Color =3D Unknown
=C2=A0=C2=A0=C2=A0=C2=A0DefAssociation =3D 0x1, Sequence =3D 0x0
=C2=A0=C2=A0=C2=A0=C2=A0Misc =3D NO_PRESENCE
=C2=A0 Pin-ctls: 0x40: OUT
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
=C2=A0 Connection: 2
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x10* 0x11
Node 0x18 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
=C2=A0 Control: name=3D"Line Boost Volume", index=3D0, device=3D0
=C2=A0=C2=A0=C2=A0=C2=A0ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
=C2=A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
=C2=A0 Amp-In vals:=C2=A0=C2=A0[0x00 0x00]
=C2=A0 Pincap 0x00001324: IN Detect
=C2=A0=C2=A0=C2=A0=C2=A0Vref caps: HIZ 50 80
=C2=A0 Pin Default 0x40f001f0: [N/A] Other at Ext N/A
=C2=A0=C2=A0=C2=A0=C2=A0Conn =3D Unknown, Color =3D Unknown
=C2=A0=C2=A0=C2=A0=C2=A0DefAssociation =3D 0xf, Sequence =3D 0x0
=C2=A0=C2=A0=C2=A0=C2=A0Misc =3D NO_PRESENCE
=C2=A0 Pin-ctls: 0x20: IN VREF_HIZ
=C2=A0 Unsolicited: tag=3D05, enabled=3D1
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
Node 0x19 [Pin Complex] wcaps 0x40048b: Stereo Amp-In
=C2=A0 Control: name=3D"Mic Boost Volume", index=3D0, device=3D0
=C2=A0=C2=A0=C2=A0=C2=A0ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
=C2=A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
=C2=A0 Amp-In vals:=C2=A0=C2=A0[0x03 0x03]
=C2=A0 Pincap 0x00001324: IN Detect
=C2=A0=C2=A0=C2=A0=C2=A0Vref caps: HIZ 50 80
=C2=A0 Pin Default 0x04a11030: [Jack] Mic at Ext Right
=C2=A0=C2=A0=C2=A0=C2=A0Conn =3D 1/8, Color =3D Black
=C2=A0=C2=A0=C2=A0=C2=A0DefAssociation =3D 0x3, Sequence =3D 0x0
=C2=A0 Pin-ctls: 0x24: IN VREF_80
=C2=A0 Unsolicited: tag=3D03, enabled=3D1
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
Node 0x1a [Pin Complex] wcaps 0x40040b: Stereo Amp-In
=C2=A0 Control: name=3D"Internal Mic Boost Volume", index=3D0, device=3D0
=C2=A0=C2=A0=C2=A0=C2=A0ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
=C2=A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
=C2=A0 Amp-In vals:=C2=A0=C2=A0[0x00 0x00]
=C2=A0 Pincap 0x00000020: IN
=C2=A0 Pin Default 0x95a60120: [Fixed] Mic at Int Top
=C2=A0=C2=A0=C2=A0=C2=A0Conn =3D Digital, Color =3D Unknown
=C2=A0=C2=A0=C2=A0=C2=A0DefAssociation =3D 0x2, Sequence =3D 0x0
=C2=A0=C2=A0=C2=A0=C2=A0Misc =3D NO_PRESENCE
=C2=A0 Pin-ctls: 0x20: IN
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
Node 0x1b [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1c [Vendor Defined Widget] wcaps 0xf00000: Mono
Node 0x1d [Pin Complex] wcaps 0x40058b: Stereo Amp-In
=C2=A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
=C2=A0 Amp-In vals:=C2=A0=C2=A0[0x00 0x00]
=C2=A0 Pincap 0x0001133c: IN OUT HP EAPD Detect
=C2=A0=C2=A0=C2=A0=C2=A0Vref caps: HIZ 50 80
=C2=A0 EAPD 0x0:
=C2=A0 Pin Default 0x04211040: [Jack] HP Out at Ext Right
=C2=A0=C2=A0=C2=A0=C2=A0Conn =3D 1/8, Color =3D Black
=C2=A0=C2=A0=C2=A0=C2=A0DefAssociation =3D 0x4, Sequence =3D 0x0
=C2=A0 Pin-ctls: 0xc0: OUT HP VREF_HIZ
=C2=A0 Unsolicited: tag=3D01, enabled=3D1
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
=C2=A0 Connection: 2
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x10 0x11*
Node 0x1e [Pin Complex] wcaps 0x40048b: Stereo Amp-In
=C2=A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
=C2=A0 Amp-In vals:=C2=A0=C2=A0[0x00 0x00]
=C2=A0 Pincap 0x00000024: IN Detect
=C2=A0 Pin Default 0x40f001f0: [N/A] Other at Ext N/A
=C2=A0=C2=A0=C2=A0=C2=A0Conn =3D Unknown, Color =3D Unknown
=C2=A0=C2=A0=C2=A0=C2=A0DefAssociation =3D 0xf, Sequence =3D 0x0
=C2=A0=C2=A0=C2=A0=C2=A0Misc =3D NO_PRESENCE
=C2=A0 Pin-ctls: 0x00:
=C2=A0 Unsolicited: tag=3D00, enabled=3D0
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
Node 0x1f [Pin Complex] wcaps 0x40040b: Stereo Amp-In
=C2=A0 Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x2f, mute=3D0
=C2=A0 Amp-In vals:=C2=A0=C2=A0[0x00 0x00]
=C2=A0 Pincap 0x00000020: IN
=C2=A0 Pin Default 0x40f001f0: [N/A] Other at Ext N/A
=C2=A0=C2=A0=C2=A0=C2=A0Conn =3D Unknown, Color =3D Unknown
=C2=A0=C2=A0=C2=A0=C2=A0DefAssociation =3D 0xf, Sequence =3D 0x0
=C2=A0=C2=A0=C2=A0=C2=A0Misc =3D NO_PRESENCE
=C2=A0 Pin-ctls: 0x00:
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
Node 0x20 [Audio Output] wcaps 0x611: Stereo Digital
=C2=A0 Converter: stream=3D0, channel=3D0
=C2=A0 Digital:
=C2=A0 Digital category: 0x0
=C2=A0 IEC Coding Type: 0x0
=C2=A0 PCM:
=C2=A0=C2=A0=C2=A0=C2=A0rates [0x540]: 48000 96000 192000
=C2=A0=C2=A0=C2=A0=C2=A0bits [0xe]: 16 20 24
=C2=A0=C2=A0=C2=A0=C2=A0formats [0x5]: PCM AC3
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
Node 0x21 [Pin Complex] wcaps 0x400701: Stereo Digital
=C2=A0 Pincap 0x00000010: OUT
=C2=A0 Pin Default 0x40f001f0: [N/A] Other at Ext N/A
=C2=A0=C2=A0=C2=A0=C2=A0Conn =3D Unknown, Color =3D Unknown
=C2=A0=C2=A0=C2=A0=C2=A0DefAssociation =3D 0xf, Sequence =3D 0x0
=C2=A0=C2=A0=C2=A0=C2=A0Misc =3D NO_PRESENCE
=C2=A0 Pin-ctls: 0x00:
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
=C2=A0 Connection: 1
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x20
Node 0x22 [Pin Complex] wcaps 0x400501: Stereo
=C2=A0 Pincap 0x00010010: OUT EAPD
=C2=A0 EAPD 0x0:
=C2=A0 Pin Default 0x40f001f0: [N/A] Other at Ext N/A
=C2=A0=C2=A0=C2=A0=C2=A0Conn =3D Unknown, Color =3D Unknown
=C2=A0=C2=A0=C2=A0=C2=A0DefAssociation =3D 0xf, Sequence =3D 0x0
=C2=A0=C2=A0=C2=A0=C2=A0Misc =3D NO_PRESENCE
=C2=A0 Pin-ctls: 0x00:
=C2=A0 Power states:=C2=A0=C2=A0D0 D1 D2 D3 EPSS
=C2=A0 Power: setting=3DD0, actual=3DD0
=C2=A0 Connection: 2
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A00x10* 0x11


--=-k7WtYrdagGUdPnA6HXGK
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCCEFQw
ggUxMIIEGaADAgECAhBNRhEyk/HZ7naOeTHWrzuAMA0GCSqGSIb3DQEBCwUAMIGXMQswCQYDVQQG
EwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYD
VQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVu
dGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQTAeFw0xNzEyMjEwMDAwMDBaFw0xODEyMjEyMzU5
NTlaMCQxIjAgBgkqhkiG9w0BCQEWE2R3bXcyQGluZnJhZGVhZC5vcmcwggEiMA0GCSqGSIb3DQEB
AQUAA4IBDwAwggEKAoIBAQDgzLNWa18DNpGUj/ZeH0Sgz53ESIbzdPw3OJeuNP6jZhxZojbyfxbM
hETscxI/Hj6UZ4a7sHm5BkVjlsB1Af2Za/PXUt8MmLAcPMHkMPGunvkUibEvblDvpqMkQZlaZM+t
5PqFmWkbehLaEvbpNY7dmEAAeKh4klTzJzrr5AAzaCQ32cA2e3+DEIv5O5l9ViMIjy/JM+xMQrfX
3PZ0chY1PaVWjg59d4Uno+5LRDbgCnPkKJX4ysBGadibjBGQGJEZCjh94iiEebn2KsRLvtrJ72Ph
3W2HDEdngW3YP0wujFQVs81U7L8XN3kdPRsa9zNqGtYQP/+1KMMJQ57hnfi9AgMBAAGjggHpMIIB
5TAfBgNVHSMEGDAWgBSCr2yM+MX+lmF86B89K3FIXsSLwDAdBgNVHQ4EFgQUpL+/5lli9jmj2KHj
ryyhnB2xRt0wDgYDVR0PAQH/BAQDAgWgMAwGA1UdEwEB/wQCMAAwIAYDVR0lBBkwFwYIKwYBBQUH
AwQGCysGAQQBsjEBAwUCMBEGCWCGSAGG+EIBAQQEAwIFIDBGBgNVHSAEPzA9MDsGDCsGAQQBsjEB
AgEBATArMCkGCCsGAQUFBwIBFh1odHRwczovL3NlY3VyZS5jb21vZG8ubmV0L0NQUzBaBgNVHR8E
UzBRME+gTaBLhklodHRwOi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50
aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3JsMIGLBggrBgEFBQcBAQR/MH0wVQYIKwYBBQUHMAKG
SWh0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUNsaWVudEF1dGhlbnRpY2F0aW9uYW5k
U2VjdXJlRW1haWxDQS5jcnQwJAYIKwYBBQUHMAGGGGh0dHA6Ly9vY3NwLmNvbW9kb2NhLmNvbTAe
BgNVHREEFzAVgRNkd213MkBpbmZyYWRlYWQub3JnMA0GCSqGSIb3DQEBCwUAA4IBAQCK28BdbVJ9
QKQqTDfXwogAYiRBEGptfE1Bjy4F5vC6eWJqOJ15vunxjLwdbZYb4L0qrJlh+ZHHHlbIK8uEZu7N
XHUntmWMbGbZiu7JgrbSXJK1ct9gxrN/sdWYJ+JDjVHg7GfDTvTTPa26JMRqJsO1TjjyDX7A3K39
TjV8C0hqXvwF9BsNf+qBeWO6GVzJ5572awY221hc1umibmZaKV4fg+7fS7qscx5TSuIc6uvMBQhm
7NQiCq6euMMWBDUDlotQCDW0ilm0OuLW3IVLuZCm6Msc+6hT9+dCT4JUvxTHZnnO7uLCxV+Ujad+
PH3itRm38i96p2zvwgLr8vwWA0ckMIIFMTCCBBmgAwIBAgIQTUYRMpPx2e52jnkx1q87gDANBgkq
hkiG9w0BAQsFADCBlzELMAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQ
MA4GA1UEBxMHU2FsZm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENP
TU9ETyBSU0EgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTcx
MjIxMDAwMDAwWhcNMTgxMjIxMjM1OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNkd213MkBpbmZyYWRl
YWQub3JnMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4MyzVmtfAzaRlI/2Xh9EoM+d
xEiG83T8NziXrjT+o2YcWaI28n8WzIRE7HMSPx4+lGeGu7B5uQZFY5bAdQH9mWvz11LfDJiwHDzB
5DDxrp75FImxL25Q76ajJEGZWmTPreT6hZlpG3oS2hL26TWO3ZhAAHioeJJU8yc66+QAM2gkN9nA
Nnt/gxCL+TuZfVYjCI8vyTPsTEK319z2dHIWNT2lVo4OfXeFJ6PuS0Q24Apz5CiV+MrARmnYm4wR
kBiRGQo4feIohHm59irES77aye9j4d1thwxHZ4Ft2D9MLoxUFbPNVOy/Fzd5HT0bGvczahrWED//
tSjDCUOe4Z34vQIDAQABo4IB6TCCAeUwHwYDVR0jBBgwFoAUgq9sjPjF/pZhfOgfPStxSF7Ei8Aw
HQYDVR0OBBYEFKS/v+ZZYvY5o9ih468soZwdsUbdMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8E
AjAAMCAGA1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMFAjARBglghkgBhvhCAQEEBAMCBSAw
RgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAQEwKzApBggrBgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUu
Y29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2gS4ZJaHR0cDovL2NybC5jb21vZG9jYS5jb20v
Q09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRpb25hbmRTZWN1cmVFbWFpbENBLmNybDCBiwYIKwYB
BQUHAQEEfzB9MFUGCCsGAQUFBzAChklodHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FD
bGllbnRBdXRoZW50aWNhdGlvbmFuZFNlY3VyZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRw
Oi8vb2NzcC5jb21vZG9jYS5jb20wHgYDVR0RBBcwFYETZHdtdzJAaW5mcmFkZWFkLm9yZzANBgkq
hkiG9w0BAQsFAAOCAQEAitvAXW1SfUCkKkw318KIAGIkQRBqbXxNQY8uBebwunliajideb7p8Yy8
HW2WG+C9KqyZYfmRxx5WyCvLhGbuzVx1J7ZljGxm2YruyYK20lyStXLfYMazf7HVmCfiQ41R4Oxn
w0700z2tuiTEaibDtU448g1+wNyt/U41fAtIal78BfQbDX/qgXljuhlcyeee9msGNttYXNbpom5m
WileH4Pu30u6rHMeU0riHOrrzAUIZuzUIgqunrjDFgQ1A5aLUAg1tIpZtDri1tyFS7mQpujLHPuo
U/fnQk+CVL8Ux2Z5zu7iwsVflI2nfjx94rUZt/Iveqds78IC6/L8FgNHJDCCBeYwggPOoAMCAQIC
EGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBD
QSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRpb24gQXV0aG9yaXR5MB4X
DTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBM
aW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2Vj
dXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvrOeV6wodnVAFsc4
A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQPTRI5Or1u6zf+bGBSyD9aH95dDSmeny1
nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivlJTRENf+RKwrB6vcfWlP8dSsE3Rfywq09N0Zf
xcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG9qrxpZxyb4o4yNNwTqzaaPpGRqXB7IMjtf7tTmU2
jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoSWY66nJN/VCJv5ym6Q0mdCbDKCMPybTjoNCQuelc0IAaO
4nLUXk0BOSxSxt8kCvsUtQIDAQABo4IBPDCCATgwHwYDVR0jBBgwFoAUu69+Aj36pvE8hI6t7jiY
7NkyMtQwHQYDVR0OBBYEFIKvbIz4xf6WYXzoHz0rcUhexIvAMA4GA1UdDwEB/wQEAwIBhjASBgNV
HRMBAf8ECDAGAQH/AgEAMBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8ERTBDMEGgP6A9hjtodHRw
Oi8vY3JsLmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDBx
BggrBgEFBQcBAQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9E
T1JTQUFkZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20w
DQYJKoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2SQgG1NgvNc3fQP7TcePo
7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs0j8CGpfb+SJA3GaBQ+39
4k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDMKVmU/PUWNMKSTvtlenlx
Bhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+E2pvOUtY+hPebuPtTbq7
vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfHM5tdhYF/8v5UY5g2xANP
ECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4jkhJiA7EuTecP/CFtR72
uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJM/1tyZR2niOYihZ+FCbtf3D9
mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJUmpvVdZ4ognzgXtgtdk3ShrtOS1iA
N2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTKTlL8YXLI8nAbR9HWdFqzcOoB/hxfEyIQ
px9/s81rgzdEZOofSlZHynoSMYIDxzCCA8MCAQEwgawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQI
ExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBD
QSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQg
U2VjdXJlIEVtYWlsIENBAhBNRhEyk/HZ7naOeTHWrzuAMA0GCWCGSAFlAwQCAQUAoIIB6zAYBgkq
hkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0xODA0MDQxNjI5MjNaMC8GCSqG
SIb3DQEJBDEiBCBI1Qx9u5CgN9fIkxsXpkTtVEDPfZJ1OYLzWOTLDz7urTCBvQYJKwYBBAGCNxAE
MYGvMIGsMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYD
VQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RP
IFJTQSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIQTUYRMpPx2e52
jnkx1q87gDCBvwYLKoZIhvcNAQkQAgsxga+ggawwgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJH
cmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBM
aW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2Vj
dXJlIEVtYWlsIENBAhBNRhEyk/HZ7naOeTHWrzuAMA0GCSqGSIb3DQEBAQUABIIBAAshI2Aedv3o
rTXdUKRnZwp4imI4ZqHObxg4NFvXLLviiHQWdeiMTWHy8qlxmxRxGPwA5sfdyggFjuq9lCVvhGaM
aLKTzjdWEk4HhfuH13YnFNlSaLYYf1ANqcLG4DKtvXQ96vunshzmInFzuYZl/6ViMIjrbEY5rsgI
Zf22CHlG/wqHtYWRKIvap9742VW4/x69dlmSl/HZ4eyIMNuq+SVhHIjUSwkYpMnSP06Xtwpb6Iue
QIMZW8nB/C05hgePiY6rv7d3np3CYFTut01hE9IlTSKhQCAM4/7Zx8YQEBQU03nPhQssioX50Jgg
z93/0irGb8YogR2xT7JanfCy0dUAAAAAAAA=


--=-k7WtYrdagGUdPnA6HXGK--


--===============3031888938668775828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3031888938668775828==--
