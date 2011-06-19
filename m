From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Sun, 19 Jun 2011 09:46:43 +0800
Message-ID: <BANLkTi=e2L+XDj51KQCaBGH4r+_0ST5r+A@mail.gmail.com>
References: <BANLkTi=9d5A+oa6Bh+fis4+WY=xNbbnkYw@mail.gmail.com>
	<BANLkTi=i+3CJLtY-1OtkFnvrzWz4+=d=VA@mail.gmail.com>
	<BANLkTimUVPCHzyASs3s0MtNV1DNKS0BfzA@mail.gmail.com>
	<BANLkTikcUZESFMF-Y30jLJ889nCLEBwNhA@mail.gmail.com>
	<BANLkTikxTsM6FUSQcZjwzcMAveJd_uS68g@mail.gmail.com>
	<BANLkTi=vxO-9KqP158AtkQozOjfqzVp_EA@mail.gmail.com>
	<BANLkTimR1_tT57o7iLbv4_QdirNbUORbfA@mail.gmail.com>
	<BANLkTi=tKPpmn0D8-Bj1NYbXSkcOveO99g@mail.gmail.com>
	<BANLkTi=-dE0hvTN96yCvdNzsM59MY=csfA@mail.gmail.com>
	<BANLkTinwNT_bbvSkd5Q106c9SoEmPURzng@mail.gmail.com>
	<BANLkTimJb-UMD5Nk3d+_GW-b9Cir13PjMw@mail.gmail.com>
	<BANLkTindBqVQhAVJukt6Ekbfwu+9pUYhdg@mail.gmail.com>
	<BANLkTime=EgRduJaUYpDB=E08=e7Zn+rMg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) by alsa0.perex.cz (Postfix) with ESMTP id 5940724640
	for <alsa-devel@alsa-project.org>;
	Sun, 19 Jun 2011 03:46:45 +0200 (CEST)
Received: by fxm5 with SMTP id 5so1762141fxm.38
	for <alsa-devel@alsa-project.org>; Sat, 18 Jun 2011 18:46:43 -0700 (PDT)
In-Reply-To: <BANLkTime=EgRduJaUYpDB=E08=e7Zn+rMg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

2011/6/12 alex dot baldacchino dot alsasub at gmail dot com
<alex.baldacchino.alsasub@gmail.com>:
> IMPORTANT UPDATE!!!!!
>
> Node 0x0b can drive HP! The problem was function
> set_widgets_power_state_vt1718S() not updating power state for the
> correct nid, solved as follows:
>
>
> static void set_widgets_power_state_vt1718S(struct hda_codec *codec)
> {
> ...
> =A0 =A0 =A0 =A0if (spec->hp_independent_mode) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* PW4 (28h), MW3 (1bh), MUX1(34h), AOW4 (c=
h) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* PW4 (28h), MW3 (1bh), MUX1(34h), AOW4 (c=
h) of AOW3 (bh) */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0parm =3D AC_PWRST_D3;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_pin_power_state(codec, 0x28, &parm);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_write(codec, 0x1b, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AC=
_VERB_SET_POWER_STATE, parm);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_write(codec, 0x34, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AC=
_VERB_SET_POWER_STATE, parm);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_write(codec, 0xc, 0,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 snd_hda_codec_write(codec, spec->multiout.h=
p_nid, 0,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AC=
_VERB_SET_POWER_STATE, parm);
> =A0 =A0 =A0 =A0}
>

Can your hear the same signal from black and orange jack when you
playing stereo to hw:0,0,0 ?

if you look at snd_hda_multi_out_analog_prepare() in hda_codec.c,

if mout->no_share_stream=3D0 ,it seem that there is "upmix" feature when
mout->num_dacs is 4 for those 5 jacks/6 jacks motherboard

i.e. the black and orange jacks can have the same signal as the green jack

	/* front */
	snd_hda_codec_setup_stream(codec, nids[HDA_FRONT], stream_tag,
				   0, format);
	if (!mout->no_share_stream &&
	    mout->hp_nid && mout->hp_nid !=3D nids[HDA_FRONT])
		/* headphone out will just decode front left/right (stereo) */
		snd_hda_codec_setup_stream(codec, mout->hp_nid, stream_tag,
					   0, format);
	/* extra outputs copied from front */
	for (i =3D 0; i < ARRAY_SIZE(mout->extra_out_nid); i++)
		if (!mout->no_share_stream && mout->extra_out_nid[i])
			snd_hda_codec_setup_stream(codec,
						   mout->extra_out_nid[i],
						   stream_tag, 0, format);

	/* surrounds */
	for (i =3D 1; i < mout->num_dacs; i++) {
		if (chs >=3D (i + 1) * 2) /* independent out */
			snd_hda_codec_setup_stream(codec, nids[i], stream_tag,
						   i * 2, format);
		else if (!mout->no_share_stream) /* copy front */
			snd_hda_codec_setup_stream(codec, nids[i], stream_tag,
						   0, format);
	}
	return 0;
}

> but in via_independent_hp_put():
>
>
> =A0 =A0 =A0 =A0unsigned int pinsel =3D ucontrol->value.enumerated.item[0];
> =A0 =A0 =A0 =A0/* Get Independent Mode index of headphone pin widget */
> =A0 =A0 =A0 =A0spec->hp_independent_mode =3D spec->hp_independent_mode_in=
dex =3D=3D pinsel
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0? 1 : 0; /* <- TROUBLES! */
>
>
> When turning on Independent HP mode for codec VT1718S, pinsel is 1,
> when turning it off that's 0, thus, if spec->hp_independent_mode_index
> is 2, spec->hp_independent_mode is always 0 (condition
> spec->hp_independent_mode_index =3D=3D pinsel alwyas fails) and
> corresponding controls can't be activated:
>
>
> =A0 =A0 =A0 =A0/* update HP volume/swtich active state */
> =A0 =A0 =A0 =A0if (spec->codec_type =3D=3D VT1708S
> =A0 =A0 =A0 =A0 =A0 =A0|| spec->codec_type =3D=3D VT1702
> =A0 =A0 =A0 =A0 =A0 =A0|| spec->codec_type =3D=3D VT1718S
> =A0 =A0 =A0 =A0 =A0 =A0|| spec->codec_type =3D=3D VT1716S
> =A0 =A0 =A0 =A0 =A0 =A0|| VT2002P_COMPATIBLE(spec)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0activate_ctl(codec, "Headphone Playback Vo=
lume",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->hp_independ=
ent_mode);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0activate_ctl(codec, "Headphone Playback Sw=
itch",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spec->hp_independ=
ent_mode);
> =A0 =A0 =A0 =A0}
>

if the hp jack can also use "copy front" mode for "redirected headphone"

the driver don't need to disable "Headphone Playback Volume" for those
10 channels codecs or change the connection in
via_independent_hp_put()

For those 3 jacks motherobard, "channel mode" 6-8 or "Use HP as Side"
switch may just need tot switch the connection to use 0x0b or 0x0c if
0b has  "Side Playback Volume" and 0x0c has "Headphone Playback
Volume"
