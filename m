From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: dapm: Modify widget stream name according to prefix
Date: Tue, 12 May 2015 19:07:39 +0100
Message-ID: <20150512180738.GN3066@sirena.org.uk>
References: <1431311813-37430-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N/GrjenRD+RJfyz+"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431311813-37430-1-git-send-email-koro.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, s.hauer@pengutronix.de, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--N/GrjenRD+RJfyz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 11, 2015 at 10:36:53AM +0800, Koro Chen wrote:
> When there is prefix specified, currently we will add this prefix in
> widget->name, but not in widget->sname.
> it causes failure at snd_soc_dapm_link_dai_widgets:

Applied, thanks.

--N/GrjenRD+RJfyz+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVUkFqAAoJECTWi3JdVIfQs+0H/RZvf/6+FqJqf/33naIp/cf3
DMD1iuPlxCJUxezEMofeoZXxSwGZP87bBrBjaZPJThOKtV2Cs9SgejcnQS38HCDB
kMdxrn0yXlt/vQG77mqVYnVJ6NJ+ivEOlaOdNPJAIVCi2QmZPGp9c5GNUN8kcRBi
xjED0aO37G7W6/XKwN/uyFK8qfEXIwg2Mm4K01llrQ7x/imAU92FG1dkGRw2tIXn
cGqjcFNfyTt+5lLQUzng3tW8xALBqo/Bv/hZWIsDqBqVjMhim1x1/7HgJ5uuNH9Z
w9ku5bEX9SCDZ/engev68pY4HH4AOsqGheDS3fGu0dYNVz8LumXsi4X+p+GM+gE=
=16xX
-----END PGP SIGNATURE-----

--N/GrjenRD+RJfyz+--
