From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 3/3] ASoC: ux500: Dynamically fill DAI
 driver data on probe
Date: Tue, 03 Dec 2013 09:57:56 +0100
Message-ID: <529D9D14.9040109@metafoo.de>
References: <1386007222-10081-1-git-send-email-lee.jones@linaro.org>
 <1386007222-10081-3-git-send-email-lee.jones@linaro.org>
 <529CCD2F.3060206@metafoo.de> <20131203084026.GC11828@lee--X1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
 (mailhost.informatik.uni-hamburg.de [134.100.9.70])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F9F326512A
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 09:56:49 +0100 (CET)
In-Reply-To: <20131203084026.GC11828@lee--X1>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, linus.walleij@linaro.org, broonie@kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 12/03/2013 09:40 AM, Lee Jones wrote:
> On Mon, 02 Dec 2013, Lars-Peter Clausen wrote:
>
>> On 12/02/2013 07:00 PM, Lee Jones wrote:
>> [...]
>>> +void ux500_msp_populate_dai_drv(struct snd_soc_dai_driver *ux500_msp_dai_drv)
>>> +{
>>> +	ux500_msp_dai_drv->probe                 = ux500_msp_dai_probe;
>>> +	ux500_msp_dai_drv->suspend               = NULL;
>>> +	ux500_msp_dai_drv->resume                = NULL;
>>> +	ux500_msp_dai_drv->playback.channels_min = UX500_MSP_MIN_CHANNELS;
>>> +	ux500_msp_dai_drv->playback.channels_max = UX500_MSP_MAX_CHANNELS;
>>> +	ux500_msp_dai_drv->playback.rates        = UX500_I2S_RATES;
>>> +	ux500_msp_dai_drv->playback.formats      = UX500_I2S_FORMATS;
>>> +	ux500_msp_dai_drv->capture.channels_min  = UX500_MSP_MIN_CHANNELS;
>>> +	ux500_msp_dai_drv->capture.channels_max  = UX500_MSP_MAX_CHANNELS;
>>> +	ux500_msp_dai_drv->capture.rates         = UX500_I2S_RATES;
>>> +	ux500_msp_dai_drv->capture.formats       = UX500_I2S_FORMATS;
>>> +	ux500_msp_dai_drv->ops                   = ux500_msp_dai_ops;
>>>   };
>>
>> You can just use the same static driver for all devices. No need to
>> dynamically allocate it.
>
> How do you mean? Just create a 'static struct' instead?

Yes.

static struct snd_soc_dai_driver ux500_msp_dai_driver = {
	...
};

>
>>>   static const struct snd_soc_component_driver ux500_msp_component = {
>>> @@ -809,6 +742,7 @@ static const struct snd_soc_component_driver ux500_msp_component = {
>>>   static int ux500_msp_drv_probe(struct platform_device *pdev)
>>>   {
>>>   	struct ux500_msp_i2s_drvdata *drvdata;
>>> +	struct snd_soc_dai_driver *ux500_msp_dai_drv;
>>>   	int ret = 0;
>>>
>>>   	dev_dbg(&pdev->dev, "%s: Enter (pdev->name = %s).\n", __func__,
>>> @@ -863,8 +797,18 @@ static int ux500_msp_drv_probe(struct platform_device *pdev)
>>>   	}
>>>   	dev_set_drvdata(&pdev->dev, drvdata);
>>>
>>> +	ux500_msp_dai_drv = devm_kzalloc(&pdev->dev,
>>> +					 sizeof(*ux500_msp_dai_drv),
>>> +					 GFP_KERNEL);
>>> +	if (!ux500_msp_dai_drv) {
>>> +		ret = -ENOMEM;
>>> +		goto err_init_msp;
>>> +	}
>>> +
>>> +	ux500_msp_populate_dai_drv(ux500_msp_dai_drv);
>>> +
>>>   	ret = snd_soc_register_component(&pdev->dev, &ux500_msp_component,
>>> -					 &ux500_msp_dai_drv[drvdata->msp->id], 1);
>>> +					 ux500_msp_dai_drv, 1);
>>>   	if (ret < 0) {
>>>   		dev_err(&pdev->dev, "Error: %s: Failed to register MSP%d!\n",
>>>   			__func__, drvdata->msp->id);
>>>
>>
>
