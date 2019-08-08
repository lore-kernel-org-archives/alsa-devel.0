From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [alsa-devel] [PATCH v2 4/4] ASoC: codecs: add wsa881x amplifier
 support
Date: Thu, 8 Aug 2019 10:18:53 -0500
Message-ID: <3ad15652-9d6c-11e4-7cc3-0f076c6841bb@linux.intel.com>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-5-srinivas.kandagatla@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190808144504.24823-5-srinivas.kandagatla@linaro.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, vkoul@kernel.org, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org


> +/* 4 ports */
> +static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
> +	{
> +		/* DAC */
> +		.num = 1,
> +		.type = SDW_DPN_SIMPLE,

IIRC we added the REDUCED type in SoundWire 1.1 to cover the PDM case 
with channel packing (or was it grouping) used by Qualcomm. I am not 
sure the SIMPLE type works?

> +		.min_ch = 1,
> +		.max_ch = 8,
> +		.simple_ch_prep_sm = true,
> +	}, {
> +		/* COMP */
> +		.num = 2,
> +		.type = SDW_DPN_SIMPLE,
> +		.min_ch = 1,
> +		.max_ch = 8,
> +		.simple_ch_prep_sm = true,
> +	}, {
> +		/* BOOST */
> +		.num = 3,
> +		.type = SDW_DPN_SIMPLE,
> +		.min_ch = 1,
> +		.max_ch = 8,
> +		.simple_ch_prep_sm = true,
> +	}, {
> +		/* VISENSE */
> +		.num = 4,
> +		.type = SDW_DPN_SIMPLE,
> +		.min_ch = 1,
> +		.max_ch = 8,
> +		.simple_ch_prep_sm = true,
> +	}
> +};

> +static int wsa881x_update_status(struct sdw_slave *slave,
> +				 enum sdw_slave_status status)
> +{
> +	struct wsa881x_priv *wsa881x = dev_get_drvdata(&slave->dev);
> +
> +	if (status == SDW_SLAVE_ATTACHED) {

there is an ambiguity here, the Slave can be attached but as device0 
(not enumerated). We should check dev_num > 0

> +		if (!wsa881x->regmap) {
> +			wsa881x->regmap = devm_regmap_init_sdw(slave,
> +						       &wsa881x_regmap_config);
> +			if (IS_ERR(wsa881x->regmap)) {
> +				dev_err(&slave->dev, "regmap_init failed\n");
> +				return PTR_ERR(wsa881x->regmap);
> +			}
> +		}
> +
> +		return snd_soc_register_component(&slave->dev,
> +						  &wsa881x_component_drv,
> +						  NULL, 0);
> +	} else if (status == SDW_SLAVE_UNATTACHED) {
> +		snd_soc_unregister_component(&slave->dev);

the update_status() is supposed to be called based on bus events, it'd 
be very odd to register/unregister the component itself dynamically. In 
our existing Realtek-based solutions the register_component() is called 
in the probe function (and unregister_component() in remove). We do the 
inits when the Slave becomes attached but the component is already 
registered.

> +	}
> +
> +	return 0;
> +}
> +
> +static int wsa881x_port_prep(struct sdw_slave *slave,
> +			     struct sdw_prepare_ch *prepare_ch,
> +			     enum sdw_port_prep_ops state)
> +{
> +	struct wsa881x_priv *wsa881x = dev_get_drvdata(&slave->dev);
> +
> +	if (state == SDW_OPS_PORT_POST_PREP)
> +		wsa881x->port_prepared[prepare_ch->num - 1] = true;
> +	else
> +		wsa881x->port_prepared[prepare_ch->num - 1] = false;
> +
> +	return 0;
> +}
> +
> +static int wsa881x_bus_config(struct sdw_slave *slave,
> +			      struct sdw_bus_params *params)
> +{
> +	sdw_write(slave, SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(params->next_bank),
> +		  0x01);
> +
> +	return 0;
> +}
> +
> +static struct sdw_slave_ops wsa881x_slave_ops = {
> +	.update_status = wsa881x_update_status,
> +	.bus_config = wsa881x_bus_config,
> +	.port_prep = wsa881x_port_prep,
> +};
> +
> +static int wsa881x_probe(struct sdw_slave *pdev,
> +			 const struct sdw_device_id *id)
> +{
> +	struct wsa881x_priv *wsa881x;
> +
> +	wsa881x = devm_kzalloc(&pdev->dev, sizeof(*wsa881x), GFP_KERNEL);
> +	if (!wsa881x)
> +		return -ENOMEM;
> +
> +	wsa881x->sd_n = devm_gpiod_get_optional(&pdev->dev, "pd",
> +						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
> +	if (IS_ERR(wsa881x->sd_n)) {
> +		dev_err(&pdev->dev, "Shutdown Control GPIO not found\n");
> +		return PTR_ERR(wsa881x->sd_n);
> +	}
> +
> +	dev_set_drvdata(&pdev->dev, wsa881x);
> +	wsa881x->slave = pdev;
> +	wsa881x->dev = &pdev->dev;
> +	pdev->prop.sink_ports = GENMASK(WSA881X_MAX_SWR_PORTS, 0);
> +	pdev->prop.sink_dpn_prop = wsa_sink_dpn_prop;
> +	gpiod_set_value(wsa881x->sd_n, 1);
> +
> +	return 0;
> +}
> +
> +static int wsa881x_remove(struct sdw_slave *sdw)
> +{
> +	return 0;
> +}
> +
> +static const struct sdw_device_id wsa881x_slave_id[] = {
> +	SDW_SLAVE_ENTRY(0x0217, 0x2010, 0),
> +	{},
> +};
> +MODULE_DEVICE_TABLE(sdw, wsa881x_slave_id);
> +
> +static struct sdw_driver wsa881x_codec_driver = {
> +	.probe	= wsa881x_probe,
> +	.remove = wsa881x_remove,

is this needed since you do nothing in that function?

> +	.ops = &wsa881x_slave_ops,
> +	.id_table = wsa881x_slave_id,
> +	.driver = {
> +		.name	= "wsa881x-codec",
> +	}
> +};
> +module_sdw_driver(wsa881x_codec_driver);
> +
> +MODULE_DESCRIPTION("WSA881x codec driver");
> +MODULE_LICENSE("GPL v2");
> 
