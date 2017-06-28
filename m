From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: nau8825: devicetree for crosstalk
	bypass
Date: Wed, 28 Jun 2017 19:14:15 +0100
Message-ID: <20170628181415.gj6cc4jn47636hf6@sirena.org.uk>
References: <1498460028-12314-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8673693642984887835=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C25AA266838
 for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2017 20:14:32 +0200 (CEST)
In-Reply-To: <1498460028-12314-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <supercraig0719@gmail.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, benzh@chromium.org, mac.chiang@intel.com, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============8673693642984887835==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="t5mqk2enkiy2tmot"
Content-Disposition: inline


--t5mqk2enkiy2tmot
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 26, 2017 at 02:53:48PM +0800, John Hsu wrote:

> +  - nuvoton,crosstalk-bypass: make crosstalk function bypass if set 1.

This should just be a boolean property, no need for a value.

--t5mqk2enkiy2tmot
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllT8fcACgkQJNaLcl1U
h9Aj+wf9EFbIYtbzdweOEXxajHOJgfDpsgjfZystR5e2hfFvCAb+tTBxxLIzBr3z
msaj0JnI3jSaqe7cKLdM4i2kCtXlBCTDc2BSxv5ov+MKeA3CFv90kg0nfHh/nzaL
Siw2086mGBTBD9glyFCRhGX/CSVASAcBOX8c1IVTtO6Z77yPHc0nbYoF+6JeHgil
ramq7yBavzbI0CjUj6V1oLFzp8mgwwbsRJKJU6aqzhNGRmA9DUhcO4LyElyxdiWK
tmv/xFaHre4M1xZqv9CHdrDkiyK8Oc2kkKgzF+3dY1fkN8DBfr0D3WFTZb/5w3Ug
+pZcrVskU6BnM5whNCujSGphgEVfEg==
=GJgk
-----END PGP SIGNATURE-----

--t5mqk2enkiy2tmot--

--===============8673693642984887835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8673693642984887835==--
