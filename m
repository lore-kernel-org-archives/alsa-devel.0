From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/3] ASoC: sgtl5000: fix buggy 'Capture
 Attenuate Switch' control
Date: Thu, 1 Aug 2013 15:00:26 +0100
Message-ID: <20130801140026.GV9858@sirena.org.uk>
References: <1375281871-28128-1-git-send-email-LW@KARO-electronics.de>
 <1375281871-28128-2-git-send-email-LW@KARO-electronics.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0967481626182506432=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 4153E2608A1
 for <alsa-devel@alsa-project.org>; Thu,  1 Aug 2013 16:00:28 +0200 (CEST)
In-Reply-To: <1375281871-28128-2-git-send-email-LW@KARO-electronics.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Shawn Guo <shawn.guo@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============0967481626182506432==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="buHhpaMO4lcZIXkU"
Content-Disposition: inline


--buHhpaMO4lcZIXkU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2013 at 04:44:30PM +0200, Lothar Wa=DFmann wrote:
> The SGTL5000 Capture Attenuate Switch (or "ADC Volume Range Reduction"
> as it is called in the manual) is single bit only.

Applied, thanks.

--buHhpaMO4lcZIXkU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJR+mn2AAoJELSic+t+oim90VkP/3NAA+8t8hkNVgCaINhiiVYk
DJFrv3Ii4pi/CI+LaBDXNbLTi1QjwVwvh/i4HgOsSZ6gx4mZ2bTWMTA8p7AoAt7W
4Pv22OO2DjDhXWk4IdYB7VufcGJB71RnCxs3N3S8cpSBqCEY82Uq7ExHGW5cXXTW
q1auyXDwDNO9JgZexQD69PZ8Fx61RohhJVdZfxqWKLrz6kVEpBrMjQKFGPErXz++
qm0JtNShVSFXDzCzxlEaXm6yrE4X9XXdrQAKQ7MRfU9VQUpYA9U0yd3DlXFVa9Ri
tRQ/1dLkqDBcIWFNYmPzB3ZSLT3hJA+MU0UTxswSb58XT8JNqbtHCDvHcsPkktJx
fVuVhBG0nCIMwS+WnQM/cNm4T2S2TKk5kXOOSmVfxKK4WLlNsISkyrBRH9X4oNzC
RiMYCifUcGU4QSDplN6e+J4UKOgKX4hF9fQr95aIN2PYzPLELSyFszH4KbSBgy/U
epwufgekA0LoGMF82SRyD/EGDKaNTn01VdA9r14gFuRumlpbJnQbZKgV9Gh9OKZm
aJ0OZPOFBrhC528tshINruZhtTKkLbOQ16LL6Rv6r8z2dsKwRyEVtKF+cnXsFLfA
QT0BQBuIXI5OX21q3vYSp0G6qSGVBmxAoMWLPwCpXvzCQMHu7KpakblSF9jDEKPm
xZhj7T/lDqSLsRKRxMXm
=Nfk7
-----END PGP SIGNATURE-----

--buHhpaMO4lcZIXkU--

--===============0967481626182506432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0967481626182506432==--
