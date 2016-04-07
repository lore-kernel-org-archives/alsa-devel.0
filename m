From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 2/6] ASoC: Davinci: McBSP: add device tree
 support for McBSP
Date: Thu, 7 Apr 2016 16:45:56 +0300
Message-ID: <57066494.2090808@ti.com>
References: <1459948893-4206-1-git-send-email-petr@barix.com>
 <1459948893-4206-3-git-send-email-petr@barix.com> <570655BE.7030109@ti.com>
 <5706615A.1080805@barix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id A538A2650CC
 for <alsa-devel@alsa-project.org>; Thu,  7 Apr 2016 15:46:02 +0200 (CEST)
In-Reply-To: <5706615A.1080805@barix.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Petr Kulhavy <petr@barix.com>, nsekhar@ti.com, khilman@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, devicetree@vger.kernel.org
Cc: mark.rutland@arm.com, alsa-devel@alsa-project.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, robh+dt@kernel.org, galak@codeaurora.org
List-Id: alsa-devel@alsa-project.org

On 04/07/16 16:32, Petr Kulhavy wrote:
> =

> =

> On 07.04.2016 14:42, Peter Ujfalusi wrote:
>> On 04/06/16 16:21, Petr Kulhavy wrote:
>>
>>>    */
>>>     #include <linux/init.h>
>>> @@ -648,15 +654,82 @@ static const struct snd_soc_component_driver
>>> davinci_i2s_component =3D {
>>>       .name        =3D "davinci-i2s",
>>>   };
>>>   +static struct snd_platform_data*
>>> +davinci_i2s_set_pdata_from_of(struct platform_device *pdev)
>>> +{
>>> +    struct snd_platform_data *pdata =3D NULL;
>>> +    struct device_node *np;
>>> +    struct of_phandle_args dma_spec;
>>> +    int ret;
>>> +
>>> +    if (!IS_ENABLED(CONFIG_OF) || !pdev->dev.of_node)
>>> +        return dev_get_platdata(&pdev->dev);
>>> +
>>> +    pdata =3D devm_kzalloc(&pdev->dev, sizeof(*pdata), GFP_KERNEL);
>>> +    if (!pdata)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    np =3D pdev->dev.of_node;
>>> +
>>> +    ret =3D of_property_match_string(np, "dma-names", "tx");
>>> +    if (ret >=3D 0) {
>>> +        ret =3D of_parse_phandle_with_args(np, "dmas", "#dma-cells", r=
et,
>>> +                         &dma_spec);
>>> +        if (ret >=3D 0)
>>> +            pdata->tx_dma_channel =3D dma_spec.args[0];
>>> +    }
>>> +
>>> +    ret =3D of_property_match_string(np, "dma-names", "rx");
>>> +    if (ret >=3D 0) {
>>> +        ret =3D of_parse_phandle_with_args(np, "dmas", "#dma-cells", r=
et,
>>> +                         &dma_spec);
>>> +        if (ret >=3D 0)
>>> +            pdata->rx_dma_channel =3D dma_spec.args[0];
>>> +    }
>> Why would you do this? If we booted with DT the only thing needed by the
>> edma-pcm (dmaengine) is the name of the DMA channel...
> I don't like this code either. But I have tried just to set the dma_filte=
r to
> "rx" or "tx" and it didn't work.
> Perhaps because the edma pcm filter function filters by channel number an=
d not
> by name?

the filter_fn is only used in legacy boot case not in DT boot.

> Or do you see an easier way of getting the channel number from the name?

It was failing because you were using wrong dt bindings for the eDMA, if you
update that it will work.

> =

>>
>>> +
>>> +    /* optional parameters */
>>> +
>>> +    pdata->enable_channel_combine =3D
>>> +        of_property_read_bool(np, "channel-combine");
>> This can only be done when the McBSP is used in DSP_x mode since this wi=
ll
>> make the McBSP to transmit the stereo audio as mono on the bus.
> I have actually never used this option and don't see a benefit of it.
> Is it just some workaround that should not be included in the binding?

It is to have more time for the DMA to write, read the audio data as McBSP
does not have FIFO.
This is a SW parameter, so it does not belong to the DT if we take things by
the letter. Probably it is better to leave it out for now and add it later =
if
there is a need?

>> After a quick look at the relevant parts in the driver, I think most of =
the
>> things are pretty much broken or at least they are not totally correct. =
McBSP
>> do support real I2S (SRGR:FWID), and the phase setup is wrong in the cod=
e. IMO.
>> I don't have HW to test the daVinci-MCBSP or the ASP so I can not commen=
t on
>> how well things are working.
> The I2S worked for me if the frame size equalled the PCM data size. E.g.
> 16-bit audio, 2 channels, 16 bit frame size -> 32 clock ticks per sample =
in
> total.
> However with bigger frame sizes it didn't work because it cannot insert
> "blanks" between the channels.
> E.g. with 32-bit wide slots and 16-bit audio it sends both left and right=
 data
> in the first 32 clock ticks (i.e. still the first channel) and then the d=
uring
> the other channel the data line goes to high impedance which results in
> effectively playing only the left channel (and noise in the other channel=
).

Yeah, this is not working on OMAP-McBSP either.

> That's probably what the comment about broken I2S is trying to say.
> I couldn't find any help in the datasheet either.

With exact bclk the I2S is working fine, with most codecs at least we are
using that with OMAPs.

> On some codecs the frame size is configurable and there it works, but cod=
ecs
> that require 32-bit frames don't work with 16-bit audio or need to use DS=
P_x
> format.
>>
>>> +
>>> +    return pdata;
>>> +}
>>> +
>>>   static int davinci_i2s_probe(struct platform_device *pdev)
>>>   {
>>> +    struct snd_platform_data *pdata;
>>>       struct davinci_mcbsp_dev *dev;
>>>       struct resource *mem, *res;
>>>       void __iomem *io_base;
>>>       int *dma;
>>>       int ret;
>>>   -    mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +    pdata =3D davinci_i2s_set_pdata_from_of(pdev);
>>> +    if (IS_ERR(pdata)) {
>>> +        dev_err(&pdev->dev, "Error populating platform data, err %ld\n=
",
>>> +            PTR_ERR(pdata));
>>> +        return PTR_ERR(pdata);
>>> +    }
>>> +
>>> +    mem =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "mpu");
>>> +    if (!mem) {
>>> +        dev_warn(&pdev->dev,
>>> +             "\"mpu\" mem resource not found, using index 0\n");
>>> +        mem =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>> +        if (!mem) {
>>> +            dev_err(&pdev->dev, "no mem resource?\n");
>>> +            return -ENODEV;
>>> +        }
>>> +    }
>>> +
>>>       io_base =3D devm_ioremap_resource(&pdev->dev, mem);
>>>       if (IS_ERR(io_base))
>>>           return PTR_ERR(io_base);
>>> @@ -680,25 +753,21 @@ static int davinci_i2s_probe(struct platform_devi=
ce
>>> *pdev)
>>>           (dma_addr_t)(mem->start + DAVINCI_MCBSP_DRR_REG);
>>>         /* first TX, then RX */
>>> -    res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
>>> -    if (!res) {
>>> -        dev_err(&pdev->dev, "no DMA resource\n");
>>> -        ret =3D -ENXIO;
>>> -        goto err_release_clk;
>>> -    }
>>>       dma =3D &dev->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
>>> -    *dma =3D res->start;
>>>       dev->dma_data[SNDRV_PCM_STREAM_PLAYBACK].filter_data =3D dma;
>>> +    res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
>>> +    if (res)
>>> +        *dma =3D res->start;
>>> +    else
>>> +        *dma =3D pdata->tx_dma_channel;
>> Please follow the way davinci-mcasp does it right now:
>>     dma_data =3D &mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
>>     ...
>>     dma =3D &mcasp->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
>>     res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
>>     if (res)
>>         *dma =3D res->start;
>>     else
>>         *dma =3D pdata->tx_dma_channel;
>>
>>     /* dmaengine filter data for DT and non-DT boot */
>>     if (pdev->dev.of_node)
>>         dma_data->filter_data =3D "tx";
>>     else
>>         dma_data->filter_data =3D dma;
>>
>> while we are here, I think the tx/rx_dma_channel is something we should =
just
>> get rid of. It is not used as far as I can tell.
>> Something like this would do I think:
>>     dma_data =3D &mcasp->dma_data[SNDRV_PCM_STREAM_PLAYBACK];
>>     ...
>>     res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
>>     if (res) {
>>         dma =3D &mcasp->dma_request[SNDRV_PCM_STREAM_PLAYBACK];
>>         *dma =3D res->start;
>>         dma_data->filter_data =3D dma;
>>     } else if (pdev->dev.of_node) {
>>         dma_data->filter_data =3D "tx";
>>     } else {
>>         dev_err(&pdev->dev, "Missing DMA tx resource\n");
>>         return -ENODEV;
>>     }
> Is the edma pcm filter function able to filter in once case by the dma nu=
mber
> and in the other case by the dma name?
> See my above comment as well...

