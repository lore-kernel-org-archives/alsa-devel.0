From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v2 5/9] ASoC: sunxi: Add new driver for
 Allwinner A64 codec's analog path controls
Date: Mon, 15 Oct 2018 10:24:50 +0200
Message-ID: <20181015082450.i56n5cppwgiu44ko@flea>
References: <20181013165329.13363-1-anarsoul@gmail.com>
 <20181013165329.13363-6-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8375792516944468966=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 384E8267864
 for <alsa-devel@alsa-project.org>; Mon, 15 Oct 2018 10:24:51 +0200 (CEST)
In-Reply-To: <20181013165329.13363-6-anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org


--===============8375792516944468966==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rmvcilg4tpucomcb"
Content-Disposition: inline


--rmvcilg4tpucomcb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 13, 2018 at 09:53:25AM -0700, Vasily Khoruzhick wrote:
> The internal codec on A64 is split into 2 parts. The analog path controls
> are routed through an embedded custom register bus accessed through
> the PRCM block.
>=20
> Add an ASoC component driver for it. This should be tied to the codec
> audio card as an auxiliary device.
>=20
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--rmvcilg4tpucomcb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE0VqZU19dR2zEVaqr0rTAlCFNr3QFAlvETtEACgkQ0rTAlCFN
r3S25g/+OusRZ37+XCqkgBo64KzWBdwXpwkkk8AoLtnxnjI2uBDLL9KtNowpQ2Vo
U2iOw8dMywyBqyZ6zo4+qKXk22rZ59hPBElSaHEQYNLeAjr4OHzA08FLsymymM5a
KXX4pM1CSV9+3l/var2vk/uaxFyCW1VmAvz0OCIIvpU0zSAIIBeXbOE+UQbOdsAg
FbS96VipW5mw+IOWCokh0EHo986y5fIziWxSS/jslKHdHPSv28QR5c7brNEm/Tqu
U7HUcu6hlKp7xWo8ClKQTka+UpY/XM00nT5NJ5dKHLLddYUJEe8aug+Hn+yMQwoF
UJdNjzywWPx/WRE52Dcwe9+rVFaafLMe60TfutyZBInQjKJG5pZom+jTIRHjQE/t
MgwdR8yDjQKbG/GhPPkh9ogET6SI43RocEPloSvjObVkEcGqLKI1q0sRQarR7ppw
wFoBIsWvikbfeKlGewIVB/A4IRJV0w7Zbtj4ANFiOjW8XrKA6WY/ZCpywnlFhBup
MWOfquNhLKuvSkFmaAJynuDMEN7+iagDJAVN0dAukivb5CKeo6yY4XH/dWs1yMLj
WuZ+YpAgHF+aY9bRSHkxBi/UA0IyaZqKywLUyafUV4JTWGDmvjvEwCqZ1Bjfho6Z
/AYzvxYpM9cWIO1ZcTfTe7vE326CVUoW6L5zcUb903aU9NOHN4A=
=57nO
-----END PGP SIGNATURE-----

--rmvcilg4tpucomcb--

--===============8375792516944468966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8375792516944468966==--
