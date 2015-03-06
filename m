From: Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH 3/6] ASoC: sgtl5000: initialize
 CHIP_ANA_POWER to power-on defaults
Date: Fri, 6 Mar 2015 20:12:07 +0000
Message-ID: <20150306201207.GX21293@sirena.org.uk>
References: <1424991273-10081-1-git-send-email-eric.nelson@boundarydevices.com>
 <1424991273-10081-4-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2296004386222498276=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 19F8D265E17
 for <alsa-devel@alsa-project.org>; Fri,  6 Mar 2015 21:12:16 +0100 (CET)
In-Reply-To: <1424991273-10081-4-git-send-email-eric.nelson@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: fabio.estevam@freescale.com, alsa-devel@alsa-project.org, lars@metafoo.de, tiwai@suse.de, lgirdwood@gmail.com, rmk+kernel@arm.linux.org.uk, jean-michel.hautbois@vodalys.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============2296004386222498276==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NyAGqWZHBkCadxLI"
Content-Disposition: inline


--NyAGqWZHBkCadxLI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 26, 2015 at 03:54:30PM -0700, Eric Nelson wrote:
> Initialize CHIP_ANA_POWER to match power on defaults, which disables
> ADC, DAC, and charge pumps.

> +++ b/sound/soc/codecs/sgtl5000.c
> @@ -47,12 +47,10 @@ static const struct reg_default sgtl5000_reg_defaults[] = {
>  	{ SGTL5000_CHIP_ANA_ADC_CTRL,		0x0000 },
>  	{ SGTL5000_CHIP_ANA_HP_CTRL,		0x1818 },
>  	{ SGTL5000_CHIP_ANA_CTRL,		0x0111 },
> -	{ SGTL5000_CHIP_LINREG_CTRL,		0x0000 },
>  	{ SGTL5000_CHIP_REF_CTRL,		0x0000 },
>  	{ SGTL5000_CHIP_MIC_CTRL,		0x0000 },
>  	{ SGTL5000_CHIP_LINE_OUT_CTRL,		0x0000 },
>  	{ SGTL5000_CHIP_LINE_OUT_VOL,		0x0404 },
> -	{ SGTL5000_CHIP_ANA_POWER,		0x7060 },

Two big problems here.  One is that this appears to also affect
LINREG_CTRL which your changelog didn't mention.  The other is that
contrary to what the changelog says this isn't fixing the default, it's
removing it.  The whole point of the register defaults table is to
contain the default power on register values, if it contains other
things that is a bug and should be fixed by changing the values not
removing them.

Given that confusion I'm really having a hard time understanding the
rest of the commit.

--NyAGqWZHBkCadxLI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU+goWAAoJECTWi3JdVIfQDzMH/11RIugkHlEOD+dG2Iqtr+SV
fXkeibOLsTGPQMYAbugEvYkBQcyCjrlVSEypxuecm6w5rg906AGS5KkiJNsx1K7P
u7f0Ut4OoSFLCDubQHP8wa4bbzfeJJGmKrJC5gGgpHrhUEVQ4B9xk4XHwsl/aTXV
J9DiXwC5ElH75RyopCZa2hOBJPn0I2GUkxAbE9oQPvp9yMmlmn0pqn8kzjLaukX4
iLzrx7vNImtbeP/cDf8oNOKhvvFtFiIHg95jpVZofSVaJrIDT3o9HWPlCOro+cB/
jnlJ+wrU5Izj4rI7mi+s731d28R8d3q0aOGH3/Qzdez7QFFB+99rHI3IV6pIn0U=
=PcxV
-----END PGP SIGNATURE-----

--NyAGqWZHBkCadxLI--

--===============2296004386222498276==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2296004386222498276==--
