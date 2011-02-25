From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v5] ASoC: Add Freescale SGTL5000 codec
	support
Date: Fri, 25 Feb 2011 12:09:06 +0000
Message-ID: <20110225120906.GE28980@opensource.wolfsonmicro.com>
References: <1298484501-3993-1-git-send-email-zhaoming.zeng@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D97B3103830
	for <alsa-devel@alsa-project.org>; Fri, 25 Feb 2011 13:08:46 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1298484501-3993-1-git-send-email-zhaoming.zeng@freescale.com>
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
Cc: alsa-devel@alsa-project.org, s.hauer@pengutronix.de, timur.tabi@gmail.com, zengzm.kernel@gmail.com, xiao-lizhang@freescale.com, linuxzsc@gmail.com, arnaud.patard@rtp-net.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, Feb 24, 2011 at 02:08:21AM +0800, zhaoming.zeng@freescale.com wrote:

This is mostly good, there's a few issues around the regulator usage
though.  I've applied the patch but please send incremental patches to
fix the issues below and also the issue Liam raised with the controls.

> +	.constraints = {
> +		.min_uV                 = 850000,
> +		.max_uV                 = 1600000,
> +		.valid_modes_mask       = REGULATOR_MODE_NORMAL,
> +		.valid_ops_mask         = REGULATOR_CHANGE_STATUS,
> +	},

This regulator supports a range of voltages but does not support
changing the voltage.

> +	/* set regulator value firstly */
> +	reg = (1600 - ldo->voltage / 1000) / 50;
> +	reg = clamp(reg, 0x0, 0xf);
> +
> +	/* amend the voltage value, unit: uV */
> +	ldo->voltage = (1600 - reg * 50) * 1000;
> +
> +	/* set voltage to register */
> +	snd_soc_update_bits(codec, SGTL5000_CHIP_LINREG_CTRL,
> +				(0x1 << 4) - 1, reg);

This looks like it should be in a regulator set_voltage() operation not
here:

> +
> +	snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
> +				SGTL5000_LINEREG_D_POWERUP,
> +				SGTL5000_LINEREG_D_POWERUP);

You have a separate enable bit which is probably the only thing you need
to deal with here.  If the hardware needs this better to explain why.

> +	vdda  = regulator_get_voltage(sgtl5000->supplies[VDDA].consumer);
> +	vddio = regulator_get_voltage(sgtl5000->supplies[VDDIO].consumer);
> +	vddd  = regulator_get_voltage(sgtl5000->supplies[VDDD].consumer);
> +
> +	vdda  = vdda / 1000;
> +	vddio = vddio / 1000;
> +	vddd  = vddd / 1000;
> +
> +	if (vdda <= 0 || vddio <= 0 || vddd < 0) {
> +		dev_err(codec->dev, "regulator voltage not set correctly\n");
> +
> +		return -EINVAL;
> +	}

This is going to fail on systems without voltage readback capabilities,
including systems which have the regulator API disabled and stubbed out.

> +	/*
> +	 * copy DAP default values to default value array.
> +	 * sgtl5000 register space has a big hole, merge it
> +	 * at init phase makes life easy.
> +	 * FIXME: should we drop 'const' of sgtl5000_regs?
> +	 */
> +	memcpy((void *)(&sgtl5000_regs[0] + (SGTL5000_DAP_REG_OFFSET >> 1)),
> +			sgtl5000_dap_regs,
> +			SGTL5000_MAX_REG_OFFSET - SGTL5000_DAP_REG_OFFSET);

As has been pointed out on previous revisions of the patch there is no
need to cast away from void in C and it can be actively harmful.
