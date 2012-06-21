From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH V2 2/9] sound:asoc: Add support for STA529
	Audio Codec
Date: Thu, 21 Jun 2012 13:25:40 +0100
Message-ID: <20120621122540.GV4037@opensource.wolfsonmicro.com>
References: <cover.1340273261.git.rajeev-dlh.kumar@st.com>
	<d06e4180229ac4aa0e0f27aa4d444dd7a9634afd.1340273261.git.rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0895928097652603880=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BB05B10B97A
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 13:04:31 +0200 (CEST)
In-Reply-To: <d06e4180229ac4aa0e0f27aa4d444dd7a9634afd.1340273261.git.rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org


--===============0895928097652603880==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oAjj1ZwgLg4oRN9q"
Content-Disposition: inline


--oAjj1ZwgLg4oRN9q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 21, 2012 at 03:54:50PM +0530, Rajeev Kumar wrote:
> This patch adds the support for STA529 audio codec.

As I said last time always use subject lines corresponding to the style
of the subsystem, don't make up your own style.

This is mostly OK, a few things below but nothing terribly major.

> +static int sta529_mute(struct snd_soc_dai *dai, int mute)
> +{
> +	u8 val;
> +
> +	if (mute)
> +		val |= CODEC_MUTE_VAL;

You need to initialise val otherwise it's going to have an undefined
value when you're not muting.

> +	codec->control_data = sta529->regmap;
> +	ret = snd_soc_codec_set_cache_io(codec, 8, 8, SND_SOC_I2C);

You've got a regmap, you should be using SND_SOC_REGMAP as the control
mode.

> +	snd_soc_add_codec_controls(codec, sta529_snd_controls,
> +			ARRAY_SIZE(sta529_snd_controls));
> +
> +	snd_soc_add_codec_controls(codec, sta529_new_snd_controls,
> +			ARRAY_SIZE(sta529_new_snd_controls));

Set these in the CODEC driver structure and merge the two arrays, no
point in having code for this.

> +static int sta529_resume(struct snd_soc_codec *codec)
> +{
> +	snd_soc_cache_sync(codec);

You're not using the ASoC cache code.

> +	sta529_set_bias_level(codec, SND_SOC_BIAS_STANDBY);
> +	sta529_set_bias_level(codec, codec->dapm.suspend_bias_level);

The second of these isn't needed, the core will ensure the device is in
standby before suspend.

> +	sta529->regmap = regmap_init_i2c(i2c, &sta529_regmap);
> +	if (IS_ERR(sta529->regmap)) {

devm_regmap_init_i2c() then you don't need any cleanup code for it.

> +static int __init sta529_modinit(void)
> +{
> +	int ret = 0;

module_i2c_driver.

--oAjj1ZwgLg4oRN9q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJP4xFCAAoJEBus8iNuMP3dvl0P/ib62k2yUJB1YeA6ORoVcFK9
g/zg7dbQRtjxEEnPC/WpitfHEn+GxP1OIooxZf+3xpi4gxMjtVeWIWsnZtqdAMCB
nlnVH4iDti2yEYw3UWGT1B7+yQ3uMF6QxDvVgxbC0F/lcAGQei2/SpiYZvdvMhrz
rXrdJz/TqWKGUF5MlPzd0qcVHuFeySr6qd0jrnnqrjhIIQjrPnNzmG/G9I7RwHqZ
2Pi3+MPOjJHtqqgsSi926jLESbnDCBT/1++xSDIa4PgYS7HNNTNREbJhHBvlQTxa
tBFY0pM4y//QhKl6MAwqARpdU6f+WV0CJiTGHYwYFkKG7SEV28J23UGijUuHMJKX
iwMfQrU5yVZNqBa3lXQgZLg7VfSdcLiiYgy56JZIKkA44ijbID+i+nJbisWSfu2K
Qdx9ar8+EYi4JiIK8glJeAOTjM7xpXg9cyjzL0AJo6hh8EPpiQ41goePZQIzTXhN
OBysFFZyxj+l3qQKFG583GyHzJ6Be15GcT2A723DSTG9N6gcTkWZOSbVJCdisvIh
HGRXvVF1m0gP41VV+KX+4WaIfEHGbYYwB8Ekga44r0Dowey7jpMSAs5pY9R0YNAX
gVesbsMeX85Fh3udn9Ra+Sbe+BJ/6LXlZTIc7x6qB7BnRDA4ee/VapMx3UerpnP+
gSaY7LisV0VcxOTeehYV
=0mmF
-----END PGP SIGNATURE-----

--oAjj1ZwgLg4oRN9q--

--===============0895928097652603880==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0895928097652603880==--
