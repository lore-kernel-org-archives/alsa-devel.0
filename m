From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Tue, 7 Jun 2011 16:32:20 +0800
Message-ID: <BANLkTinwNT_bbvSkd5Q106c9SoEmPURzng@mail.gmail.com>
References: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
	<BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
	<BANLkTimUVPCHzyASs3s0MtNV1DNKS0BfzA@mail.gmail.com>
	<BANLkTikcUZESFMF-Y30jLJ889nCLEBwNhA@mail.gmail.com>
	<BANLkTikxTsM6FUSQcZjwzcMAveJd_uS68g@mail.gmail.com>
	<BANLkTi=vxO-9KqP158AtkQozOjfqzVp_EA@mail.gmail.com>
	<BANLkTimR1_tT57o7iLbv4_QdirNbUORbfA@mail.gmail.com>
	<BANLkTi=tKPpmn0D8-Bj1NYbXSkcOveO99g@mail.gmail.com>
	<BANLkTi=-dE0hvTN96yCvdNzsM59MY=csfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id C19DD24392
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Jun 2011 10:32:20 +0200 (CEST)
Received: by fxm5 with SMTP id 5so3479874fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 07 Jun 2011 01:32:20 -0700 (PDT)
In-Reply-To: <BANLkTi=-dE0hvTN96yCvdNzsM59MY=csfA@mail.gmail.com>
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

2011/6/2 alex dot baldacchino dot alsasub at gmail dot com
<alex.baldacchino.alsasub@gmail.com>:

>>>
>>> Must these controls be always coupled? Is it a specification
>>> constraint? What if via_hp_build() didn't execute
>>>
>>> knew =3D via_clone_control(spec, &via_hp_mixer[1]);
>>>
>>> when side_mute_status() returned '0' ?
>>>
>>
>
> But I was also asking for the following code:
>
>> static const struct snd_kcontrol_new via_hp_mixer[2] =3D {
>> =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.iface =3D SNDRV_CTL_ELEM_IFACE_MIXER,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "Independent HP",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.info =3D via_independent_hp_info,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.get =3D via_independent_hp_get,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.put =3D via_independent_hp_put,
>> =A0 =A0 =A0 =A0},
>> =A0 =A0 =A0 =A0{
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.iface =3D NID_MAPPING,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.name =3D "Independent HP",
>> =A0 =A0 =A0 =A0},
>> };
>>
>
> Must there be always two "Independent HP" controls in all via codecs,
> or there could be just one? In the latter case via_hp_mixer[1] could
> be ignored in some cases.
>

Refer to commit 3d83e577a8206f0f3822a3840e12f76477142ba2

There are codec which does not support indepedent HP

http://thread.gmane.org/gmane.linux.alsa.devel/68414

NID_MAPPING seem used for debugging only

The error "hda-codec: no NID for mapping control Independent HP:0:0"
can be fixed by checking  the value returned by side_mute_channel()


	knew =3D via_clone_control(spec, &via_hp_mixer[0]);
	if (knew =3D=3D NULL)
		return -ENOMEM;

	knew->subdevice =3D HDA_SUBDEV_NID_FLAG | nid;
	knew->private_value =3D nid;
+
+     if (side_mute_channel(spec) =3D=3D 0)
+              return 0;

	knew =3D via_clone_control(spec, &via_hp_mixer[1]);
	if (knew =3D=3D NULL)
		return -ENOMEM;
	knew->subdevice =3D side_mute_channel(spec);


