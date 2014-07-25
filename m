From: Varka Bhadram <varkabhadram-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v3 2/2] ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and platform
 drivers
Date: Fri, 25 Jul 2014 11:47:42 +0530
Message-ID: <53D1F686.30600@gmail.com>
References: <cover.1406259578.git.nicoleotsuka@gmail.com> <f4ff79269a1680f9ce128e0e98fea926d3a41834.1406259578.git.nicoleotsuka@gmail.com> <53D1DC0B.1000905@gmail.com> <20140725055447.GC29136@MrMyself>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140725055447.GC29136@MrMyself>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolin Chen <Guangyu.Chen-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: Nicolin Chen <nicoleotsuka-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, rdunlap-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, timur-N01EOCouUvQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, b02247-KZfg59tc24xl57MIdRCFDg@public.gmane.org, b42378-KZfg59tc24xl57MIdRCFDg@public.gmane.org, tklauser-93Khv+1bN0NyDzI6CaY1VQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Hi Nicolin,

On 07/25/2014 11:24 AM, Nicolin Chen wrote:
> Hi Varka,
>
>     Regarding a point you suggested.
>
> On Fri, Jul 25, 2014 at 09:54:43AM +0530, Varka Bhadram wrote:
>> On 07/25/2014 09:33 AM, Nicolin Chen wrote:
>> (...)
>>
>>> +
>>> +static const struct platform_device_id fsl_asrc_devtype[] = {
>>> +	{
>>> +		.name = "imx35-asrc",
>>> +		.driver_data = IMX35_ASRC,
>>> +	}, {
>>> +		.name = "imx53-asrc",
>>> +		.driver_data = IMX53_ASRC,
>>> +	}, {
>>> +		/* sentinel */
>>> +	}
>>> +};
>>> +MODULE_DEVICE_TABLE(platform, fsl_asrc_devtype);
>>> +
>>> +static const struct of_device_id fsl_asrc_ids[] = {
>>> +	{
>>> +		.compatible = "fsl,imx35-asrc",
>>> +		.data = &fsl_asrc_devtype[IMX35_ASRC],
>>> +	}, {
>>> +		.compatible = "fsl,imx53-asrc",
>>> +		.data = &fsl_asrc_devtype[IMX53_ASRC],
>>> +	}, {
>>> +		/* sentinel */
>>> +	}
>>> +};
>>> +MODULE_DEVICE_TABLE(of, fsl_asrc_ids);
>>> +
>> move these ids after probe/remove... every driver follows same thing...
> Hmm.. fsl_asrc_ids is called in probe(), so it's probably not a good choice
> to put them after probe/remove. And actually not every driver does so.
> For example drivers/i2c/busses/i2c-s3c2410.c
>
> I think it should be okay to put here if it contains data.

You are using these ids in the probe .Tt should be above the probe() so
we can see of_match_device() directly...
and also one more thing that the interrupt handler also would be immediately
above the probe()

ex:
static irqreturn_t fsl_asrc_isr(int irq, void *dev_id)
{
...
}

device ids..

your_probe()
{
...
}

your_remove()
{
...
}

Now every driver that is coming following this style...

If your not using device ids in probe then it would be like

static irqreturn_t fsl_asrc_isr(int irq, void *dev_id)
{
...
}

your_probe()
{
...
}

your_remove()
{
...
}

device ids..

Thanks...

-- 
Regards,
Varka Bhadram.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
