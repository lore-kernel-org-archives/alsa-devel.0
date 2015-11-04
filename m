From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/5] ASoC: rockchip: i2s: Support to set the divider
 clock API
Date: Wed, 4 Nov 2015 14:34:31 +0000
Message-ID: <20151104143431.GH1717@sirena.org.uk>
References: <1446514438-13922-1-git-send-email-wxt@rock-chips.com>
 <1446514438-13922-2-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Enx9fNJ0XV5HaWRu"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446514438-13922-2-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Sonny Rao <sonnyrao@chromium.org>, Dylan Reid <dgreid@chromium.org>, Doug Anderson <dianders@chromium.org>, Cheng-Yi Chiang <cychiang@chromium.org>, linux-rockchip@lists.infradead.org, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--Enx9fNJ0XV5HaWRu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 03, 2015 at 09:33:54AM +0800, Caesar Wang wrote:
> In order to support more sample rates, add the divider clock api.
>=20
> As the input source clock to the module is MCLK_I2S,
> and by the divider of the module, the clock generator generates
> SCLK and LRCK to transmitter and receiver.

Same thing as your other very similar patch: why does this feature
require set_clkdiv()?

--Enx9fNJ0XV5HaWRu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWOhd2AAoJECTWi3JdVIfQYagH/jtmiRopsnEjllfxq4a1PL7G
mLnIEEJrXF2zkc4twWSgXbypLBEeKS690tTFAa6G1Hv/cY6p36FrnV/OisBYv4Xu
graN195pjcnQntfYYDJs5RV/S4U7Vhil97Vu46ROGqp99y5d8tjTwtRjfIRwT6AJ
HVWywTFNKZNBJDFrzYh7TH5SMZo2qIpwSPgAplPhitHXBv01q0HhEQt/EpLD5KE3
qkycbiNEh8BSnO/WxlrOKub4yKS6E073JuMQBzAg6y7puW9RrLySnxUyu3nN0a//
m92fRs/qiapKW8uwe/COvzqznvns/jUAsPrGqmSymc1fOPqyYIQctTxNrmGYRgc=
=2R+l
-----END PGP SIGNATURE-----

--Enx9fNJ0XV5HaWRu--
