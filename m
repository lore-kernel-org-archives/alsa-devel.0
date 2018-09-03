From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic31xx: Add MICBIAS off
	setting
Date: Mon, 3 Sep 2018 12:26:56 +0100
Message-ID: <20180903112656.GF10302@sirena.org.uk>
References: <20180831180507.28867-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1357242101759875352=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 52BC42676C9
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 13:26:58 +0200 (CEST)
In-Reply-To: <20180831180507.28867-1-afd@ti.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
List-Id: alsa-devel@alsa-project.org


--===============1357242101759875352==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UBnjLfzoMQYIXCvq"
Content-Disposition: inline


--UBnjLfzoMQYIXCvq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 31, 2018 at 01:05:07PM -0500, Andrew F. Davis wrote:
> Leaving microphone bias off is a valid setting and even used in the DT
> binding document example. Add this setting here and document the same.
> Although it may not make much sense to enable a microphone here without
> any bias, it is a valid setting that can be chosen by DT and may be
> needed for some boards.

If we really want to pay attention to something setting this up we'd
need to completely remove the widget - what the code is doing at the
minute is setting the voltage that the bias will go to when enabled,
there's still a widget for turning it on and off.  There's some chance
that this will break existing boards.

--UBnjLfzoMQYIXCvq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluNGn8ACgkQJNaLcl1U
h9A6NQf9FIcD4SbCFvYGpIiui4wHjrOSFo04ImxUF1jAN578Ph5UsIi4GfFhfFDz
3z8ovw+6WC1R4o0KvI0VoInKHWEwib+CtPV329hdymhqoN9xOjZ+IElkIfILeInd
DOPf2o7x4n8YO1rNmuG5k61NrycD1+wpEwQKj9i7ArSPS5/FdqRMJPQz/0YL+DMr
2+MG8ntByql1MrlY34rWqDnChTRoe+JuoI5lFjXMP56Q4zX+aD9R7kgeAkkpg677
LzIFCkK2fq3PNYCufw5Mo77xBjMsolp1eVdDkAPCNaA58/3ceAzNoEXyEydF6a0I
yOEDUk7iuvnX9T2+cMVio2WD67bseg==
=4dIm
-----END PGP SIGNATURE-----

--UBnjLfzoMQYIXCvq--

--===============1357242101759875352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1357242101759875352==--
