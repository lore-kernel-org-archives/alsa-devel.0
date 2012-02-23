From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH] hda - add id for Atom Cedar Trail HDMI
 codec
Date: Thu, 23 Feb 2012 11:31:45 +0100
Message-ID: <1329993105.3678.11.camel@mattotaupa>
References: <20120223070744.GA5505@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4837145473945635498=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id 4950624398
	for <alsa-devel@alsa-project.org>; Thu, 23 Feb 2012 11:31:51 +0100 (CET)
In-Reply-To: <20120223070744.GA5505@localhost>
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
Cc: Wu Fengguang <fengguang.wu@intel.com>
List-Id: alsa-devel@alsa-project.org


--===============4837145473945635498==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-7DX8PuvUljWQ66ZFL+sX"


--=-7DX8PuvUljWQ66ZFL+sX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Fengguang,


Am Donnerstag, den 23.02.2012, 15:07 +0800 schrieb Wu Fengguang:
> Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>

as always I am confused what is your first name and what is the surname.

Intel email messages seem to be <$fristname.$lastname@intel.com>. So if
Wu is your last name you should put a =C2=BB,=C2=AB behind Wu in your Mutt
configuration and adapt your Git configuration with the following
command.

    git config --global user.name "Fengguang Wu"

> ---
>  sound/pci/hda/patch_hdmi.c |    2 ++
>  1 file changed, 2 insertions(+)
>=20
> --- sound.orig/sound/pci/hda/patch_hdmi.c	2012-02-23 14:51:19.562540743 +=
0800
> +++ sound/sound/pci/hda/patch_hdmi.c	2012-02-23 15:05:51.774522844 +0800
> @@ -1913,6 +1913,7 @@ static const struct hda_codec_preset snd
>  { .id =3D 0x80862805, .name =3D "CougarPoint HDMI",	.patch =3D patch_gen=
eric_hdmi },
>  { .id =3D 0x80862806, .name =3D "PantherPoint HDMI", .patch =3D patch_ge=
neric_hdmi },
>  { .id =3D 0x808629fb, .name =3D "Crestline HDMI",	.patch =3D patch_gener=
ic_hdmi },
> +{ .id =3D 0x80862880, .name =3D "CedarTrail HDMI",	.patch =3D patch_gene=
ric_hdmi },
>  {} /* terminator */
>  };
> =20
> @@ -1959,6 +1960,7 @@ MODULE_ALIAS("snd-hda-codec-id:80862804"
>  MODULE_ALIAS("snd-hda-codec-id:80862805");
>  MODULE_ALIAS("snd-hda-codec-id:80862806");
>  MODULE_ALIAS("snd-hda-codec-id:808629fb");
> +MODULE_ALIAS("snd-hda-codec-id:80862880");
> =20
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("HDMI HD-audio codec");

Thank you for your patch.

Next time it would be nice, if you could add some test information to
the commit message.


Thanks,

Paul


[1] http://cn.linkedin.com/pub/fengguang-wu/2b/587/b18
[2] http://www.igi-global.com/chapter/advanced-operating-systems-kernel-app=
lications/37951

--=-7DX8PuvUljWQ66ZFL+sX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk9GFZEACgkQPX1aK2wOHVjwQACeJEY29AswEx3ipn0YSFVTO7LC
UTQAn3jbid5nfbRvnlBjYbq+PZX6eYB6
=no3A
-----END PGP SIGNATURE-----

--=-7DX8PuvUljWQ66ZFL+sX--


--===============4837145473945635498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4837145473945635498==--
