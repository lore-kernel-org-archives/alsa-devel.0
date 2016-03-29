From: Jose Abreu <Jose.Abreu@synopsys.com>
Subject: Re: [PATCH 1/3 v2] drm/i2c/adv7511: Add audio support
Date: Tue, 29 Mar 2016 11:52:07 +0100
Message-ID: <56FA5E57.2000506@synopsys.com>
References: <cover.1459174494.git.joabreu@synopsys.com>
 <15b1936d307912ba12df7fa09ec3a7a80ac5fcef.1459174494.git.joabreu@synopsys.com>
 <56FA3745.3000807@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56FA3745.3000807@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Archit Taneja <architt@codeaurora.org>, Jose Abreu <Jose.Abreu@synopsys.com>, linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: tixy@linaro.org, mark.rutland@arm.com, broonie@kernel.org, Alexey.Brodkin@synopsys.com, lgirdwood@gmail.com, yitian.bu@tangramtek.com, wsa+renesas@sang-engineering.com, laurent.pinchart+renesas@ideasonboard.com, nariman@opensource.wolfsonmicro.com, Maruthi.Bayyavarapu@amd.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, Vineet.Gupta1@synopsys.com, buyitian@gmail.com, perex@perex.cz, tiwai@suse.com, robh+dt@kernel.org, galak@codeaurora.org, alexander.deucher@amd.com, CARLOS.PALMINHA@synopsys.com
List-Id: alsa-devel@alsa-project.org

Hi Archit,

