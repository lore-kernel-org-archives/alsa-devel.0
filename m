Return-Path: <SRS0=cpJH=YO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0F8CA9EAF
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:26:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE0A20684
	for <alsa-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lZZGcNkm";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xqIxF+9M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE0A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FE2A9F6;
	Mon, 21 Oct 2019 13:26:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FE2A9F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571657212;
	bh=+obXwlaKiYvTHui9CTyIVvuF2xAjY8vq/T+/K0/G8MQ=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lZZGcNkmt0O8GlrmIDpqRPzxjtJt3Q/DOQnOfme5bxDp3q6eqGoJtxVTB61fkz6Uq
	 t151bFRag7Gm42l6urt+TwREYPigPhEH2lgsopucrZg+5a8HobYaRRBhtrFwhy36t+
	 zb5H75vOuTw2MaETrUVxIt7iTAD3zpC8yIJT2oNU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 96404F80321;
	Mon, 21 Oct 2019 13:26:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 393FCF80368; Mon, 21 Oct 2019 13:25:59 +0200 (CEST)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9ABD3F80112
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2019 13:25:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9ABD3F80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="xqIxF+9M"
Received: by mail-wr1-x444.google.com with SMTP id v9so2262258wrq.5
 for <alsa-devel@alsa-project.org>; Mon, 21 Oct 2019 04:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IoIwguD84l9TdKOgIJ6k+NaPdGHth76VlXctQ/52GAY=;
 b=xqIxF+9MYXYRVZPdLb01gQWr+VIugeUrnEUZArwU1V5796KikHPXG/7BUjbJwd7gF+
 w/8nq4zoTzaZVWIu+E1v11ZYoz0IZ7sCin6eM+yqVVQsvaIIyCFuD0akeBQ0uRNdlZeQ
 bIEnMYTCF2exPyDpTWHWdrHEoEKvXdos65r+twfdvNwQ11ELrVPgFHVd8LTQoZXK9wkD
 6pC5KnYwnjtjpFkH4QfsECky8N444Q3u42QT+D/hchoyuIYQo3fgQVdRjUTAp28+D2GF
 fQydIK48vCnY/6PE+4Hu8t146LAFeUrg60tfRlkdC9phiNuYYbiiNAr+53NgZgb+Z8+D
 P2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IoIwguD84l9TdKOgIJ6k+NaPdGHth76VlXctQ/52GAY=;
 b=nFKWkpozInTneIUIYBHhBrL7SNacIkcrnBr6AClj97dBjLd/zsxVd2h3qYG7l9G+6Y
 Q39zhpTpaYl96L45gK/HjfC2SDbzJsURBq/2af265e7p0gQ9ptB6fuD6KdJEfT5DLFjI
 T+Skk3RAY43BPZK4BXnqMRD9yVxUrhwC62Yh7I/lI7ZYX/fhNJWc4KzT+mGg1wGzsxMS
 RvCi/8sVPYSq2po422Svk7Wzx6+24pQBadBg9p5xJb9dIfLiigH5nKNVlMFfmrUgqn0/
 Ne9vqS1t49pakrLqGYhlW4H0Wy4z5Kx9zfdHik/yKUup2smZQHYWHSsNPFzKy6rkAbcK
 LrcA==
X-Gm-Message-State: APjAAAVgiyLPG5WCEscac/ql0e1zkXNFesimP9UmtrYU533ayuhxYalm
 h0fCU5V4YsqT9Q1TIV7Mign1zw==
X-Google-Smtp-Source: APXvYqyYjDblvuAXUOiGxRxoOHlR+3MiGcdtPvzyetJP+LpvAsFsDJf8xyDkuzhWJGG5meZW4KEGDg==
X-Received: by 2002:adf:a50b:: with SMTP id i11mr20423440wrb.308.1571657140501; 
 Mon, 21 Oct 2019 04:25:40 -0700 (PDT)
