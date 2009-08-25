From: Denis Kup <dener.kup@gmail.com>
Subject: Re: Acer Aspire 7730G support
Date: Tue, 25 Aug 2009 16:01:15 +0400
Message-ID: <376f0d430908250501rda3b9baud60b3358fea1f6f0@mail.gmail.com>
References: <376f0d430906240509w7b8e23d4m92e3fc99fabd528@mail.gmail.com>
	<s5heit9ajvk.wl%tiwai@suse.de>
	<376f0d430906240941k699e494cr325f1c091a609f19@mail.gmail.com>
	<376f0d430906241052i1e37904bo9c90b98e0dca6077@mail.gmail.com>
	<d54969c50906241339u7a4a41cbvbc66643e794436b9@mail.gmail.com>
	<376f0d430906241436k20912428o3cd8ea5d83b300ce@mail.gmail.com>
	<376f0d430908240610h55c7afb8kb77a4cf2289d53b8@mail.gmail.com>
	<s5h3a7hpcer.wl%tiwai@suse.de>
	<376f0d430908240857k7c03a392x187fdbb9488757d3@mail.gmail.com>
	<s5hzl9o5tyf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.156])
	by alsa0.perex.cz (Postfix) with ESMTP id 9216A103806
	for <alsa-devel@alsa-project.org>;
	Tue, 25 Aug 2009 14:01:16 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 13so662874fge.21
	for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2009 05:01:16 -0700 (PDT)
In-Reply-To: <s5hzl9o5tyf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, =?ISO-8859-1?Q?Emilio_L=F3pez?= <buhitoescolar@gmail.com>
List-Id: alsa-devel@alsa-project.org

2009/8/25 Takashi Iwai <tiwai@suse.de>:
> At Mon, 24 Aug 2009 19:57:58 +0400,
> Denis Kup wrote:
>>
>> 2009/8/24 Takashi Iwai <tiwai@suse.de>
>>
>> > At Mon, 24 Aug 2009 17:10:10 +0400,
>> > Denis Kup wrote:
>> > >
>> > > Sorry, I was very busy last two months. We don't finish with this th=
eme.
>> > > What about my patch?
>> >
>> > Please check with the latest sound GIT tree (or alsa-driver snapshot)
>> > whether it still work and repost the patch. =A0There have been lots of
>> > changes in HD-audio driver code, so an old patch might not work any
>> > more.
>> >
>> >
>> > thanks,
>> >
>> > Takashi
>>
>>
>> I tested patch with alsa-driver-1.0.20.40.g13311.579.gcf341. All works a=
s it
>> should.
>
> Try rather with the snapshot tarball in
> =A0ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-drive=
r-snapshot.tar.gz
> The version you tried isn't the latest one.
>
>> It's diff between patched version( patch_realtek_new.c ) and unpatched:
>
> Make a patch with diff -u option (and better with -p, too).
>
>
>
> thanks,
>
> Takashi
>

I tested with new one. All is OK, but i found strange thing that was
before(with older versions). If i make boost level for front mic very
high, speakers starts
whistle ( I think you understand me). Is it normal, or not?

And diff:

dener@linux-wpg9:~/Documents/1> diff ./patch_realtek_new.c
./patch_realtek_old.c -u -p
--- ./patch_realtek_new.c       2009-08-25 13:44:34.000000000 +0400
+++ ./patch_realtek_old.c       2009-08-25 10:53:13.000000000 +0400
@@ -220,7 +220,6 @@ enum {
        ALC888_ACER_ASPIRE_4930G,
        ALC888_ACER_ASPIRE_6530G,
        ALC888_ACER_ASPIRE_8930G,
-       ALC888_ACER_ASPIRE_7730G,
        ALC883_MEDION,
        ALC883_MEDION_MD2,
        ALC883_LAPTOP_EAPD,
@@ -8473,32 +8472,6 @@ static struct hda_verb alc883_acer_eapd_
        { }
 };

