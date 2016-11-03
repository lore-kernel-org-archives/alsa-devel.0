From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 05/14] ASoC: sun4i-codec: Add support for optional
 reset control to quirks
Date: Thu, 3 Nov 2016 09:26:57 +0100
Message-ID: <20161103082656.xhf7d7wguwbi3rsx@lukather>
References: <20161103075556.29018-1-wens@csie.org>
 <20161103075556.29018-6-wens@csie.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ymzm7354gb444s7t"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161103075556.29018-6-wens@csie.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chen-Yu Tsai <wens@csie.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-sunxi@googlegroups.com
List-Id: alsa-devel@alsa-project.org


--ymzm7354gb444s7t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 03, 2016 at 03:55:47PM +0800, Chen-Yu Tsai wrote:
> The later Allwinner SoCs have a dedicated reset controller, and
> peripherals have dedicated reset controls which need to be deasserted
> before the associated peripheral can be used.
>=20
> Add support for this to the quirks structure and probe/remove functions.
>=20
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ymzm7354gb444s7t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYGvTQAAoJEBx+YmzsjxAgNUUQAIXBSxi2bEOU88f3tFLC8n5x
yQCPOhP1CajlBPcZVg/eQ4POQctydMknvZhH2zyQJhTZmfv+gri76glu6yfGASb2
kleo1IB98Mw1BRX/brRjbpibT54kGtB3Qk2Q9WpzaS7Q+4ul5NlVcpJs0cJVklcu
NnwG3UPkuja0lWzh1fC2oMQ0rQBtEHNRSNomoPfkpcDY5LadWYpaLZj/a9eEgbLz
lGoE+VkUn54MkF/NrGckLcpDz8JH3cZbEBJP6DiNHK3E8EC3dcy/2jY7w3895Tbp
gPtO+GjtNc1sLpRTTNJA6NScUcQBKKqz+qOTlkuoRK1qK56QvIMvHZ2QJMpaLnXi
owCvdrXFytEqcPDU59zHZlUcy8a5UZAHendWWnfKYukfV7h7jJmhqQKSgPKZHN+4
oEOt6YpzxmMwq2rNsrkVRmfuPaGEBGNdItkJ7VbG+0iMnw4OsMqhPS1vCfEB8caN
pPSyIXuhLCxk5UDa+9RJEYkAEgzcGYqosxCelUWoGkWrzuqSxNf7PFwquZRmSZwL
oYolPJWEnXMd26SgJEoptUm2A2qps919WES8XZkwZpYWDg8EBGarvFk1DduYoxRE
WXmGUT+gqRye/og/Npstv4hoEXg6tqq5feFSw39QWICvXP7WkW+at+2qd9orfYhk
xCYROcG77ROz2l5mRoXy
=SlJC
-----END PGP SIGNATURE-----

--ymzm7354gb444s7t--
