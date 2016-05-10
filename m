From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/9] ASoC: es8328: Use more suitable definition for mic
 bias
Date: Tue, 10 May 2016 18:53:35 +0100
Message-ID: <20160510175335.GC6261@sirena.org.uk>
References: <20160509112437.8924-1-john@metanate.com>
 <20160509112437.8924-6-john@metanate.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160509112437.8924-6-john@metanate.com>
Sender: linux-kernel-owner@vger.kernel.org
To: John Keeping <john@metanate.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 09, 2016 at 12:24:33PM +0100, John Keeping wrote:

> -	SND_SOC_DAPM_SUPPLY("Mic Bias", ES8328_ADCPOWER,
> -			ES8328_ADCPOWER_MIC_BIAS_OFF, 1, NULL, 0),
> +	SND_SOC_DAPM_MICBIAS("Mic Bias", ES8328_ADCPOWER,
> +			ES8328_ADCPOWER_MIC_BIAS_OFF, 1),

No, this is broken.  The specialist MICBIAS widget is legacy and should
not be used.

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXMiAeAAoJECTWi3JdVIfQ9gQH/idMyOWGYiIuO3texhPTU+++
TetQcXACjH3mwSDBoPRGOYHTO+F1bnX64QwFFddYfvb2YI7oV7u+GiCtpGUciFXP
HVgXfbjRNtFPG8JRsCkiAnXgTkHO4c2zzRaIXSjogUmcm2NEl1uwOBfGmdFcJRwZ
iRPV+EXku7l53N2VhpLbZ9eeD7l2Rp7w/JiW6J/mQIqdQbez6Zde//EAZWupJayx
zUT0l/YMzb/VIyDQsI6TGbqE/iXUiTuVQlARC/PEYrpBdX7TyV8v00C9saXrjHF/
A2lmE88rkCsSH/gPVgkmCXH1m5w9jJJrhygIXFPPd9qUwnj87nPQ2u5r6uzVXXc=
=VAcg
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
