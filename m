From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 1/2] ASoC: cs43130: Add support for CS43130 codec
Date: Thu, 15 Dec 2016 12:12:06 +0000
Message-ID: <20161215121206.7yj6in4m7s7hwgnj@sirena.org.uk>
References: <4c1d62fd-3bcf-4996-a942-bfcf6d7dce52@EX4.ad.cirrus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="emjjei6p5omoodfy"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <4c1d62fd-3bcf-4996-a942-bfcf6d7dce52-k7YZYYsDncjfk+Ne4bZl5AC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
Cc: alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org, Paul.Handrigan-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--emjjei6p5omoodfy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 13, 2016 at 11:47:06AM -0600, Li Xu wrote:

> +	dev_dbg(codec->dev, "%s: cs43130->mclk =3D %d, cs43130->pll_out =3D %d",
> +		__func__, cs43130->mclk, cs43130->pll_out);

If the standard style for logging output in the kernel were to include
the function name then dev_ would already do that.  It isn't so they
don't - I think I also saw this affecting some of the non-debugging
messages.

> +				if (cs43130->xtal_ibias > 0) {
> +					usleep_range(1000, 1050);
> +					/*PDN_XTAL =3D 0,enable*/

To repeat what I said last time:

| Please use the standard kernel coding style, need spaces here.

Please don't ignore review comments, people are generally making them
for a reason and are likely to have the same concerns if issues remain
unaddressed.  Having to repeat the same comments can get repetitive and
make people question the value of time spent reviewing.  If you disagree
with the review comments that's fine but you need to reply and discuss
your concerns so that the reviewer can understand your decisions.

> +					regmap_update_bits(cs43130->regmap,
> +						CS43130_PWDN_CTL,
> +						CS43130_PDN_XTAL_MASK,
> +						0 << CS43130_PDN_XTAL_SHIFT);
> +				}
> +
> +				/* PLL_START =3D 0, disable PLL_START */
> +				regmap_update_bits(cs43130->regmap,
> +					CS43130_PLL_SET_1,
> +					CS43130_PLL_START_MASK,
> +				    0 << CS43130_PLL_START_MASK);

The indentation style here isn't consistent even between the two
adjacent function calls :( .  The first one is more the normal coding
style for the kernel, keeping each row of arguments aligned.

I'm picking up a lot of coding style stuff here - it really is
important, people read as much by pattern matching as by reading
individual letters so it does make it harder for people and poor coding
style also tends to be a very good indicator that there's other problems
in the code with poor understanding of APIs and so on.

> +	bitwidth =3D (cs43130->dai_bit+1)*8;

Coding style, use spaces.

> +	SOC_SINGLE("Swap L/R", CS43130_PCM_PATH_CTL_2, 1, 1, 0),
> +	SOC_SINGLE("Copy L/R", CS43130_PCM_PATH_CTL_2, 0, 1, 0),

These should really be DAPM muxes.

> +		/* ASP_3ST =3D 0 in master mode */
> +		if (cs43130->dai_mode)
> +			regmap_update_bits(cs43130->regmap, CS43130_PAD_INT_CFG,
> +						    0x01, 0x00);

Again, why do we never need to undo this?  If we never need to undo it
why not just do it unconditionally on probe?

> +	 SND_SOC_DAPM_DAC_E("HiFi DAC",
> +		NULL, CS43130_PWDN_CTL, CS43130_PDN_HP_SHIFT, 1,
> +		cs43130_dac_event,
> +		(SND_SOC_DAPM_PRE_PMD)
> +		),

Like I said last time:

| There's no need for the ); to be on a new line here, nor for the extra
| indentation on the line before.  There are lots more coding style
| issues, checkpatch will probably pick up many of them.

You also don't need the brackets around the DAPM constants.

> +	regmap_read(cs43130->regmap, CS43130_PCM_PATH_CTL_1, &reg);
> +	mute_reg =3D reg & 0xfc;
> +	if (mute)
> +		regmap_write(cs43130->regmap, CS43130_PCM_PATH_CTL_1,
> +			mute_reg | 0x03);
> +	else
> +		regmap_write(cs43130->regmap, CS43130_PCM_PATH_CTL_1, mute_reg);

This looks like you're open coding regmap_update_bits().

> +	if (freq_in < 9600000 || freq_in > 26000000) {
> +		dev_err(codec->dev,
> +			"unsupported pll input reference clock:%d\n", freq_in);
> +		return -EINVAL;
> +	}
> +
> +	switch (freq_in) {
> +	case 9600000:
> +	case 11289600:
> +	case 12000000:
> +	case 12288000:
> +	case 13000000:
> +	case 19200000:
> +	case 22579200:
> +	case 24000000:
> +	case 24576000:
> +	case 26000000:
> +		cs43130->mclk =3D freq_in;
> +		break;
> +	default:
> +		dev_err(codec->dev,
> +			"unsupported pll input reference clock:%d\n", freq_in);
> +		return -EINVAL;
> +	}

You've got both a range check and a list of explicit supported
frequencies here - surely the range check is redundant?

> +	/* Read all INT status and mask reg */
> +	regmap_bulk_read(cs43130->regmap, CS43130_INT_STATUS_1,
> +		stickies, CS43130_NUM_INT * sizeof(unsigned int));
> +	regmap_bulk_read(cs43130->regmap, CS43130_INT_MASK_1,
> +		masks, CS43130_NUM_INT * sizeof(unsigned int));

These are going to be buffer overflows, regmap bulk_read() takes a
number of registers to read not a number of bytes.

> +	default:
> +		dev_info(&i2c_client->dev,
> +			"cirrus,xtal-ibias value or xtal unused %d",
> +			val);
> +	}

