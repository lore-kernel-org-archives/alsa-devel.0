From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fix platform_get_irq()
	error handling
Date: Fri, 17 Apr 2015 14:17:06 +0100
Message-ID: <20150417131706.GB11465@sirena.org.uk>
References: <1429067295-16052-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7331079378184706372=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EA278260578
 for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2015 15:17:46 +0200 (CEST)
In-Reply-To: <1429067295-16052-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: nicoleotsuka@gmail.com, Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org


--===============7331079378184706372==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ADZbWkCsHQ7r3kzd"
Content-Disposition: inline


--ADZbWkCsHQ7r3kzd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2015 at 12:08:15AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> We should check whether platform_get_irq() returns a negative number and
> propagate the error in this case.

Applied, thanks.

--ADZbWkCsHQ7r3kzd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVMQfSAAoJECTWi3JdVIfQ7uEH/0XmQw08ud6tfMq6cdLLDkK0
SElJnBvpIaIAJctOHpYJK4cse91hBX9Vt/I8cdoUhTfT6DAyFVfxWbdYja48hq7j
Tbgm2jS5w7U00WLrvFOq/O2YdHIseMWo3WTH6mXqOMBbN9NnWvouR1PdLKqRULm6
e9/kG8PZ4nkPm3gmulREHwi2mtYsr9xfduQY7apvgK47lc03YvTJucJLTHQ3j12v
CfZtvJAdYmPWmxp2KJZJS2kg38n7rJ77DNcGfdTZ14Rhh/aamuD02v2kDlQFM/t2
FJpXbiDFXEtfr4AAKs+Yz++P+csQROrdt+LQ61o00fz9vLuCOoyLNQp8bbaVVBU=
=eZDk
-----END PGP SIGNATURE-----

--ADZbWkCsHQ7r3kzd--

--===============7331079378184706372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7331079378184706372==--