The filter_fn is for the legacy boot, DT does not use filter, it looks up t=
he
channel.
The reason for the failure in your case was that the dma bindings in mcbsps
were not correct, if you update them they will work.

> =

>>>         dev->dev =3D &pdev->dev;
>>>       dev_set_drvdata(&pdev->dev, dev);
>>> @@ -737,11 +806,18 @@ static int davinci_i2s_remove(struct platform_dev=
ice
>>> *pdev)
>>>       return 0;
>>>   }
>>>   +static const struct of_device_id davinci_mcbsp_match[] =3D {
>>> +    { .compatible =3D "ti,da850-mcbsp-audio" },
>> I would drop the "-audio" for the binding...
> I was trying to stay consistent with the mcasp. But I don't mind keeping =
the
> name shorter :-)

Not just shorter, but the -audio postfix is just stupid. IMHO.

>>> +    {},
>>> +};
>>> +MODULE_DEVICE_TABLE(of, davinci_mcbsp_match);
>>> +
>>>   static struct platform_driver davinci_mcbsp_driver =3D {
>>>       .probe        =3D davinci_i2s_probe,
>>>       .remove        =3D davinci_i2s_remove,
>>>       .driver        =3D {
>>>           .name    =3D "davinci-mcbsp",
>>> +        .of_match_table =3D of_match_ptr(davinci_mcbsp_match),
>> The driver calls itself davinci-i2s.c and the prefixes internally used a=
re
>> davinci_i2s_*.
>> The driver name is "davinci-mcbsp".
>> And it is basically a driver for daVinci ASP (the McBSP additions are not
>> configured at all).
>> I still think we should keep the davinci_i2s_* when adding new code, or =
rename
>> the whole driver and it's prefixes to something more sensible?
> Good point, thanks! I will rename the table to davinci_i2s_match to stay
> consistent.
> =

> Petr
> =

> =



-- =

P=E9ter
