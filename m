From: alex dot baldacchino dot alsasub at gmail dot com
	<alex.baldacchino.alsasub@gmail.com>
Subject: Re: Via VT2020: issues with kernel 2.6.38.{2,
 3} (alsa 1.0.23) - working with 2.6.33.2 (alsa 1.0.21)
Date: Mon, 20 Jun 2011 15:48:24 +0200
Message-ID: <BANLkTin54Tr3R9cG8thKv1YCT6bFCvnhHg@mail.gmail.com>
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
	<BANLkTinXc3TR=zxzaQKSx=UKdSFrnLct=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id A5DFA2444B
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 15:48:26 +0200 (CEST)
Received: by wyb40 with SMTP id 40so638228wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2011 06:48:26 -0700 (PDT)
In-Reply-To: <BANLkTinXc3TR=zxzaQKSx=UKdSFrnLct=w@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/6/20 Raymond Yau <superquad.vortex2@gmail.com>:
> 2011/6/20 alex dot baldacchino dot alsasub at gmail dot com
>>>
>
> Take a look at playback_multi_pcm_prep_0() in patch_via.c , it seem
> this "copy front" mode is enabled by default in via codecs
>
>
> =A0 =A0 =A0 =A0/* front */
> =A0 =A0 =A0 =A0snd_hda_codec_setup_stream(codec, nids[HDA_FRONT], stream_=
tag,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 0, fo=
rmat);
>
> =A0 =A0 =A0 =A0if (mout->hp_nid && mout->hp_nid !=3D nids[HDA_FRONT]
> =A0 =A0 =A0 =A0 =A0 =A0&& !spec->hp_independent_mode)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* headphone out will just decode front le=
ft/right (stereo) */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_setup_stream(codec, mout->hp=
_nid, stream_tag,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 0, format);
>
> =A0 =A0 =A0 =A0/* extra outputs copied from front */
> =A0 =A0 =A0 =A0for (i =3D 0; i < ARRAY_SIZE(mout->extra_out_nid); i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (mout->extra_out_nid[i])
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_setup_stream=
(codec,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 mout->extra_out_nid[i],
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 stream_tag, 0, format);
>
> =A0 =A0 =A0 =A0/* surrounds */
> =A0 =A0 =A0 =A0for (i =3D 1; i < mout->num_dacs; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (chs >=3D (i + 1) * 2) /* independent o=
ut */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_setup_stream=
(codec, nids[i], stream_tag,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 i * 2, format);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else /* copy front */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0snd_hda_codec_setup_stream=
(codec, nids[i], stream_tag,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 0, format);
> =A0 =A0 =A0 =A0}
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

Yes, I had noticed it, but before seeing that line, I went out crazy
thinking mout->extra_out_nid was initialized somewhere in the code (in
the driver) and used in this function... Lastly, I found that place:
Nowhere Land, LOL!

I must be needing some new glasses, LOL.