-static struct hda_verb alc888_acer_aspire_7730G_verbs[] =3D {
-       {0x15, AC_VERB_SET_CONNECT_SEL, 0x00},
-       {0x17, AC_VERB_SET_CONNECT_SEL, 0x02},
-       {0x15, AC_VERB_SET_UNSOLICITED_ENABLE, ALC880_HP_EVENT |
AC_USRSP_EN},
-       { } /* end */
-};
-
-static void alc888_acer_aspire_7730G_front_automute(struct hda_codec
*codec)
-{
-       unsigned int present;
-
-       present =3D snd_hda_codec_read(codec, 0x15, 0,
-                                    AC_VERB_GET_PIN_SENSE, 0) &
0x80000000;
-       snd_hda_codec_amp_stereo(codec, 0x14, HDA_OUTPUT, 0,
-                                HDA_AMP_MUTE, present ? HDA_AMP_MUTE
: 0);
-       snd_hda_codec_amp_stereo(codec, 0x17, HDA_OUTPUT, 0,
-                                HDA_AMP_MUTE, present ? HDA_AMP_MUTE
: 0);
-}
-
-static void alc888_acer_aspire_7730G_unsol_event(struct hda_codec
*codec,
-                                          unsigned int res)
-{
-       if ((res >> 26) =3D=3D ALC880_HP_EVENT)
-               alc888_acer_aspire_7730G_front_automute(codec);
-}
-
 static void alc888_6st_dell_setup(struct hda_codec *codec)
 {
        struct alc_spec *spec =3D codec->spec;
@@ -8660,7 +8633,6 @@ static const char *alc882_models[ALC882_
        [ALC888_ACER_ASPIRE_4930G]      =3D "acer-aspire-4930g",
        [ALC888_ACER_ASPIRE_6530G]      =3D "acer-aspire-6530g",
        [ALC888_ACER_ASPIRE_8930G]      =3D "acer-aspire-8930g",
-       [ALC888_ACER_ASPIRE_7730G]      =3D "acer-aspire-7730g",
        [ALC883_MEDION]         =3D "medion",
        [ALC883_MEDION_MD2]     =3D "medion-md2",
        [ALC883_LAPTOP_EAPD]    =3D "laptop-eapd",
@@ -8707,7 +8679,6 @@ static struct snd_pci_quirk alc882_cfg_t
                ALC888_ACER_ASPIRE_6530G),
        SND_PCI_QUIRK(0x1025, 0x0166, "Acer Aspire 6530G",
                ALC888_ACER_ASPIRE_6530G),
-       SND_PCI_QUIRK(0x1025, 0x0142, "Acer Aspire 7730G",
ALC888_ACER_ASPIRE_7730G),
        /* default Acer -- disabled as it causes more problems.
         *    model=3Dauto should work fine now
         */
@@ -9209,20 +9180,6 @@ static struct alc_config_preset alc882_p
                .setup =3D alc889_acer_aspire_8930g_setup,
                .init_hook =3D alc_automute_amp,
        },
-       [ALC888_ACER_ASPIRE_7730G] =3D {
-               .mixers =3D { alc883_3ST_6ch_mixer, alc883_chmode_mixer },
-               .init_verbs =3D { alc883_init_verbs,
alc888_acer_aspire_7730G_verbs },
-               .num_dacs =3D ARRAY_SIZE(alc883_dac_nids),
-               .dac_nids =3D alc883_dac_nids,
-               .dig_out_nid =3D ALC883_DIGOUT_NID,
-               .dig_in_nid =3D ALC883_DIGIN_NID,
-               .num_channel_mode =3D ARRAY_SIZE(alc883_3ST_6ch_modes),
-               .channel_mode =3D alc883_3ST_6ch_modes,
-               .need_dac_fix =3D 1,
-               .input_mux =3D &alc883_capture_source,
-               .unsol_event =3D alc888_acer_aspire_7730G_unsol_event,
/* DENER CHANGE AUTOMUTE DECLARATION*/
-               .init_hook =3D alc888_acer_aspire_7730G_front_automute,
-       },
        [ALC883_MEDION] =3D {
                .mixers =3D { alc883_fivestack_mixer,
                            alc883_chmode_mixer },
