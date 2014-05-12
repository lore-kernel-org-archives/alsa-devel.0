From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5640: add default case for
	unexpected ID
Date: Mon, 12 May 2014 22:09:41 +0100
Message-ID: <20140512210941.GX12304@sirena.org.uk>
References: <1399362966-19908-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0502507553063613490=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9DB09265171
 for <alsa-devel@alsa-project.org>; Mon, 12 May 2014 23:09:51 +0200 (CEST)
In-Reply-To: <1399362966-19908-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, swarren@wwwdotorg.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============0502507553063613490==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gmHUB1IiSbxoxvGT"
Content-Disposition: inline


--gmHUB1IiSbxoxvGT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2014 at 03:56:06PM +0800, bardliao@realtek.com wrote:
> From: Bard Liao <bardliao@realtek.com>
>=20
> We may read an unexpected value when detemining which codec is attached.
> In that case, either a unsupported codec is attached or something wrong=
=20
> with I2C. The driver will not work properly on both cases. So we return
> an error for that.

Applied, thanks.

--gmHUB1IiSbxoxvGT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTcTiSAAoJELSic+t+oim9bd0P/A3cAgLYQIEbFD75QhghZKNT
qGwOXVLO2qChpe0zXV2+Nc9aB0RpnfmroeIZRAh7OtjmWaPDg9oG2w6ESp1gavQR
dSygTbTlf5hKeKSUuWPp2D8+xE6s/26TJ3anQ6RZqHPYP+9B36yePPA9g+56cdig
NiS4m/op6j0tOeOmsIgKV8j3XsKtXUUNIrqSrPY6rlVxk4Cs++7ZgMF3DYcetVei
of2znKh1g5fvyvk+661Q4mghQkqjdWKMrF7c4Rv+WwJpp3wbv2FpQA8X6VdH9KuK
WWfuqG1WK1xR0BYjvx+nUDH9c4Hj0Sv9pUh26aQrbnWgkfbSkkMfjRByxsB/UnXg
b3HLxRP0tlkh+B4FbPYR1bQ7CP0MPo4/vmLbpSR1jhxCPQ4QlB5ovoKXGyxAPdoX
JE7OefGM+ilfCxRElCSAGv1BOe1xROUC2FKPD+1TXDpqPII0R2TrX6GjhdfLMUdi
jdM0MmX6n9zPdUfo7pG10NKEpZwwancdJGcYkjOf22LdZbyFPcW06VJEmXQIVpgD
PKXmrXf4GpXfuL02q/j2svm9PcCMESNItB9ALp+h2ALFFOFpQJgCUl4d2O+k9thS
dgax0lrKmj3ag4VTJFTY7zfJKuhZlN5gEbvEUKcWh6kTJ3sIAY4Bpp6MeItL2vQS
xOuoqLeOmqVvE3qiU7XG
=CNWm
-----END PGP SIGNATURE-----

--gmHUB1IiSbxoxvGT--

--===============0502507553063613490==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0502507553063613490==--
