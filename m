From: Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/3 v2] drm/i2c/adv7511: Add audio support
Date: Tue, 5 Apr 2016 12:00:54 +0100
Message-ID: <57039AE6.7050601@synopsys.com>
References: <cover.1459174494.git.joabreu@synopsys.com>
 <5276355.2bQYPXCpz6@avalon> <57022E63.2010900@synopsys.com>
 <2037371.nWufVmEmFd@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <2037371.nWufVmEmFd@avalon>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Jose Abreu <Jose.Abreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
Cc: dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-snps-arc-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, tixy-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Alexey.Brodkin-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, yitian.bu-sf4bEIuTEZ8/jFmSBShxMA@public.gmane.org, wsa+renesas-jBu1N2QxHDJrcw3mvpCnnVaTQe2KTcn/@public.gmane.org, laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org, nariman-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, Maruthi.Bayyavarapu-5C7GfCeVMHo@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, Vineet.Gupta1-HKixBCOQz3hWk0Htik3J/w@public.gmane.org, buyitian-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-IBi9RG/b67k@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, CARLOS.PALMINHA-HKixBCOQz3hWk0Htik3J/w@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Laurent,


On 04-04-2016 22:41, Laurent Pinchart wrote:
> Hi Jose,
>
> On Monday 04 Apr 2016 10:05:39 Jose Abreu wrote:
>> On 01-04-2016 18:10, Laurent Pinchart wrote:
>>> On Monday 28 Mar 2016 15:36:09 Jose Abreu wrote:
>>>> This patch adds audio support for the ADV7511 HDMI transmitter
>>>> using ALSA SoC.
>>>>
>>>> The code was ported from Analog Devices linux tree from
>>>> commit 1770c4a1e32b ("Merge remote-tracking branch
>>>>
>>>> 'xilinx/master' into xcomm_zynq"), which is available at:
>>>> 	- https://github.com/analogdevicesinc/linux/
>>>>
>>>> The main core file was renamed from adv7511.c to adv7511_core.c
>>>> so that audio and video compile into a single adv7511.ko module
>>>> and to keep up with Analog Devices kernel tree.
>>>>
>>>> The audio can be disabled using menu-config so it is possible
>>>> to use only video mode.
>>>>
>>>> The HDMI mode is automatically started at boot and the audio
>>>> (when enabled) registers as a codec into ALSA.
>>>>
>>>> SPDIF DAI format was also added to ASoC as it is required
>>>> by adv7511 audio.
>>>>
>>>> Signed-off-by: Jose Abreu <joabreu-HKixBCOQz3hWk0Htik3J/w@public.gmane.org>
>>>> ---
>>>>
>>>> No changes v1 -> v2.
>>>>
>>>>  drivers/gpu/drm/i2c/Kconfig         |   11 +
>>>>  drivers/gpu/drm/i2c/Makefile        |    2 +
>>>>  drivers/gpu/drm/i2c/adv7511.c       | 1024 ----------------------------
>>>>  drivers/gpu/drm/i2c/adv7511.h       |   41 ++
>>>>  drivers/gpu/drm/i2c/adv7511_audio.c |  310 +++++++++++
>>>>  drivers/gpu/drm/i2c/adv7511_core.c  | 1005 ++++++++++++++++++++++++++++
>>> Please use git-format-patch -M to detect renames if you send a new version
>>> of this series, it will help with review.
>> Ok, will do that in next version.
>>
>>>>  include/sound/soc-dai.h             |    1 +
>>>>  7 files changed, 1370 insertions(+), 1024 deletions(-)
>>>>  delete mode 100644 drivers/gpu/drm/i2c/adv7511.c
>>>>  create mode 100644 drivers/gpu/drm/i2c/adv7511_audio.c
>>>>  create mode 100644 drivers/gpu/drm/i2c/adv7511_core.c
>>> [snip]
>>>
>>>> diff --git a/drivers/gpu/drm/i2c/adv7511_core.c
>>>> b/drivers/gpu/drm/i2c/adv7511_core.c new file mode 100644
>>>> index 0000000..d54256a
>>>> --- /dev/null
>>>> +++ b/drivers/gpu/drm/i2c/adv7511_core.c
>>> [snip]
>>>
>>>> +static int adv7511_probe(struct i2c_client *i2c, const struct
>>>> i2c_device_id *id) +{
>>>> +	struct adv7511_link_config link_config;
>>>> +	struct adv7511 *adv7511;
>>>> +	struct device *dev = &i2c->dev;
>>>> +	unsigned int val;
>>>> +	int ret;
>>>> +
>>>> +	if (!dev->of_node)
>>>> +		return -EINVAL;
>>>> +
>>>> +	adv7511 = devm_kzalloc(dev, sizeof(*adv7511), GFP_KERNEL);
>>>> +	if (!adv7511)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	adv7511->powered = false;
>>>> +	adv7511->status = connector_status_disconnected;
>>>> +
>>>> +	ret = adv7511_parse_dt(dev->of_node, &link_config);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	/*
>>>> +	 * The power down GPIO is optional. If present, toggle it from active
>>>> to
>>>> +	 * inactive to wake up the encoder.
>>>> +	 */
>>>> +	adv7511->gpio_pd = devm_gpiod_get_optional(dev, "pd", 
> GPIOD_OUT_HIGH);
>>>> +	if (IS_ERR(adv7511->gpio_pd))
>>>> +		return PTR_ERR(adv7511->gpio_pd);
>>>> +
>>>> +	if (adv7511->gpio_pd) {
>>>> +		mdelay(5);
>>>> +		gpiod_set_value_cansleep(adv7511->gpio_pd, 0);
>>>> +	}
>>>> +
>>>> +	adv7511->regmap = devm_regmap_init_i2c(i2c, &adv7511_regmap_config);
>>>> +	if (IS_ERR(adv7511->regmap))
>>>> +		return PTR_ERR(adv7511->regmap);
>>>> +
>>>> +	ret = regmap_read(adv7511->regmap, ADV7511_REG_CHIP_REVISION, &val);
>>>> +	if (ret)
>>>> +		return ret;
>>>> +	dev_dbg(dev, "Rev. %d\n", val);
>>>> +
>>>> +	ret = regmap_register_patch(adv7511->regmap, adv7511_fixed_registers,
>>>> +				    ARRAY_SIZE(adv7511_fixed_registers));
>>>> +	if (ret)
>>>> +		return ret;
>>>> +
>>>> +	regmap_write(adv7511->regmap, ADV7511_REG_EDID_I2C_ADDR,
>>>> edid_i2c_addr);
>>>> +	regmap_write(adv7511->regmap, ADV7511_REG_PACKET_I2C_ADDR,
>>>> +		     packet_i2c_addr);
>>>> +	regmap_write(adv7511->regmap, ADV7511_REG_CEC_I2C_ADDR, 
> cec_i2c_addr);
>>>> +	adv7511_packet_disable(adv7511, 0xffff);
>>>> +
>>>> +	adv7511->i2c_main = i2c;
>>>> +	adv7511->i2c_edid = i2c_new_dummy(i2c->adapter, edid_i2c_addr >> 1);
>>>> +	if (!adv7511->i2c_edid)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	if (i2c->irq) {
>>>> +		init_waitqueue_head(&adv7511->wq);
>>>> +
>>>> +		ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
>>>> +						adv7511_irq_handler,
>>>> +						IRQF_ONESHOT, dev_name(dev),
>>>> +						adv7511);
>>>> +		if (ret)
>>>> +			goto err_i2c_unregister_device;
>>>> +	}
>>>> +
>>>> +	/* CEC is unused for now */
>>>> +	regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL,
>>>> +		     ADV7511_CEC_CTRL_POWER_DOWN);
>>>> +
>>>> +	adv7511_power_off(adv7511);
>>>> +
>>>> +	i2c_set_clientdata(i2c, adv7511);
>>>> +
>>>> +#ifdef CONFIG_DRM_I2C_ADV7511_AUDIO
>>>> +	adv7511_audio_init(&i2c->dev);
>>>> +#endif
>>> Shouldn't we condition this to the audio channel being somehow described
>>> in DT ? If a board doesn't route audio signals to the ADV7511 audio
>>> input, there's no need to register an audio codec.
>> I can do this but the audio is already conditionally compiled using
>> menuconfig. Is it really necessary to add this extra layer of condition?
> The idea is that enabling support for ADV7511 audio in the kernel isn't 
> coupled with whether the system includes audio support. It would be confusing, 
> and would also waste resources, to create a Linux sound device when no sound 
> channel is routed on the board.

Ok, will do that in next version. Another question: I am facing a problem when
compiling ALSA as a module, as the ADV7511 audio is not embedded into ALSA the
compilation fails with undefined references to ALSA functions. The solution that
I am planning to use is to add a default value to the ADV7511 kconfig entry so
that the driver is compiled as module when ALSA is a module and as embedded if
ALSA is embedded. Is this okay or is there another solution without moving the
ADV7511 audio to the ALSA directory?

>
>>>> +
>>>> +	adv7511_set_link_config(adv7511, &link_config);
>>>> +
>>>> +	/* Enable HDMI mode */
>>>> +	regmap_update_bits(adv7511->regmap, ADV7511_REG_HDCP_HDMI_CFG,
>>>> +			ADV7511_HDMI_CFG_MODE_MASK,
>>>> +			ADV7511_HDMI_CFG_MODE_HDMI);
>>>> +
>>>> +	return 0;
>>>> +
>>>> +err_i2c_unregister_device:
>>>> +	i2c_unregister_device(adv7511->i2c_edid);
>>>> +
>>>> +	return ret;
>>>> +}

Best regards,
Jose Miguel Abreu
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
