From: Kip Warner <kip@thevertigo.com>
Subject: Re: Patch for ALC882
Date: Sun, 20 Jan 2008 18:04:07 -0800
Message-ID: <1200881047.6980.25.camel@kip-laptop>
References: <1200361715.6964.12.camel@kip-laptop>
	<s5hsl0z2ybq.wl%tiwai@suse.de> <1200434828.8884.1.camel@kip-laptop>
	<s5htzleug4z.wl%tiwai@suse.de> <1200625227.7715.20.camel@kip-laptop>
	<s5hk5m78w2y.wl%tiwai@suse.de> <1200639924.7715.31.camel@kip-laptop>
	<s5hprvzcv2m.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1289376153560340518=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from defout.telus.net (defout.telus.net [199.185.220.240])
	by alsa0.perex.cz (Postfix) with ESMTP id B9C88244D3
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 03:04:11 +0100 (CET)
In-Reply-To: <s5hprvzcv2m.wl%tiwai@suse.de>
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
Cc: pshou@realtek.com.tw, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============1289376153560340518==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-xIUN5Qe+48eNcQbCV88t"


--=-xIUN5Qe+48eNcQbCV88t
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2008-01-18 at 11:00 +0100, Takashi Iwai wrote:

> The necessary changes are likely only what's in the below.
> Could you try it with the latest HG version, or the latest daily
> snapshot tarball?
>=20
>=20
> Takashi
>=20
> diff -r 1cb5fe1b2443 pci/hda/patch_realtek.c
> --- a/pci/hda/patch_realtek.c	Thu Jan 17 17:44:49 2008 +0100
> +++ b/pci/hda/patch_realtek.c	Fri Jan 18 08:28:15 2008 +0100
> @@ -5645,7 +5645,9 @@ static struct hda_verb alc882_asus_a7j_v
> =20
>  	{0x18, AC_VERB_SET_CONNECT_SEL, 0x02}, /* mic/clfe */
>  	{0x1a, AC_VERB_SET_CONNECT_SEL, 0x01}, /* line/surround */
> -	{0x1b, AC_VERB_SET_CONNECT_SEL, 0x00}, /* HP */
> +	{0x1b, AC_VERB_SET_CONNECT_SEL, 0x00}, /* line */
> +	{0x1b, AC_VERB_SET_PIN_WIDGET_CONTROL, PIN_IN},
> +	{0x1b, AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE},
>  	{ } /* end */
>  };
> =20
> @@ -5969,7 +5971,8 @@ static struct alc_config_preset alc882_p
>  	[ALC882_ASUS_A7J] =3D {
>  		.mixers =3D { alc882_asus_a7j_mixer, alc882_chmode_mixer,
>  			    alc882_capture_mixer },
> -		.init_verbs =3D { alc882_init_verbs, alc882_asus_a7j_verbs},
> +		.init_verbs =3D { alc882_init_verbs, alc882_asus_a7j_verbs,
> +				alc880_gpio1_init_verbs },
>  		.num_dacs =3D ARRAY_SIZE(alc882_dac_nids),
>  		.dac_nids =3D alc882_dac_nids,
>  		.dig_out_nid =3D ALC882_DIGOUT_NID,

I just applied your patch against the latest alsa-driver-hg20080120
bzip'd tarball. I tried it both with and without the patch and both ways
produce proper four speaker sound. Please let me know if I can be of any
further assistance.

--=20
Kip Warner -- Software Engineer
OpenPGP encrypted/signed mail preferred
http://www.thevertigo.com

--=-xIUN5Qe+48eNcQbCV88t
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHk/2XC5QMQlLfBOsRArONAJ4ovP3hOZCg+vJWaGpMftxrfhEIkQCdE31S
ngmgm6SnUStdeEGbiLMWncI=
=9DqQ
-----END PGP SIGNATURE-----

--=-xIUN5Qe+48eNcQbCV88t--


--===============1289376153560340518==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============1289376153560340518==--
