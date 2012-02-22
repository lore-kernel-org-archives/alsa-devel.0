From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: imx: move SND_SOC_AC97_BUS selection
 down to machine driver
Date: Wed, 22 Feb 2012 13:26:50 +0000
Message-ID: <20120222132650.GH7340@opensource.wolfsonmicro.com>
References: <1329917147-24962-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4365981355952223578=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8BE5D103F5E
	for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2012 14:27:01 +0100 (CET)
In-Reply-To: <1329917147-24962-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: alsa-devel@alsa-project.org, Sascha Hauer <s.hauer@pengutronix.de>
List-Id: alsa-devel@alsa-project.org


--===============4365981355952223578==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hAW+M2+FUO+onfmf"
Content-Disposition: inline


--hAW+M2+FUO+onfmf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 22, 2012 at 09:25:47PM +0800, Shawn Guo wrote:
> SND_SOC_AC97_BUS is selected to enable the AC97 support in soc-core.
> Rather than selecting the option under SND_IMX_SOC, it's better to
> leave the selection to individual machine driver which knows if AC97
> support is needed or not.

Can you please rebase this against for-3.4?  It doesn't apply right now,
I didn't check what the conflict was.

--hAW+M2+FUO+onfmf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPRO0SAAoJEBus8iNuMP3dQygP/iyTXkavcr4mb0E4+yF/rmkp
/tM3azVZRr0hjEHhUWwpfd+sA68kjdr3Moz62UQSszf/w1+EkCP30R8pem8BBwIZ
7GHLKCunDRI7sLuxm8MaFq9gkYzeZIIPRPfkHW55YB84oSm3IZS0pO00CbPVrJzZ
u6yIUI0NLTXY37sl30wBotC6IYtMnKYVYnNVisIc8TFSQG55BVCVAi3M8cJxmGDb
dzdfBppjPX6pigCahgFPPBidys3+3L0qO7XxTdLjzzH9rEiP/cUdLsTiavMG3j0A
UBqwkUmBda8IjLTnXtkCdxGXfuC9oqdaLS8Cb/CP8IiN9X39JyChLZZjoo98jQEw
Te4QrCw5Oexx5rFgvmhIlk3QOuyZLV2Ca+8yRlubn1/8BE3dYFC0+amjt8MB1wWu
fCmi1yXpW9nZwyfw6gcW2+YmWw6UYZX79hJY2BNok1X8oQAmWepHb6UoWD1LdSh5
yl9qZ0Aabyd4IAl9eKT502VDTGCwlYGVWP9zRI27sf3XSnllKpPvayn8MXEgKXiV
KIzPL/u+Ej8xakQvaARBf/tXXXZr1sXL0u+kldaT/FjM+wYZZyTLg/KMSHho2RDl
iCl3W0kJcORZ2mrnqmg92OywmBz4LSgY4URlnz2SWl+FSVzdW0DpDCYywVX7wN/O
pfDjWnc/xwLPbcAA4r0I
=8w3F
-----END PGP SIGNATURE-----

--hAW+M2+FUO+onfmf--

--===============4365981355952223578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4365981355952223578==--
