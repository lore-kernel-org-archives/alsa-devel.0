From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: tlv320aic32x4: Add Switch for
 Setting Common Mode Voltage
Date: Thu, 4 Apr 2019 12:43:22 +0700
Message-ID: <20190404054322.GM5748@sirena.org.uk>
References: <20190404040155.29246-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8809829235383631639=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C1169F8071D
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2019 07:43:27 +0200 (CEST)
In-Reply-To: <20190404040155.29246-1-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Annaliese McDermond <nh6z@nh6z.net>
Cc: alsa-devel@alsa-project.org, team@nwdigitalradio.com
List-Id: alsa-devel@alsa-project.org


--===============8809829235383631639==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4ybNbZnZ8tziJ7D6"
Content-Disposition: inline


--4ybNbZnZ8tziJ7D6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 03, 2019 at 09:01:54PM -0700, Annaliese McDermond wrote:
> Add a switch for setting common mode voltage.  This can allow
> for higher drive levels on the amplifier outputs.

Should this be runtime controllable or is this something that's likely
to be fixed by the board design?

--4ybNbZnZ8tziJ7D6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlylmXcACgkQJNaLcl1U
h9AFrQf9HGTt5lhxjQ1HVHvVNDSNGOodAbnl04t1FYFDnn+jcFfK7SQaY5ReRhm0
u7DYKTILN2EqRalmqqHbPKl2gOy3uoqyvwSQF7kE28s2QeQqdAEnFs6RqD4sRoth
iymA4uqsbBzq/BvVhOi4zT2VrEEgeQN/UwA3kh3u+vaJF/LTX4LhE0PwgpSi41RT
qA1ss4iWQoxw7NZ3Nfz2OhancnsKAkGqCn34KGRAOboMnR/eFG4zokAXhJ5RqsZb
x2WuLnbRVdm+RNEZIel1gzWp5FtziHOAERGix8CSMMz3tewz6WLhbIJcOAXzeduZ
85zpw14iLx4sheFVJeyCiLGwwxR9fg==
=WY8S
-----END PGP SIGNATURE-----

--4ybNbZnZ8tziJ7D6--

--===============8809829235383631639==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8809829235383631639==--
