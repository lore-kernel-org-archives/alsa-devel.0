From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: S3C2412: suspend and resume support
Date: Tue, 20 Nov 2007 14:08:59 +0100
Message-ID: <20071120130859.GL31205@lug-owl.de>
References: <20071120123334.GA27701@fluff.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4433240998334178184=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lug-owl.de (lug-owl.de [195.71.106.12])
	by alsa0.perex.cz (Postfix) with ESMTP id B2F3F24A1C
	for <alsa-devel@alsa-project.org>; Tue, 20 Nov 2007 14:08:59 +0100 (CET)
In-Reply-To: <20071120123334.GA27701@fluff.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ben Dooks <ben-alsa@fluff.org>
Cc: Liam Girwood <liam.girdwood@opensource.wolfsonmicro.com>, ALSA Devel List <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Vincent Sanders <vince@simtec.co.uk>
List-Id: alsa-devel@alsa-project.org


--===============4433240998334178184==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aYrjF+tKt+ApYAdb"
Content-Disposition: inline


--aYrjF+tKt+ApYAdb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-11-20 12:33:34 +0000, Ben Dooks <ben-alsa@fluff.org> wrote:
> --- linux-2.6.24-rc3-asoc1/sound/soc/s3c24xx/s3c2412-i2s.c	2007-11-19 21:=
28:16.000000000 +0000
> +++ linux-2.6.24-rc3-asoc2/sound/soc/s3c24xx/s3c2412-i2s.c	2007-11-20 12:=
29:46.000000000 +0000
> @@ -381,7 +385,7 @@ static int s3c2412_i2s_trigger(struct sn
>  	case SNDRV_PCM_TRIGGER_START:
>  		/* On start, ensure that the FIFOs are cleared and reset. */
> =20
> -		writel(capture ? S3C2412_IISFIC_RXFLUSH : S3C2412_IISFIC_TXFLUSH,
> +		writel(capture ? S3C2412_IISFIC_RXFLUSH : S3C2412_IISFIC_TXFLUSH  ,
                                                                           =
   ^^^^^^
Uh?

>  		       s3c2412_i2s.regs + S3C2412_IISFIC);
> =20
>  		/* clear again, just in case */

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:         Alles wird gut! ...und heute wirds schon ein bi=C3=9F=
chen besser.
the second  :

--aYrjF+tKt+ApYAdb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHQtxrHb1edYOZ4bsRAnOwAJ4s1YyUSrmP92RS//bjLuVc2dpkeQCdFT1a
JE+94CE1ySJOWxJniSNs49I=
=0Sjd
-----END PGP SIGNATURE-----

--aYrjF+tKt+ApYAdb--

--===============4433240998334178184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4433240998334178184==--
