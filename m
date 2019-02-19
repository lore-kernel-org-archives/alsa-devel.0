From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 2/2] ASoC: codecs: pcm186x: Fix energysense SLEEP bit
Date: Tue, 19 Feb 2019 16:56:54 +0000
Message-ID: <20190219165654.GB20883@sirena.org.uk>
References: <20190219162840.7244-1-codrin.ciubotariu@microchip.com>
 <20190219162840.7244-2-codrin.ciubotariu@microchip.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190219162840.7244-2-codrin.ciubotariu@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Codrin.Ciubotariu@microchip.com
Cc: lgirdwood@gmail.com, dannenberg@ti.com, m-stecklein@ti.com, afd@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 19, 2019 at 04:29:28PM +0000, Codrin.Ciubotariu@microchip.com wrote:

> The ADCs are sleeping when the SLEEP bit is set and running when it's
> cleared, so the bit should be inverted.
> Tested on pcm1863.

This definitely seems to be the case from the datasheet but...

> @@ -184,8 +184,8 @@ static const struct snd_soc_dapm_widget pcm1865_dapm_widgets[] = {
>  	 * Put the codec into SLEEP mode when not in use, allowing the
>  	 * Energysense mechanism to operate.
>  	 */
> -	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  0),
> -	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  0),
> +	SND_SOC_DAPM_ADC("ADC1", "HiFi Capture 1", PCM186X_POWER_CTRL, 1,  1),
> +	SND_SOC_DAPM_ADC("ADC2", "HiFi Capture 2", PCM186X_POWER_CTRL, 1,  1),
>  };

...we still have a bug on pcm1865 as we've got the same register bit for
both channels which isn't something that's supposed to happen.  Looking
at the register description this feels like it'd be better handled in
set_bias_level() or as a DAPM supply widget.  However that's already an
issue without this patch.  I am a bit curious how this ever worked for
anyone though.

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlxsNVUACgkQJNaLcl1U
h9AO/Af8CsANMFAV4KT3K/DF+qSVvEq+iLlU4Op5w9ozsNP/Mv4UpBuATJ5xOHe1
P7IkfODTQp3iep1B3u+ZtMLKkR8FuSVEg/fbAbraBuZ6veVH//8IUOXc57/heL7c
6z9/dnXPoGrAa1VMynaThm7e9aeX7UWo6LVZDSabN8UqOBSjvePTGVWPLxcpQhLb
ro8yf/Msaceurtyd4uPzS4TaIH0VD4z5TP41XyljM/04YmJiAU7OBHFtqTkP9Whk
H3JECDi4+SgLjk4RyUxlmYeMASjo/OEgDCzmLR1HgSRdqk4YNU15fenEl6xbWS4T
llmwXxGLVkX9TWb0IQOV+aKJa/w2rQ==
=e8Bn
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
