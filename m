From: Andrew Jackson <Andrew.Jackson@arm.com>
Subject: Re: [PATCH 1/5] ASoC: dwc: Allocate resources with
	devm_ioremap_resource
Date: Thu, 04 Dec 2014 08:57:06 +0000
Message-ID: <548021E2.2080506@arm.com>
References: <547F3C96.9070509@arm.com> <547F3DD0.10405@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cam-smtp0.cambridge.arm.com (fw-tnat.cambridge.arm.com
 [217.140.96.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A6C0260525
 for <alsa-devel@alsa-project.org>; Thu,  4 Dec 2014 09:57:09 +0100 (CET)
In-Reply-To: <547F3DD0.10405@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, Mark Brown <broonie@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 12/03/14 16:44, Lars-Peter Clausen wrote:
> On 12/03/2014 05:38 PM, Andrew Jackson wrote:
> [,,,[
>> +	dw_i2s_dai = devm_kzalloc(&pdev->dev, sizeof(*dw_i2s_dai), GFP_KERNEL);
>> +	if (!dw_i2s_dai) {
>> +		dev_err(&pdev->dev, "mem allocation failed for dai driver\n");
> 
> All the memory alloc functions already print a error message.

I will remove the error message(s).

>>   		return -ENOMEM;
>>   	}
>>
>> +	dw_i2s_dai->ops = &dw_i2s_dai_ops;
>> +	dw_i2s_dai->suspend = dw_i2s_suspend;
>> +	dw_i2s_dai->resume = dw_i2s_resume;
> 
> This seems to be separate from the devm_ioremap_resource() change.

It seemed reasonable to assign these known values to the dw_i2s_dai as soon as it had been allocated. Would you prefer this in a separate patch?

>> +
>> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +	if (!res) {
> 
> You don't actually have to check it devm_ioremap_resource does this for you.

Oh, thanks, paranoia was taking over.

>> +		dev_err(&pdev->dev, "no i2s resource defined\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	dev->i2s_base = devm_ioremap_resource(&pdev->dev, res);
>> +	if (IS_ERR(dev->i2s_base)) {
>> +		dev_err(&pdev->dev, "ioremap fail for i2s_region\n");
> 
> Same here devm_ioremap_resource() will already print a appropriate error 
> message.
> 
>> +		return PTR_ERR(dev->i2s_base);
>> +	}
> 
> 
