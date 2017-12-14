From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 00/13] Introduce framework for SLIMbus
	device driver
Date: Thu, 14 Dec 2017 17:25:49 +0000
Message-ID: <20171214172549.GJ9788@sirena.org.uk>
References: <20171211234307.14465-1-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9035778121517833051=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 000C226732A
 for <alsa-devel@alsa-project.org>; Thu, 14 Dec 2017 18:25:51 +0100 (CET)
In-Reply-To: <20171211234307.14465-1-srinivas.kandagatla@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: srinivas.kandagatla@linaro.org
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org, j.neuschaefer@gmx.net, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, pombredanne@nexb.com, sdharia@codeaurora.org
List-Id: alsa-devel@alsa-project.org


--===============9035778121517833051==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="j+MD90OnwjQyWNYt"
Content-Disposition: inline


--j+MD90OnwjQyWNYt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 11, 2017 at 11:42:54PM +0000, srinivas.kandagatla@linaro.org wr=
ote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>=20
> SLIMbus (Serial Low Power Interchip Media Bus) is a specification
> developed by MIPI (Mobile Industry Processor Interface) alliance.
> SLIMbus is a 2-wire implementation, which is used to communicate with
> peripheral components like audio-codec.

Reviwed-by: Mark Brown <broonie@kernel.org>

This all looks pretty good to me, I might've missed some stuff as this
is a fairly large series but I can't see there would be anything major
and re-reading it again definitely isn't going to help with that so
let's get it merged!

--j+MD90OnwjQyWNYt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAloytBwACgkQJNaLcl1U
h9CcaQgAghpHRKy9ciUCNXadKvvOgQZ7QZf0D+VwM8n2B4NYKIGunXzmee6i5iN+
kSBkIVL+7y1APnKqAQCEqLUb9ZgxCnLkUGTkR3RYRI9+n7ttvkwMDUYJ771vnDCb
oU0is8SxIQuVVsr7J1tMvxjppq45UyLpKaw0tS9Bt40U+ImfTQUy3gjDHI1LqTdD
I2gFoLqq4/novmhhPvUKpn2kd7kl9WZDefiLZG7/LDlze2mwaZiAZ+DpB2hVjBjM
vDFKzeyX1cFeuYdBYH6jSb2Sgl/sfbQZS3WHK78UNNPoH1HJvq3po7GJ4E0jPEns
ntqvncKWk+vzJoSrrpy/TZjmv2GT8w==
=mqpg
-----END PGP SIGNATURE-----

--j+MD90OnwjQyWNYt--

--===============9035778121517833051==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9035778121517833051==--
