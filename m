From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: add machine driver for
 i.mx27_visstrim_m10 board
Date: Tue, 4 Aug 2009 20:54:45 +0100
Message-ID: <20090804195445.GD4342@sirena.org.uk>
References: <eedb5540908040818j3ba586ceq124016bb7eb9d7b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D000243ED
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 21:54:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <eedb5540908040818j3ba586ceq124016bb7eb9d7b5@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 04, 2009 at 05:18:02PM +0200, javier Martin wrote:
> This adds support for i.mx27_visstrim_sm10 board machine driver which
> uses an i.mx27 processor plus a wm8974 codec.

> It has been tested on a visstrim_sm10 board.

> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

Again, this all looks good with some relatively small nits.

> +/**
> +  * This function connects SSI1 (HPCR1) as slave to
> +  * SSI1 external signals (PPCR1)
> +  * As slave, HPCR1 must set TFSDIR and TCLKDIR as inputs from
> +  * port 4
> +  */
> +void audmux_connect_1_4(void)
> +{

Obviously this ought to get pulled out, either into an arch AUXMUX thing
or a separate file in here.  However, neither of those things exist
right now.  I'll just go prod the last AUXMUX thread on linux-arm-kernel.

> +	return;
> +}

No need for the return; here.

> +	/*
> +	 * The WM8974 is better at generating accurate audio clocks than the
> +	 * MX27 SSI controller, so we will use it as master when we can.
> +	 */
> +	switch (params_rate(params)) {
> +	case 8000:

Unless I'm missing something the "when we can" is "in all cases" :)

> +	/* set codec DAI configuration */
> +	ret = codec_dai->ops->set_fmt(codec_dai,
> +		SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_IF |
> +		SND_SOC_DAIFMT_SYNC | fmt);
> +	if (ret < 0) {
> +		printk(KERN_ERR "Error from codec DAI configuration\n");
> +		return ret;
> +	}

Printing the value of ret would be nice.

> +	/* Put DC field of STCCR to 1 (not zero) */
> +	ret = cpu_dai->ops->set_tdm_slot(cpu_dai, 0, 2);

Rats, you are using the TDM slot configuration.  Oh well.  Should check
this error.

> +static int mx27vis_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +	return 0;
> +}
> +
> +static int mx27vis_resume(struct platform_device *pdev)
> +{
> +	return 0;
> +}

These can be omitted if empty.

> +	unsigned int ssi1_pins[] = {
> +		PC20_PF_SSI1_FS,
> +		PC21_PF_SSI1_RXD,
> +		PC22_PF_SSI1_TXD,
> +		PC23_PF_SSI1_CLK,
> +	};
> +	unsigned int ssi2_pins[] = {
> +		PC24_PF_SSI2_FS,
> +		PC25_PF_SSI2_RXD,
> +		PC26_PF_SSI2_TXD,
> +		PC27_PF_SSI2_CLK,
> +	};
> +	if (ssi_num == 0)
> +		ret = mxc_gpio_setup_multiple_pins(ssi1_pins,
> +				ARRAY_SIZE(ssi1_pins), "USB OTG");
> +	else
> +		ret = mxc_gpio_setup_multiple_pins(ssi2_pins,
> +				ARRAY_SIZE(ssi2_pins), "USB OTG");

This would normally be done under arch/arm in the board setup code.
