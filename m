From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: adau1761: Mark expected switch
	fall-though
Date: Thu, 9 Aug 2018 10:31:00 +0100
Message-ID: <20180809093100.GC6132@sirena.org.uk>
References: <20180808192213.GA27872@embeddedor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5995782576969179407=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 704112677A8
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2018 11:31:02 +0200 (CEST)
In-Reply-To: <20180808192213.GA27872@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--===============5995782576969179407==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UPT3ojh+0CqEDtpF"
Content-Disposition: inline


--UPT3ojh+0CqEDtpF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Aug 08, 2018 at 02:22:13PM -0500, Gustavo A. R. Silva wrote:

> @@ -518,7 +518,8 @@ static int adau1761_setup_digmic_jackdetect(struct snd_soc_component *component)
>  			ARRAY_SIZE(adau1761_jack_detect_controls));
>  		if (ret)
>  			return ret;
> -	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE: /* fallthrough */
> +		/* fall through */
> +	case ADAU1761_DIGMIC_JACKDET_PIN_MODE_NONE:
>  		ret = snd_soc_dapm_add_routes(dapm, adau1761_no_dmic_routes,
>  			ARRAY_SIZE(adau1761_no_dmic_routes));
>  		if (ret)

Again, are you *sure* here?

--UPT3ojh+0CqEDtpF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAltsCdQACgkQJNaLcl1U
h9BuQQf/TCi8yGlYZEF7RX3gN++hw95VcrRisZ+dRCCSqvNLd7HLThruScE2erOa
TDNlOUChGODOjFc4cDhR2XJPFi8+RtrU6TNEyjGZiwtAnY129PS7SdVHrKsFAUQH
nidn2ogCbeC0uSJCYwXCSRdSmXDKDMJQg9GBQvlmopDTFGDyF8wA3GiiGKXl31kz
gM3AN/TstSfFxnVeQYC69XJm7/apOmuWQ/kUsTotH8U+g3/5wbCLcX37Yx7+bp62
65/X0x2jgOXa49lONaoO/LuR1IFPb7DytV0jyihk660w0V3pLxB05pk3hMs1Mq8v
LrUeF8oOt79DYGEm+FCNvBTwsr5Xlw==
=P1Yl
-----END PGP SIGNATURE-----

--UPT3ojh+0CqEDtpF--

--===============5995782576969179407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5995782576969179407==--
