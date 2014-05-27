From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v5] ASoC: sgtl5000: Fix the cache handling
Date: Tue, 27 May 2014 12:22:46 +0100
Message-ID: <20140527112246.GT12304@sirena.org.uk>
References: <1401111260-23320-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0304381680921550171=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FD9D265529
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 13:23:07 +0200 (CEST)
In-Reply-To: <1401111260-23320-1-git-send-email-fabio.estevam@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <fabio.estevam@freescale.com>
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============0304381680921550171==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IK/5xRxqPaC+itfG"
Content-Disposition: inline


--IK/5xRxqPaC+itfG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2014 at 10:34:20AM -0300, Fabio Estevam wrote:
> Since commit e5d80e82e32e (ASoC: sgtl5000: Convert to use regmap directly=
) a=20
> kernel oops is observed after a suspend/resume sequence.
>=20
> The kernel oops happens inside sgtl5000_restore_regs() as codec->reg_cach=
e is no
> longer a valid pointer.

Applied, thanks.

--IK/5xRxqPaC+itfG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJThHWDAAoJELSic+t+oim9wwsP/3tWkQhk+5qXhzjEKSLBgDGJ
yZslXSmjmK6KRZfUwVg/eEsU98cIhTu3o6mfZc+38JBWtpb6m7cu3kphWQHKcEyp
4riKvnK8HeAMDfkxzvOPr7TvumidsnQohY9gEHH+e2mmEmdq1C7abQ1lbSSLOmRu
2N+Jx++fl9OEnCDog9y3CRsF7tAe8ux5RpFRE7IuTsJBnF5TSEVvghQ5+N0xK7HM
RjFPHcZau6gc50kH6RdEkNvEGmJQzhVNfHXZvFUX6xUZp0Ods/vv9K8HYtlnlNNg
uMa/o7OTA3nWnPEowbzhiOkO7UFMvwjxVOp+hNEt54G+qYrEUeb1GSXvbCiKXJfN
3t+1gXshu7G9dyi3rnAW2vENfJMzKkwop0Y0wiInG9EVLQl7I3GRUs/FcI0Oc3z3
3F3Hv0TygA/Kluz8H+YclSDMqYZF9qgjWAWVeEKxh80kSJ8T6CTDcNcqYJZ5gZuB
KKSFXOHc0LmbMzFlnHgFelFLJPEUaB34cP5Dq+5/Iohl3YnJcx2CJ9mpMrbornkF
Zz3oeSAWomOWrX19zQn3l83jDBG0e2xu7m+S8LKjkBc3EszyDlilL6x9DWTMs51M
4ynhyw/Rxuqk4feQKZjUXDepnhAoAq/S1pCjVwPjHgET0eycB0SsrkpkYq3ulyvS
ErUVwfOCrpVCjK/W2BCZ
=IW5P
-----END PGP SIGNATURE-----

--IK/5xRxqPaC+itfG--

--===============0304381680921550171==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0304381680921550171==--
