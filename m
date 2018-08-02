From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 03/10] mfd: wcd9335: add wcd irq support
Date: Thu, 2 Aug 2018 09:54:02 +0100
Message-ID: <74081a83-abcf-5529-babb-83a7b5242f68@linaro.org>
References: <20180727121806.18209-1-srinivas.kandagatla@linaro.org>
 <20180727121806.18209-4-srinivas.kandagatla@linaro.org>
 <20180802080525.GM4662@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180802080525.GM4662@dell>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com, lgirdwood@gmail.com, tiwai@suse.com, bgoswami@codeaurora.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, vkoul@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Thanks for the review,

On 02/08/18 09:05, Lee Jones wrote:
> On Fri, 27 Jul 2018, Srinivas Kandagatla wrote:
> 
>> WCD9335 supports two lines of irqs INTR1 and INTR2.
>> Multiple interrupts are muxed via these lines.
>> INTR1 consists of all possible interrupt sources like:
>> Ear OCP, HPH OCP, MBHC, MAD, VBAT, and SVA
>> INTR2 is a subset of first interrupt sources like MAD, VBAT, and SVA
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/mfd/Makefile                |   2 +-
>>   drivers/mfd/wcd9335-core.c          |   9 ++
>>   drivers/mfd/wcd9335-irq.c           | 172 ++++++++++++++++++++++++++++++++++++
> 
> Any particular reason for separating out IRQ handling?
No particular reason, I tried to follow what other codecs like wm8994, 
wm8350 and 14 others do.

> 
>>   include/dt-bindings/mfd/wcd9335.h   |  43 +++++++++
>>   include/linux/mfd/wcd9335/wcd9335.h |   3 +
>>   5 files changed, 228 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/mfd/wcd9335-irq.c
>>   create mode 100644 include/dt-bindings/mfd/wcd9335.h
>>
>> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
>> index a4697370640b..210875afe78a 100644
>> --- a/drivers/mfd/Makefile
>> +++ b/drivers/mfd/Makefile
>> @@ -58,7 +58,7 @@ obj-$(CONFIG_MFD_ARIZONA)	+= cs47l24-tables.o
>>   endif
>>   
>>   obj-$(CONFIG_MFD_WCD9335)	+= wcd9335.o
>> -wcd9335-objs			:= wcd9335-core.o
>> +wcd9335-objs			:= wcd9335-core.o wcd9335-irq.o
>>   
>>   obj-$(CONFIG_MFD_WM8400)	+= wm8400-core.o
>>   wm831x-objs			:= wm831x-core.o wm831x-irq.o wm831x-otp.o
>> diff --git a/drivers/mfd/wcd9335-core.c b/drivers/mfd/wcd9335-core.c
>> index 8f746901f4e9..6299dfb63aca 100644
>> --- a/drivers/mfd/wcd9335-core.c
>> +++ b/drivers/mfd/wcd9335-core.c
>> @@ -243,12 +243,20 @@ static int wcd9335_slim_status(struct slim_device *sdev,
>>   		return ret;
>>   	}
>>   
>> +	wcd9335_irq_init(wcd);
> 
> Why don't you check the return value?
> 
> What happens if it defers?
> 
It would not defer here as the regmaps are already setup in probe and 
the status callback is only invoked when the SLIMbus device is up.

I will add the missing checks here.

>>   	wcd->slim_ifd = wcd->slim_ifd;
>>   
>>   	return mfd_add_devices(wcd->dev, 0, wcd9335_devices,
>>   			       ARRAY_SIZE(wcd9335_devices), NULL, 0, NULL);
>>   }
>>   
>> +static void wcd9335_slim_remove(struct slim_device *sdev)
>> +{
>> +	struct wcd9335 *wcd = dev_get_drvdata(&sdev->dev);
>> +
>> +	wcd9335_irq_exit(wcd);
>> +}
>> +
>>   static const struct slim_device_id wcd9335_slim_id[] = {
>>   	{0x217, 0x1a0, 0x1, 0x0},
>>   	{}
>> @@ -259,6 +267,7 @@ static struct slim_driver wcd9335_slim_driver = {
>>   		.name = "wcd9335-slim",
>>   	},
>>   	.probe = wcd9335_slim_probe,
>> +	.remove = wcd9335_slim_remove,
>>   	.device_status = wcd9335_slim_status,
>>   	.id_table = wcd9335_slim_id,
>>   };
>> diff --git a/drivers/mfd/wcd9335-irq.c b/drivers/mfd/wcd9335-irq.c
>> new file mode 100644
>> index 000000000000..84098c89419b
>> --- /dev/null
>> +++ b/drivers/mfd/wcd9335-irq.c
>> @@ -0,0 +1,172 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2018, Linaro Limited
>> +//
> 
> Blank line?
> 
Yep.

