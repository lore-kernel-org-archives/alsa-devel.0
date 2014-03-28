From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2] ASoC: sta350: Add codec driver
Date: Fri, 28 Mar 2014 10:00:41 +0100
Message-ID: <53353A39.3040006@metafoo.de>
References: <1395950176-15184-1-git-send-email-zonque@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-024.synserver.de (smtp-out-066.synserver.de
 [212.40.185.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 67E8E265499
 for <alsa-devel@alsa-project.org>; Fri, 28 Mar 2014 09:59:51 +0100 (CET)
In-Reply-To: <1395950176-15184-1-git-send-email-zonque@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Daniel Mack <daniel@zonque.org>, alsa-devel@alsa-project.org, broonie@kernel.org, neumann@teufel.de, brandau@gmx.de
List-Id: alsa-devel@alsa-project.org

[...]
> +  - reset-gpio: a GPIO spec for the reset pin. If specified, it will be
> +		deasserted before communication to the codec starts.
> +
> +  - power-down-gpio: a GPIO spec for the power down pin. If specified,
> +		     it will be deasserted before communication to the codec
> +		     starts.

I think the property name should always be '...-gpios', even if it is just 
one. There is some code in the kernel that assumes this.

[...]
> +
> +static const unsigned int sta350_limiter_ac_attack_tlv[] = {
> +	TLV_DB_RANGE_HEAD(2),
> +	0, 7, TLV_DB_SCALE_ITEM(-1200, 200, 0),
> +	8, 16, TLV_DB_SCALE_ITEM(300, 100, 0),
> +};
> +
> +static const unsigned int sta350_limiter_ac_release_tlv[] = {
> +	TLV_DB_RANGE_HEAD(5),
> +	0, 0, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 0),
> +	1, 1, TLV_DB_SCALE_ITEM(-2900, 0, 0),
> +	2, 2, TLV_DB_SCALE_ITEM(-2000, 0, 0),
> +	3, 8, TLV_DB_SCALE_ITEM(-1400, 200, 0),
> +	8, 16, TLV_DB_SCALE_ITEM(-700, 100, 0),
> +};
> +
> +static const unsigned int sta350_limiter_drc_attack_tlv[] = {
> +	TLV_DB_RANGE_HEAD(3),
> +	0, 7, TLV_DB_SCALE_ITEM(-3100, 200, 0),
> +	8, 13, TLV_DB_SCALE_ITEM(-1600, 100, 0),
> +	14, 16, TLV_DB_SCALE_ITEM(-1000, 300, 0),
> +};
> +
> +static const unsigned int sta350_limiter_drc_release_tlv[] = {
> +	TLV_DB_RANGE_HEAD(5),
> +	0, 0, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 0),
> +	1, 2, TLV_DB_SCALE_ITEM(-3800, 200, 0),
> +	3, 4, TLV_DB_SCALE_ITEM(-3300, 200, 0),
> +	5, 12, TLV_DB_SCALE_ITEM(-3000, 200, 0),
> +	13, 16, TLV_DB_SCALE_ITEM(-1500, 300, 0),
> +};

Those TLVs above should use DECLARE_TLV_DB_RANGE(). The macro automatically 
sets the number specified in the TLV_DB_RANGE_HEAD is equal to the number of 
items, hence leaves less room for errors.

E.g.

static DECLARE_TLV_DB_RANGE(sta350_limiter_ac_attack_tlv,
	0, 7, TLV_DB_SCALE_ITEM(-1200, 200, 0),
	8, 16, TLV_DB_SCALE_ITEM(300, 100, 0),
);
[...]
> +
> +static int sta350_i2c_probe(struct i2c_client *i2c,
> +			    const struct i2c_device_id *id)
> +{
> +	struct sta350_priv *sta350;
> +	int ret, i;
> +
> +	sta350 = devm_kzalloc(&i2c->dev, sizeof(struct sta350_priv),
> +			      GFP_KERNEL);
> +	if (!sta350)
> +		return -ENOMEM;
> +
> +	sta350->pdata = dev_get_platdata(&i2c->dev);
> +	sta350->gpio_nreset = -EINVAL;
> +	sta350->gpio_power_down = -EINVAL;
> +
> +	mutex_init(&sta350->coeff_lock);
> +
> +#ifdef CONFIG_OF
> +	ret = sta350_probe_dt(&i2c->dev, sta350);

You still need to check if i2c->dev.of_node is actually set.

> +	if (ret < 0)
> +		return ret;
> +#endif
> +
> +	/* GPIOs */
> +	if (gpio_is_valid(sta350->gpio_nreset)) {
> +		ret = devm_gpio_request_one(&i2c->dev, sta350->gpio_nreset,
> +					    GPIOF_OUT_INIT_HIGH,
> +					    "ST350 Reset");

New code should use the GPIO descriptor API. See 
http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/include/linux/gpio/consumer.h

> +		if (ret < 0)
> +			return ret;
> +	}
