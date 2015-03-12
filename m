From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5645: Add TDM support for rt5650
Date: Thu, 12 Mar 2015 19:19:18 +0000
Message-ID: <20150312191918.GX28806@sirena.org.uk>
References: <1426163107-32363-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4440858436079251182=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 67D43265884
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2015 20:19:24 +0100 (CET)
In-Reply-To: <1426163107-32363-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, john.lin@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============4440858436079251182==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3KjGcObhCP65ZtLm"
Content-Disposition: inline


--3KjGcObhCP65ZtLm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 12, 2015 at 08:25:07PM +0800, Bard Liao wrote:
> rt5650 and rt5645 use different register bits for TDM configuration.
> This patch modifies rt5645_set_tdm_slot to support both codecs.

Applied, thanks.

--3KjGcObhCP65ZtLm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVAea1AAoJECTWi3JdVIfQFPMH/2L/I5i45JdoCHSLJYBwBa+2
0QWWP/3kyvRmPEednITyUJv2NMsJPoTSczgIxW2Tg9vKE05JZycyYIF0hvVczOzy
jksHWr32xU/uFS55FI8AcZ+wGfXT1MAx8zlSpBtj+Cr1yW/YEPiRnFqwmDFIzgnv
Z/+6hjhkVclboU7KDF86XwsiC0IZjbLSaxtRbgfs48AW5WIUDcoFpsaxmRYCPH3A
XJPBEffdtTNqXVvq/ZtcnSvBNPfww8nyEuvFzb1XWOH06LpGyv+lYgt8cehBgk7m
Z0y0pSqMjQh9JCV6YwQ9AEagxs42/uShARN/uke/JnTc2rjWBLcvy16WVB+qnak=
=1gRO
-----END PGP SIGNATURE-----

--3KjGcObhCP65ZtLm--

--===============4440858436079251182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4440858436079251182==--