>> +#include <linux/gpio.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/regmap.h>
>> +#include <linux/of_irq.h>
>> +#include <dt-bindings/mfd/wcd9335.h>
>> +#include <linux/mfd/wcd9335/wcd9335.h>
>> +#include <linux/mfd/wcd9335/registers.h>
> 
> Please place in alphabetical order.
> 
sure!

>> +static const struct regmap_irq wcd9335_irqs[] = {
>> +	/* INTR_REG 0 */
>> +	[WCD9335_IRQ_SLIMBUS] = {
>> +		.reg_offset = 0,
>> +		.mask = BIT(0),
>> +	},
> 
> [snipped approx 1,000,000 entries]
> 
>> +	[WCD9335_IRQ_SVA_OUTBOX2] = {
>> +		.reg_offset = 3,
>> +		.mask = BIT(6),
>> +	},
>> +};
> 
> Please use REGMAP_IRQ_REG() to significantly reduce the diff.
> 

Nice, that looks good, I will use that in next version.

>> +static const struct regmap_irq_chip wcd9335_regmap_irq1_chip = {
>> +	.name = "wcd9335_pin1_irq",
>> +	.status_base = WCD9335_INTR_PIN1_STATUS0,
>> +	.mask_base = WCD9335_INTR_PIN1_MASK0,
>> +	.ack_base = WCD9335_INTR_PIN1_CLEAR0,
>> +	.type_base = WCD9335_INTR_LEVEL0,
>> +	.num_regs = 4,
>> +	.irqs = wcd9335_irqs,
>> +	.num_irqs = ARRAY_SIZE(wcd9335_irqs),
>> +};
>> +
>> +int wcd9335_irq_init(struct wcd9335 *wcd)
>> +{
>> +	int ret;
> 
> '\n' here.

yep!

> 
>> +	/*
>> +	 * INTR1 consists of all possible interrupt sources Ear OCP,
>> +	 * HPH OCP, MBHC, MAD, VBAT, and SVA
>> +	 * INTR2 is a subset of first interrupt sources MAD, VBAT, and SVA
>> +	 */
>> +	wcd->intr1 = of_irq_get_byname(wcd->dev->of_node, "intr1");
>> +	if (wcd->intr1 < 0 || wcd->intr1 == -EPROBE_DEFER) {
>> +		dev_err(wcd->dev, "Unable to configure irq\n");
> 
> Nit: s/irq/IRQ/
> 
> Do you really want to issue an error message for -EPROBE_DEFER?
> 
> This maybe confusing if it is initiated later.

Thanks for spotting this, I will take a closer look at this error path 
and handle the DEFER case correctly in next version!
> 
>> +		return wcd->intr1;
>> +	}
>> +
>> +	ret = regmap_add_irq_chip(wcd->regmap, wcd->intr1,
>> +				 IRQF_TRIGGER_HIGH | IRQF_ONESHOT,
>> +				 0, &wcd9335_regmap_irq1_chip,
>> +				 &wcd->irq_data);
>> +	if (ret != 0) {
> 
> "if (ret)"
> 
Yep!

>> +		dev_err(wcd->dev, "Failed to register IRQ chip: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +int wcd9335_irq_exit(struct wcd9335 *wcd)
>> +{
>> +	regmap_del_irq_chip(wcd->intr1, wcd->irq_data);
> 
> '\n' here.
yep!
> 
>> +	return 0;
>> +}
> 
> Or better still, make this a void and remove the superfluous return.

Makes sense, I will give that a try in next version.
