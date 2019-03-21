From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 02/11] ASoC: tlv320aic32x4: Model PLL in
	CCF
Date: Thu, 21 Mar 2019 15:12:08 +0000
Message-ID: <20190321151208.GA24351@sirena.org.uk>
References: <20190321023854.16947-1-nh6z@nh6z.net>
 <20190321023854.16947-3-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1944807982167406938=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C583F80C0F
 for <alsa-devel@alsa-project.org>; Thu, 21 Mar 2019 16:12:09 +0100 (CET)
In-Reply-To: <20190321023854.16947-3-nh6z@nh6z.net>
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


--===============1944807982167406938==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 20, 2019 at 07:38:45PM -0700, Annaliese McDermond wrote:
> Model and manage the on-board PLL as a component in the Core
> Clock Framework.  This should allow us to do some more complex
> clock management and power control.  Also, some of the
> on-board chip clocks can be exposed to the outside, and this
> change will make those clocks easier to consume by other
> parts of the kernel.

This doesn't apply against current code, please check and resend:

Applying: ASoC: tlv320aic32x4: Model PLL in CCF
Using index info to reconstruct a base tree...
M	sound/soc/codecs/Kconfig
M	sound/soc/codecs/Makefile
error: patch failed: sound/soc/codecs/tlv320aic32x4.c:722
error: sound/soc/codecs/tlv320aic32x4.c: patch does not apply
error: Did you hand edit your patch?
It does not apply to blobs recorded in its index.

I also had to apply the first patch for -next since it seems to depend
on other changes, like you said it's not a super important fix so that's
no big deal.

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyTqccACgkQJNaLcl1U
h9BoaAf/URQDj8u2k2dDVq3/pgazozkB2zSmhEviJhHaeO4zoZgtXx5tClYb9xMK
IPdvgV04XeNRkNheeLIM09oPrTzO5dmbNhsRlVtpFaqhUd8aVumOER4qQbXebXyJ
X9UaagitxvWu3phVmIIFRMp+QOwHUjcOGPGb+Rdn33IfVIXNau4eIG7vofLi8GeU
lAswZ773LteXmW5CR+8NTpj71i43RDEQsFRX1Q83g9SeDoy3VRetdnySETfjsFlQ
dn65tz3FqsI4IDQ+m4ek341UId3k9kfm6d+Fy22/QJJFi3IZufp2dPioQghbUBl4
p24hyJ+vYQr4kIbcef+YLTnz6E0lqA==
=D9+e
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--

--===============1944807982167406938==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1944807982167406938==--