Received: from [192.168.86.34]
 (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
 by smtp.googlemail.com with ESMTPSA id a186sm12614204wmd.3.2019.10.21.04.25.39
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 21 Oct 2019 04:25:39 -0700 (PDT)
To: Lee Jones <lee.jones@linaro.org>
References: <20191018001849.27205-1-srinivas.kandagatla@linaro.org>
 <20191018001849.27205-3-srinivas.kandagatla@linaro.org>
 <20191021104611.GZ4365@dell>
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <1af8a875-8f55-6b7e-4204-ecedc1608889@linaro.org>
Date: Mon, 21 Oct 2019 12:25:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191021104611.GZ4365@dell>
Content-Language: en-US
Cc: robh@kernel.org, alsa-devel@alsa-project.org, bgoswami@codeaurora.org,
 vinod.koul@linaro.org, devicetree@vger.kernel.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org,
 spapothi@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v2 02/11] mfd: wcd934x: add support to
 wcd9340/wcd9341 codec
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Thanks Lee for taking time to review.

I agree with most of the style related comments, will fix them in next 
version. For others I have replied it inline.

On 21/10/2019 11:46, Lee Jones wrote:
> On Fri, 18 Oct 2019, Srinivas Kandagatla wrote:
> 
>> Qualcomm WCD9340/WCD9341 Codec is a standalone Hi-Fi audio codec IC.
>>
>> This codec has integrated SoundWire controller, pin controller and
>> interrupt controller.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   drivers/mfd/Kconfig                   |   8 +
>>   drivers/mfd/Makefile                  |   1 +
>>   drivers/mfd/wcd934x.c                 | 330 ++++++++++++++++
>>   include/linux/mfd/wcd934x/registers.h | 529 ++++++++++++++++++++++++++
>>   include/linux/mfd/wcd934x/wcd934x.h   |  24 ++
>>   5 files changed, 892 insertions(+)
>>   create mode 100644 drivers/mfd/wcd934x.c
>>   create mode 100644 include/linux/mfd/wcd934x/registers.h
>>   create mode 100644 include/linux/mfd/wcd934x/wcd934x.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index ae24d3ea68ea..ab09862b5996 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -1967,6 +1967,14 @@ config MFD_STMFX
>>   	  additional drivers must be enabled in order to use the functionality
>>   	  of the device.
>>   

[...]

>> diff --git a/drivers/mfd/wcd934x.c b/drivers/mfd/wcd934x.c
>> new file mode 100644
>> index 000000000000..bb4d2a6c89bc
>> --- /dev/null
>> +++ b/drivers/mfd/wcd934x.c
>> @@ -0,0 +1,330 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2019, Linaro Limited
>> +
>> +#include <linux/clk.h>
>> +#include <linux/gpio.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/core.h>
>> +#include <linux/mfd/wcd934x/registers.h>
>> +#include <linux/mfd/wcd934x/wcd934x.h>
>> +#include <linux/module.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/of.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/slimbus.h>
>> +

[...]

