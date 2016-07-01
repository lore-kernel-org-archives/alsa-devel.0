From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/6] ASoC: samsung: Add Samsung Low
 Power Audio Subsystem driver
Date: Fri, 1 Jul 2016 17:07:09 +0200
Message-ID: <20160701150709.GT6247@sirena.org.uk>
References: <1466678715-19962-1-git-send-email-s.nawrocki@samsung.com>
 <1466678715-19962-3-git-send-email-s.nawrocki@samsung.com>
 <20160629215757.GX6247@sirena.org.uk>
 <577553FE.6080803@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7153767638174936463=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 219502614E3
 for <alsa-devel@alsa-project.org>; Fri,  1 Jul 2016 17:07:25 +0200 (CEST)
In-Reply-To: <577553FE.6080803@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: robh@kernel.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, inki.dae@samsung.com, Beomho Seo <beomho.seo@samsung.com>, ideal.song@samsung.com
List-Id: alsa-devel@alsa-project.org


--===============7153767638174936463==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8c7vHYlrYOebzgj6"
Content-Disposition: inline


--8c7vHYlrYOebzgj6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 30, 2016 at 07:16:46PM +0200, Sylwester Nawrocki wrote:

> Sorry, I didn't notice this e-mail earlier.  With previous Exynos versions
> the LPASS (or AudioSS) was mainly about the embedded audio DSP processor
> (at least WRT to SFRs), which was not required for boards supported in=20
> the mainline kernel. Since e.g. Exynos5433 the LPASS SFR region contains=
=20
> also entries related to other IP blocks, like I2S or DMAC.  Even though=
=20
> functionality covered by these registers is still rather trivial, like=20
> SW resets and unmasking interrupts, it's essential for the whole audio=20
> subsystem operation. The intention was to have in future the LPASS driver=
=20
> covering any functionality provided by the embedded audio dedicated MCU.
> I'm afraid we have to handle those power sequences in central place to
> ensure proper SoC operation. I would also rather avoid adding any exynos=
=20
> quirks to the PL330 DMAC driver.=20

Hrm.  This is sounding a bit like a combination of a power domain and
an interrupt controller, would something like that fit in perhaps?
Depends on how many of these trivial bits there are I think...

--8c7vHYlrYOebzgj6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXdoccAAoJECTWi3JdVIfQh+kH/i9aFuoU8o+j/zXrUtjiGEJZ
8z+D4pLohJPf48YHDeqZ0TZYxjHjJh9Z2Qu+uc5cfGF95MTKOzwMhFExub6b9fz/
b7bWjibkMaj1sKQCGkOSb9+sR3dvqJYhwmsHDbL8nmCq7+hHYCz7+D7Mp8SOe7K4
6k46pf71cj/Ugo1U0BFcFqSgao3DxwALqjD5YDxpBQCTMkZ0aCBAA77CV42UHsmk
h4wR2busVxyFY+2VEGHQIN7BmSWngzowRCys6Rc2UAZSSKWxeBBYsd1qjZTyTe+e
9Zrs7QIcCNS6CJBY81We/d2+xFxAR75yQwT5ByAMdVQwTVYd3S+z79xDXiAjKzQ=
=2Zer
-----END PGP SIGNATURE-----

--8c7vHYlrYOebzgj6--

--===============7153767638174936463==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7153767638174936463==--
