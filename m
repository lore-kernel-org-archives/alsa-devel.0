From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: qcom: storm: allocate snd_soc_card struct
 dynamically.
Date: Tue, 9 Jun 2015 17:19:09 +0100
Message-ID: <20150609161909.GE14071@sirena.org.uk>
References: <1433856861-15433-1-git-send-email-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="mKGVDr+iJdqKOcjA"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1433856861-15433-1-git-send-email-srinivas.kandagatla@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Patrick Lai <plai@codeaurora.org>, kwestfie@codeaurora.org, Rob Herring <robh+dt@kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-msm@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--mKGVDr+iJdqKOcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 09, 2015 at 02:34:21PM +0100, Srinivas Kandagatla wrote:
> This patch moves static allocation of snd_soc_card to dynamic allocation,
> the reason to do this is to avoid holding up any dangling pointers
> in this static structures. And I see no use for having this struct as static
> given that the card->name is also populated dynamically from dt.

Applied both, thanks.

--mKGVDr+iJdqKOcjA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVdxH8AAoJECTWi3JdVIfQBCAH/i/Rz4xPlyha2SNHl+DkYUoq
MbnIhKOfPGRLDeU+GAwSE+fXluqF02r6nKt4TfNH44Hx1ZJwn8BvoIAlKbtNMvBA
4NeUEzet4gGEG0BiGMkiNwvAgC2iVm+QqsNfmwP2ScHhzl8+fwHEaA/A90T3EhE3
PaM6Vv37EAYqnDT/DBvgucy6QmiVKPHor4g3BN+gqLvhLMlwfcCh3uObHGrYLeTZ
0Ta31zf3j1KqIbApfkPpPln0I9vE70txo0PeeP9ATiIy67Iba25NnwRCg1z6LowH
dVJo/A/R6M5b4TnlPFyBJnn8OoosBoJXqbFzjYGh19YHhxAhMgSg2GvQkeF46rE=
=q3jC
-----END PGP SIGNATURE-----

--mKGVDr+iJdqKOcjA--
