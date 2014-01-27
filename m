From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 5/6] ASoC: tlv320aic32x4: Support for
	master clock
Date: Mon, 27 Jan 2014 18:17:07 +0000
Message-ID: <20140127181707.GD11841@sirena.org.uk>
References: <1390824190-18376-1-git-send-email-mpa@pengutronix.de>
 <1390824190-18376-6-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8083011972080772362=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A5E6261AA4
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2014 19:17:17 +0100 (CET)
In-Reply-To: <1390824190-18376-6-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, kernel@pengutronix.de, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============8083011972080772362==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8nsIa27JVQLqB7/C"
Content-Disposition: inline


--8nsIa27JVQLqB7/C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 27, 2014 at 01:03:09PM +0100, Markus Pargmann wrote:

>  	case SND_SOC_BIAS_STANDBY:
> +		/* Switch off master clock */
> +		if (!IS_ERR(aic32x4->mclk))
> +			clk_disable_unprepare(aic32x4->mclk);
> +
>  		/* Switch off PLL */
>  		snd_soc_update_bits(codec, AIC32X4_PLLPR,
>  				    AIC32X4_PLLEN, 0);

This looks like it's disabling the MCLK before disabling the PLL - if
the two are being disabled together I would expect to see the other way
around.

Otherwise this looks good to me.

--8nsIa27JVQLqB7/C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJS5qKgAAoJELSic+t+oim9i0YP/jUIjww9I9eedf5x/YqL/0jH
W7jK/pJJ23lcIWTkr/nBXzJPDNZm9r3B6hE0okH3QgxSMpnuRaGINkzistabeOxZ
e0m0hdGuJ5ZKkJGdMmi/czqd7354xXFv5wgPvhHcZV2OWg0pgajXBAEV1vOdCYXU
esBpD2X5Ty28McYkJIQlyAARzBN7vosVSK2IlXPQdkiF3+QiHw0FtaSmJO+Momdc
KMBVRZXNJSWQ8w06VlrFv5EWKF4rYIKWMXFL1f4uyEu7T0VwOHRuQWGjk8gDfTN8
jCjflLlajWdsR8uay+1tFDWRd8HPLAThj0n6QEMBP0ZzOnXFIje80rDBlUxaC55y
mEzxJ9LNhyklp33yGb4nHVsUqStaohJNN5yMJ1ayQFgu/9BjKqw08hvgkp+rjvdY
lH3ZGH2YSzKl/RRSvaldvAB0Ncn7R1dtwmy62ORP+3nMUrmrVts1Qoo+o6PtnXVf
/DRVKZ1j9sB/1dl2JmvxEAh3pi+Xg96L3YmShWfn2rRRrUtGY8o3kCCsBhSTBRKu
Q14e4vOeDZ4xHikCiU8qAiSDvODVHh5dBefc0y1wSRjeFZfPbH2A59Eg61N9fpwl
zDcGmfQoJDRzcF2i00H1pz23yvmFhNCXD9aivRMc3CevQvpPQ4UDW2pjS9NiH13O
DYq4SN3TVYoHkazC8Es0
=gER7
-----END PGP SIGNATURE-----

--8nsIa27JVQLqB7/C--

--===============8083011972080772362==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============8083011972080772362==--
