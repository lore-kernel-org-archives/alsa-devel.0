From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 7/9] ASoC: atmel-classd: remove aclk clock from DT
 binding
Date: Fri, 7 Jul 2017 13:44:20 +0100
Message-ID: <20170707124419.jfkgyl66wi7jfhnu@sirena.org.uk>
References: <20170704115927.32662-1-quentin.schulz@free-electrons.com>
 <20170704115927.32662-8-quentin.schulz@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="woub2x6txwmvzhcf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170704115927.32662-8-quentin.schulz@free-electrons.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: mturquette@baylibre.com, sboyd@codeaurora.org, robh+dt@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, nicolas.ferre@microchip.com, alexandre.belloni@free-electrons.com, linux@armlinux.org.uk, boris.brezillon@free-electrons.com, perex@perex.cz, tiwai@suse.com, cyrille.pitchen@wedev4u.fr, thomas.petazzoni@free-electrons.com, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--woub2x6txwmvzhcf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 04, 2017 at 01:59:25PM +0200, Quentin Schulz wrote:
> Since gclk (generated-clk) is now able to determine the rate of the
> audio_pll, there is no need for classd to have a direct phandle to the
> audio_pll while already having a phandle to gclk.

Acked-by: Mark Brown <broonie@kernel.org>

--woub2x6txwmvzhcf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllfgiMACgkQJNaLcl1U
h9D4EAf/RdCKk4UjTfyf4/fmSVtDhhexDdLPZ2dtAdyhOXP0/WJBzS4FXuHMU5V8
vuFe96ZKhVqeQFWzDV3Hf6Xit8JmgfKbIukIOVvY9FfDHfr/cslPIebGosWvDKT9
txSlXUdCacd2cpd8PqTfx9aeT6An6HgL38JHwQSkxVBMbVuu3ZM1oE9ReJ2TOXIG
OSn6IvR3VYJ0G6cw+zbJ61u48vdHLj5QVEy/lm7AhLjUhp6lL9zVhBoPTYV1EiR9
G8WJbAXxwfGkHZayulD4mI73Hr/1sMYnvrebsJDSnFOJPgk/I9hQHlm16DSv4cVo
zw9O4tbWs7PAN7Ej/WziemoWbokP1g==
=c1fk
-----END PGP SIGNATURE-----

--woub2x6txwmvzhcf--
