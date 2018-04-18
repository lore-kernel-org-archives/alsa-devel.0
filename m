From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/5] ASoC: add mt6351 codec driver
Date: Wed, 18 Apr 2018 17:40:40 +0100
Message-ID: <20180418164040.GG10061@sirena.org.uk>
References: <20180416003252.4177-1-kaichieh.chuang@mediatek.com>
 <20180416003252.4177-2-kaichieh.chuang@mediatek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5079040343173244405=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A729B26767A
 for <alsa-devel@alsa-project.org>; Wed, 18 Apr 2018 18:40:48 +0200 (CEST)
In-Reply-To: <20180416003252.4177-2-kaichieh.chuang@mediatek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: KaiChieh Chuang <kaichieh.chuang@mediatek.com>
Cc: alsa-devel@alsa-project.org, garlic.tseng@mediatek.com, linux-mediatek@lists.infradead.org, chipeng.chang@mediatek.com, wsd_upstream@mediatek.com
List-Id: alsa-devel@alsa-project.org


--===============5079040343173244405==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="w/VI3ydZO+RcZ3Ux"
Content-Disposition: inline


--w/VI3ydZO+RcZ3Ux
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 16, 2018 at 08:32:48AM +0800, KaiChieh Chuang wrote:

This looks pretty good, a couple of small things but nothing major here:

> +	offset = idx > old_idx ? idx - old_idx : old_idx - idx;
> +	reg_idx = old_idx;

These ternery statements would probably be clearer as regular if
statements.

> +/* dl pga gain */
> +static const char *const dl_pga_gain[] = {
> +	"8Db", "7Db", "6Db", "5Db", "4Db",
> +	"3Db", "2Db", "1Db", "0Db", "-1Db",
> +	"-2Db", "-3Db", "-4Db", "-5Db", "-6Db",
> +	"-7Db", "-8Db", "-9Db", "-10Db", "-40Db",
> +};

These gains should be put in TLVs rather than an enum so userspace can
handle them (also it should be dB not Db).  You can handle irregular
step sizes like these with DECLARE_TLV_DB_SCALE(), there's several
examples in the code already.

> +static int dl_pga_get(struct snd_kcontrol *kcontrol,
> +		      struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
> +	struct mt6351_priv *priv = snd_soc_codec_get_drvdata(codec);
> +
> +	ucontrol->value.integer.value[0] = priv->ana_gain[kcontrol->id.device];
> +
> +	if (ucontrol->value.integer.value[0] == 0x1f)	/* reg idx for -40dB*/
> +		ucontrol->value.integer.value[0] = ARRAY_SIZE(dl_pga_gain) - 1;

Why do this rewriting?

> +/* ul pga gain */
> +static const char *const ul_pga_gain[] = {
> +	"0Db", "6Db", "12Db", "18Db", "24Db", "30Db",
> +};

This should be a regular control with a TLV too.

> +static const struct snd_kcontrol_new mt6351_snd_ul_controls[] = {
> +	MT_SOC_ENUM_EXT_ID("Audio_PGA1_Setting", ul_pga_enum[0],
> +			   ul_pga_get, ul_pga_set,
> +			   AUDIO_ANALOG_VOLUME_MICAMP1),

Volume controls should have names ending with " Volume" so userspace
knows how to handle them.

> +static int mt6351_codec_probe(struct snd_soc_codec *codec)
> +{
> +	struct mt6351_priv *priv = snd_soc_codec_get_drvdata(codec);
> +
> +	/* add codec controls */
> +	snd_soc_add_codec_controls(codec,
> +				   mt6351_snd_controls,
> +				   ARRAY_SIZE(mt6351_snd_controls));
> +	snd_soc_add_codec_controls(codec,
> +				   mt6351_snd_ul_controls,
> +				   ARRAY_SIZE(mt6351_snd_ul_controls));
> +
> +	mt6351_codec_init_reg(codec);
> +
> +	priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTL] = 8;
> +	priv->ana_gain[AUDIO_ANALOG_VOLUME_HPOUTR] = 8;
> +	priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP1] = 3;
> +	priv->ana_gain[AUDIO_ANALOG_VOLUME_MICAMP2] = 3;
> +
> +	return 0;
> +}

Can we read the configuration of the device back from the hardware?
It's better to just use the defaults rather than set things up for a
particular use case, that way there's a standard that can be agreed even
if it's not good for every use case.

> +static struct snd_soc_codec_driver mt6351_soc_codec_driver = {
> +	.probe = mt6351_codec_probe,
> +	.get_regmap = mt6351_get_regmap,

We're just about to remove CODEC drivers entirely and replace them with
components - nothing else is using the get_regmap() callback.  Do you
really need that callback, if you do we should just add it to the
component interface?

> +	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);

This should be the default behaviour so I'm guessing you don't need the
callback?

--w/VI3ydZO+RcZ3Ux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlrXdQgACgkQJNaLcl1U
h9Buqgf/T5vQN0h3AI2agycQaLVw7iJxCk09Jj0Bs9QtXVosVEw8hMWwz5F6Z8yY
7ylyTvli3TahDxax28If3q9DdUzaLEEvbMlbghQcIX3oozmCbkDmsyN/QscynEXs
rbWxhsJKwwCa3m0Iixm3e16RTcKWxsoqRKKrdwPofqtETrAyB/YJINA9gB3Oefcx
79VSh777KzU6A8kU6vVyH1XXeXqc/cVYpY2qZI/u6G0EcXLSnjDGsW8wKCi8KWXt
RSu2J6iVSCT2b7nT/OfuWhPU5UYQr3gwYspJzocmRDxOGbJONseIpXqd8N9h1SEe
GY9T0I8IJdXtCa+lhLEVDKQXIkdrew==
=lRci
-----END PGP SIGNATURE-----

--w/VI3ydZO+RcZ3Ux--

--===============5079040343173244405==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5079040343173244405==--
