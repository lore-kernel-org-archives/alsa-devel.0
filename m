From: "Kenneth Westfield" <kwestfie@codeaurora.org>
Subject: Re: [alsa-devel] [PATCH 3/9] ASoC: ipq806x: add native LPAIF driver
Date: Fri, 21 Nov 2014 12:19:24 -0800
Message-ID: <870eae19cad448faacf0e501c2a4fccc.squirrel@www.codeaurora.org>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
    <1416423169-21865-4-git-send-email-kwestfie@codeaurora.org>
    <546DDF64.1090308@metafoo.de>
Reply-To: kwestfie@codeaurora.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <546DDF64.1090308@metafoo.de>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Banajit Goswami <bgoswami@codeaurora.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <gregkh@linuxfoundation.org>, Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <rob.herring@calxeda.com>, Bryan Huntsman <bryanh@codeaurora.org>, Mark Brown <broonie@kernel.org>, David Brown <davidb@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On Thu, November 20, 2014 4:32 am, Lars-Peter Clausen wrote:

> On 11/19/2014 07:52 PM, Kenneth Westfield wrote:
>> From: Kenneth Westfield <kwestfie@codeaurora.org>
>>
>> Add the native LPAIF driver for LPASS block in Qualcomm
>> Technologies SoCs.
>>
>> Change-Id: I0f06f73a1267d7721209e58ce18e0d4897001141
>> Signed-off-by: Kenneth Westfield <kwestfie@codeaurora.org>
>> Signed-off-by: Banajit Goswami <bgoswami@codeaurora.org>
>> ---
>>   sound/soc/qcom/lpass-lpaif.c | 488 +++++++++++++++++++++++++++++++++++++++++++
>>   sound/soc/qcom/lpass-lpaif.h | 181 ++++++++++++++++
>>   2 files changed, 669 insertions(+)
>>   create mode 100644 sound/soc/qcom/lpass-lpaif.c
>>   create mode 100644 sound/soc/qcom/lpass-lpaif.h
>>
>> diff --git a/sound/soc/qcom/lpass-lpaif.c b/sound/soc/qcom/lpass-lpaif.c
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..e62843fe9bc4c63c3c7c119a9f076085b16a56b3
>> --- /dev/null
>> +++ b/sound/soc/qcom/lpass-lpaif.c
>> @@ -0,0 +1,488 @@
>> +/*
>> + * Copyright (c) 2010-2011,2013-2014 The Linux Foundation. All rights reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 and
>> + * only version 2 as published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/clk.h>
>> +#include <linux/types.h>
>> +#include <sound/soc.h>
>> +#include "lpass-lpaif.h"
>> +
>> +#define DRV_NAME	"lpass-lpaif"
>> +#define DRV_VERSION	"1.0"
>> +
>> +struct lpaif_dai_baseinfo {
>> +	void __iomem *base;
>> +};
>> +
>> +struct lpaif_dai_drv {
>> +	unsigned char *buffer;
>> +	dma_addr_t buffer_phys;
>> +	int channels;
>> +	irqreturn_t (*callback)(int intrsrc, void *private_data);
>> +	void *private_data;
>> +	int in_use;
>> +	unsigned int buffer_len;
>> +	unsigned int period_len;
>> +	unsigned int master_mode;
>> +};
>> +
>> +static struct lpaif_dai_baseinfo lpaif_dai_info;
>> +static struct lpaif_dai_drv *lpaif_dai[LPAIF_MAX_CHANNELS];
>> +static spinlock_t lpaif_lock;
>> +static struct resource *lpaif_irq;
>
> Please don't use global state for device drivers. Make the state device
> instance specific.
>
>> +
> [...]
>> +
>> +static int lpaif_dai_probe(struct platform_device *pdev)
>> +{
>> +	uint8_t i;
>> +	int32_t rc;
>> +	struct resource *lpa_res;
>> +	struct device *lpaif_device;
>> +
>> +	lpaif_device = &pdev->dev;
>> +
>> +	lpa_res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
>> +			"lpass-lpaif-mem");
>> +	if (!lpa_res) {
>> +		dev_err(&pdev->dev, "%s: error getting resource\n", __func__);
>> +		return -ENODEV;
>> +	}
>> +	lpaif_dai_info.base = ioremap(lpa_res->start,
>> +			(lpa_res->end - lpa_res->start));
>
> It's probably better to use devm_ioremap_resource here.
>
>> +	if (!lpaif_dai_info.base) {
>> +		dev_err(&pdev->dev, "%s: error remapping resource\n",
>> +				__func__);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	lpaif_irq = platform_get_resource_byname(
>> +			pdev, IORESOURCE_IRQ, "lpass-lpaif-irq");
>
> platform_get_irq_byname
>
>> +	if (!lpaif_irq) {
>> +		dev_err(&pdev->dev, "%s: failed get irq res\n", __func__);
>> +		rc = -ENODEV;
>> +		goto error;
>> +	}
>> +
>> +	rc = request_irq(lpaif_irq->start, lpaif_dai_irq_handler,
>> +			IRQF_TRIGGER_RISING, "lpass-lpaif-intr", NULL);
>> +
>> +	if (rc < 0) {
>> +		dev_err(&pdev->dev, "%s: irq resource request failed\n",
>> +				__func__);
>> +		goto error;
>> +	}
>> +
>> +	/*
>> +	 * Allocating memory for all the LPA_IF DMA channels
>> +	 */
>> +	for (i = 0; i < LPAIF_MAX_CHANNELS; i++) {
>> +		lpaif_dai[i] = kzalloc(sizeof(struct lpaif_dai_drv),
>> +				GFP_KERNEL);
>> +		if (!lpaif_dai[i]) {
>> +			rc = -ENOMEM;
>> +			goto error_irq;
>> +		}
>> +	}
>> +	spin_lock_init(&lpaif_lock);
>
>
> This needs to be initialized before you request the interrupt as the
> interrupt handler is using the spinlock.
>
>> +	return 0;
>> +
>> +error_irq:
>> +	free_irq(lpaif_irq->start, NULL);
>> +	lpaif_dai_ch_free();
>> +error:
>> +	iounmap(lpaif_dai_info.base);
>> +	return rc;
>> +}
>> +
>> +static int lpaif_dai_remove(struct platform_device *pdev)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < LPAIF_MAX_CHANNELS; i++)
>> +		lpaif_dai_stop(i);
>> +	synchronize_irq(lpaif_irq->start);
>
> free_irq does a synchronize_irq, not need to call it manually.
>
>> +	free_irq(lpaif_irq->start, NULL);
>> +	iounmap(lpaif_dai_info.base);
>> +	lpaif_dai_ch_free();
>> +	return 0;
>> +}
>> +
> [..]
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>

Lars

Thank you for your comments.  I will separately address each comment shortly.

-- 
Kenneth Westfield
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