>
>>>
>>> The last part is interesting. If vt2020 works the same way, the
>>> 8-channel setup should disallow the "Independent HP" function, that is
>>> it should be automatically turned off and 0x28 should be either muted,
>>> or used as a 'duplicate' for 0x0c (same sound of blue jack) or 0x08
>>> (same sound as rear green jack, as in 'redirected audio' ). If I'm not
>>> misunderstanding everything, of course.
>>
>> static const struct hda_pcm_stream vt1718S_pcm_analog_playback =3D {
>> =A0 =A0 =A0 =A0.substreams =3D 2,
>> =A0 =A0 =A0 =A0.channels_min =3D 2,
>> =A0 =A0 =A0 =A0.channels_max =3D 10,
>> =A0 =A0 =A0 =A0.nid =3D 0x8, /* NID to query formats and rates */
>>
>> This look like vt1718s support 10 channels and 10 channels allow
>> independent HP and surround71 at the same time
>>
>
> If this part of the driver is correct, you're definitely right. That
> also means admin's answer at
>
> http://www.viaarena.com/forums/showthread.php?t=3D41015
>
> is mistaken when he says
>
> "Please note that the =93Independent Headphone=94 function requires two
> channels. Therefore, only six
> channels will be available if =93Independent Headphone=94 is being used."
>
> On the other hand, the picture of via's configuration panel seems to
> give him right: in "Independent HP" mode ("Auricular independiente" in
> the picture) the two side speakers for surround effects are grayed out
> as to mean they're disabled, whereas in 'Redirected Ouptut"
> ("Auricular redirigido" in the picture) those ones seem to be enabled.
> Though, there could be a lack of support for all ten channels in the
> motherboard implementation and/or a limitation in that particular
> version of via's driver/mixer (if possible at all, I'm just
> guessing...)
>

The codec vt1708s mentioned in the thread is a 8 channel codec


if you look at vt1718S_auto_fill_dac_nids() and
vt1718S_auto_create_hp_ctls() ,
grey jack use 0x0b and headphone use 0x0c

yes, it is still possible that vt1718s without a grey jack is just a 8
channel codec , but those variants of vt1718s which has a grey jack
are most likely a 10 channel codec

/* fill in the dac_nids table from the parsed pin configuration */
static int vt1718S_auto_fill_dac_nids(struct via_spec *spec,
				     const struct auto_pin_cfg *cfg)
{
	int i;
	hda_nid_t nid;

	spec->multiout.num_dacs =3D cfg->line_outs;

	spec->multiout.dac_nids =3D spec->private_dac_nids;

	for (i =3D 0; i < 4; i++) {
		nid =3D cfg->line_out_pins[i];
		if (nid) {
			/* config dac list */
			switch (i) {
			case AUTO_SEQ_FRONT:
				spec->private_dac_nids[i] =3D 0x8;
				break;
			case AUTO_SEQ_CENLFE:
				spec->private_dac_nids[i] =3D 0xa;
				break;
			case AUTO_SEQ_SURROUND:
				spec->private_dac_nids[i] =3D 0x9;
				break;
			case AUTO_SEQ_SIDE:
				spec->private_dac_nids[i] =3D 0xb;
				break;
			}
		}
	}

	return 0;
}

