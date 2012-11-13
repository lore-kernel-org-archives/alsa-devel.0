From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5 2/3] ASoC: atmel-ssc-dai: register dai and pcm directly
Date: Tue, 13 Nov 2012 17:30:33 +0900
Message-ID: <20121113083031.GP18224@opensource.wolfsonmicro.com>
References: <1352706028-750-1-git-send-email-voice.shen@atmel.com>
 <1352706028-750-3-git-send-email-voice.shen@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="s9kDAZ2EyO0AcRYa"
Return-path: <linux-sound-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1352706028-750-3-git-send-email-voice.shen@atmel.com>
Sender: linux-sound-owner@vger.kernel.org
To: Bo Shen <voice.shen@atmel.com>
Cc: plagnioj@jcrosoft.com, nicolas.ferre@atmel.com, linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-sound@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--s9kDAZ2EyO0AcRYa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 12, 2012 at 03:40:26PM +0800, Bo Shen wrote:

>  static struct platform_device sam9g20ek_audio_device = {
>  	.name   = "at91sam9g20ek-audio",
> -	.id     = -1,
> +	.id     = 0,
>  };

Why are you changing this?  Single devices are supposed to specify -1 as
their id.

>  static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>  			     struct snd_soc_dai *dai)
>  {
> -	struct atmel_ssc_info *ssc_p = &ssc_info[dai->id];
> +	struct atmel_ssc_info *ssc_p = &ssc_info;

This seems like a very big step backwards, there's now a single global
variable for the ssc_info which presumably means there can be only one
SSC active in the system at once.  That's changing a lot more than just
the registration...

--s9kDAZ2EyO0AcRYa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJQogTyAAoJELSic+t+oim9umQP/RIuxfm6bmfHp+Ovx6Rq+6La
BV+jcDuhnGa0Z1AMAmvPfBqdKbZeDtmrGQqqvcAh5GhPcBeZlDVGhHKRsvQ6KoHo
zeNk+VY95tdrSfNgNBh8HAWBuY31fUPx7IUqD2/CwpnfzVDj5PzCbt5Y+XUxGsML
fgjDzyoDl46p3Onzomme+7/cUGAOWeleYmoOa/AiAjDS409YEyZsHHPDnHPucwOn
UFBVkzDuO8ZLA4m/ggWM4wMjWjmS6t58XLRQm9p6edWStho3R+3KDFqjo0DZMaEA
Cfl13mYHGtCF3GXzjyWJdfti7E6AitjA3s9J71Rx2frxVq3+V+iKQxTqOMSmr5Ha
cuRWJ21IM6cBnsUrAAo00a5kVw8Y8lCveHMkZ5p+rV93jBXYgHoWg+Jkz688YqeV
L9zZgFQY237IBWsUQvkw0G7+2Ypq3AZtCkKuWHFrdMcjsTm3hco4axO+P4KgOi/c
QKRJqVMQvMuE8RTs7r9xegwh3hCZg19+v+bo6nOLGJ2YVIYxmnGxv+Duh6MV1jeL
5C0Z42kTRimb+dcnorGiw078T5b+B5OAlITTLJoNy9i5JiICfDMEtOpQ8wBYVUxs
/74F1er+JIiaDqEqjdpZllJLrFvilAQ20UGqkXN3wgdB9uWj/Vmaa614SggGmteY
13vyPGuTqyrXrkDLvHcn
=mzEK
-----END PGP SIGNATURE-----

--s9kDAZ2EyO0AcRYa--
