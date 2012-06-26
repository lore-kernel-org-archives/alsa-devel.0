From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2] ASoC: tlv320aic3x: Fix codec pll
	configure bug
Date: Tue, 26 Jun 2012 09:54:03 +0100
Message-ID: <20120626085403.GH30406@opensource.wolfsonmicro.com>
References: <1340690623-18177-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8204576065956014684=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8D7392456E
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Jun 2012 10:54:05 +0200 (CEST)
In-Reply-To: <1340690623-18177-1-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-user@lists.sourceforge.net, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============8204576065956014684==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAgJxtfIS94j9H4T"
Content-Disposition: inline


--uAgJxtfIS94j9H4T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2012 at 11:33:43AM +0530, Hebbar, Gururaja wrote:
> In sound/soc/codecs/tlv320aic3x.c
>=20
>         data =3D snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
>         snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
>                       data | (pll_p << PLLP_SHIFT));
>=20
> In the above code, pll-p value is OR'ed with previous value without
> clearing it. Bug is not seen if pll-p value doesn't change across
> Sampling frequency.

A better fix is to change the code to use snd_soc_update_bits() rather
than open code it.  This is more idiomatic and will suppress writes if
they don't change anything.

--uAgJxtfIS94j9H4T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6XiXAAoJEBus8iNuMP3d4o8P/225q6hhEb7M+IQ0JC+h8a5M
HLr1Gwwad2M/T/M0kgenAler4kK16w+w+xSK90SFLpgtwixJ5et4dG3rv07LlfTN
mDIdNJLjw+pdRcoC8cKu41Ky2gaI43Ja6wdDc3e0XbMj/9+cE5c4YU9ha7LRgSah
RdH3f5Ywki8hw48DMsdhb4rvqjbpiB9M9Rrc/MzNii46lSPsi5uTKXJEHz5zGa9T
BViNt4cPignq2WeevVh+UCQwJ1U8bqeZtnmJEPl8DAHUZKuviC6RGbP+NSUjjfB1
oHPv6BrvLTt3yDMnE+5C0hQuPL/1ltuj8sI7yHEQusGejrTiWPu6oF1ldcO2UU1K
a1kxk6L7bpoyk34B+ZGQufkOi4vKEy5dP/z8Mp7xiRbOCfx57oQoy2gJsNSduzgZ
SOZJUc3vtMduTe/k26488mqFZYprKXdqDCSO5sjfSXaO6BwAstckmUgXllp0/pjB
6LGfcZt4OsV+KSHGn4TSjOOFmmylvG/DSNqheOWpfPWopqejwkPSiDYD3fY8qt3R
1z46At6ijcVsHPihnuCEZfbOZS47hDGeHSsVGgClSPAOlBGZI4ZNlt1f3+QjzF9+
c1H+TidhQnoC48P/f26/ITshS0qbpBh5EGxjeBteAWn0IFL6aP8jsm0NNhuBNc8i
IlRNlcwwcg1ar27jLm0l
=uTIx
-----END PGP SIGNATURE-----

--uAgJxtfIS94j9H4T--

--===============8204576065956014684==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8204576065956014684==--
