From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add RT5677 CODEC driver
Date: Sun, 1 Jun 2014 20:19:13 +0100
Message-ID: <20140601191913.GP5099@sirena.org.uk>
References: <1401107553-314-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2157176247544451978=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BF2A3265475
 for <alsa-devel@alsa-project.org>; Sun,  1 Jun 2014 21:19:29 +0200 (CEST)
In-Reply-To: <1401107553-314-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: bardliao@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============2157176247544451978==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jZ6LB7VX2Q2qroxd"
Content-Disposition: inline


--jZ6LB7VX2Q2qroxd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 26, 2014 at 08:32:33PM +0800, Oder Chiou wrote:
> This patch adds the Realtek ALC5677 codec driver.

This looks nice but some minor things need fixing.  Since they're so
minor especially in the context of such a large and generally good
driver I've gone ahead and applied this, please submit followup patches
for the issues below.

> +	/* ADC Boost Volume Control */
> +	SOC_DOUBLE_TLV("STO1 ADC Boost Gain", RT5677_STO1_2_ADC_BST,
> +		RT5677_STO1_ADC_L_BST_SFT, RT5677_STO1_ADC_R_BST_SFT, 3, 0,
> +		adc_bst_tlv),

Gain controls of all kinds should be called Volume so UIs do the right
thing.

> +static const struct snd_kcontrol_new rt5677_sto2_dmic_mux =
> +	SOC_DAPM_ENUM("Stereo2 DMIC source", rt5677_stereo2_dmic_enum);

The general style is to capitalise each word so "Stereo2 DMIC Source".

> +static int rt5677_set_micbias1_event(struct snd_soc_dapm_widget *w,
> +	struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_codec *codec = w->codec;
> +	struct rt5677_priv *rt5677 = snd_soc_codec_get_drvdata(codec);
> +
> +	switch (event) {
> +	case SND_SOC_DAPM_POST_PMU:
> +		regmap_update_bits(rt5677->regmap, RT5677_PWR_ANLG2,
> +			RT5677_PWR_CLK_MB1 | RT5677_PWR_PP_MB1 |
> +			RT5677_PWR_CLK_MB, RT5677_PWR_CLK_MB1 |
> +			RT5677_PWR_PP_MB1 | RT5677_PWR_CLK_MB);

What does this do - I note we never undo this?

> +	/* Input Side */
> +	/* micbias */
> +	SND_SOC_DAPM_SUPPLY("micbias1", RT5677_PWR_ANLG2, RT5677_PWR_MB1_BIT,
> +		0, rt5677_set_micbias1_event, SND_SOC_DAPM_POST_PMU),

Idiomaticlaly this would be "MICBIAS1".

> +static int __init rt5677_modinit(void)
> +{
> +	return i2c_add_driver(&rt5677_i2c_driver);
> +}
> +module_init(rt5677_modinit);
> +
> +static void __exit rt5677_modexit(void)
> +{
> +	i2c_del_driver(&rt5677_i2c_driver);
> +}
> +module_exit(rt5677_modexit);

module_i2c_driver().

--jZ6LB7VX2Q2qroxd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIbBAEBAgAGBQJTi3yuAAoJELSic+t+oim9IDIP9jbz6k9Lr3Y30xyjkfGWFbEp
hLisxV7eGvrO7hyuyaKNDEWuAmrx3kAhuF3XGhs7Fh4AxTDRvfxW944r7jTzU1nT
C/TB0PmIv5V1ikfZM9/cqg81H051UrNw2Ztd91qfqWR2l6VJ1dBZ0PaAlw9+S6Ou
sr3E12D4j5Ob3NXEot9ZetgiG6OY2BwGN2h5/4SJZ05sPhqsNkwRDSy2YBdzMPU0
w7GTMxaRptU0DnXq/vUFl3s33JsgNazN51bs6yrbS65SwJraDqO2xbaD73NXBDP1
aBbxtCqa1ZFRhWOFtlXTFf+JOVPCtfPkto2hWsPwdfg7SSsnfdpuAqSItwTnds0H
tnTqOKqFWjyyVVvf7Q8esJk+fWZxNMOQW0B2rDQIFNN3xCEAEZZa3V5gAPKoTr3d
z+n3dFGxeUIYz1SYuDY6LNnF2sKw0C0zHofuG7lMWyX2gV9KRZ583ATj7PaXR00W
1+Hd+GHVcXxV6ro6ohZUtoP7wKTVaZlY+LXRws94755kWL38h/2fqk7oX83mWb3q
vbuDdZWa1CanU3uMnZRIwBghaokxBr6ewoVeeYDATpG8CGBV/jVq95vB8BQrRVv5
nL2zSN52GL/R961amVfXeKuRRyFuGi0zNXnkr+hYHc8w5mpsMm0i/hlC12KuX5X5
vXJP94ajlwE4zxcqUd0=
=ibLy
-----END PGP SIGNATURE-----

--jZ6LB7VX2Q2qroxd--

--===============2157176247544451978==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2157176247544451978==--
