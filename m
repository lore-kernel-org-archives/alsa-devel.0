From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl: Fix SND_SOC_EUKREA_TLV320 build
 error on i.MX8M
Date: Thu, 13 Dec 2018 11:00:15 +0000
Message-ID: <20181213110015.GA10669@sirena.org.uk>
References: <1544647253-3806-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4975599321762586845=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 48276267BB0
 for <alsa-devel@alsa-project.org>; Thu, 13 Dec 2018 12:00:16 +0100 (CET)
In-Reply-To: <1544647253-3806-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, linux-imx@nxp.com
List-Id: alsa-devel@alsa-project.org


--===============4975599321762586845==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Dec 12, 2018 at 06:40:53PM -0200, Fabio Estevam wrote:
> eukrea-tlv320.c machine driver runs on non-DT platforms
> and include <asm/mach-types.h> header file in order to be able
> to use some machine_is_eukrea_xxx() macros.

Oh, I actually just did this myself as a -next build report was earlier
on in my inbox.  I'll drop it and apply your v2 patch instead since I
didn't push out my change yet.

--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwSO74ACgkQJNaLcl1U
h9DzVwf/dJaB3XWFAyc6SOb2d0EMkLrkqtQv+pCT6G1WOy/4lhvXGZcypdv2H+O4
UyISUWACrkIAzxcGhS6yg06UjYO0vUk7fV8E3BCHC8oJmt0o1iyA+I0hZBuxwZ5F
+//Ri+qi/jpqWann4fP+3DqSnjeDvgOSyT9JI3iTNX/69tY2/FYjRSLIJValjA9d
/C2KuQ00mgdTTpXC+qb5VTzadE6wc4NbwIEDdxK6wQF+8QEKiSATOiMzkVxmpcZb
Qo3VR/93ymkQLoGBS1XZA6y+0lICaUs8ol1BA5WzCCENZ56GJqQWgP6En0HLv2hA
4recRwkIIvESySLpz3v2FvIVRg/qlw==
=TUDJ
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--

--===============4975599321762586845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4975599321762586845==--
