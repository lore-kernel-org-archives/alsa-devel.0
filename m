From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/3] ASoC: ux500_pcm: Stop pretending that we support
 varying address widths
Date: Mon, 2 Dec 2013 19:09:13 +0000
Message-ID: <20131202190913.GQ27568@sirena.org.uk>
References: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVx8OOgYiG4KXJJB"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linus.walleij@linaro.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--EVx8OOgYiG4KXJJB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Dec 02, 2013 at 06:00:20PM +0000, Lee Jones wrote:
> The Slave Config's addr_width attribute is populated by data_width of
> dma_cfg, which in turn is derived from dma_params' data_size attribute
> and that comes from the slot_width which is always 16 bits (2 Bytes).
> We're cutting out the middle man here and just setting the DMA Slave
> Config directly.

Applied, thanks.

--EVx8OOgYiG4KXJJB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSnNrWAAoJELSic+t+oim97PcP/0undSbMLAciSYvyApxYDOlJ
IZI4GunVbKWjWLW1zI86N1KhPmdXk7ncaRlocolD4DWq7unP4BsLL/G4C0dtDYNm
brPDrs4gP70nvmEPrRbfMb3rjJA2Ia/InVbomCNJKGXcIFhYhEQeijUrcnumAjJX
v84S+nKrlQxSnwMEC7IhS2eqjDW2oomHer7ZHAHPKX3mY5AnfEU0HlfpPdOQuPf3
wHIN5ke2pLbWDkGWCBVPooymqwdLU2yPrdZ5PRlACJ0Z5xqgUY2cRzfMs3PJm+uO
XW/o+0LUeI8et+K7AlPUyeas4MUTiueDBokUJakngVR4JypIHXFE7n07g2f2dsuE
kTNqZzlF9skf8uWJQdfsfKxWLCtNQR1rf7CMnCecXODkQ5rMU8Yuj/bWJ18xBIFK
i6/Hds8bi7rO4nYlWOKIdztOEc0J84H7Zl5rdgpMBug47PKkvQZGxCenwfSAMVlK
6WJjK4rk1smJ2jSo9iiGgwyEMfabPHe+y6k0OT+g34636LZhHl0bV2wedECnwJH3
pQVJhAcsO+NtiJ+6vnpbXct7V8czF3I0mo9VEpEgpXkFRxvbbfVR9yPeK4O4iJj+
mVq3nXRvSDNT3YJPhqeB+/gMOjKlNm7i9wwrz3Dplytw5Mw/URtj8581dWH/fENz
GNKLYa+uuctDIXd9n85q
=loza
-----END PGP SIGNATURE-----

--EVx8OOgYiG4KXJJB--
