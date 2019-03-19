From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/13] ASoC: tlv320aic32x4: Remove sysclk
	references
Date: Tue, 19 Mar 2019 15:37:22 +0000
Message-ID: <20190319153722.GI5514@sirena.org.uk>
References: <20190319033756.20616-1-nh6z@nh6z.net>
 <20190319033756.20616-11-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0324063544667397936=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 102CDF8968A
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 16:37:24 +0100 (CET)
In-Reply-To: <20190319033756.20616-11-nh6z@nh6z.net>
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


--===============0324063544667397936==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Op27XXJsWz80g3oF"
Content-Disposition: inline


--Op27XXJsWz80g3oF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 18, 2019 at 08:37:53PM -0700, Annaliese McDermond wrote:

> Sysclk is not used by anything anymore.  Remove support for it.
> All that information now comes from the clock tree.

Have you checked for existing users here?  If the operation is removed
existing users will get errors, not all of them will be prepared for
that.

--Op27XXJsWz80g3oF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyRDLEACgkQJNaLcl1U
h9AM3Af/TwOYlpF64aGRjCTcQz3GOQxKIeCeGetuFrLCI6DWXtHsUQZJGUNZICpu
Zy0ifVSLCgpkd8QbhzbyrIFvYgYXPdIvQGOmps3vuA0IQWebqzC4G60I3w6L5YSc
XXBrfW++AXXpdqQfZpeB8l9NudqJ54WckQM+SnK6I9us4REJIwbzgPbuREsIqdnq
Zbx95ewlEZT+57/RrknZji7nIRiUPRN3peSzMM2WT1a2vrAmXIXQCwxPy05gBUfw
Y5j6psnfg9YTTc6pzV3+0YQx3aH3+GAZ5HfeIHKrLc99ghBiIMo/HWO7ROkbb56s
3/is3GHLoL/g1+/2q4sPeF2ae/EnrA==
=jheB
-----END PGP SIGNATURE-----

--Op27XXJsWz80g3oF--

--===============0324063544667397936==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0324063544667397936==--