>
>>>
>>> BTW, 0x2a is connected to (gets input from) 0x09, which is labeled
>>> 'Surround Playback Volume' and is also an input for 0x25 ('Surround
>>> Playback Switch', black jack, rear speaker according to manual)
>>> throughout 0x19; 0x27 (missing gray jack) would be connected to 0x0b
>>> throughout 0x1a...
>>>
>>>>
>>>> In alsa,
>>>>
>>>> when independent HP is on,
>>>>
>>>> The HP jack is supposed to connected to [Audio Output] which is not
>>>> used by the rear panel jacks (i.e. 0x25) and application has to use
>>>> sudevice 1
>>>>
>>>> you can use aplay -Dhw:0,0,1 stereo.wav
>>>
>>> Tested: it works. I can get different streams out of rear (front
>>> playback) and front (hp) line out jacks (used mplayer on the 'default'
>>> rear channel(s) and aplay as above on the front panel)
>>>
>>
>>
>>
>> so you can check whether 0xb can be used instead of 0xc for headphone
>
> Before testing your code:
>
>>
>> static int via_independent_hp_put(struct snd_kcontrol *kcontrol,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struc=
t snd_ctl_elem_value *ucontrol)
>> {
>> =A0 =A0 =A0 =A0struct hda_codec *codec =3D snd_kcontrol_chip(kcontrol);
>> =A0 =A0 =A0 =A0struct via_spec *spec =3D codec->spec;
>> =A0 =A0 =A0 =A0hda_nid_t nid =3D kcontrol->private_value;
>> =A0 =A0 =A0 =A0unsigned int pinsel =3D ucontrol->value.enumerated.item[0=
];
>> =A0 =A0 =A0 =A0/* Get Independent Mode index of headphone pin widget */
>> =A0 =A0 =A0 =A0spec->hp_independent_mode =3D spec->hp_independent_mode_i=
ndex =3D=3D pinsel
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0? 1 : 0;
>> =A0 =A0 =A0 =A0if (spec->codec_type =3D=3D VT1718S)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_write(codec, nid, 0,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC=
_VERB_SET_CONNECT_SEL, pinsel ? 2 : 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AC=
_VERB_SET_CONNECT_SEL, pinsel ?
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sp=
ec->hp_independent_mode_index : 0);
>>
>>
>
>
> This is to select entry at index #1 (which should be 0x0b) in the
> connection list of node 0x34 (the Audio Selector driving node 0x28)
> when Independent HP is selected, right?
>

Refer to commit  cdc1784d49258198df600fbc1d37c07d7eee5ed6

and ce0e5a9e81fbb153ee15ca60246c6722f07fc546

it look like  spec->hp_independent_mode_index is used to select the
path for HP pin to [Audio Output]

(e..g. vt1702 is using spec->hp_independent_mode_index =3D 0


Node 0x10 [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name=3D"Front Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Device: name=3D"VT1702 Analog", type=3D"Audio", device=3D0
  Amp-Out caps: ofs=3D0x2a, nsteps=3D0x2a, stepsize=3D0x05, mute=3D0
  Amp-Out vals:  [0x2a 0x2a]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0

Node 0x17 [Pin Complex] wcaps 0x40058d: Stereo Amp-Out
  Control: name=3D"Headphone Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Control: name=3D"Independent HP", index=3D0, device=3D0
  Amp-Out caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
  Amp-Out vals:  [0x00 0x00]
  Pincap 0x0000001c: OUT HP Detect
  Pin Default 0x0221401f: [Jack] HP Out at Ext Front
    Conn =3D 1/8, Color =3D Green
    DefAssociation =3D 0x1, Sequence =3D 0xf
  Pin-ctls: 0xc0: OUT HP
  Unsolicited: tag=3D05, enabled=3D1
  Power states:  D0 D1 D2 D3
  Power: setting=3DD3, actual=3DD3
  Connection: 2
     0x1d 0x1a*

Node 0x1a [Audio Mixer] wcaps 0x20050b: Stereo Amp-In
  Control: name=3D"Master Front Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Master Front Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Mic Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Control: name=3D"Mic Playback Switch", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DIn, idx=3D0, ofs=3D0
  Amp-In caps: ofs=3D0x17, nsteps=3D0x1f, stepsize=3D0x05, mute=3D1
  Amp-In vals:  [0x09 0x09] [0x00 0x00] [0x00 0x00] [0x00 0x00]
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
  Connection: 4
     0x10 0x14 0x15 0x18

Node 0x1d [Audio Output] wcaps 0x41d: Stereo Amp-Out
  Control: name=3D"Headphone Playback Volume", index=3D0, device=3D0
    ControlAmp: chs=3D3, dir=3DOut, idx=3D0, ofs=3D0
  Amp-Out caps: ofs=3D0x2a, nsteps=3D0x2a, stepsize=3D0x05, mute=3D0
  Amp-Out vals:  [0x2a 0x2a]
  Converter: stream=3D0, channel=3D0
  PCM:
    rates [0x5e0]: 44100 48000 88200 96000 192000
    bits [0xe]: 16 20 24
    formats [0x1]: PCM
  Power states:  D0 D1 D2 D3
  Power: setting=3DD0, actual=3DD0
>
>>
>>[...cut...]
>>
>> static const struct hda_verb vt1718S_volume_init_verbs[] =3D {
>>
>> - =A0 =A0 =A0 {0x34, AC_VERB_SET_CONNECT_SEL, 0x2},
>> + =A0 =A0 =A0 {0x34, AC_VERB_SET_CONNECT_SEL, 0x0},
>> =A0 =A0 =A0 =A0{0x35, AC_VERB_SET_CONNECT_SEL, 0x1},
>>
>>
>
>
> What's the param field's meaning here? Is it the index of a connection
> list to be selected? In this case, entry #0 for 0x34 should be 0x08,
> is it to start with Independent HP turned off?
>
> For the rest of your code (6/8 channels mode selection and retasking
> part), shall I apply that altogether with the 0x0b selection part, or
> should I rather test if 0x0b is usable for headphone in place of 0x0c
> first?
>

The 6/8 channel mode switch is based on vt2020 is a 10 channel codec
so you have to check whether  [Audio Output] 0x0b can be used
