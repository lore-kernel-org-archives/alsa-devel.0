From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Mon, 20 Jun 2011 15:13:02 +0800
Message-ID: <BANLkTinXc3TR=zxzaQKSx=UKdSFrnLct=w@mail.gmail.com>
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
	<BANLkTi=e2L+XDj51KQCaBGH4r+_0ST5r+A@mail.gmail.com>
	<BANLkTi=t6--XhAwBBQ7saOj=qswbiOj+cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 5B98B1037FF
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 09:13:02 +0200 (CEST)
Received: by fxm5 with SMTP id 5so2192374fxm.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2011 00:13:02 -0700 (PDT)
In-Reply-To: <BANLkTi=t6--XhAwBBQ7saOj=qswbiOj+cQ@mail.gmail.com>
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

2011/6/20 alex dot baldacchino dot alsasub at gmail dot com
>>
>> Can your hear the same signal from black and orange jack when you
>> playing stereo to hw:0,0,0 ?
>>
>> if you look at snd_hda_multi_out_analog_prepare() in hda_codec.c,
>>
>> if mout->no_share_stream=3D0 ,it seem that there is "upmix" feature when
>> mout->num_dacs is 4 for those 5 jacks/6 jacks motherboard
>>
>> i.e. the black and orange jacks can have the same signal as the green ja=
ck
>>
>> =A0 =A0 =A0 =A0/* front */
>> =A0 =A0 =A0 =A0snd_hda_codec_setup_stream(codec, nids[HDA_FRONT], stream=
_tag,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, f=
ormat);
>> =A0 =A0 =A0 =A0if (!mout->no_share_stream &&
>> =A0 =A0 =A0 =A0 =A0 =A0mout->hp_nid && mout->hp_nid !=3D nids[HDA_FRONT])
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* headphone out will just decode front l=
eft/right (stereo) */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_setup_stream(codec, mout->h=
p_nid, stream_tag,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0, format);
>> =A0 =A0 =A0 =A0/* extra outputs copied from front */
>> =A0 =A0 =A0 =A0for (i =3D 0; i < ARRAY_SIZE(mout->extra_out_nid); i++)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!mout->no_share_stream && mout->extra=
_out_nid[i])
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_setup_strea=
m(codec,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 mout->extra_out_nid[i],
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 stream_tag, 0, format);
>>
>> =A0 =A0 =A0 =A0/* surrounds */
>> =A0 =A0 =A0 =A0for (i =3D 1; i < mout->num_dacs; i++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (chs >=3D (i + 1) * 2) /* independent =
out */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_setup_strea=
m(codec, nids[i], stream_tag,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 i * 2, format);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else if (!mout->no_share_stream) /* copy =
front */
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_setup_strea=
m(codec, nids[i], stream_tag,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 0, format);
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0return 0;
>> }
>>
>
>
> I fear I cannot test it the best way (I've got a 5.1 system, but have
> some 'logistic' problems using it). I've made an attempt by using two
> headphones, connected as follows:
>
> 1) one to (rear) green jack, one to orange,
> 2) one to green, one to black,
> 3) one to orange, one to black,
>
> and played a short two-channels file with aplay -Dhw:0,0,0 stereo.wav
> a few times, in each case I was able to here (same) sound from both
> headsets.
>
> However, it would seem to me that snd_hda_multi_out_analog_prepare()
> is not used by VIA Codecs, instead, some pcm operations are defined
> within patch_via.c and used by each codec, e.g.
>

Take a look at playback_multi_pcm_prep_0() in patch_via.c , it seem
this "copy front" mode is enabled by default in via codecs


	/* front */
	snd_hda_codec_setup_stream(codec, nids[HDA_FRONT], stream_tag,
				   0, format);

	if (mout->hp_nid && mout->hp_nid !=3D nids[HDA_FRONT]
	    && !spec->hp_independent_mode)
		/* headphone out will just decode front left/right (stereo) */
		snd_hda_codec_setup_stream(codec, mout->hp_nid, stream_tag,
					   0, format);

	/* extra outputs copied from front */
	for (i =3D 0; i < ARRAY_SIZE(mout->extra_out_nid); i++)
		if (mout->extra_out_nid[i])
			snd_hda_codec_setup_stream(codec,
						   mout->extra_out_nid[i],
						   stream_tag, 0, format);

	/* surrounds */
	for (i =3D 1; i < mout->num_dacs; i++) {
		if (chs >=3D (i + 1) * 2) /* independent out */
			snd_hda_codec_setup_stream(codec, nids[i], stream_tag,
						   i * 2, format);
		else /* copy front */
			snd_hda_codec_setup_stream(codec, nids[i], stream_tag,
						   0, format);
	}
