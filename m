From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 10/13] ASoC: tlv320aic32x4: Remove sysclk
 references
Date: Wed, 20 Mar 2019 16:27:04 +0000
Message-ID: <20190320162704.GB27518@sirena.org.uk>
References: <20190319033756.20616-1-nh6z@nh6z.net>
 <20190319033756.20616-11-nh6z@nh6z.net>
 <20190319153722.GI5514@sirena.org.uk>
 <C1BEBA27-6BDE-4172-98A7-E60FAF8D877D@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7220759821041220962=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3296F80791
 for <alsa-devel@alsa-project.org>; Wed, 20 Mar 2019 17:27:06 +0100 (CET)
In-Reply-To: <C1BEBA27-6BDE-4172-98A7-E60FAF8D877D@nh6z.net>
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


--===============7220759821041220962==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Content-Disposition: inline


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2019 at 09:18:01AM -0700, Annaliese McDermond wrote:

> > Have you checked for existing users here?  If the operation is removed
> > existing users will get errors, not all of them will be prepared for
> > that.

> I haven=E2=80=99t checked with existing users.  A better implementation m=
ay be
> that we just use clk_set_rate on whatever the sysclk is to set the
> upstream rate.  That way we can preserve compatibility.

Yes, that'd be the simplest thing.

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlySadgACgkQJNaLcl1U
h9D34Qf/X5vixOyEMcmLosLCaDP2PmjfLwM4jxVLPCq4kVOgw9ipFBe6XiHm+LT7
ctA4hl/w5V40UYQpX04SlFs1VyzcsRO0gqwpjvWwBYvv2fBjCwgPq7x+xR+XpR34
iPc0P6Yfn0smOM/OQXlxwSAKrPMj/xUPA9hOilRdTdNyKajQvIBoDEu1PJVZ4bXh
6MWUDOCR1OKpg/aoiX69jfHk+LK/8a13/SMv8lEp/OPtasHbWrdM1WD1a4RKXbTU
viKP+9etJ6plb4hes2V9o/6qWkgkog8g8+hGxEqw/6eT/P5OPMMIOgE4RR6eF3FU
WwNv+nrnIG5fLFBYvRCCrSyBW66s+A==
=AvsF
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--

--===============7220759821041220962==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7220759821041220962==--
