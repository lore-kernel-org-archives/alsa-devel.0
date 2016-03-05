From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: nau8825: reduce stanby power
	consumption
Date: Sat, 5 Mar 2016 13:10:14 +0900
Message-ID: <20160305041014.GZ18327@sirena.org.uk>
References: <1456686105-6885-1-git-send-email-KCHSU0@nuvoton.com>
 <1456688827-7337-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4925613813324965450=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3700226599E
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2016 13:41:56 +0100 (CET)
In-Reply-To: <1456688827-7337-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, YHCHuang@nuvoton.com, lgirdwood@gmail.com, benzh@chromium.org, CTLIN0@nuvoton.com, mhkuo@nuvoton.com, yong.zhi@intel.com
List-Id: alsa-devel@alsa-project.org


--===============4925613813324965450==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+2VoOUYPONkisRYF"
Content-Disposition: inline


--+2VoOUYPONkisRYF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 29, 2016 at 03:47:07AM +0800, John Hsu wrote:
> There is side effect at last patch.
> The playback has no sound with MCLK if internal clock frequency decreases.
> Thus, we need to recover frequency setting when MCLK case.

This doesn't apply against current code, please check and resend also...

>  	/* ADC for button press detection */
> -	SND_SOC_DAPM_ADC("SAR", NULL, NAU8825_REG_SAR_CTRL,
> -		NAU8825_SAR_ADC_EN_SFT, 0),
> +	SND_SOC_DAPM_SUPPLY("SAR", NAU8825_REG_SAR_CTRL,
> +		NAU8825_SAR_ADC_EN_SFT, 0, NULL, 0),

This looks like an unrelated change so should be in a separate patch.

--+2VoOUYPONkisRYF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW2lwlAAoJECTWi3JdVIfQtusH/15lOkA7Nnf7x9gjxBVg3uWL
yOYpISxw5W0vBhVnGGCkefu5ZHLLeThuE5pX159yePSVW3l15hgRTFh1xV49USWT
igccHfNIHvqFDX5MPkySg1Q1cKMntl20YzPjppvM2ABiSdV9gvEiqipxZ1Y1/nfG
nomN496b3l4H58DkiOdaOns/AFOxctfibrYMFPvS215E7AZcBaAZikjvOCLZt7PV
KREvB1aV2LS4q44somAOHwUmXSAimruJop0F+NEoa/a+7pndLGHe2axeKaqBC3I+
NRDKpeBiuVet+uCWZrfKIwaxNI2oMdn2NRlwu8lQvSimETuwFZrNKvZ2UvZKvxk=
=78fT
-----END PGP SIGNATURE-----

--+2VoOUYPONkisRYF--

--===============4925613813324965450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4925613813324965450==--
