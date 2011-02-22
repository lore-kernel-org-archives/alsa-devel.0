From: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v4] ASoC: Add Freescale SGTL5000 codec
	support
Date: Tue, 22 Feb 2011 14:43:19 +0100
Message-ID: <20110222134319.GA7381@pengutronix.de>
References: <1298246965-22575-1-git-send-email-zhaoming.zeng@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id A2F5A2452C
	for <alsa-devel@alsa-project.org>; Tue, 22 Feb 2011 14:43:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1298246965-22575-1-git-send-email-zhaoming.zeng@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: zhaoming.zeng@freescale.com
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, timur.tabi@gmail.com, zengzm.kernel@gmail.com, linuxzsc@gmail.com, arnaud.patard@rtp-net.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Hi Zeng,

I finally got some time testing this. I did not get it to work
yet, but some comments inline.

Sascha

On Mon, Feb 21, 2011 at 08:09:25AM +0800, zhaoming.zeng@freescale.com wrote:
> +
> +/* regulator supplies for sgtl5000, VDDD is an option external supply */
> +enum sgtl5000_regulator_supplies {
> +	VDDA,
> +	VDDIO,
> +	VDDD,
> +	SGTL5000_SUPPLY_NUM
> +};
> +
> +/* vddd is optinal supply */

Should be 'optional'

> +
> +	/* set devided factor of frame clock */

'divided'

