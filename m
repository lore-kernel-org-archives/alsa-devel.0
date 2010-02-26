From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [Regression] With the new 2.6.33 when I plug in
 headphones, the speakers don't turn off anymore
Date: Fri, 26 Feb 2010 23:34:42 +0100
Message-ID: <1267223682.3648.16.camel@mattotaupa>
References: <hm82oh$1am$1@dough.gmane.org>
	<1267176828.3751.12.camel@mattotaupa> <hm8aat$shn$1@dough.gmane.org>
	<hm8afm$shn$2@dough.gmane.org> <1267184543.3802.13.camel@mattotaupa>
	<4B87D414.5050409@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5810169783499892222=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 1EECA103827
	for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2010 23:34:51 +0100 (CET)
In-Reply-To: <4B87D414.5050409@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org


--===============5810169783499892222==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-+8lfoNR2lYyYkXTavPb+"


--=-+8lfoNR2lYyYkXTavPb+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Freitag, den 26.02.2010, 15:00 +0100 schrieb giggzounet:
> Paul Menzel a =C3=A9crit :
> > Am Freitag, den 26.02.2010, 12:15 +0100 schrieb giggzounet:
> >> [snip]
> >>
> >>>> I do not know why enable_msi is set to =C2=BB-1=C2=AB and not one si=
nce it should
> >>>> be enabled by default now [1]. Could you try to load the sound modul=
e
> >>>> with `enable_msi` set to `0` and report back your findings, please.
> >>>>
> >>>>         $ sudo modinfo snd-hda-intel
> >>>>         [=E2=80=A6]
> >>>>         parm:           enable_msi:Enable Message Signaled Interrupt=
 (MSI) (int)
> >>>>         [=E2=80=A6]
> >>>>
> >>> I have modified /etc/modprobe.d/sound with :
> >>> snd-hda-intel index=3D0 enable_msi=3D0
> >>>
> >>> I attach the log of alsa-info.
> >>>
> >> I have forgotten to say that the problem is always here with
> >> enable_msi=3D0
> >>
> >> [snip]
> >=20
> > That=E2=80=99s unfortunate. It would have been nice if this had fixed i=
t.
>=20
> I have take a look to the history of changes of hda_intel.f and found tha=
t :
> http://git.kernel.org/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco=
mmit;h=3D0a27fcfaaf61108d94f0377f91bed81b2dd35f52
>=20
> in the source I'm seeing a blacklist :
> /*
>  * white/black-list for enable_msi
>  */
> static struct snd_pci_quirk msi_black_list[] __devinitdata =3D {
> 	SND_PCI_QUIRK(0x1043, 0x81f2, "ASUS", 0), /* Athlon64 X2 + nvidia */
> 	SND_PCI_QUIRK(0x1043, 0x81f6, "ASUS", 0), /* nvidia */
> 	{}
> };
>=20
> And on my eeepc 1201n there is lot's of nvidia things...How can I know
> if I'm on this blacklist or not ? ...sorry, I don't have a lot of
> knowledge in C. But this could be explain why msi is not enabled by
> default...

Just to make it clear. I am also stabbing in the dark here and do not
know what those options actually do. I just saw the difference in the
outputs of `alsa-info.sh`. Maybe you can try to load `snd-hda-intel`
with `enable_msi=3D1` to enable it explicitly and try it? But I emphasize
again that this MSI issue might not be related to your problem at all.

Anyway, looking at the output of `alsa-info.sh` which executes I think
`lspci -vnn` we find your IDs. (I just looked through the file and
=E2=80=9Cgrepped=E2=80=9D it just to include it here.

        $ grep "PCI Vendor" -A4 alsa-info_2.6.33.log=20
        !!Advanced information - PCI Vendor/Device/Susbsystem ID's
        !!--------------------------------------------------------
       =20
        00:08.0 0403: 10de:0ac0 (rev b1)
        	Subsystem: 1043:83ce

So those quirks you listed do not apply to your system. Searching for
your device ID=E2=80=99s in the tree reveals the following.

        sound-2.6/sound/pci/hda$ grep -Ri 83ce *
        patch_realtek.c:	SND_PCI_QUIRK(0x1043, 0x83ce, "ASUS P1005HA", ALC2=
69_DMIC),

`ALC269_DMIC` turns up in `patch_realtek.c` in the following places.

        sound-2.6/sound/pci/hda$ more patch_realtek.c=20
        /*
         * configuration and preset
         */
        static const char *alc269_models[ALC269_MODEL_LAST] =3D {
                [ALC269_BASIC]                  =3D "basic",
                [ALC269_QUANTA_FL1]             =3D "quanta",
                [ALC269_AMIC]                   =3D "laptop-amic",
                [ALC269_DMIC]                   =3D "laptop-dmic",
                [ALC269_FUJITSU]                =3D "fujitsu",
                [ALC269_LIFEBOOK]               =3D "lifebook",
                [ALC269_AUTO]                   =3D "auto",
        };
        [=E2=80=A6]
                [ALC269_DMIC] =3D {
                        .mixers =3D { alc269_laptop_mixer },
                        .cap_mixer =3D
        alc269_laptop_digital_capture_mixer,
                        .init_verbs =3D { alc269_init_verbs,
                                        alc269_laptop_dmic_init_verbs },
                        .num_dacs =3D ARRAY_SIZE(alc269_dac_nids),
                        .dac_nids =3D alc269_dac_nids,
                        .hp_nid =3D 0x03,
                        .num_channel_mode =3D ARRAY_SIZE(alc269_modes),
                        .channel_mode =3D alc269_modes,
                        .unsol_event =3D alc269_laptop_unsol_event,
                        .setup =3D alc269_laptop_dmic_setup,
                        .init_hook =3D alc269_laptop_inithook,
                },

But I have not clue what that all does. I do not know if and when
Takashi or some other dev will have time to answer, but until then you
could ask on IRC or try to figure out if something changed there or in
the function it calls. I think `git annotate` comes to your rescue here.


Sorry, that I cannot help you further. Thanks,

Paul

--=-+8lfoNR2lYyYkXTavPb+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkuITHsACgkQPX1aK2wOHVgzugCfXVPTUcG9fdERR/rBWXatUlZM
7agAnjYB7rhxf/erWR7zfnlpR1TPgXrw
=0dVw
-----END PGP SIGNATURE-----

--=-+8lfoNR2lYyYkXTavPb+--


--===============5810169783499892222==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5810169783499892222==--
