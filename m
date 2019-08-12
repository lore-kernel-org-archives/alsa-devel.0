From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: ti: davinci-mcasp: Protect hw_params
 callback against race
Date: Mon, 12 Aug 2019 14:01:07 +0100
Message-ID: <20190812130107.GJ4592@sirena.co.uk>
References: <20190812095304.19030-1-peter.ujfalusi@ti.com>
 <20190812111332.GH4592@sirena.co.uk>
 <20154773-1cf8-4e2e-a248-f3dfb29a5024@ti.com>
 <20190812115751.GI4592@sirena.co.uk>
 <4055fa34-c6b8-5b47-c728-54e65ef0f16c@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3794624682202806812=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2985EF800F6
 for <alsa-devel@alsa-project.org>; Mon, 12 Aug 2019 15:01:08 +0200 (CEST)
In-Reply-To: <4055fa34-c6b8-5b47-c728-54e65ef0f16c@ti.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, jsarha@ti.com, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org


--===============3794624682202806812==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Xssso5lpTBgMxDfe"
Content-Disposition: inline


--Xssso5lpTBgMxDfe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 12, 2019 at 03:56:11PM +0300, Peter Ujfalusi wrote:
> On 12/08/2019 14.57, Mark Brown wrote:
> > On Mon, Aug 12, 2019 at 02:46:33PM +0300, Peter Ujfalusi wrote:

> >> to card level could substitute (new mutex on the card for pcm operations
> >> probably) the need to handle this in drivers.

> >> We would need to change soc-core/pcm/compress for this.

> > Yeah, it'd be a reasonably substantial change.

> OK, works fine on several boards, I'll send a patch tomorrow after a bit
> more testing.

Ah, excellent, thanks for that!  That was more of a "we should do this"
thing than a "do this instead" thing but obviously fixing more systems
is even better so please don't let me stop you.  Only sending applied
mails when I push things out solves one set of problems but does make
for other races :/

--Xssso5lpTBgMxDfe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl1RYxIACgkQJNaLcl1U
h9DcxggAgkCTz8igdchM7COXCZBPAt9/smtbOoA0ovffaDpRrZxbKRQHtfSnt5Nm
ABoGFH9ZTjXK7lLHh2oSIRs98vQ8/Z+J2WFSdrq37DF/VFZ96sEneBM3LdP62Ora
xOYhn+w6blFr++atHAMBQIVwbXvf+YYfw2LZFLNp2TITCyf2vNggnqv+ewAjDF24
uyfpnXcVa8uU1WN/mUMrD82mj7PXkGZLsXaArwUR+Fm5mPcQRbjfe/IG7+jn6do9
XIxzEUAc8LdU/4IL+8S9MrGY+neDMFejXWPBHBTZ+QT7B0RDYGRFjYE+TiHDOtG4
9rpBKu+nk6kJ6H/dub+FypV8YsIOXw==
=BT1C
-----END PGP SIGNATURE-----

--Xssso5lpTBgMxDfe--

--===============3794624682202806812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3794624682202806812==--