Missing break and this should be an error.

> +	/* Enable interrupt handler */
> +	ret =3D devm_request_threaded_irq(&client->dev,
> +			client->irq,
> +			NULL, cs43130_irq_thread,
> +			IRQF_ONESHOT | IRQF_TRIGGER_LOW,
> +			"cs43130", cs43130);
> +	if (ret !=3D 0) {
> +		dev_err(&client->dev, "Failed to request IRQ: %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Unmask INT */
> +	regmap_update_bits(cs43130->regmap, CS43130_INT_MASK_1,
> +		CS43130_XTAL_RDY_INT | CS43130_XTAL_ERR_INT, 0);

We don't mask the interrupts when removing the driver.  This means the
interrupt could fire as the device is being unbound which might crash
since the interrupt handler will still be registered as you're using
devm_ here.  It's generally better not to use devm_ for interrupts, it's
hard to get right.

> +	pm_runtime_disable(&client->dev);

We never enabled runtime PM.

> +	regulator_bulk_disable(CS43130_NUM_SUPPLIES,
> +		cs43130->supplies);

The indentation of the second line here is weird - normally it'd be

> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int cs43130_runtime_suspend(struct device *dev)
> +{
> +	struct cs43130_private *cs43130 =3D dev_get_drvdata(dev);
> +
> +	regcache_cache_only(cs43130->regmap, true);
> +	regcache_mark_dirty(cs43130->regmap);
> +
> +	gpiod_set_value_cansleep(cs43130->reset_gpio, 0);
> +
> +	regulator_bulk_disable(CS43130_NUM_SUPPLIES,
> +		cs43130->supplies);
> +	return 0;
> +}
> +
> +static int cs43130_runtime_resume(struct device *dev)
> +{
> +	struct cs43130_private *cs43130 =3D dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret =3D regulator_bulk_enable(CS43130_NUM_SUPPLIES,
> +		cs43130->supplies);
> +	if (ret !=3D 0) {
> +		dev_err(dev, "Failed to enable supplies: %d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	regcache_cache_only(cs43130->regmap, false);
> +
> +	gpiod_set_value_cansleep(cs43130->reset_gpio, 1);
> +
> +	usleep_range(2000, 2050);
> +
> +	ret =3D regcache_sync(cs43130->regmap);
> +	if (ret !=3D 0) {
> +		dev_err(dev, "Failed to restore register cache\n");
> +		goto err;
> +	}
> +	return 0;
> +err:
> +	regcache_cache_only(cs43130->regmap, true);
> +	regulator_bulk_disable(CS43130_NUM_SUPPLIES,
> +		cs43130->supplies);
> +
> +	return ret;
> +}
> +#endif
> +
> +static const struct dev_pm_ops cs43130_runtime_pm =3D {
> +	SET_RUNTIME_PM_OPS(cs43130_runtime_suspend, cs43130_runtime_resume,
> +			   NULL)
> +};
> +
> +static const struct of_device_id cs43130_of_match[] =3D {
> +	{ .compatible =3D "cirrus,cs43130", },
> +	{},
> +};
> +
> +MODULE_DEVICE_TABLE(of, cs43130_of_match);
> +
> +static const struct i2c_device_id cs43130_i2c_id[] =3D {
> +	{"cs43130", 0},
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, cs43130_i2c_id);
> +
> +static struct i2c_driver cs43130_i2c_driver =3D {
> +	.driver =3D {
> +		.name		=3D "cs43130",
> +		.of_match_table	=3D cs43130_of_match,
> +	},
> +	.id_table	=3D cs43130_i2c_id,
> +	.probe		=3D cs43130_i2c_probe,
> +	.remove		=3D cs43130_i2c_remove,
> +};
> +
> +module_i2c_driver(cs43130_i2c_driver);
> +
> +MODULE_AUTHOR("Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>");
> +MODULE_DESCRIPTION("Cirrus Logic CS43130 ALSA SoC Codec Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/sound/soc/codecs/cs43130.h b/sound/soc/codecs/cs43130.h
> new file mode 100644
> index 0000000..bceae76
> --- /dev/null
> +++ b/sound/soc/codecs/cs43130.h
> @@ -0,0 +1,268 @@
> +/*
> + * ALSA SoC CS43130 codec driver
> + *
> + * Copyright 2016 Cirrus Logic, Inc.
> + *
> + * Author: Li Xu <li.xu-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License
> + * version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful, but
> + * WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
> + * General Public License for more details.
> + *
> + */
> +
> +#ifndef __CS43130_H__
> +#define __CS43130_H__
> +
> +/* CS43130 registers addresses */
> +/* all reg address is shifted by a byte for control byte to be LSB */
> +#define CS43130_FIRSTREG	0x010000
> +#define CS43130_LASTREG		0x0F0014
> +#define CS43130_CHIP_ID		0x00043130
> +#define CS4399_CHIP_ID		0x00043990
> +#define CS43130_DEVID_AB	0x010000         /*Device ID A & B [RO]*/
> +#define CS43130_DEVID_CD	0x010001         /*Device ID C & D [RO]*/
> +#define CS43130_DEVID_E		0x010002         /*Device ID E [RO]*/
> +#define CS43130_FAB_ID		0x010003         /*Fab ID [RO]*/
> +#define CS43130_REV_ID		0x010004         /*Revision ID [RO]*/
> +#define CS43130_SUBREV_ID	0x010005         /*Subrevision ID*/
> +#define CS43130_SYS_CLK_CTL_1	0x010006      /*System Clocking Ctl 1*/
> +#define CS43130_SP_SRATE	0x01000B         /*Serial Port Sample Rate*/
> +#define CS43130_SP_BITSIZE	0x01000C         /*Serial Port Bit Size*/
> +#define CS43130_PAD_INT_CFG	0x01000D      /*Pad Interface Config*/
> +#define CS43130_DXD1            0x010010        /*DXD1*/
> +#define CS43130_PWDN_CTL	0x020000         /*Power Down Ctl*/
> +#define CS43130_DXD2            0x020019        /*DXD2*/
> +#define CS43130_CRYSTAL_SET	0x020052      /*Crystal Setting*/
> +#define CS43130_PLL_SET_1	0x030001         /*PLL Setting 1*/
> +#define CS43130_PLL_SET_2	0x030002         /*PLL Setting 2*/
> +#define CS43130_PLL_SET_3	0x030003         /*PLL Setting 3*/
> +#define CS43130_PLL_SET_4	0x030004         /*PLL Setting 4*/
> +#define CS43130_PLL_SET_5	0x030005         /*PLL Setting 5*/
> +#define CS43130_PLL_SET_6	0x030008         /*PLL Setting 6*/
> +#define CS43130_PLL_SET_7	0x03000A         /*PLL Setting 7*/
> +#define CS43130_PLL_SET_8	0x03001B         /*PLL Setting 8*/
> +#define CS43130_PLL_SET_9	0x040002         /*PLL Setting 9*/
> +#define CS43130_PLL_SET_10	0x040003         /*PLL Setting 10*/
> +#define CS43130_CLKOUT_CTL	0x040004         /*CLKOUT Ctl*/
> +#define CS43130_ASP_NUM_1	0x040010         /*ASP Numerator 1*/
> +#define CS43130_ASP_NUM_2	0x040011         /*ASP Numerator 2*/
> +#define CS43130_ASP_DENOM_1	0x040012      /*ASP Denominator 1*/
> +#define CS43130_ASP_DENOM_2	0x040013      /*ASP Denominator 2*/
> +#define CS43130_ASP_LRCK_HI_TIME_1 0x040014 /*ASP LRCK High Time 1*/
> +#define CS43130_ASP_LRCK_HI_TIME_2 0x040015 /*ASP LRCK High Time 2*/
> +#define CS43130_ASP_LRCK_PERIOD_1  0x040016 /*ASP LRCK Period 1*/
> +#define CS43130_ASP_LRCK_PERIOD_2  0x040017 /*ASP LRCK Period 2*/
> +#define CS43130_ASP_CLOCK_CONF	0x040018   /*ASP Clock Config*/
> +#define CS43130_ASP_FRAME_CONF	0x040019   /*ASP Frame Config*/
> +#define CS43130_XSP_NUM_1	0x040020         /*XSP Numerator 1*/
> +#define CS43130_XSP_NUM_2	0x040021         /*XSP Numerator 2*/
> +#define CS43130_XSP_DENOM_1	0x040022      /*XSP Denominator 1*/
> +#define CS43130_XSP_DENOM_2	0x040023      /*XSP Denominator 2*/
> +#define CS43130_XSP_LRCK_HI_TIME_1 0x040024 /*XSP LRCK High Time 1*/
> +#define CS43130_XSP_LRCK_HI_TIME_2 0x040025 /*XSP LRCK High Time 2*/
> +#define CS43130_XSP_LRCK_PERIOD_1  0x040026 /*XSP LRCK Period 1*/
> +#define CS43130_XSP_LRCK_PERIOD_2  0x040027 /*XSP LRCK Period 2*/
> +#define CS43130_XSP_CLOCK_CONF	0x040028   /*XSP Clock Config*/
> +#define CS43130_XSP_FRAME_CONF	0x040029   /*XSP Frame Config*/
> +#define CS43130_ASP_CH_1_LOC	0x050000      /*ASP Chan 1 Location*/
> +#define CS43130_ASP_CH_2_LOC	0x050001      /*ASP Chan 2 Location*/
> +#define CS43130_ASP_CH_1_SZ_EN	0x05000A   /*ASP Chan 1 Size, Enable*/
> +#define CS43130_ASP_CH_2_SZ_EN	0x05000B   /*ASP Chan 2 Size, Enable*/
> +#define CS43130_XSP_CH_1_LOC	0x060000      /*XSP Chan 1 Location*/
> +#define CS43130_XSP_CH_2_LOC	0x060001      /*XSP Chan 2 Location*/
> +#define CS43130_XSP_CH_1_SZ_EN	0x06000A   /*XSP Chan 1 Size, Enable*/
> +#define CS43130_XSP_CH_2_SZ_EN	0x06000B   /*XSP Chan 2 Size, Enable*/
> +#define CS43130_DSD_VOL_B	0x070000         /*DSD Volume B*/
> +#define CS43130_DSD_VOL_A	0x070001         /*DSD Volume A*/
> +#define CS43130_DSD_PATH_CTL_1	0x070002   /*DSD Proc Path Sig Ctl 1*/
> +#define CS43130_DSD_INT_CFG	0x070003      /*DSD Interface Config*/
> +#define CS43130_DSD_PATH_CTL_2	0x070004   /*DSD Proc Path Sig Ctl 2*/
> +#define CS43130_DSD_PCM_MIX_CTL	0x070005   /*DSD and PCM Mixing Ctl*/
> +#define CS43130_DSD_PATH_CTL_3	0x070006   /*DSD Proc Path Sig Ctl 3*/
> +#define CS43130_HP_OUT_CTL_1	0x080000      /*HP Output Ctl 1*/
> +#define CS43130_PCM_FILT_OPT	0x090000      /*PCM Filter Option*/
> +#define CS43130_PCM_VOL_B	0x090001         /*PCM Volume B*/
> +#define CS43130_PCM_VOL_A	0x090002         /*PCM Volume A*/
> +#define CS43130_PCM_PATH_CTL_1	0x090003   /*PCM Path Signal Ctl 1*/
> +#define CS43130_PCM_PATH_CTL_2	0x090004   /*PCM Path Signal Ctl 2*/
> +#define CS43130_CLASS_H_CTL	0x0B0000      /*Class H Ctl*/
> +#define CS43130_HP_DETECT	0x0D0000         /*HP Detect*/
> +#define CS43130_HP_STATUS	0x0D0001         /*HP Status [RO]*/
> +#define CS43130_HP_LOAD_1	0x0E0000         /*HP Load 1*/
> +#define CS43130_HP_MEAS_LOAD_1	0x0E0003   /*HP Load Measurement 1*/
> +#define CS43130_HP_MEAS_LOAD_2	0x0E0004   /*HP Load Measurement 2*/
> +#define CS43130_HP_DC_STAT_1	0x0E000D      /*HP DC Load Status 0 [RO]*/
> +#define CS43130_HP_DC_STAT_2	0x0E000E      /*HP DC Load Status 1 [RO]*/
> +#define CS43130_HP_AC_STAT_1	0x0E0010      /*HP AC Load Status 0 [RO]*/
> +#define CS43130_HP_AC_STAT_2	0x0E0011      /*HP AC Load Status 1 [RO]*/
> +#define CS43130_HP_LOAD_STAT	0x0E001A      /*HP Load Status [RO]*/
> +#define CS43130_INT_STATUS_1	0x0F0000      /*Interrupt Status 1*/
> +#define CS43130_INT_STATUS_2	0x0F0001      /*Interrupt Status 2*/
> +#define CS43130_INT_STATUS_3	0x0F0002      /*Interrupt Status 3*/
> +#define CS43130_INT_STATUS_4	0x0F0003      /*Interrupt Status 4*/
> +#define CS43130_INT_STATUS_5	0x0F0004      /*Interrupt Status 5*/
> +#define CS43130_INT_MASK_1	0x0F0010         /*Interrupt Mask 1*/
> +#define CS43130_INT_MASK_2	0x0F0011         /*Interrupt Mask 2*/
> +#define CS43130_INT_MASK_3	0x0F0012         /*Interrupt Mask 3*/
> +#define CS43130_INT_MASK_4	0x0F0013         /*Interrupt Mask 4*/
> +#define CS43130_INT_MASK_5	0x0F0014         /*Interrupt Mask 5*/
> +
> +#define CS43130_MCLK_SRC_SEL_MASK		0x03
> +#define CS43130_MCLK_SRC_SEL_SHIFT		0
> +#define CS43130_MCLK_INT_MASK			0x04
> +#define CS43130_MCLK_INT_SHIFT			2
> +#define CS43130_SP_SRATE_MASK			0x0F
> +#define CS43130_SP_SRATE_SHIFT			0
> +#define CS43130_SP_BITSIZE_ASP_MASK		0x03
> +#define CS43130_SP_BITSIZE_ASP_SHIFT	0
> +#define CS43130_HP_DETECT_CTRL_SHIFT            6
> +#define CS43130_HP_DETECT_CTRL_MASK     (0x03 << CS43130_HP_DETECT_CTRL_=
SHIFT)
> +#define CS43130_HP_DETECT_INV_SHIFT             5
> +#define CS43130_HP_DETECT_INV_MASK      (1 << CS43130_HP_DETECT_INV_SHIF=
T)
> +
> +/* CS43130_INT_MASK_1 */
> +#define CS43130_HP_PLUG_INT_SHIFT       6
> +#define CS43130_HP_PLUG_INT             (1 << CS43130_HP_PLUG_INT_SHIFT)
> +#define CS43130_HP_UNPLUG_INT_SHIFT     5
> +#define CS43130_HP_UNPLUG_INT           (1 << CS43130_HP_UNPLUG_INT_SHIF=
T)
> +#define CS43130_XTAL_RDY_INT_SHIFT      4
> +#define CS43130_XTAL_RDY_INT            (1 << CS43130_XTAL_RDY_INT_SHIFT)
> +#define CS43130_XTAL_ERR_INT_SHIFT      3
> +#define CS43130_XTAL_ERR_INT            (1 << CS43130_XTAL_ERR_INT_SHIFT)
> +
> +/*Reg CS43130_SP_BITSIZE*/
> +#define CS43130_SP_BIT_SIZE_8			0x00
> +#define CS43130_SP_BIT_SIZE_16			0x01
> +#define CS43130_SP_BIT_SIZE_24			0x02
> +#define CS43130_SP_BIT_SIZE_32			0x03
> +
> +/*PLL*/
> +#define CS43130_PLL_START_MASK (0x1<<0)
> +#define CS43130_PLL_MODE_MASK  0x02
> +#define CS43130_PLL_MODE_SHIFT 1
> +
> +#define CS43130_PLL_REF_PREDIV_MASK 0x3
> +
> +#define CS43130_ASP_STP_MASK	0x10
> +#define CS43130_ASP_STP_SHIFT	4
> +#define CS43130_ASP_5050_MASK	0x08
> +#define CS43130_ASP_5050_SHIFT	3
> +#define CS43130_ASP_FSD_MASK	0x07
> +#define CS43130_ASP_FSD_SHIFT	0
> +
> +#define CS43130_ASP_MODE_MASK	0x10
> +#define CS43130_ASP_MODE_SHIFT	4
> +#define CS43130_ASP_SCPOL_OUT_MASK	0x08
> +#define CS43130_ASP_SCPOL_OUT_SHIFT	3
> +#define CS43130_ASP_SCPOL_IN_MASK	0x04
> +#define CS43130_ASP_SCPOL_IN_SHIFT	2
> +#define CS43130_ASP_LCPOL_OUT_MASK	0x02
> +#define CS43130_ASP_LCPOL_OUT_SHIFT	1
> +#define CS43130_ASP_LCPOL_IN_MASK	0x01
> +#define CS43130_ASP_LCPOL_IN_SHIFT	0
> +
> +/*Reg CS43130_PWDN_CTL*/
> +#define CS43130_PDN_XSP_MASK	0x80
> +#define CS43130_PDN_XSP_SHIFT	7
> +#define CS43130_PDN_ASP_MASK	0x40
> +#define CS43130_PDN_ASP_SHIFT	6
> +#define CS43130_PDN_DSPIF_MASK	0x20
> +#define CS43130_PDN_DSDIF_SHIFT	5
> +#define CS43130_PDN_HP_MASK	0x10
> +#define CS43130_PDN_HP_SHIFT	4
> +#define CS43130_PDN_XTAL_MASK	0x08
> +#define CS43130_PDN_XTAL_SHIFT	3
> +#define CS43130_PDN_PLL_MASK	0x04
> +#define CS43130_PDN_PLL_SHIFT	2
> +#define CS43130_PDN_CLKOUT_MASK	0x02
> +#define CS43130_PDN_CLKOUT_SHIFT	1
> +
> +#define CS43130_7_0_MASK		0xFF
> +#define CS43130_15_8_MASK		0xFF00
> +#define CS43130_23_16_MASK		0xFF0000
> +
> +/* Reg CS43130_HP_OUT_CTL_1 */
> +#define CS43130_HP_IN_EN_SHIFT		3
> +#define CS43130_HP_IN_EN_MASK		0x08
> +
> +#define CS43130_ASP_FORMATS (SNDRV_PCM_FMTBIT_S8  | \
> +			SNDRV_PCM_FMTBIT_S16_LE | \
> +			SNDRV_PCM_FMTBIT_S24_LE | \
> +			SNDRV_PCM_FMTBIT_S32_LE)
> +
> +#define CS43130_XSP_FORMATS (SNDRV_PCM_FMTBIT_S24_LE | \
> +			SNDRV_PCM_FMTBIT_S32_LE)
> +
> +enum cs43130_asp_rate {
> +	CS43130_ASP_SPRATE_32K =3D 0,
> +	CS43130_ASP_SPRATE_44_1K,
> +	CS43130_ASP_SPRATE_48K,
> +	CS43130_ASP_SPRATE_88_2K,
> +	CS43130_ASP_SPRATE_96K,
> +	CS43130_ASP_SPRATE_176_4K,
> +	CS43130_ASP_SPRATE_192K,
> +	CS43130_ASP_SPRATE_352_8K,
> +	CS43130_ASP_SPRATE_384K,
> +};
> +
> +enum cs43130_mclk_src_sel {
> +	CS43130_MCLK_SRC_XTAL =3D 0,
> +	CS43130_MCLK_SRC_PLL,
> +	CS43130_MCLK_SRC_RCO
> +};
> +
> +enum cs43130_mode {
> +	CS43130_SLAVE_MODE =3D 0,
> +	CS43130_MASTER_MODE
> +};
> +
> +enum cs43130_xtal_ibias {
> +	CS43130_XTAL_IBIAS_15UA =3D 2,
> +	CS43130_XTAL_IBIAS_12_5UA =3D 4,
> +	CS43130_XTAL_IBIAS_7_5UA =3D 6,
> +};
> +
> +#define CS43130_AIF_BICK_RATE 1
> +#define CS43130_SYSCLK_MCLK 1
> +#define CS43130_NUM_SUPPLIES 5
> +static const char *const cs43130_supply_names[CS43130_NUM_SUPPLIES] =3D {
> +	"VA",
> +	"VP",
> +	"VCP",
> +	"VD",
> +	"VL",
> +};
> +
> +#define CS43130_NUM_INT 5       /* number of interrupt status reg */
> +
> +struct	cs43130_private {
> +	struct snd_soc_codec		*codec;
> +	struct regmap			*regmap;
> +	struct regulator_bulk_data supplies[CS43130_NUM_SUPPLIES];
> +	/* codec device ID */
> +	unsigned int dev_id;
> +	int				mclk;
> +	int				sclk;
> +	int xtal_ibias;
> +
> +	bool pll_bypass;
> +	int pll_out;
> +	int mclk_int;
> +	int dai_format;
> +	int dai_mode;
> +	int dai_bit;
> +	int asp_size;
> +	int fs;
> +	bool bick_invert;
> +	bool lrck_invert;
> +	int bick;
> +	struct gpio_desc *reset_gpio;
> +};
> +
> +#endif	/* __CS43130_H__ */
> --=20
> 1.9.1
>=20

--emjjei6p5omoodfy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhSiJUACgkQJNaLcl1U
h9COVAf/Xq9s5tmHrhSSQAqrMxAkwVDDTfrUknEb58YlzCSwo/odRlXpocGiYQeK
/c86rSaH/y0NIb3EL4kK2xdxGwCnuVIr332Uik/PdyFfKdFRlp1L4r1xAjEq4MKO
6DDOCElCp2NfsjcqgmVPqdYwGPvCqNZYHAzsLeskmYoqJ6PjcbRV9VwFGniq9k6J
yijQ/+GBivQT4HQXBm2AOZIFY9lll1G1FIYcycHBPxYtgmQFZdMdSE3JoVxbqwTQ
ah0Zy8oRBR1dVcdhISXBMc3p9MmIlOSK0PvXL2utirQism5Z/VBFTBssG62qKm1Q
y57NaswjW4D4Od+7P8ArbP5ooxcVVw==
=pBPf
-----END PGP SIGNATURE-----

--emjjei6p5omoodfy--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
