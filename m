From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: sirf: Add audio usp interface driver
Date: Tue, 1 Jul 2014 18:48:44 +0100
Message-ID: <20140701174844.GA410@sirena.org.uk>
References: <1404181134-21663-1-git-send-email-rongjun.ying@csr.com>
 <1404181134-21663-2-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1404181134-21663-2-git-send-email-rongjun.ying@csr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rongjun Ying <rongjun.ying@csr.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Barry Song <baohua@kernel.org>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Workgroup.linux@csr.com
List-Id: alsa-devel@alsa-project.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 01, 2014 at 10:18:53AM +0800, Rongjun Ying wrote:

A few *really* trivial things below, otherwise this looks good:

> +	if (usp->daifmt_format == SND_SOC_DAIFMT_I2S)
> +		regmap_update_bits(usp->regmap, USP_RX_FRAME_CTRL,
> +			USP_I2S_SYNC_CHG, USP_I2S_SYNC_CHG);
> +	else if (usp->daifmt_format == SND_SOC_DAIFMT_DSP_A) {
> +		regmap_update_bits(usp->regmap, USP_RX_FRAME_CTRL,
> +			USP_I2S_SYNC_CHG, 0);
> +		frame_len = data_len * params_channels(params);
> +		data_len = frame_len;
> +	}

Make this a switch statement for legibility, and if you do need to use {
} make sure they're used consistently for all branches of an if ().

> +	int playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK;

I'm not sure the extra variable adds much here.

> +static struct snd_soc_dai_driver sirf_usp_pcm_dai = {
> +	.probe = sirf_usp_pcm_dai_probe,
> +	.name		= "sirf-usp-pcm",
> +	.id			= 0,

Weird indentation here.

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJTsvR5AAoJELSic+t+oim9730QAIVOkmg4xp3NzxMusbbEZmNY
UNank+PX00PQwAEUAlDaWuGTvrRNsKs974Un0l1uAmewsWfaZPR9q6CXab2QAfrp
ld85dm+nbpK3LkDqk9pKMuih49pn4QPtl23g7cjCh1dFnD145hGd+aI9XBDdMR8B
Bf6NViVoa6WPHbbmLno08FKsIX+p2hJHKC8Sl1xELk+cfyELlYF6ugWIRBvz3+18
B+gV9O/uSfxFJn2GG0Jz2qxMhEVENii/j3bRuuJH6jeAiNRaCMu5bcB3QESs53wJ
x1kepyijISEUjrjoR0GO1ptc763vJVkVPd2h0DgsPg0JVlxxsKBMustETo6+X8MS
rREvAzkQ4CDdG9EjLPyTHPEhdksj5SQB2T1ay9ZgR/cZc2YYDSAeRqmAVLV2uXiZ
5xlBYCZat6PNdyIzpB8KoDabH3F67FUYtk7hOMW7DEx6wPltRx/9kq44IN5YXJc1
yWcbBqClTOdDWba6qZ/BojfPf4WFlIy6UW8cToXtSi6UxJpBBigCEPKQVPyUDQSE
9VKwrTmLt0Yvr/6u7ws9D5MhCJulOFcgiSrP/s4hWRSMuDeSNOK05y7CU6gWRi6M
1/F9mVgYqCM4605blRlYQhz6wmY09xN8B6wRNEse13s7HAoV6Gn3/yfHQA77PKWm
QsTqA4+gEHRNW99qDyj3
=EqWV
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
