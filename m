From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V3 1/1] ASoC: tlv320aic3x: Fix codec pll
	configure bug
Date: Wed, 27 Jun 2012 12:47:21 +0100
Message-ID: <20120627114721.GI308@opensource.wolfsonmicro.com>
References: <1340718911-9325-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0830334819469064095=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 079EF103F9E
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jun 2012 13:47:23 +0200 (CEST)
In-Reply-To: <1340718911-9325-1-git-send-email-gururaja.hebbar@ti.com>
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
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, jiri.prchal@aksignal.cz, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, alsa-user@lists.sourceforge.net, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0830334819469064095==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BWWlCdgt6QLN7tv3"
Content-Disposition: inline


--BWWlCdgt6QLN7tv3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 26, 2012 at 07:25:11PM +0530, Hebbar, Gururaja wrote:
> In sound/soc/codecs/tlv320aic3x.c
>=20
>         data =3D snd_soc_read(codec, AIC3X_PLL_PROGA_REG);
>         snd_soc_write(codec, AIC3X_PLL_PROGA_REG,
>                       data | (pll_p << PLLP_SHIFT));

Applied, thanks.

--BWWlCdgt6QLN7tv3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP6vKmAAoJEBus8iNuMP3dGlYP/jvKyI7Sr+cK+M8pNtrvXIia
MgHXvig8TH6HGniAiTOuX1mLVmC+8JX6nG0Jiwf2bQERD6p5XWHtZOBGXxh7EGbJ
W7wf1MwsA+L9Df81icpukMjKMEH2y5M9Y5AeUcg9smZCJX2mARKAg7ejXIvhxcD9
j2DfxqUc5H+Opje4MnfeHUKu+vBwjxEYKM+3aWH+muwn8TCkB/THymN2wLFXW/2P
mmYvWtemCvbm6+/SpAve0lzmwp5qRDroOnbLjQgjNN3AFXywefS8BMvOORHDJSWM
7ErGTpPEveNAV6ku7r8bkFbGppLY1kuf/DUO6qzgKG6Eihx/FFIQbF4mnbSobjfY
zRq0W7WCG2VwW4d2kflxsIr5R0Rk88ftk20jKO1tNVNfdgND9ddkWAvux5SfLPYT
cjv4YFcDximtG6/1avI2salTbG9swvYjCcSM14/anvHstim0SmZCG0aGVfGTPiWs
PRUxlE2eO1N3CeXmKqKEegg7SQFXT23Mr4sU0pFvPUdORm+rXdLHuhAtjv7ADO8Y
meblYUuV1eDCaoVBZLi7C2PmrMh5JiEUWRDbRl7rsdfz9uJMjHWystgydQIE4FVs
h3PV3muFqCHGxF2kW5G0z9lQGmsW2bzhSXd/JaOePDFKoLYbIuFaJHxNXzNLATDH
A97FGIa27dY+a0U2/E3q
=9qSb
-----END PGP SIGNATURE-----

--BWWlCdgt6QLN7tv3--

--===============0830334819469064095==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0830334819469064095==--
