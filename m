From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 14/19] ASoC: tlv320aic31xx: Remove
 regulator notification handling
Date: Fri, 1 Dec 2017 15:55:33 +0000
Message-ID: <20171201155533.ayjzh4wxokwlbtsy@sirena.org.uk>
References: <20171129213300.20021-1-afd@ti.com>
 <20171129213300.20021-15-afd@ti.com>
 <20171201133604.6v3ychahwvlaygxi@sirena.org.uk>
 <216ac36e-772a-0919-67cc-86589d3916fc@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0714516517714184540=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 33E45267029
 for <alsa-devel@alsa-project.org>; Fri,  1 Dec 2017 16:55:38 +0100 (CET)
In-Reply-To: <216ac36e-772a-0919-67cc-86589d3916fc@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Andrew F. Davis" <afd@ti.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Tony Lindgren <tony@atomide.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============0714516517714184540==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="adpueagi53trpasx"
Content-Disposition: inline


--adpueagi53trpasx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 01, 2017 at 09:01:19AM -0600, Andrew F. Davis wrote:

> Looking into the call sites, at least in this case the only time this
> notification will be called, outside the normal enable/disable paths
> (which do the same thing here: turn on regmap cache only mode and mark
> it dirty), will be during a force disable scenario.

If all the disable sites in the driver mark the cache dirty then they
should be fixed not to.

--adpueagi53trpasx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlohe3UACgkQJNaLcl1U
h9DyVwf/Txy0JVTNnMSj8TemYe3Rp5XRmDAY8up7HMPbDPYYxfgQIET52AM1gpDl
sVAoNq3svyGPb1iwP75H2ygdN1JoV/ybfvOHBRZ+99RRo4PZr8oCz8B6i85Gxa1X
6310wE9rsSypV3OZ50S6Py2H4qLxF1kZI4UkMCemOGcnQsGmKNtTCpmjOIqtcY/E
mWSbz7VbZ0yBrd1It2pJJ7RSenVm6qixz4OkMASLmJR/ArDqYFAfpa6wH3OWYipA
16KQxjayJ6sxVWzfrHJCznBpH6SSzezguWIv6fcYbajqYEI2GBO5lkrXpc5tYR9U
p05syTc7WKSn/DE+bstipL8ibL7yjw==
=n0Kw
-----END PGP SIGNATURE-----

--adpueagi53trpasx--

--===============0714516517714184540==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0714516517714184540==--
