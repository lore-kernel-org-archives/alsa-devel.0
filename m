From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [RFC/PATCH] pxa2xx_ac97 and gpio reset line
Date: Sat, 14 Mar 2009 22:46:49 +0000
Message-ID: <20090314224648.GB6523@sirena.org.uk>
References: <87iqn6f97x.fsf@free.fr>
	<4C46CDB4-EF69-4B6F-929E-FCBE644A7FA5@sirena.org.uk>
	<87bpsb6dt1.fsf@free.fr> <20090308193138.GB18035@sirena.org.uk>
	<20090308194456.GC18035@sirena.org.uk> <878wn723si.fsf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3F72F1037F3
	for <alsa-devel@alsa-project.org>; Sat, 14 Mar 2009 23:46:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <878wn723si.fsf@free.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Mar 14, 2009 at 10:27:41PM +0100, Robert Jarzmik wrote:

> As the PXA series allow 2 gpios to reset the ac97 bus, allow
> through platform data configuration the definition of the
> correct gpio which will reset the AC97 bus.

> This comes from a silicon defect on the PXA series, where
> the gpio must be manually controlled in warm reset cases.

The changelog should note that this only applies to PXA27x.

> +/* AC97 platform_data */
> +/**
> + * struct pxa2xx_ac97_platform_data - pxa ac97 platform data
> + * @reset_gpio_95: AC97 reset gpio is gpio95
> + * @reset_gpio_113: AC97 reset gpio is gpio113
> + */
> +struct pxa2xx_ac97_platform_data {
> +	unsigned reset_gpio_95:1;
> +	unsigned reset_gpio_113:1;
> +};

Hrm.  I'd rather just specify an int here in case we end up needing to
cope with other CPUs later.  The comments should also say that this data
is only required for non-default pins to avoid worrying people with
other boards.  Parameter checking can reject values we can't cope with.

> + * As the PXA CPUs suffer from a AC97 bug, a manual control of the reset
> + * line must be done to insure proper work of AC97 reset line.

Again, this should specify that ths only applies to PXA27x.

> +	if (!pdata) {
> +		is_ac97_resetgpio_113 = 1;
> +	} else {
> +		if (pdata->reset_gpio_95)
> +			is_ac97_resetgpio_95 = 1;
> +		if (pdata->reset_gpio_113)
> +			is_ac97_resetgpio_113 = 1;
> +	}

This should be something more like:

	if (pdata) {
		switch (pdata->reset_gpio) {
		case 95:
		case 113:
			reset_gpio = pdata->reset_gpio;
			break;
		case 0:
			break;
		default:
			dev_err(dev, "Invalid reset GPIO %d\n",
				pdata->reset_gpio);
		}
	}

	if (cpu_is_pxa27x() && !reset_gpio)
		reset_gpio = 113;
	
probably also with some handling for not letting this be set on varaints
that are OK.  That way if we need more platform data for the device we
can just zero initialise this field within the platform data.
