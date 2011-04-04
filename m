From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [PATCH 3/3 v3] alsa-lib: fixed coverity reported
 issues under "USE_AFTER_FREE" checker.
Date: Mon, 04 Apr 2011 11:12:51 +0200
Message-ID: <1301908371.3970.29.camel@mattotaupa>
References: <1301907239-1873-1-git-send-email-sudarshan.bisht@nokia.com>
	<1301907239-1873-3-git-send-email-sudarshan.bisht@nokia.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6085901499557298286=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gw90.de (mail.gw90.de [188.40.100.199])
	by alsa0.perex.cz (Postfix) with ESMTP id AA8481038EB
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Apr 2011 11:12:54 +0200 (CEST)
Received: from f053044031.adsl.alicedsl.de ([78.53.44.31]
	helo=[192.168.178.21])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69) (envelope-from <paulepanter@users.sourceforge.net>)
	id 1Q6fq9-0008R0-Uk
	for alsa-devel@alsa-project.org; Mon, 04 Apr 2011 09:12:54 +0000
In-Reply-To: <1301907239-1873-3-git-send-email-sudarshan.bisht@nokia.com>
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
List-Id: alsa-devel@alsa-project.org


--===============6085901499557298286==
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-zsGiBcsxy9cnmGLRc4F0"


--=-zsGiBcsxy9cnmGLRc4F0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Sudarshan,


Am Montag, den 04.04.2011, 11:53 +0300 schrieb sudarshan.bisht@nokia.com:

[=E2=80=A6]

> diff --git a/src/mixer/simple_abst.c b/src/mixer/simple_abst.c
> index 9e9aaf5..dd0dfa3 100644
> --- a/src/mixer/simple_abst.c
> +++ b/src/mixer/simple_abst.c
> @@ -336,6 +336,8 @@ int snd_mixer_simple_basic_register(snd_mixer_t
> *mixer,
>                 err =3D find_module(class, top);
>         if (err >=3D 0)
>                 err =3D snd_mixer_attach_hctl(mixer, priv->hctl);
> +               if (err < 0)=20
> +                        goto __error;         =20

There are still trailing white spaces at the end of both lines. The
following command should show these to you with red color.

	git log -p --color-words

>         if (err >=3D 0) {
>                 priv->attach_flag =3D 1;
>                 err =3D snd_mixer_class_register(class, mixer);


Thanks,

Paul

--=-zsGiBcsxy9cnmGLRc4F0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk2Zi5MACgkQPX1aK2wOHVhzRgCghPxkci47wehM8awfwltnTgV9
RXYAn0hQBoazowtUEzyI76idXQJcrg/3
=J1bc
-----END PGP SIGNATURE-----

--=-zsGiBcsxy9cnmGLRc4F0--


--===============6085901499557298286==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============6085901499557298286==--
