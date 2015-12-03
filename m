From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: mediatek: Use current HW pointer for
 pointer callback
Date: Thu, 3 Dec 2015 11:01:58 +0000
Message-ID: <20151203110158.GD5727@sirena.org.uk>
References: <1449129208-63615-1-git-send-email-koro.chen@mediatek.com>
 <s5h8u5b98dp.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h8u5b98dp.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Koro Chen <koro.chen@mediatek.com>, lgirdwood@gmail.com, alsa-devel@alsa-project.org, srv_heupstream@mediatek.com, s.hauer@pengutronix.de, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 03, 2015 at 10:41:38AM +0100, Takashi Iwai wrote:

> While reading this patch, I wondered how regmap can be used safely in
> an irq-disabled context.  Mark, do we have any API for that?

We can use user supplied locks or spin_lock_irqsave().

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWYCElAAoJECTWi3JdVIfQxuQH/2+4Rg+bjjkDIhG3WyP590im
+3LgsYKs+AsNmr32773UhmFT9zrRsRSPuI/2ZSJ91Aix1wPCCeepng/fKYOMcDq/
lrhnfgLXIgjj/tLbwKdJz/TL5JC4/njjM1hS582B4iRIBOzee2EYwcodjvnF58jf
ClRCQexacKMeVeNv6qsXfBOxfYAYuIx7Fhh3nythUDe4UKDZqf/OWmJLTaymgLVW
uaYkBay9qHuIWrCw6Fp3XOAJmvgjhZGkioRd80ByUPXhVPoFiU7bEe2b3trV6ZhC
nRdNPngqebxasxBfcYo1XM7ipvVrzjcop02gmwuo1FdIeOlxb/kxTlB530QC3i8=
=yCNK
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
