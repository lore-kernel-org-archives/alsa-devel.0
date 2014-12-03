From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH 1/5] ASoC: dwc: Allocate resources with devm_ioremap_resource
Date: Wed, 03 Dec 2014 17:44:00 +0100
Message-ID: <547F3DD0.10405@metafoo.de>
References: <547F3C96.9070509@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <547F3C96.9070509@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Jackson <Andrew.Jackson@arm.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Mark Brown <broonie@kernel.org>, Rajeev Kumar <rajeevkumar.linux@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 12/03/2014 05:38 PM, Andrew Jackson wrote:
[,,,[
> +	dw_i2s_dai = devm_kzalloc(&pdev->dev, sizeof(*dw_i2s_dai), GFP_KERNEL);
> +	if (!dw_i2s_dai) {
> +		dev_err(&pdev->dev, "mem allocation failed for dai driver\n");

All the memory alloc functions already print a error message.

>   		return -ENOMEM;
>   	}
>
> +	dw_i2s_dai->ops = &dw_i2s_dai_ops;
> +	dw_i2s_dai->suspend = dw_i2s_suspend;
> +	dw_i2s_dai->resume = dw_i2s_resume;

This seems to be separate from the devm_ioremap_resource() change.

> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {

You don't actually have to check it devm_ioremap_resource does this for you.

> +		dev_err(&pdev->dev, "no i2s resource defined\n");
> +		return -ENODEV;
> +	}
> +
> +	dev->i2s_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (IS_ERR(dev->i2s_base)) {
> +		dev_err(&pdev->dev, "ioremap fail for i2s_region\n");

Same here devm_ioremap_resource() will already print a appropriate error 
message.

> +		return PTR_ERR(dev->i2s_base);
> +	}
