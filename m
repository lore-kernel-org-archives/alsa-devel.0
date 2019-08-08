From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [alsa-devel] [PATCH v2 4/4] ASoC: codecs: add wsa881x amplifier
 support
Date: Thu, 8 Aug 2019 17:20:10 +0100
Message-ID: <32516aae-8a43-6a74-c564-92dea8ff6e53@linaro.org>
References: <20190808144504.24823-1-srinivas.kandagatla@linaro.org>
 <20190808144504.24823-5-srinivas.kandagatla@linaro.org>
 <3ad15652-9d6c-11e4-7cc3-0f076c6841bb@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3ad15652-9d6c-11e4-7cc3-0f076c6841bb@linux.intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org, broonie@kernel.org
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org, linux-kernel@vger.kernel.org, plai@codeaurora.org, lgirdwood@gmail.com, robh+dt@kernel.org
List-Id: alsa-devel@alsa-project.org

Thanks for taking time to review,

On 08/08/2019 16:18, Pierre-Louis Bossart wrote:
> 
>> +/* 4 ports */
>> +static struct sdw_dpn_prop wsa_sink_dpn_prop[WSA881X_MAX_SWR_PORTS] = {
>> +    {
>> +        /* DAC */
>> +        .num = 1,
>> +        .type = SDW_DPN_SIMPLE,
> 
> IIRC we added the REDUCED type in SoundWire 1.1 to cover the PDM case 
> with channel packing (or was it grouping) used by Qualcomm. I am not 
> sure the SIMPLE type works?
grouping I guess.

This is a simplified data port as there is no DPn_OffsetCtrl2 register 
implemented.

Having said below channel count looks incorrect, i should fix that.

> 
>> +        .min_ch = 1,
>> +        .max_ch = 8,
>> +        .simple_ch_prep_sm = true,
>> +    }, {
>> +        /* COMP */
>> +        .num = 2,
>> +        .type = SDW_DPN_SIMPLE,
>> +        .min_ch = 1,
>> +        .max_ch = 8,
>> +        .simple_ch_prep_sm = true,
>> +    }, {
>> +        /* BOOST */
>> +        .num = 3,
>> +        .type = SDW_DPN_SIMPLE,
>> +        .min_ch = 1,
>> +        .max_ch = 8,
>> +        .simple_ch_prep_sm = true,
>> +    }, {
>> +        /* VISENSE */
>> +        .num = 4,
>> +        .type = SDW_DPN_SIMPLE,
>> +        .min_ch = 1,
>> +        .max_ch = 8,
>> +        .simple_ch_prep_sm = true,
>> +    }
>> +};
> 
>> +static int wsa881x_update_status(struct sdw_slave *slave,
>> +                 enum sdw_slave_status status)
>> +{
>> +    struct wsa881x_priv *wsa881x = dev_get_drvdata(&slave->dev);
>> +
>> +    if (status == SDW_SLAVE_ATTACHED) {
> 
> there is an ambiguity here, the Slave can be attached but as device0 
> (not enumerated). We should check dev_num > 0
> 
Thanks for point that! will add a check!

>> +        if (!wsa881x->regmap) {
>> +            wsa881x->regmap = devm_regmap_init_sdw(slave,
>> +                               &wsa881x_regmap_config);
>> +            if (IS_ERR(wsa881x->regmap)) {
>> +                dev_err(&slave->dev, "regmap_init failed\n");
>> +                return PTR_ERR(wsa881x->regmap);
>> +            }
>> +        }
>> +
>> +        return snd_soc_register_component(&slave->dev,
>> +                          &wsa881x_component_drv,
>> +                          NULL, 0);
>> +    } else if (status == SDW_SLAVE_UNATTACHED) {
>> +        snd_soc_unregister_component(&slave->dev);
> 
> the update_status() is supposed to be called based on bus events, it'd 
> be very odd to register/unregister the component itself dynamically. In 
> our existing Realtek-based solutions the register_component() is called 
> in the probe function (and unregister_component() in remove). We do the 
> inits when the Slave becomes attached but the component is already 
> registered.
> 
looks less intrusive!  I will give that a try!

>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +
>> +static int wsa881x_remove(struct sdw_slave *sdw)
>> +{
>> +    return 0;
>> +}
>> +
>> +static const struct sdw_device_id wsa881x_slave_id[] = {
>> +    SDW_SLAVE_ENTRY(0x0217, 0x2010, 0),
>> +    {},
>> +};
>> +MODULE_DEVICE_TABLE(sdw, wsa881x_slave_id);
>> +
>> +static struct sdw_driver wsa881x_codec_driver = {
>> +    .probe    = wsa881x_probe,
>> +    .remove = wsa881x_remove,
> 
> is this needed since you do nothing in that function?

yes, it can be removed! will do that in next version.

--srini
