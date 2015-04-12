From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: davinci-evm: Use card DAPM context
 to access widgets
Date: Sun, 12 Apr 2015 12:44:37 +0100
Message-ID: <20150412114437.GB6023@sirena.org.uk>
References: <1428750688-12171-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7108443658816435112=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 00E2E26056A
 for <alsa-devel@alsa-project.org>; Sun, 12 Apr 2015 13:44:44 +0200 (CEST)
In-Reply-To: <1428750688-12171-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============7108443658816435112==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2M5S/FFnatmgZKAU"
Content-Disposition: inline


--2M5S/FFnatmgZKAU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 11, 2015 at 01:11:28PM +0200, Lars-Peter Clausen wrote:
> The dapm field of the snd_soc_codec struct will eventually be removed
> (replaced with the DAPM context from the component embedded inside the
> CODEC). Replace its usage with the card's DAPM context. The idea is that
> DAPM is hierarchical and with the card at the root it is possible to access
> widgets from other contexts through the card context.

Applied, thanks.

--2M5S/FFnatmgZKAU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVKlqkAAoJECTWi3JdVIfQSo4H/20MYRk7fP74iMK23RALTNDc
x65PzqLN+AO7ZkEZyuFJZ7fHoXNeY4lx1mGhxHSOnguLrxceeZ01TfJph/jAsteC
brGJq84zgYGOBQfiazoVTjnzKdsMjwVeDFfcJl3KoYwJAUcWGEszZSm+V/IQx+Gr
eNVTszjrZ/+gU4LcJfqeOrvGoYzRDm763Cva/DkN6iEZZlHauZmb0J7VrgtkT6ph
rzSxOv7sH81kX2F0KBMjrI2e1D+5rbqLRYNiLrOt+gV8L4rktHlBP4FECBuWvSvj
iV6WIcO6fyAU8YpNojQoh/+WeBcrdFdNjRftFt8//PZXfSqFQ01FkuQbUN0l9Dw=
=77E9
-----END PGP SIGNATURE-----

--2M5S/FFnatmgZKAU--

--===============7108443658816435112==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7108443658816435112==--
