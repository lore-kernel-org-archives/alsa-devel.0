From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: rt5668: add rt5668 codec driver
Date: Fri, 13 May 2016 13:36:41 +0100
Message-ID: <20160513123641.GO22038@sirena.org.uk>
References: <1462791463-19264-1-git-send-email-john.lin@realtek.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1343280386617779942=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id BD844260675
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 14:37:02 +0200 (CEST)
In-Reply-To: <1462791463-19264-1-git-send-email-john.lin@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Lin <john.lin@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, bardliao@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org


--===============1343280386617779942==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1bhFRg6vL9BT9osV"
Content-Disposition: inline


--1bhFRg6vL9BT9osV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 09, 2016 at 06:57:43PM +0800, John Lin wrote:

> +static bool rt5668_volatile_register(struct device *dev, unsigned int reg)
> +{
> +	switch (reg) {
> +	case 0x0000:
> +	case 0x0011:
> +	case 0x0082:

I'm not a big fan of all the magic numbers for the registers here, it's
OK if not ideal for the defaults tables since I can understand that
they're probably generated but here it's making things harder to read
and maintain.

> +static void rt5668_enable_push_button_irq(struct snd_soc_codec *codec,
> +	bool enable)
> +{
> +	struct rt5668_priv *rt5668 = snd_soc_codec_get_drvdata(codec);

This is two separate functions, there's nothing shared between the
enable and disable paths except the private data structure here.

> +		if (rt5668->codec_type == CODEC_TYPE_RT5668)
> +			snd_soc_update_bits(codec, RT5668_IRQ_3,
> +				RT5668_EN_IRQ_INLINE_MASK,
> +				RT5668_EN_IRQ_INLINE_NOR);
> +		else
> +			snd_soc_update_bits(codec, RT5668_IRQ_2,
> +				RT5663_EN_IRQ_INLINE_MASK,
> +				RT5663_EN_IRQ_INLINE_NOR);

Write this as a switch statement so future variants can be more easily
handled.  This is a common pattern in this driver.

> + */
> +
> +static int rt5663_jack_detect(struct snd_soc_codec *codec, int jack_insert)

Extra blank line.

> +{
> +	struct rt5668_priv *rt5668 = snd_soc_codec_get_drvdata(codec);
> +	int val, i = 0, sleep_time[5] = {300, 150, 100, 50, 30};
> +
> +	dev_dbg(codec->dev, "%s jack_insert:%d\n", __func__, jack_insert);
> +
> +	if (jack_insert) {
> +		while (i < 5) {
> +			msleep(sleep_time[i]);
> +			val = snd_soc_read(codec, RT5663_EM_JACK_TYPE_2) &
> +				0x0003;
> +			i++;
> +			if (val == 0x1 || val == 0x2 || val == 0x3)
> +				break;
> +			dev_dbg(codec->dev, "%s: MX-00e7 val=%x sleep %d\n",
> +				__func__, val, sleep_time[i]);
> +		}
> +		dev_dbg(codec->dev, "%s val = %d\n", __func__, val);
> +		switch (val) {
> +		case 1:
> +		case 2:

This looks like the same code as was in the detection handler, shouldn't
it be shared?

> +int rt5668_button_detect(struct snd_soc_codec *codec)
> +{
> +	int btn_type, val;
> +
> +	val = snd_soc_read(codec, RT5668_4BTN_IL_CMD_1);
> +	dev_dbg(codec->dev, "%s: val=0x%x\n", __func__, val);
> +	btn_type = val & 0xfff0;
> +	snd_soc_write(codec, RT5668_4BTN_IL_CMD_1, val);
> +
> +	return btn_type;
> +}
> +EXPORT_SYMBOL(rt5668_button_detect);

What is this and why is it exported?  Note also that all ASoC and regmap
exports are EXPORT_SYMBOL_GPL()...

> +static irqreturn_t rt5668_irq(int irq, void *data)
> +{
> +	struct rt5668_priv *rt5668 = data;
> +
> +	dev_dbg(rt5668->codec->dev, "%s IRQ queue work\n", __func__);
> +
> +	queue_delayed_work(system_wq, &rt5668->jack_detect_work,
> +		msecs_to_jiffies(250));
> +
> +	return IRQ_HANDLED;
> +}

Given that the interrupt handler just schedules a work item there's no
need for it to be a threaded interrupt, it can just be a normal
interrupt and save the bother of masking the hardware interrupt and
running a thread.

> +int rt5668_set_jack_detect(struct snd_soc_codec *codec,
> +	struct snd_soc_jack *hs_jack)
> +{
> +	struct rt5668_priv *rt5668 = snd_soc_codec_get_drvdata(codec);
> +
> +	rt5668->hs_jack = hs_jack;
> +
> +	rt5668_irq(0, rt5668);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(rt5668_set_jack_detect);

We don't need to do anything in the hardware to enable jack detection?

> +static int rt5668_set_bclk_ratio(struct snd_soc_dai *dai, unsigned int ratio)
> +{
> +	struct snd_soc_codec *codec = dai->codec;
> +	struct rt5668_priv *rt5668 = snd_soc_codec_get_drvdata(codec);
> +
> +	dev_dbg(codec->dev, "%s ratio = %d\n", __func__, ratio);
> +
> +	if (rt5668->codec_type == CODEC_TYPE_RT5663) {
> +		switch (ratio) {

No handling for the other CODEC?  Should it return an error?

> +static int rt5668_resume(struct snd_soc_codec *codec)
> +{
> +	struct rt5668_priv *rt5668 = snd_soc_codec_get_drvdata(codec);
> +
> +	regcache_cache_only(rt5668->regmap, false);
> +	regcache_sync(rt5668->regmap);

Should check the return code.

> +	/* reset and calibrate */
> +	regmap_write(rt5668->regmap, RT5668_RESET, 0);
> +	regcache_cache_bypass(rt5668->regmap, true);
> +	if (rt5668->codec_type == CODEC_TYPE_RT5668)
> +		rt5668_calibrate(rt5668);
> +	else
> +		rt5663_calibrate(rt5668);
> +	regcache_cache_bypass(rt5668->regmap, false);
> +	regmap_write(rt5668->regmap, RT5668_RESET, 0);
> +	dev_dbg(&i2c->dev, "calibrate done\n");

Do we not need to do this on resume?

> +		/* BST1 power on for JD */
> +		regmap_update_bits(rt5668->regmap, RT5668_PWR_ANLG_2,
> +			RT5668_PWR_BST1_MASK, RT5668_PWR_BST1_ON);
> +		regmap_update_bits(rt5668->regmap, RT5663_EM_JACK_TYPE_1,
> +			RT5663_CBJ_DET_MASK | RT5663_EXT_JD_MASK |
> +			RT5663_POL_EXT_JD_MASK, RT5663_CBJ_DET_EN |
> +			RT5663_EXT_JD_EN | RT5663_POL_EXT_JD_EN);

I'd expect any enables for jack detection to be done only if the system
is actually using jack detection.

> +		/* RECMIX */
> +		regmap_update_bits(rt5668->regmap, RT5663_RECMIX,
> +			RT5663_RECMIX1_BST1_MASK, RT5663_RECMIX1_BST1_UNMUTE);
> +		/* ADCDAT L/L */
> +		regmap_update_bits(rt5668->regmap, RT5668_TDM_1,
> +			RT5663_DATA_SWAP_ADCDAT1_MASK,
> +			RT5663_DATA_SWAP_ADCDAT1_LL);

This looks like routing control?

> +	setup_timer(&rt5668->btn_check_timer, rt5668_btn_check_callback,
> +		(unsigned long)rt5668);

Does this really need to be running *all* the time?

--1bhFRg6vL9BT9osV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXNcpXAAoJECTWi3JdVIfQRaQH/RllTOskkYFHNn/lQT3E49ex
qpWWhX2bSThqw4PTRMhD+0lL/pFTxB6mgt8q8WpEwSxwSP4hcGmID4D61i40gNkJ
50iFh9an5Dnwor86jzu1PzVtbwMguDFfA5pxdCMd3TSOmG2hPItInCEodjfjC4le
pZ+az09ysD6PaDBLkhVKPBMipFbw5oa6rtOlDPfY6NOPjuKioicQby4YK/pQwUVn
6VCAwHB2+wy6HAJz+TxKzRXf8lZuQ5MZAvuOhWncrjbmCpO+ircCulcL+r1w5/rR
Wuwh+yxVaprJ3hWK5coJUZ7Ifdo2zRotK6+zeSeSiEgQEx0xFqkB9Fclt+hxa5g=
=/3Cl
-----END PGP SIGNATURE-----

--1bhFRg6vL9BT9osV--

--===============1343280386617779942==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1343280386617779942==--
