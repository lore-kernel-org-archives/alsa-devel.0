Return-Path: <SRS0=67eO=X7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E038FC10F14
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Oct 2019 10:07:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C95214D9
	for <alsa-devel@archiver.kernel.org>; Sun,  6 Oct 2019 10:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FNg+/7H2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C95214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 57DB483A;
	Sun,  6 Oct 2019 12:06:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 57DB483A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1570356454;
	bh=qUQIwkE4hg88vbPbzxopCZffbJWgK1FWzeH3R1m+IYQ=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FNg+/7H2ZaKgKXJEpncMhB8kI0cegjlcJXIy995r6r4uBoop7tIXEK/VSf/oHuPdu
	 9WLYoNYO9NN7xj251D8Z7JL/gYwvH+LUIM4XchtlDSXnL3MGAK+hq/CyCcCRYPsazW
	 xUxDLegWjY+pAiScsMqMHNInXvMdFyItOKpTiIeU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DAB95F80137;
	Sun,  6 Oct 2019 12:06:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6C099F8038F; Sun,  6 Oct 2019 12:06:42 +0200 (CEST)
Received: from huawei.com (szxga07-in.huawei.com [45.249.212.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A3F3F80137
 for <alsa-devel@alsa-project.org>; Sun,  6 Oct 2019 12:06:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A3F3F80137
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 3BE62B1B645913D1E252;
 Sun,  6 Oct 2019 18:06:33 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0;
 Sun, 6 Oct 2019 18:06:29 +0800
To: Ladislav Michl <ladis@linux-mips.org>
References: <20191006072241.56808-1-yuehaibing@huawei.com>
 <20191006095720.GA13261@lenoch>
From: Yuehaibing <yuehaibing@huawei.com>
Message-ID: <4f5b8272-c299-ecc2-83f2-e7cdc534f061@huawei.com>
Date: Sun, 6 Oct 2019 18:06:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20191006095720.GA13261@lenoch>
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Cc: m.felsch@pengutronix.de, andradanciu1997@gmail.com,
 ckeepax@opensource.cirrus.com, kuninori.morimoto.gx@renesas.com,
 linux-kernel@vger.kernel.org, mirq-linux@rere.qmqm.pl,
 piotrs@opensource.cirrus.com, tiwai@suse.com, lgirdwood@gmail.com,
 paul@crapouillou.net, alsa-devel@alsa-project.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, enric.balletbo@collabora.com,
 shifu0704@thundersoft.com, rf@opensource.wolfsonmicro.com
Subject: Re: [alsa-devel] [PATCH -next] ASoc: tas2770: Fix build error
 without GPIOLIB
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 2019/10/6 17:57, Ladislav Michl wrote:
> Dear YueHaibing,
> 
> On Sun, Oct 06, 2019 at 03:22:41PM +0800, YueHaibing wrote:
>> If GPIOLIB is not set, building fails:
>>
>> sound/soc/codecs/tas2770.c: In function tas2770_reset:
>> sound/soc/codecs/tas2770.c:38:3: error: implicit declaration of function gpiod_set_value_cansleep; did you mean gpio_set_value_cansleep? [-Werror=implicit-function-declaration]
>>    gpiod_set_value_cansleep(tas2770->reset_gpio, 0);
>>    ^~~~~~~~~~~~~~~~~~~~~~~~
>>    gpio_set_value_cansleep
>> sound/soc/codecs/tas2770.c: In function tas2770_i2c_probe:
>> sound/soc/codecs/tas2770.c:749:24: error: implicit declaration of function devm_gpiod_get_optional; did you mean devm_regulator_get_optional? [-Werror=implicit-function-declaration]
>>   tas2770->reset_gpio = devm_gpiod_get_optional(tas2770->dev,
>>                         ^~~~~~~~~~~~~~~~~~~~~~~
>>                         devm_regulator_get_optional
>> sound/soc/codecs/tas2770.c:751:13: error: GPIOD_OUT_HIGH undeclared (first use in this function); did you mean GPIOF_INIT_HIGH?
>>              GPIOD_OUT_HIGH);
>>              ^~~~~~~~~~~~~~
>>              GPIOF_INIT_HIGH
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: 1a476abc723e ("tas2770: add tas2770 smart PA kernel driver")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  sound/soc/codecs/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
>> index bcac957..d639f17 100644
>> --- a/sound/soc/codecs/Kconfig
>> +++ b/sound/soc/codecs/Kconfig
>> @@ -1108,6 +1108,7 @@ config SND_SOC_TAS2552
>>  config SND_SOC_TAS2770
>>  	tristate "Texas Instruments TAS2770 speaker amplifier"
>>  	depends on I2C
>> +	select GPIOLIB
> 
> GPIOLIB API is working perfectly fine even if GPIOLIB is not selected
> and gpiod_* functions will merely return -ENOSYS in this case.
> Please see <linux/gpio/consumer.h> and fix your patch accordingly.


Thanks, will send v2 as your suggestion.

> 
>>  config SND_SOC_TAS5086
>>  	tristate "Texas Instruments TAS5086 speaker amplifier"
>> -- 
>> 2.7.4
>>
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> .
> 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
