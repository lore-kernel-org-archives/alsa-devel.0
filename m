From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_spdif: Don't try to round-up for clock divisor
 calculation
Date: Mon, 25 May 2015 12:58:12 +0100
Message-ID: <20150525115812.GG21391@sirena.org.uk>
References: <1432455161-4924-1-git-send-email-nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ov6R7U0hl+EAcYoD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1432455161-4924-1-git-send-email-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, fabio.estevam@freescale.com, zidan.wang@freescale.com
List-Id: alsa-devel@alsa-project.org


--ov6R7U0hl+EAcYoD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 24, 2015 at 01:12:41AM -0700, Nicolin Chen wrote:
> As commit 6c8ca30eec7b ("ASoC: fsl_ssi: Don't try to round-up for PM
> divisor calculation") mentioned that there's no more need to use a
> round up work around to get a better divisor since the clk-divider
> driver has been refined a lot.

Applied, thanks.

--ov6R7U0hl+EAcYoD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVYw5TAAoJECTWi3JdVIfQ1PsH/1DoaslX7SwxMS299PW1fdPU
dbNxwOQLCyNfrN2UwKfu44I0VlVfiksuHQMtbPZfqI3ioGMwPd+OyAxmyu5oWFc3
yJp1VvXGQPmBvkKyLfkX/EVFcsHwkotIPXq76GvWG7eq9PDXPsGkK5kGOwW2FVe5
skd0wg1NxvoF84Lc6nBb16/ea0EP5ODDX5L6BUZzFVD4XshC02zclBUmDc9vlYuA
aGdy7gHinhq52Cs4B/VMJe9m6iQKcnCoWIUovVbf1mMDRFR+KjuhnsxQIRPpgk4L
MMDmWV0sqdTHkAg0XpRhjAB4Yub0NccpDQv5kOANXbPTfdou8V3XEv6pKIgdJZo=
=qEqZ
-----END PGP SIGNATURE-----

--ov6R7U0hl+EAcYoD--
