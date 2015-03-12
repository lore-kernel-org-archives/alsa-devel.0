From: Vasil Zlatanov <vasil.zlatanov@gmail.com>
Subject: Re: Microphone Not Working after Suspend on Apple
 MacBookAir5, 2 Cirrus Logic CS4206
Date: Thu, 12 Mar 2015 20:53:13 +0100
Message-ID: <20150312195313.GC12398@airon>
References: <20150311222600.GA2927@airon>
 <s5hlhj27b68.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9205275347298822784=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F4E8260614
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 20:53:21 +0100 (CET)
Received: by labmn12 with SMTP id mn12so18330842lab.0
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 12:53:18 -0700 (PDT)
In-Reply-To: <s5hlhj27b68.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============9205275347298822784==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kfjH4zxOES6UT95V"
Content-Disposition: inline


--kfjH4zxOES6UT95V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

(Reply to all) Applied patches against 3.18.6-1 successfully and both of
the described issues were resolved :).=20

* sorry Takashi for double reply

On Thu, Mar 12, 2015 at 11:38:39AM +0100, Takashi Iwai wrote:
> At Wed, 11 Mar 2015 23:26:00 +0100,
> Vasil Zlatanov wrote:
> >=20
> > Issue as seen on reddit thread:
> > https://www.reddit.com/r/linux/comments/1kccbk/alsa_bug_driving_me_craz=
y_please_help/
> >=20
> > A common problem for Apple Macbook Air 5.2 users where microphone does=
=20
> > not work after system resume. As users have noted microphone starts=20
> > working ones again when the volume is changed in alsa-mixer.=20
> >=20
> > alsa-info dumps are attached showing before and after being adjusted
> > (where before causes microphone not to work while in after it does)
> >=20
> > IRC user 'debianuser' kindly helped out and found that using the two
> > following commands fix the issue:
> >=20
> > amixer -cPCH set "Capture" 0% nocap=20
> > amixer -cPCH set "Capture" 100% cap                                    =
 =20
> >=20
> > In my experience both are required and they seem to have the same effect
> > as manually changing the volume level in alsamixer, and as such resolve
> > the issue (until another suspend when they have to be run again).
>=20
> This might be due to the single ADC amp.  The ADC widgets have
> multiple inputs and usually they have individual amp volumes.  But
> some codecs give only a single volume for all inputs.
>=20
> There is a flag in the driver to change the control for that.  The
> patch below enables it.
>=20
> diff --git a/sound/pci/hda/patch_cirrus.c b/sound/pci/hda/patch_cirrus.c
> index 1589c9bcce3e..dd2b3d92071f 100644
> --- a/sound/pci/hda/patch_cirrus.c
> +++ b/sound/pci/hda/patch_cirrus.c
> @@ -584,6 +584,7 @@ static int patch_cs420x(struct hda_codec *codec)
>  		return -ENOMEM;
> =20
>  	spec->gen.automute_hook =3D cs_automute;
> +	codec->single_adc_amp =3D 1;
> =20
>  	snd_hda_pick_fixup(codec, cs420x_models, cs420x_fixup_tbl,
>  			   cs420x_fixups);
>=20
> Alternatively, you can pass "single_adc_smp =3D true" hint in the
> firmware patch passed via patch option.  See
> Documentation/sound/alsa/HD-Audio.txt for details.
>=20
>=20
> > As of now I'm resolving this issue by creating a service that is to run
> > after resume from susspend with the given amixer commands to renable the
> > microphone.
> >=20
> > The second issue, which is also in the reddit thread, is that the
> > microphine is mono and when recording only right channel audio is seen.
> > For me this broke programs such as mumble and skype.
> >=20
> > A alsa-info output with coefficients is attached.
> >=20
> > 'debianuser' managed to find a solution to this issue well, resolving it
> > by running the following two commands:
> >=20
> > hda-verb /dev/snd/hwC0D0 0x11 SET_COEF_INDEX 2
> > hda-verb /dev/snd/hwC0D0 0x11 SET_PROC_COEF 0x102a
> >=20
> > After one runs them a single time after boot, the channels collectly
> > show and programs issues are resolved. 'debianuser' mentions that the
> > sources for the commands are available in the kernel and applied to the
> > macbook 8.1 model, but not to mine.
>=20
> Yes, it's the very same workaround for MBP8,1.  You can pass
> model=3Dmbp81 option.  If it works, you can just add a sline to
> cs420x_fixup_tbl[] something like
>=20
> @@ -393,6 +393,7 @@ static const struct snd_pci_quirk cs420x_fixup_tbl[] =
=3D {
>  	SND_PCI_QUIRK(0x106b, 0x1c00, "MacBookPro 8,1", CS420X_MBP81),
>  	SND_PCI_QUIRK(0x106b, 0x2000, "iMac 12,2", CS420X_IMAC27_122),
>  	SND_PCI_QUIRK(0x106b, 0x2800, "MacBookPro 10,1", CS420X_MBP101),
> +	SND_PCI_QUIRK(0x106b, 0x5600, "MacBookAir 5,2", CS420X_MBP81),
>  	SND_PCI_QUIRK(0x106b, 0x5b00, "MacBookAir 4,2", CS420X_MBA42),
>  	SND_PCI_QUIRK_VENDOR(0x106b, "Apple", CS420X_APPLE),
>  	{} /* terminator */
>=20
>=20
>=20
> Takashi

--kfjH4zxOES6UT95V
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVAe6pAAoJEO5QSAKJUTTF8S0H/RDlIqT14COcjVgTrGf4Q5GJ
Uh7+9BODJlG1EGssUpU0jD/izzPOzHXFm/zceRdiPvKV8wu7vKMQpnDw6GL5v4GS
uhCQ4NTy/rwzfHBQHAIg7kL3KYKv0BGK7zWZYZuuvq8mtegAYA2CyTxvjLhc1vm9
k/3ktHnDHKmJoD6NGNoAzlGwuNeO6prkUiXh+sD0JXx7bRku+dxJFAwXfzg9CwBd
Ybd9VuYp4KEy4cpQefRaDlMtW9vp3joQEwsLjDw5rWN+wPGkE3li2H++lAL/GrLO
hjP/IxivCAMNZVLxuIeTCxQlLO5ftnFzMyTL7Opey74UiDdgzDEiKvbwQSdYsg8=
=/QX1
-----END PGP SIGNATURE-----

--kfjH4zxOES6UT95V--

--===============9205275347298822784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9205275347298822784==--
