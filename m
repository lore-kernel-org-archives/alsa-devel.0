From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ASoC: Support TI Isabelle Audio driver
Date: Mon, 4 Jun 2012 11:37:54 +0100
Message-ID: <20120604103753.GF7538@opensource.wolfsonmicro.com>
References: <1338569514-18106-1-git-send-email-MR.Swami.Reddy@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1144348220988368320=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3B6B72490B
	for <alsa-devel@alsa-project.org>;
	Mon,  4 Jun 2012 12:37:56 +0200 (CEST)
In-Reply-To: <1338569514-18106-1-git-send-email-MR.Swami.Reddy@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: MR.Swami.Reddy@ti.com
Cc: alsa-devel@alsa-project.org, vishwas.a.deshpande@ti.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org


--===============1144348220988368320==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5CUMAwwhRxlRszMD"
Content-Disposition: inline


--5CUMAwwhRxlRszMD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 01, 2012 at 10:21:54PM +0530, MR.Swami.Reddy@ti.com wrote:
> From: M R Swami Reddy <MR.Swami.Reddy@ti.com>
>=20
> ASoC: Support TI Isabelle Audio driver
>=20
> The Isabelle Audio IC is a complete low power high fidelity CODEC with in=
tegrated
> ADCs, DACs, decimation and interpolation filters, PLL, and power provider=
s. This

Actually, I tried to apply this but the Makefile and Kconfig clearly
show that whatever thsi was generated against wasn't for-3.6...  I fixed
it up by hand.

--5CUMAwwhRxlRszMD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJPzI/sAAoJEBus8iNuMP3dxRMP+QG1b2s1Atzr7L+EurcdtCk7
uLACh0R+mR4f1Pf9J8cbyPTGWnw2zaJa9duOgmix/JuVoXyfIPITkKITavWXaFtP
m54MHmHVqWzjC4Mcpmg2CFRklvb+ooAPlmGunOJ1SbnlLsdS5gGPuVBEa3lr8DPO
UFtYBz5XMOEJOF88Otz+soE2QwQ7AzxSRY55YDOm6096r1eJRnrtufk5QauQwxOz
2bnAymF25H2ahPjGaIiK/s/nkTjHYDMeT/dBRGKmN6BYk6EZ5dQR8M/PdhJ3VQLk
ZNO8mGm8Q9PgKA2R3Vd8swSwDYVMUeyADb6ZZmJIiS+1PATBKNo0rrznU/IDXMZD
g0wgOtLAu6zMQkE0HUxQldekFuRmMbSlgcpgQvWuwhKpvviiPZ7hM+fFUCK2ClTD
8pq0Pi02rXVru3QXBf6TKZskRDlwcviHUgK4gDffRLKYUIINDpPKhcz7KdgF5AgO
y5qEpTYAsvVRFzhho1MoSXVGm3OPosjInA5CW987jmtsFtozQ5j7cMOjVumJUNFP
FPR+rKD/3xAUPePfeL+VKzEKhGz8uNYcJV9uRoWzHkPkoCG6JOg66bxF1D6SasxB
LgJdoyNtfMuM4724gLTUir2k2QpGx/D6Mra7A/CHNwYRqiLUXoHxN3Fu22mnakaq
J188dPKkA7alM00e1Mg+
=jZ29
-----END PGP SIGNATURE-----

--5CUMAwwhRxlRszMD--

--===============1144348220988368320==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1144348220988368320==--
