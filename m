From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rockchip-i2s: fix infinite loop in
 rockchip_snd_txctrl
Date: Wed, 8 Oct 2014 12:29:47 +0100
Message-ID: <20141008112947.GV4609@sirena.org.uk>
References: <1412755131-27542-1-git-send-email-sonnyrao@chromium.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1nWzwthe/g5xaf/W"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1412755131-27542-1-git-send-email-sonnyrao@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sonny Rao <sonnyrao@chromium.org>
Cc: linux-kernel@vger.kernel.org, dianders@chromium.org, Jianqun <jay.xu@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--1nWzwthe/g5xaf/W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2014 at 12:58:51AM -0700, Sonny Rao wrote:
> We can get into an infinite loop if the I2S_CLR register fails to
> clear due to a missing break statement, so add that.

Applied, thanks.

--1nWzwthe/g5xaf/W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUNSArAAoJECTWi3JdVIfQjGwH/iVgLdwxh86ob6hhMvimR5GW
GWwrIpyU+ShjnOoUZcNkkMt/g7nCaSS6UiQFtK4AjtvHVduxyLcu0Mj8v8L+PSiN
gS45pI8ItBVIexCUMlqm/OASnwtJwJoNpHnSQMbeB98hnWdD7ZgnTtwNao6y6uGn
35fYw5o4Gp9KSrxqVoa1hSDIrEHbtmFCwnK6pgsgc0lcfLZoTBCF+506YlSdgPxI
8+21yqPPfXh3vSTKlTMaPEnsMFVc9LzMPXn/SE8E1lEXlPQlP3jNoELEfu0v67OI
nuzdq23NC6jEpKkS3yFuIy7DLGB3ELv8YTcbUO6JsK10ot2loVvNYFKzUdZxYTk=
=WAn/
-----END PGP SIGNATURE-----

--1nWzwthe/g5xaf/W--
