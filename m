From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: lochnagar: Add device tree
	binding document
Date: Wed, 20 Mar 2019 16:52:51 +0000
Message-ID: <20190320165251.GC27518@sirena.org.uk>
References: <20190320142813.12745-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8679090479219640682=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A97B3F80C13
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2019 17:52:54 +0100 (CET)
In-Reply-To: <20190320142813.12745-1-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, patches@opensource.cirrus.com, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org


--===============8679090479219640682==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline


--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 20, 2019 at 02:28:12PM +0000, Charles Keepax wrote:

> +  - clock-names : Must include the following clocks:
> +      "ln-sound-mclk" Master clock source for the sound card, should
> +      normally be set to LOCHNAGAR_SOUNDCARD_MCLK provided by the
> +      Lochnagar clock driver.

Why the namespacing on the clock name here?

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlySb+IACgkQJNaLcl1U
h9D1ywf9EIOMSyYqyyri/2a8CoFHzaIumJcYOiC6pSHaHBYiYzMbhVqeAXqg4C8F
p2ZvMy7Zhg0lsyVNU7TgKbzm3rriUb3gxnsDTV6qA5mKv5DcathD/NziOYlJV+Uf
2l9yg9oeyoqQ1H5s4ZG2uw7EuuNM6wb3wStwZ6gCHrLzgsW3r9ztogkWz0foFszz
cAyo6P+o+uaJuM1FtgfqT25G+yLmhCpAfYtzRnouzITNy3p5D7RR+sdTkyxG3pTD
6qohwVQGJKRQ8KV+o7zJYCtZK0m34B6wkmuUNfXn4qJU8k9Y8iJDGH1sXDVrLPyE
d2TtpFonUs7pOyK9tlW9wHYeIPbnew==
=7a3L
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--

--===============8679090479219640682==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8679090479219640682==--
