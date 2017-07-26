From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/3] ASoC: codecs: msm8916-analog: support jack
 detection
Date: Wed, 26 Jul 2017 17:23:18 +0100
Message-ID: <20170726162318.hwomo5s56vxlzpkm@sirena.org.uk>
References: <20170725175126.26578-1-damien.riegel@savoirfairelinux.com>
 <20170725175126.26578-3-damien.riegel@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="psuwujjutheqfzxf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170725175126.26578-3-damien.riegel@savoirfairelinux.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Damien Riegel <damien.riegel@savoirfairelinux.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Patrick Lai <plai@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, kernel@savoirfairelinux.com
List-Id: alsa-devel@alsa-project.org


--psuwujjutheqfzxf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 25, 2017 at 01:51:25PM -0400, Damien Riegel wrote:

> +int pm8916_wcd_analog_jack_detect(struct snd_soc_codec *codec,
> +				  struct snd_soc_jack *jack)
> +{

Sorry, also meant to mention: use the set_jack() operation to make it
easier to use with generic cards.

--psuwujjutheqfzxf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAll4wfYACgkQJNaLcl1U
h9C6Ewf9EPXM9uxpBbXsDCJn+HXJHH22VpCfjkgPC8YuGhMDZXUfGGHr0xHFwKUr
cvGyqGxbzsKZ++Z5p837yYtWiWp8a/UFwuZtnzrULdv0IIMMCQpzfwHWgSNb/6G5
JsotTiSkrnqteanXPb84iAefjtqprk6lP+mDc5YN8+5LHbX2XMQE1IPGCuvDdOWH
gy+K49vPykPbd8aqe6bA65+UudD8w+DqXBcSmb3zRCA4eVufuoevKdqEW5IiFjri
8yAvqXc13/pWldNmujH1O6tjyg8sRuNSPFaH2G4Zv3ycxrLmafUyTOixGkRHo0VS
H8ZpvhTSUi/ns4e/7Gj0UPvsdmdYoA==
=J1vP
-----END PGP SIGNATURE-----

--psuwujjutheqfzxf--