>> +static int wcd934x_bring_up(struct wcd934x_data *wcd)
>> +{
>> +	struct regmap *rm = wcd->regmap;
> 
> It's much more common to use 'regmap' or 'map'.

Only reason to make it short here is to save some lines!
If you prefer regmap, I will add that in next version!

> 
>> +	u16 id_minor, id_major;
>> +	int ret;
>> +
>> +	ret = regmap_bulk_read(rm, WCD934X_CHIP_TIER_CTRL_CHIP_ID_BYTE0,
>> +			       (u8 *)&id_minor, sizeof(u16));
>> +	if (ret)
>> +		return -EINVAL;
>> +
>> +	ret = regmap_bulk_read(rm, WCD934X_CHIP_TIER_CTRL_CHIP_ID_BYTE2,
>> +			       (u8 *)&id_major, sizeof(u16));
>> +	if (ret)
>> +		return -EINVAL;
>> +
>> +	dev_info(wcd->dev, "wcd934x chip id major 0x%x, minor 0x%x\n",
>> +		 id_major, id_minor);
>> +
>> +	regmap_write(rm, WCD934X_CODEC_RPM_RST_CTL, 0x01);
>> +	regmap_write(rm, WCD934X_SIDO_NEW_VOUT_A_STARTUP, 0x19);
>> +	regmap_write(rm, WCD934X_SIDO_NEW_VOUT_D_STARTUP, 0x15);
>> +	/* Add 1msec delay for VOUT to settle */
>> +	usleep_range(1000, 1100);
>> +	regmap_write(rm, WCD934X_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x5);
>> +	regmap_write(rm, WCD934X_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x7);
>> +	regmap_write(rm, WCD934X_CODEC_RPM_RST_CTL, 0x3);
>> +	regmap_write(rm, WCD934X_CODEC_RPM_RST_CTL, 0x7);
>> +	regmap_write(rm, WCD934X_CODEC_RPM_PWR_CDC_DIG_HM_CTL, 0x3);
>> +
>> +	return 0;
>> +
> 
> Superfluous '\n'.
> 
>> +}
>> +
>> +static int wcd934x_slim_status(struct slim_device *sdev,
>> +			       enum slim_device_status status)
>> +{
>> +	struct device *dev = &sdev->dev;
>> +	struct wcd934x_data *wcd;
>> +	int ret;
> 
> This is semantically odd!  Why are you doing most of the
> initialisation and bring-up in 'status' and not 'probe'.  Seems
> broken to me.
> 

SLIMBus device will not be in a state to communicate before enumeration 
(at probe), so all the device initialization is done in status callback 
where it is ready for communication.

This is same with SoundWire Bus as well!

>> +	wcd = dev_get_drvdata(dev);
>> +
>> +	switch (status) {
>> +	case SLIM_DEVICE_STATUS_UP:
>> +		wcd->regmap = regmap_init_slimbus(sdev, &wcd934x_regmap_config);
>> +		if (IS_ERR(wcd->regmap)) {
>> +			dev_err(dev, "Error allocating slim regmap\n");
>> +			return PTR_ERR(wcd->regmap);
>> +		}
>> +
>> +		ret = wcd934x_bring_up(wcd);
>> +		if (ret) {
>> +			dev_err(dev, "Error WCD934X bringup: err = %d\n", ret);


[...]

>> +	return 0;
>> +}
>> +
>> +static void wcd934x_slim_remove(struct slim_device *sdev)
>> +{
>> +	struct wcd934x_data *wcd = dev_get_drvdata(&sdev->dev);
> 
> No more clean-up?  Aren't the regulators still enabled?
> Good point, will add missing regulator disable in next version.

>> +	mfd_remove_devices(&sdev->dev);
>> +	kfree(wcd);
>> +}
>> +

[...]

>> +#endif
>> diff --git a/include/linux/mfd/wcd934x/wcd934x.h b/include/linux/mfd/wcd934x/wcd934x.h
>> new file mode 100644
>> index 000000000000..d102e211948c
>> --- /dev/null
>> +++ b/include/linux/mfd/wcd934x/wcd934x.h
>> @@ -0,0 +1,24 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +
>> +#ifndef __WCD934X_H__
>> +#define __WCD934X_H__
>> +#include <linux/clk.h>
>> +#include <linux/regulator/consumer.h>
>> +#include <linux/regmap.h>
>> +#include <linux/slimbus.h>

[...]

>> +struct wcd934x_data {
>> +	int reset_gpio;
>> +	int irq;
> 
> I'd prefer to see the more complex 'struct's at the top.
> 
>> +	struct device *dev;
>> +	struct clk *extclk;
>> +	struct regmap *regmap;
>> +	struct slim_device *sdev;
> 
> You don't need 'sdev' and 'dev'.

slim_device instance (sdev) is required by audio codec driver to 
allocate stream runtime.

> 
>> +	struct regmap_irq_chip_data *irq_data;
>> +	struct regulator_bulk_data supplies[WCD934X_MAX_SUPPLY];
>> +};
>> +
>> +#endif /* __WCD934X_H__ */
>> +
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
