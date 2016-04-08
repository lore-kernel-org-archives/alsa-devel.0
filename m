From: anish kumar <yesanishhere@gmail.com>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Fri, 8 Apr 2016 13:04:12 -0700
Message-ID: <CABCoZhCWt8boo4Wq_cpDDRSO7P4c-p4DHP7D1dachJzSLLG-Kw@mail.gmail.com>
References: <1458629605-6225-1-git-send-email-yesanishhere@gmail.com>
 <570720D5.9060901@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f65.google.com (mail-vk0-f65.google.com
 [209.85.213.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4E1BC265132
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2016 22:04:13 +0200 (CEST)
Received: by mail-vk0-f65.google.com with SMTP id e185so17533729vkb.2
 for <alsa-devel@alsa-project.org>; Fri, 08 Apr 2016 13:04:13 -0700 (PDT)
In-Reply-To: <570720D5.9060901@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Apr 7, 2016 at 8:09 PM, Lars-Peter Clausen <lars@metafoo.de> wrote:
> [...]
>> +static struct reg_default max98371_reg[] = {
> const
> [...]
>> +static const unsigned int max98371_gain_tlv[] = {
>> +     0, 8, TLV_DB_SCALE_ITEM(0, 50, 0),
>> +     9, 10, TLV_DB_SCALE_ITEM(500, 100, 0),
>> +     11, 15, TLV_DB_SCALE_ITEM(0, 0, 0),
>> +};
>
> I don't think this works, you need to define a container. This is best done
> using DECLARE_TLV_DB_RANGE().
>
>> +
>> +static const unsigned int max98371_noload_gain_tlv[] = {
>> +     0, 11, TLV_DB_SCALE_ITEM(0, 100, 0),
>> +};
>
> Again, won't work I think, but since this is a single item, just just
> DECLARE_TLV_DB_SCALE.
>
> [...]
>> +             pr_info("%s: format unsupported %d",
>> +                             __func__, params_format(params));
>
> Not pr_info(), maybe dev_err() or drop it altogether. Same for the other
> pr_info() calls.
>
>> +static const struct snd_soc_dapm_widget max98371_dapm_widgets[] = {
>> +     SND_SOC_DAPM_AIF_IN("DAI_OUT",
>> +             "HiFi Playback", 0, SND_SOC_NOPM, 0, 0),
>
> This doesn't seem to do anything, just drop it.
>
>> +     SND_SOC_DAPM_DAC("DAC Enable",
>
> I'd just call this DAC.
>
>> +             "HiFi Playback", MAX98371_SPK_ENABLE, 0, 0),
>
> Drop the "HiFi Playback" here and connect the DAC in the routes to the "HiFi
> Playback" widget.
>
>> +     SND_SOC_DAPM_SUPPLY("Global Enable",
>> +             MAX98371_GLOBAL_ENABLE, 0, 0, NULL, 0),
>> +     SND_SOC_DAPM_OUTPUT("SPK_OUT"),
>> +};
>> +static struct snd_soc_dai_ops max98371_dai_ops = {
>
> const
>
>> +     .set_fmt = max98371_dai_set_fmt,
>> +     .hw_params = max98371_dai_hw_params,
>> +};
>> +
> [...]
>> +static struct snd_soc_codec_driver max98371_codec = {
>
> const
>
>> +     .controls = max98371_snd_controls,
>> +     .num_controls = ARRAY_SIZE(max98371_snd_controls),
>> +     .dapm_routes = max98371_audio_map,
>> +     .num_dapm_routes = ARRAY_SIZE(max98371_audio_map),
>> +     .dapm_widgets = max98371_dapm_widgets,
>> +     .num_dapm_widgets = ARRAY_SIZE(max98371_dapm_widgets),
>> +};
>> +
>> +static const struct regmap_config max98371_regmap = {
>> +     .reg_bits         = 8,
>> +     .val_bits         = 8,
>> +     .max_register     = MAX98371_VERSION,
>> +     .reg_defaults     = max98371_reg,
>> +     .num_reg_defaults = ARRAY_SIZE(max98371_reg),
>> +     .volatile_reg     = max98371_volatile_register,
>> +     .readable_reg     = max98371_readable_register,
>> +     .cache_type       = REGCACHE_RBTREE,
>> +};
>> +
>> +static int max98371_i2c_probe(struct i2c_client *i2c,
>> +             const struct i2c_device_id *id)
>> +{
>> +     struct max98371_priv *max98371;
>> +     int ret, reg;
>> +
>> +     max98371 = devm_kzalloc(&i2c->dev,
>> +                     sizeof(*max98371), GFP_KERNEL);
>> +     if (!max98371)
>> +             return -ENOMEM;
>> +
>> +     i2c_set_clientdata(i2c, max98371);
>> +     max98371->regmap = devm_regmap_init_i2c(i2c, &max98371_regmap);
>> +     if (IS_ERR(max98371->regmap)) {
>> +             ret = PTR_ERR(max98371->regmap);
>> +             dev_err(&i2c->dev,
>> +                             "Failed to allocate regmap: %d\n", ret);
>> +             return ret;
>> +     }
>> +
>> +     ret = regmap_read(max98371->regmap, MAX98371_VERSION, &reg);
>> +     if (ret < 0) {
>> +             dev_info(&i2c->dev, "device error %d\n", ret);
>> +             return ret;
>> +     }
>> +     dev_info(&i2c->dev, "device version %x\n", reg);
>
> Drop this, it is just noise in the boot log.
>
>> +
>> +     ret = snd_soc_register_codec(&i2c->dev, &max98371_codec,
>> +                     max98371_dai, ARRAY_SIZE(max98371_dai));
>> +     if (ret < 0) {
>> +             dev_err(&i2c->dev, "Failed to register codec: %d\n", ret);
>> +             return ret;
>> +     }
>> +     return ret;
>> +}

Thanks. All comments will be addressed in the next patch.
