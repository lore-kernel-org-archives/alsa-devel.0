From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5640 CODEC driver
Date: Tue, 11 Jun 2013 10:12:13 +0100
Message-ID: <20130611091212.GW1403@sirena.org.uk>
References: <1370927416-12216-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3892838283859597420=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 360DD261A4B
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2013 11:12:18 +0200 (CEST)
In-Reply-To: <1370927416-12216-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, swarren@nvidia.com, swarren@wwwdotorg.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============3892838283859597420==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B8YbZbqleQryf2nq"
Content-Disposition: inline


--B8YbZbqleQryf2nq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 11, 2013 at 01:10:16PM +0800, bardliao@realtek.com wrote:

> Signed-off-by: Bard Liao <bardliao@realtek.com>
> Signed-off-by: Stephen Warren <swarren@nvidia.com>

I don't think that signoff for Stephen is right...

> +static int rt5640_set_bias_level(struct snd_soc_codec *codec,
> +			enum snd_soc_bias_level level)
> +{
> +	struct rt5640_priv *rt5640 = snd_soc_codec_get_drvdata(codec);
> +	switch (level) {
> +	case SND_SOC_BIAS_STANDBY:
> +		if (SND_SOC_BIAS_OFF == codec->dapm.bias_level) {
> +			regcache_cache_only(rt5640->regmap, false);

You mark the device cache only in suspend so for symmetry this should
really be in _BIAS_OFF, especially since the device is idle_bias_off so
it'll be able to power off without a full suspend.

> +	if (rt5640->pdata.ldo1_en) {
> +		ret = devm_gpio_request_one(&i2c->dev, rt5640->pdata.ldo1_en,
> +					    GPIOF_OUT_INIT_HIGH,
> +					    "RT5640 LDO1_EN");
> +		if (ret < 0) {
> +			dev_err(&i2c->dev, "Failed to request LDO1_EN %d: %d\n",
> +				rt5640->pdata.ldo1_en, ret);
> +			return ret;
> +		}
> +		msleep(400);
> +	}

I'd expect to see some handling fo the LDO over suspend but that can be
dealt with in a followup as previously discussed.  Ideally we'd be able
to power off when in _BIAS_OFF too but if it's going to take 400ms to
ramp the LDO (which does seem high) that might be an issue.

--B8YbZbqleQryf2nq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJRtunpAAoJELSic+t+oim9phIP/1VXHC31t1Bp9CfE65zuGNnM
Z9dSFkAMKlDfSRu0wKx9FTEHRI/VYLx4ipDq9wtj3awzfd8YbE2r9ZfxM+bdwgfI
yskfKQOi7dI9qFHEoy6ePNJg1J+UqmrrZFaI2AaI6AVvffpoR3/ybeJUgccsmRZE
QPr2WtRUFcDp++/NRz7uRUS9Ebn1GbdKI0JQicFXfTWr1LVx1jVuMFAFMV88tQjM
YZYU+T9q04UkH2yA4CQ1wTSsX5CbteUGs04jQtDP7t6Br8V034mvfMYdpuZ5Fzcs
HnuqlRh9bxv0TQX5AxY4/nV1pxly/CEo8o4OaLY3zY6j+HRkEqGnQl7Z9fAfnUde
rzsRQ41vZ3zqnQzoa4bIDmzYBZOkeR0tghYrs3+RhF97ItjNp7CnRPvMxf2lmhMl
e2VfT7MW05pEGP1+I37z5ucpeDn0hYRqkqkoVYBO0Nf3gu0AEXk6I02E3++QjkcW
yQ/NmAL+Ri0S8kqHbVEfNCkQTJYoVkaqI9HFdxRCkn5mWbI68tO8PoUJmm0Z9/7j
ZSwMDxBmAxF/tp6q/nYwQr/ZK3hBrabVkFyC7cbQy9DhIAl26f+NP8I72+ZC0tz+
vJpGindxpdGWy7xcMkgmfJLrxT5WCS+4NCA8/fH/6NfcAsbdz5ZDjj3rjTuRH9S4
Q6CYlDAUzIpxpdp2IE/J
=boa0
-----END PGP SIGNATURE-----

--B8YbZbqleQryf2nq--

--===============3892838283859597420==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3892838283859597420==--
