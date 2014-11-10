From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: twl4030: don't report EBUSY if
 no change requested.
Date: Mon, 10 Nov 2014 22:49:35 +0100
Message-ID: <546132EF.7070008@metafoo.de>
References: <20141108002637.6561.19002.stgit@notabene.brown>	<20141108003803.6561.42934.stgit@notabene.brown>	<20141108092242.GB2722@sirena.org.uk>	<20141110114518.715dcd4e@notabene.brown>	<54606446.7030907@metafoo.de> <20141111084537.1b4e726c@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141111084537.1b4e726c-wvvUuzkyo1EYVZTmpyfIwg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: NeilBrown <neilb-l3A5Bk7waGM@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, GTA04 owners <gta04-owner-xXXSsgcRVICgSpxsJD1C4w@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 11/10/2014 10:45 PM, NeilBrown wrote:
> On Mon, 10 Nov 2014 08:07:50 +0100 Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org> wrote:
>
>> On 11/10/2014 01:45 AM, NeilBrown wrote:
>>> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
>>> index b6b0cb399599..613b61cee081 100644
>>> --- a/sound/soc/codecs/twl4030.c
>>> +++ b/sound/soc/codecs/twl4030.c
>>> @@ -957,6 +957,16 @@ static int snd_soc_put_twl4030_opmode_enum_double(struct snd_kcontrol *kcontrol,
>>>    {
>>>    	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
>>>    	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
>>> +	struct snd_ctl_elem_value currentval;
>>>
>>
>> snd_ctl_elem_value is a bit to big to be put onto the kernel stack. Just
>> using twl4030_read() should be fine.
>
> That's a shame, it looked so neat....
>
> Using twl4030_read forces i2c access and misses out on the regmap caching.
>
> What do you think of this?

That looks good, but either snd_soc_kcontrol_component() instead of 
snd_kcontrol_chip() or just snd_soc_read(codec, ...

>
> Thanks,
> NeilBrown
>
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index b6b0cb399599..bdb47a045aa5 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -957,6 +957,18 @@ static int snd_soc_put_twl4030_opmode_enum_double(struct snd_kcontrol *kcontrol,
>   {
>   	struct snd_soc_codec *codec = snd_soc_kcontrol_codec(kcontrol);
>   	struct twl4030_priv *twl4030 = snd_soc_codec_get_drvdata(codec);
> +	const struct soc_enum *e = &twl4030_op_modes_enum;
> +	unsigned int reg_val;
> +	int ret;
> +
> +	ret = snd_soc_component_read(snd_kcontrol_chip(kcontrol),
> +				     e->reg, &reg_val);
> +	if (ret)
> +		return ret;
> +	if (ucontrol->value.enumerated.item[0] ==
> +	    ((reg_val >> e->shift_l) & e->mask))
> +		/* no change requested, so do nothing */
> +		return 0;
>
>   	if (twl4030->configured) {
>   		dev_err(codec->dev,
>

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