> +	switch (sys_fs / frame_rate) {
> +	case 4:
> +		clk_ctl |= SGTL5000_RATE_MODE_DIV_4 << SGTL5000_RATE_MODE_SHIFT;
> +		break;
> +	case 2:
> +		clk_ctl |= SGTL5000_RATE_MODE_DIV_2 << SGTL5000_RATE_MODE_SHIFT;
> +		break;
> +	case 1:
> +		clk_ctl |= SGTL5000_RATE_MODE_DIV_1 << SGTL5000_RATE_MODE_SHIFT;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	/* set the sys_fs accroding to frame rate */

Should be 'according'. This typo is present three more times in the
patch.

> +	switch (sys_fs) {
> +	case 32000:
> +		clk_ctl |= SGTL5000_SYS_FS_32k << SGTL5000_SYS_FS_SHIFT;
> +		break;
> +	case 44100:
> +		clk_ctl |= SGTL5000_SYS_FS_44_1k << SGTL5000_SYS_FS_SHIFT;
> +		break;
> +	case 48000:
> +		clk_ctl |= SGTL5000_SYS_FS_48k << SGTL5000_SYS_FS_SHIFT;
> +		break;
> +	case 96000:
> +		clk_ctl |= SGTL5000_SYS_FS_96k << SGTL5000_SYS_FS_SHIFT;
> +		break;
> +	default:
> +		dev_err(codec->dev, "frame rate %d not supported\n",
> +			frame_rate);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * calculate the divider of mclk/sample_freq,
> +	 * factor of freq =96k can only be 256, since mclk in range (12m,27m)
> +	 */
> +	switch (sgtl5000->sysclk / sys_fs) {
> +	case 256:
> +		clk_ctl |= SGTL5000_MCLK_FREQ_256FS <<
> +			SGTL5000_MCLK_FREQ_SHIFT;
> +		break;
> +	case 384:
> +		clk_ctl |= SGTL5000_MCLK_FREQ_384FS <<
> +			SGTL5000_MCLK_FREQ_SHIFT;
> +		break;
> +	case 512:
> +		clk_ctl |= SGTL5000_MCLK_FREQ_512FS <<
> +			SGTL5000_MCLK_FREQ_SHIFT;
> +		break;
> +	default:
> +		/* if mclk not satisify the divider, use pll */
> +		if (sgtl5000->master)
> +			clk_ctl |= SGTL5000_MCLK_FREQ_PLL <<
> +				SGTL5000_MCLK_FREQ_SHIFT;
> +		else {

If one branch of an if statement has braces than the other should
have them too.

> +			pr_err("%s: PLL not supported in slave mode\n",
> +				__func__);

should be dev_err like already used elsewhere in this function.

> +
> +static int sgtl5000_enable_regulators(struct snd_soc_codec *codec)
> +{
> +	u16 reg;
> +	int ret;
> +	int rev, i;
> +	int external_vddd = 0;
> +	struct sgtl5000_priv *sgtl5000 = snd_soc_codec_get_drvdata(codec);
> +
> +	for (i = 0; i < ARRAY_SIZE(sgtl5000->supplies); i++)
> +		sgtl5000->supplies[i].supply = supply_names[i];
> +
> +	ret = regulator_bulk_get(codec->dev, ARRAY_SIZE(sgtl5000->supplies),
> +				sgtl5000->supplies);
> +	if (!ret)
> +		external_vddd = 1;
> +	else {
> +		/* set internal ldo to 1.2v */
> +		int voltage = LDO_VOLTAGE;
> +
> +		sgtl5000->supplies[VDDD].supply = LDO_CONSUMER_NAME;
> +
> +		ret = ldo_regulator_register(codec, &ldo_init_data, voltage);
> +		if (ret) {
> +			dev_err(codec->dev,
> +			"Failed to register vddd internal supplies: %d\n",
> +				ret);
> +			return ret;
> +		}
> +		ret = regulator_bulk_get(codec->dev,
> +				ARRAY_SIZE(sgtl5000->supplies),
> +				sgtl5000->supplies);
> +
> +		if (ret) {
> +			ldo_regulator_remove(codec);
> +			dev_err(codec->dev,
> +				"Failed to request supplies: %d\n", ret);
> +
> +			return ret;
> +		}
> +	}
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
> +					sgtl5000->supplies);
> +	if (ret)
> +		goto err_regulator_free;
> +
> +	/* wait for all power rails bring up */
> +	udelay(10);
> +
> +	/* read chip information */
> +	reg = snd_soc_read(codec, SGTL5000_CHIP_ID);
> +	if (((reg & SGTL5000_PARTID_MASK) >> SGTL5000_PARTID_SHIFT) !=
> +	    SGTL5000_PARTID_PART_ID) {
> +		dev_err(codec->dev,
> +			"Device with ID register %x is not a sgtl5000\n", reg);
> +		ret = -ENODEV;
> +		goto err_regulator_disable;
> +	}
> +
> +	rev = (reg & SGTL5000_REVID_MASK) >> SGTL5000_REVID_SHIFT;
> +	dev_info(codec->dev, "sgtl5000 revision %d\n", rev);
> +
> +	/*
> +	 * workaround for revision 0x11 and later,
> +	 * roll back to use internal LDO
> +	 */
> +	if (external_vddd && rev >= 0x11) {
> +		int voltage = LDO_VOLTAGE;
> +		/* disable all regulator first */
> +		regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
> +					sgtl5000->supplies);
> +		/* free VDDD regulator */
> +		regulator_put(sgtl5000->supplies[VDDD].consumer);
> +
> +		sgtl5000->supplies[VDDD].supply = LDO_CONSUMER_NAME;
> +
> +		ret = ldo_regulator_register(codec, &ldo_init_data, voltage);
> +		if (ret)
> +			return ret;
> +
> +		ret = regulator_bulk_get(codec->dev,
> +				ARRAY_SIZE(sgtl5000->supplies),
> +				sgtl5000->supplies);

If I understand this correctly you want to replace VDDD with the just
registered regulator. You freed one regulator from the array, so
instead of requesting them all again this should be:

		sgtl5000->supplies[VDDD].consumer =
			regulator_get(codec->dev, sgtl5000->supplies[VDDD].supply);

> +		if (ret) {
> +			ldo_regulator_remove(codec);
> +			dev_err(codec->dev,
> +				"Failed to request supplies: %d\n", ret);
> +
> +			return ret;
> +		}
> +
> +		ret = regulator_bulk_enable(ARRAY_SIZE(sgtl5000->supplies),
> +						sgtl5000->supplies);
> +		if (ret)
> +			goto err_regulator_free;
> +	}
> +
> +	return 0;
> +
> +err_regulator_disable:
> +	regulator_bulk_disable(ARRAY_SIZE(sgtl5000->supplies),
> +				sgtl5000->supplies);
> +err_regulator_free:
> +	regulator_bulk_free(ARRAY_SIZE(sgtl5000->supplies),
> +				sgtl5000->supplies);
> +	if (external_vddd)
> +		ldo_regulator_remove(codec);
> +	return ret;
> +
> +}
> +static int sgtl5000_probe(struct snd_soc_codec *codec)

please add a blank line between two functions.

> +{
> +	int ret;
> +

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
