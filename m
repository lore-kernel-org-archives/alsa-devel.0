From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: [PATCH] ASoC: Add GPIO support for jack
	reporting	interface
Date: Tue, 3 Mar 2009 12:39:17 -0600
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705ECD6DB74@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705ECD6D7C1@dlee07.ent.ti.com>
	<s5h63irp0qb.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AF4B103883
	for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2009 19:39:36 +0100 (CET)
In-Reply-To: <s5h63irp0qb.wl%tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

> > Add GPIO support to jack reporting framework in ASoC using gpiolib calls.
> > The gpio support exports two new functions: snd_soc_jack_add_gpios and 
> > snd_soc_jack_free_gpios.

> I prefer GPIO stuff built in conditionally.
> The jack layer is used also for non-ASoC codes, and GPIO 
> isn't always present.

Is it ok if I enclose all gpio functionality with #ifdef CONFIG_GPIOLIB?
 
> > +/* irq handler for gpio pin */
> > +static irqreturn_t gpio_handler(int irq, void *data) {
> > +	struct snd_soc_jack_gpio *gpio = data;
> > +
> > +	return IRQ_RETVAL(schedule_work(&gpio->work));

> Is this really correct?

Changed to:

static irqreturn_t gpio_handler(int irq, void *data)
{
	struct snd_soc_jack_gpio *gpio = data;

	schedule_work(&gpio->work);
	return IRQ_HANDLED;
}

> > +int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
> > +			struct snd_soc_jack_gpio *gpios)

> This error path doesn't look good.  It seems leaking / 
> keeping some resources.

Changed to:

int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
                        struct snd_soc_jack_gpio *gpios)
{
	int i, ret;

	for (i = 0; i < count; i++) {
		if (!gpio_is_valid(gpios[i].gpio)) {
			printk(KERN_ERR "Invalid gpio %d\n",
					gpios[i].gpio);
			return -EINVAL;
		}
		if (!gpios[i].name) {
			printk(KERN_ERR "No name for gpio %d\n",
					gpios[i].gpio);
			return -EINVAL;
		}

		ret = gpio_request(gpios[i].gpio, gpios[i].name);
		if (ret)
			return ret;

		ret = gpio_direction_input(gpios[i].gpio);
		if (ret) {
			gpio_free(gpios[i].gpio);
			return ret;
		}

		ret = request_irq(gpio_to_irq(gpios[i].gpio),
				gpio_handler,
				IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
				jack->card->dev->driver->name,
				&gpios[i]);
		if (ret) {
			gpio_free(gpios[i].gpio);
			return ret;
		}

		INIT_WORK(&gpios[i].work, gpio_work);
		gpios[i].jack = jack;
	}

	return 0;
}
