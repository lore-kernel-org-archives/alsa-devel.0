From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mediatek: Fix unbalanced calls to runtime
 suspend/resume
Date: Tue, 23 Jun 2015 12:11:15 +0100
Message-ID: <20150623111115.GC14071@sirena.org.uk>
References: <1435057280-21316-1-git-send-email-koro.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+98kJABsJJfEIu48"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1435057280-21316-1-git-send-email-koro.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Koro Chen <koro.chen@mediatek.com>
Cc: matthias.bgg@gmail.com, perex@perex.cz, tiwai@suse.de, srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org, s.hauer@pengutronix.de, lgirdwood@gmail.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--+98kJABsJJfEIu48
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 23, 2015 at 07:01:20PM +0800, Koro Chen wrote:
> This adds call to runtime suspend in dev remove. It fixs the problem that
> suspend is not called in the case of CONFIG_PM=n. It also fixs build
> warning when CONFIG_PM=n.

Applied, thanks (the stub does the right thing here if !CONFIG_PM).

--+98kJABsJJfEIu48
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJViT7SAAoJECTWi3JdVIfQBp8H/0NrMwR7+Wm2v9DxPgUuoVk9
aIXPUWdL/urr8f3g2gKPBZPJB2FRmlNHjfAL+zrQ2k7JoauDQM5O9xp5orwdzj+w
mVtgTBeddFNc2IAfpVa5PdGPu2xtJKaLlGIAoPtWwAgY04Szayczn69Kj6rx/3XD
N+ZkGmuMFt71bHoC/32TpI7Q2aJanZIutUnv4IVdqMkbA87wjJ7b/3ljtVqSp3gF
lVRgUn2JBOtDGocpp/rAReFVDP0IQCui6eD9YG4rc2baAgskemRhENoYlx9Bj8ac
0XVnjDd5WRSATEifUIR3jWRzezW5Au+oPMQCj6URnGnkdODXKO1pr0p/IV1LCW8=
=C1jO
-----END PGP SIGNATURE-----

--+98kJABsJJfEIu48--
