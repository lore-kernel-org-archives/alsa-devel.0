From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: hda-intel front headphone (8086:27d8 1043:83bc)
Date: Thu, 7 Jul 2011 09:31:21 +0800
Message-ID: <CAN8cciYw-nfWo75ss156UfcQu_hh5xG3n9jj8mKMr86HB-EUWg@mail.gmail.com>
References: <201107041331.41528.xenogenesi@virgilio.it>
	<CAN8ccibefvece13buxhAh0netTzELFNP4HEMeZjx7Z9ND1CBgw@mail.gmail.com>
	<201107061534.58232.xenogenesi@virgilio.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f50.google.com (mail-fx0-f50.google.com
	[209.85.161.50]) by alsa0.perex.cz (Postfix) with ESMTP id AE45124479
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jul 2011 03:31:21 +0200 (CEST)
Received: by fxh2 with SMTP id 2so722751fxh.9
	for <alsa-devel@alsa-project.org>; Wed, 06 Jul 2011 18:31:21 -0700 (PDT)
In-Reply-To: <201107061534.58232.xenogenesi@virgilio.it>
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

2011/7/6 Alex <xenogenesi@virgilio.it>:
>> 2011/7/4 Alex <xenogenesi@virgilio.it>:
>> > Hi,
>> >
>> > I run a Debian/sid on an Asus P5KPL-SE mainboard, the snd-hda-intel se=
em
>> > to work fine, ever if it run with guess method:
>> >
>> > Unknown hardware: "HDA-Intel" "Realtek ALC887"
>> > "HDA:10ec0887,104383bc,00100202" "0x1043" "0x83bc"
>> > Hardware is initialized using a guess method
>>
>> This is the message from "alsactl init"
>
> yes
>
>> > The only annoying thing is about the front headphone, every mixer
>> > application show the front headphone item but doesn't have adjustable
>> > level and I hear nothing on headphone.
>> >
>> > Any hint?
>> >
>> > http://www.alsa-project.org/db/?f=3Dd6bc3005fab4683f2606e48f2bc909258a=
4ee3e
>> > 3
>>
>> The codec alc887 in your =A0Asus P5KPL-SE seem different from
>>
>> http://www.asus.com/Motherboards/Intel_Socket_775/P5KPL_SE/#specificatio=
ns
>>
>> ALC662 High Definition Audio 6 -Channel CODEC
>> Audio Jack-detect Technology

The main point is both the specification and user manual only mention
6 channel codec
and you cannot get "Headphone Volume Control" when it is a 6 channel codec

>>
>> according to your codec info
>>
>> it seem that those fix_pin and multi_pin have the same capability to
>> connect to any DAC
>>
>>
>> static int alc880_auto_create_extra_out(struct alc_spec *spec, hda_nid_t
>> pin, const char *pfx)
>> {
>>
>> =A0 =A0 =A0 } else if (alc880_is_multi_pin(pin)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 nid =3D alc880_idx_to_dac(alc880_multi_pin_idx=
(pin));
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* specify the DAC as the extra output */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!spec->multiout.hp_nid)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.hp_nid =3D nid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->multiout.extra_out_nid[0=
] =3D nid;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* control HP volume/switch on the output mixe=
r amp */
>> + =A0 =A0 =A0 =A0 =A0 =A0 nid =3D alc880_idx_to_mixer(alc880_multi_pin_i=
dx(pin));
>> + =A0 =A0 =A0 =A0 =A0 =A0 err =3D add_pb_vol_ctrl(spec, ALC_CTL_WIDGET_V=
OL, pfx,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HDA_COMPOS=
E_AMP_VAL(nid, 3, 0, HDA_OUTPUT));
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* set manual connection */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* we have only a switch on HP-out PIN */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D add_pb_sw_ctrl(spec, ALC_CTL_WIDGET_=
MUTE, pfx,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HDA_COMP=
OSE_AMP_VAL(pin, 3, 0, HDA_OUTPUT));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err < 0)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 return 0;
>
> My knowledge of audio/alsa programming is really poor, but if someone sug=
gest
> a patch I can setup the thing and do some debug.
>

you have to find out whether 0x05 can be used by the headphone 0x1b
and create a playback volume control at 0x0f (i.e. whether alc887 is a
8 channel codec )

Node 0x05 [Audio Output] wcaps 0x411: Stereo
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x560]: 44100 48000 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0

Node 0x0f [Audio Mixer] wcaps 0x20010f: Stereo Amp-In Amp-Out
  Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-In vals:  [0x00 0x00] [0x00 0x00]
  Amp-Out caps: ofs=3D0x1f, nsteps=3D0x1f, stepsize=3D0x05, mute=3D0
  Amp-Out vals:  [0x00 0x00]
  Connection: 2
     0x05 0x0b

Node 0x1b [Pin Complex] wcaps 0x40058f: Stereo Amp-In Amp-Out
  Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-In caps: ofs=3D0x00, nsteps=3D0x03, stepsize=3D0x27, mute=3D0
  Amp-In vals:  [0x00 0x00]
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000373e: IN OUT HP Detect Trigger
    Vref caps: HIZ 50 GRD 80 100
  Pin Default 0x02214020: [Jack] HP Out at Ext Front
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0x2, Sequence =3D 0x0
  Pin-ctls: 0xc0: OUT HP VREF_HIZ
  Unsolicited: tag=3D00, enabled=3D0
  Power states:  D0 D1 D2 D3 EPSS
  Power: setting=3DD0, actual=3DD0
  Connection: 5
     0x0c* 0x0d 0x0e 0x0f 0x26
