From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: add dio2125 amplifier support
Date: Wed, 8 Mar 2017 11:00:20 +0100
Message-ID: <20170308100020.dop5pno3m2sj6fmv@sirena.org.uk>
References: <20170306174451.24406-1-jbrunet@baylibre.com>
 <1488903977.28627.4.camel@baylibre.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5824730129033249059=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 47FFF267044
 for <alsa-devel@alsa-project.org>; Wed,  8 Mar 2017 11:00:35 +0100 (CET)
In-Reply-To: <1488903977.28627.4.camel@baylibre.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--===============5824730129033249059==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7vk47e7bvsnganlx"
Content-Disposition: inline


--7vk47e7bvsnganlx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Mar 07, 2017 at 05:26:17PM +0100, Jerome Brunet wrote:
> Hi Mark,

Please don't top post, reply in line with needed context.  This allows
readers to readily follow the flow of conversation and understand what
you are talking about and also helps ensure that everything in the
discussion is being addressed.

> In this series, you applied patch 2 and 3 but not patch 1.
> (so the dioo prefix is used but not documented)

> Is it on purpose ?
> The patch does not have the "ASoC" prefix, this maybe why it was
> missed. Since, the file does no belong to alsa, I wasn't sure whether
> to put the prefix or not.

This is a generic DT patch, not part of the bindings, so I'd expect the
DT maintainers to take it.

--7vk47e7bvsnganlx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAli/1jAACgkQJNaLcl1U
h9ByKgf9Eit2EVynjCrirpq/lrV2Vf/9l9lZmwFwcpukLnyfSTEncqO2RPNKxR4h
ndiUpM2vUyMSRnYKHiZFzx+ENvFScF013QbLuq5G1FlMCruqpB28hhnZMzcq8e+f
aNBN9lvkqd/zQhq3kibC4Za3T8BWZVpQk9yzsNWScY1rT+3lluwpdqT2XqyYyqc7
rPgQv54kIatRq94+cc7cZUGx+IJ6fXSxPrYDv1b5fkFqko2VY4Ja3Pi69D8t1bNb
I1ZjN69ud9z7IBuvS50T1UoNsJ3nKj6a3FBE6Tzvtw5X9Cs5QOu+mLWVL4JK8i0O
9eh6TlitMEDtBjvgmPS7gRSJg3ks8w==
=Tpig
-----END PGP SIGNATURE-----

--7vk47e7bvsnganlx--

--===============5824730129033249059==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5824730129033249059==--
