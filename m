From: Denis Kup <dener.kup@gmail.com>
Subject: Re: Acer Aspire 7730G support
Date: Mon, 24 Aug 2009 21:23:17 +0400
Message-ID: <376f0d430908241023s14aa12cbl5a6ecc12202b5f13@mail.gmail.com>
References: <376f0d430906240509w7b8e23d4m92e3fc99fabd528@mail.gmail.com>
	<s5heit9ajvk.wl%tiwai@suse.de>
	<376f0d430906240941k699e494cr325f1c091a609f19@mail.gmail.com>
	<376f0d430906241052i1e37904bo9c90b98e0dca6077@mail.gmail.com>
	<d54969c50906241339u7a4a41cbvbc66643e794436b9@mail.gmail.com>
	<376f0d430906241436k20912428o3cd8ea5d83b300ce@mail.gmail.com>
	<376f0d430908240610h55c7afb8kb77a4cf2289d53b8@mail.gmail.com>
	<s5h3a7hpcer.wl%tiwai@suse.de>
	<376f0d430908240857k7c03a392x187fdbb9488757d3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 66DF2243AD
	for <alsa-devel@alsa-project.org>;
	Mon, 24 Aug 2009 19:23:20 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e21so545469fga.21
	for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2009 10:23:18 -0700 (PDT)
In-Reply-To: <376f0d430908240857k7c03a392x187fdbb9488757d3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
List-Id: alsa-devel@alsa-project.org

2009/8/24 Takashi Iwai <tiwai@suse.de>
>
> At Mon, 24 Aug 2009 17:10:10 +0400,
> Denis Kup wrote:
> >
> > Sorry, I was very busy last two months. We don't finish with this theme.
> > What about my patch?
>
> Please check with the latest sound GIT tree (or alsa-driver snapshot)
> whether it still work and repost the patch. =A0There have been lots of
> changes in HD-audio driver code, so an old patch might not work any
> more.
>
>
> thanks,
>
> Takashi

I tested patch with alsa-driver-1.0.20.40.g13311.579.gcf341. All works
as it should.

It's diff between patched version( patch_realtek_new.c ) and unpatched:

dener@linux-wpg9:~/Documents/1> diff ./patch_realtek_new.c ./patch_realtek_=
old.c
223d222
<=A0=A0=A0=A0=A0=A0 ALC888_ACER_ASPIRE_7730G,
8341,8366d8339
< static struct hda_verb alc888_acer_aspire_7730G_verbs[] =3D {
<=A0=A0=A0=A0=A0=A0 {0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
<=A0=A0=A0=A0=A0=A0 {0x17, AC_VERB_SET_CONNECT_SEL, 0x02},
<=A0=A0=A0=A0=A0=A0 {0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT =
| AC_USRSP_EN},
<=A0=A0=A0=A0=A0=A0 { } /* end */
< };
<
< static void alc888_acer_aspire_7730G_front_automute(struct hda_codec *cod=
ec)
< {
<=A0=A0=A0=A0=A0=A0 unsigned int present;
<
<=A0=A0=A0=A0=A0=A0 present =3D snd_hda_codec_read(codec, 0x15, 0,
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AC_VERB_GET_PIN_SENSE, 0) &
0x80000000;
<=A0=A0=A0=A0=A0=A0 snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 HDA_AMP_MUTE, present ? HDA_AMP_MUTE
: 0);
<=A0=A0=A0=A0=A0=A0 snd_hda_codec_amp_stereo(codec, 0x17, HDA_OUTPUT, 0,
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 HDA_AMP_MUTE, present ? HDA_AMP_MUTE : 0);
< }
<
< static void alc888_acer_aspire_7730G_unsol_event(struct hda_codec *codec,
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unsigned int res)
< {
<=A0=A0=A0=A0=A0=A0 if ((res >> 26) =3D=3D ALC880_HP_EVENT)
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 alc888_acer_aspire_7730G_front_=
automute(codec);
< }
<
8558d8530
<=A0=A0=A0=A0=A0=A0 [ALC888_ACER_ASPIRE_7730G]=A0=A0=A0=A0=A0 =3D "acer-asp=
ire-7730g",
8605d8576
<=A0=A0=A0=A0=A0=A0 SND_PCI_QUIRK(0x1025, 0x0142, "Acer Aspire 7730G",
ALC888_ACER_ASPIRE_7730G),
9094,9107d9064
<=A0=A0=A0=A0=A0=A0 },
<=A0=A0=A0=A0=A0=A0 [ALC888_ACER_ASPIRE_7730G] =3D {
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .mixers =3D { alc883_3ST_6ch_mi=
xer, alc883_chmode_mixer },
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .init_verbs =3D { alc883_init_v=
erbs,
alc888_acer_aspire_7730G_verbs },
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .num_dacs =3D ARRAY_SIZE(alc883=
_dac_nids),
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .dac_nids =3D alc883_dac_nids,
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .dig_out_nid =3D ALC883_DIGOUT_=
NID,
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .dig_in_nid =3D ALC883_DIGIN_NI=
D,
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .num_channel_mode =3D ARRAY_SIZ=
E(alc883_3ST_6ch_modes),
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .channel_mode =3D alc883_3ST_6c=
h_modes,
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .need_dac_fix =3D 1,
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .input_mux =3D &alc883_capture_=
source,
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .unsol_event =3D alc888_acer_as=
pire_7730G_unsol_event,
<=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 .init_hook =3D alc888_acer_aspi=
re_7730G_front_automute,