On 29-03-2016 09:05, Archit Taneja wrote:
> Hi,
>
> On 03/28/2016 08:06 PM, Jose Abreu wrote:
>> This patch adds audio support for the ADV7511 HDMI transmitter
>> using ALSA SoC.
>>
>> The code was ported from Analog Devices linux tree from
>> commit 1770c4a1e32b ("Merge remote-tracking branch
>> 'xilinx/master' into xcomm_zynq"), which is available at:
>>     - https://github.com/analogdevicesinc/linux/
>>
>> The main core file was renamed from adv7511.c to adv7511_core.c
>> so that audio and video compile into a single adv7511.ko module
>> and to keep up with Analog Devices kernel tree.
>>
>> The audio can be disabled using menu-config so it is possible
>> to use only video mode.
>>
>> The HDMI mode is automatically started at boot and the audio
>> (when enabled) registers as a codec into ALSA.
>
> Is there a reason why we set the mode to HDMI at probe itself?
> Shouldn't it be okay to set the mode later once we read the
> EDID off the panel?
>
> Some more comments below.
>

Well, when I was using this in kernel 3.18 (with an older version of the driver)
I noticed that DVI mode was being used even when HDMI was connected so I forced
the driver to start in HDMI mode. There were some changes in the driver so it is
possible that this is no longer needed. Should I drop it?

>>
>> SPDIF DAI format was also added to ASoC as it is required
>> by adv7511 audio.
>>
>> Signed-off-by: Jose Abreu <joabreu@synopsys.com>
>> ---
>>
>> No changes v1 -> v2.
>>
>>   drivers/gpu/drm/i2c/Kconfig         |   11 +
>>   drivers/gpu/drm/i2c/Makefile        |    2 +
>>   drivers/gpu/drm/i2c/adv7511.c       | 1024 -----------------------------------
>>   drivers/gpu/drm/i2c/adv7511.h       |   41 ++
>>   drivers/gpu/drm/i2c/adv7511_audio.c |  310 +++++++++++
>>   drivers/gpu/drm/i2c/adv7511_core.c  | 1005 ++++++++++++++++++++++++++++++++++
>>   include/sound/soc-dai.h             |    1 +
>>   7 files changed, 1370 insertions(+), 1024 deletions(-)
>>   delete mode 100644 drivers/gpu/drm/i2c/adv7511.c
>>   create mode 100644 drivers/gpu/drm/i2c/adv7511_audio.c
>>   create mode 100644 drivers/gpu/drm/i2c/adv7511_core.c
>
> <snip>
>
>> +
>> +static int adv7511_probe(struct i2c_client *i2c, const struct i2c_device_id
>> *id)
>> +{
>> +    struct adv7511_link_config link_config;
>> +    struct adv7511 *adv7511;
>> +    struct device *dev = &i2c->dev;
>> +    unsigned int val;
>> +    int ret;
>> +
>> +    if (!dev->of_node)
>> +        return -EINVAL;
>> +
>> +    adv7511 = devm_kzalloc(dev, sizeof(*adv7511), GFP_KERNEL);
>> +    if (!adv7511)
>> +        return -ENOMEM;
>> +
>> +    adv7511->powered = false;
>> +    adv7511->status = connector_status_disconnected;
>> +
>> +    ret = adv7511_parse_dt(dev->of_node, &link_config);
>> +    if (ret)
>> +        return ret;
>> +
>> +    /*
>> +     * The power down GPIO is optional. If present, toggle it from active to
>> +     * inactive to wake up the encoder.
>> +     */
>> +    adv7511->gpio_pd = devm_gpiod_get_optional(dev, "pd", GPIOD_OUT_HIGH);
>> +    if (IS_ERR(adv7511->gpio_pd))
>> +        return PTR_ERR(adv7511->gpio_pd);
>> +
>> +    if (adv7511->gpio_pd) {
>> +        mdelay(5);
>> +        gpiod_set_value_cansleep(adv7511->gpio_pd, 0);
>> +    }
>> +
>> +    adv7511->regmap = devm_regmap_init_i2c(i2c, &adv7511_regmap_config);
>> +    if (IS_ERR(adv7511->regmap))
>> +        return PTR_ERR(adv7511->regmap);
>> +
>> +    ret = regmap_read(adv7511->regmap, ADV7511_REG_CHIP_REVISION, &val);
>> +    if (ret)
>> +        return ret;
>> +    dev_dbg(dev, "Rev. %d\n", val);
>> +
>> +    ret = regmap_register_patch(adv7511->regmap, adv7511_fixed_registers,
>> +                    ARRAY_SIZE(adv7511_fixed_registers));
>> +    if (ret)
>> +        return ret;
>> +
>> +    regmap_write(adv7511->regmap, ADV7511_REG_EDID_I2C_ADDR, edid_i2c_addr);
>> +    regmap_write(adv7511->regmap, ADV7511_REG_PACKET_I2C_ADDR,
>> +             packet_i2c_addr);
>> +    regmap_write(adv7511->regmap, ADV7511_REG_CEC_I2C_ADDR, cec_i2c_addr);
>> +    adv7511_packet_disable(adv7511, 0xffff);
>> +
>> +    adv7511->i2c_main = i2c;
>> +    adv7511->i2c_edid = i2c_new_dummy(i2c->adapter, edid_i2c_addr >> 1);
>> +    if (!adv7511->i2c_edid)
>> +        return -ENOMEM;
>> +
>> +    if (i2c->irq) {
>> +        init_waitqueue_head(&adv7511->wq);
>> +
>> +        ret = devm_request_threaded_irq(dev, i2c->irq, NULL,
>> +                        adv7511_irq_handler,
>> +                        IRQF_ONESHOT, dev_name(dev),
>> +                        adv7511);
>> +        if (ret)
>> +            goto err_i2c_unregister_device;
>> +    }
>> +
>> +    /* CEC is unused for now */
>> +    regmap_write(adv7511->regmap, ADV7511_REG_CEC_CTRL,
>> +             ADV7511_CEC_CTRL_POWER_DOWN);
>> +
>> +    adv7511_power_off(adv7511);
>> +
>> +    i2c_set_clientdata(i2c, adv7511);
>> +
>> +#ifdef CONFIG_DRM_I2C_ADV7511_AUDIO
>> +    adv7511_audio_init(&i2c->dev);
>> +#endif
>
> If we intend to have more audio funcs being used by the core in the
> future, it would be nice to have NOP audio funcs rather than having
> multiple #ifdef checks in the driver when CONFIG_DRM_I2C_ADV7511_AUDIO
> isn't set.
>

I will move this ifdef to adv751_audio and use NOP functions.

>> +
>> +    adv7511_set_link_config(adv7511, &link_config);
>> +
>> +    /* Enable HDMI mode */
>> +    regmap_update_bits(adv7511->regmap, ADV7511_REG_HDCP_HDMI_CFG,
>> +            ADV7511_HDMI_CFG_MODE_MASK,
>> +            ADV7511_HDMI_CFG_MODE_HDMI);
>> +
>> +    return 0;
>> +
>> +err_i2c_unregister_device:
>> +    i2c_unregister_device(adv7511->i2c_edid);
>> +
>> +    return ret;
>> +}
>> +
>> +static int adv7511_remove(struct i2c_client *i2c)
>> +{
>> +    struct adv7511 *adv7511 = i2c_get_clientdata(i2c);
>> +
>
> Are we missing a call to adv7511_audio_exit() here?

I followed the code in Analog Devices tree where there is no call to
audio_exit() but indeed you are correct. I will add this call.

>
> Thanks,
> Archit
>

Thanks for your comments!

Best regards,
Jose Miguel Abreu
