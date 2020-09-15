Return-Path: <SRS0=FUiO=CY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5218FC433E2
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:42:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC992068D
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Sep 2020 18:42:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ab+jSxC0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IJx8XQmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC992068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39786820;
	Tue, 15 Sep 2020 20:41:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39786820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600195324;
	bh=yQvZv2SDZWNARuhnM61zIhbp8dONlx2HAXSJSMDrPdY=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ab+jSxC0Pnf2SaLMq/34cf+P+TFdtAhZ3Vh5RyPWL7HkpVLPS6Cr9yJPdk9cxW/ow
	 MDS8a3kI5f3nX0g4ErTxqfNqi4aqZVUElkwqPn/yufC082mNRREvBHXiRsf9zG7s+r
	 z6Ysa+kLI3zS1X0cbsr6IyZ5qBuW2xrevemEnH48=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B0F9F800F1;
	Tue, 15 Sep 2020 20:41:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6A9CF80212; Tue, 15 Sep 2020 20:41:11 +0200 (CEST)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AC7C8F800F1
 for <alsa-devel@alsa-project.org>; Tue, 15 Sep 2020 20:41:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC7C8F800F1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IJx8XQmM"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08FIf1S2125142;
 Tue, 15 Sep 2020 13:41:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1600195261;
 bh=/tdoN0OYwR8m4NawnYuovScUnXtRzZKV8TbiOry6es4=;
 h=Subject:To:CC:References:From:Date:In-Reply-To;
 b=IJx8XQmM6o7a7eLjI0Fc9mEIJJCh+o0GU0kW922XsnCUFnr0WVOfqe+qH4GKu9Mg6
 ycf1wbiBdaeHRHRHNRntzTZPkA4OLzrYvE2XCxANyi/J+NwTT8Sj/6V46WS5JuveMl
 z1PPPEth1FYjVOz5bemdqqobb0/54GeihqLcjdGY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FIf16D002249;
 Tue, 15 Sep 2020 13:41:01 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 15
 Sep 2020 13:41:00 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 15 Sep 2020 13:41:00 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08FIf0mM041635;
 Tue, 15 Sep 2020 13:41:00 -0500
Subject: Re: [PATCH v2 2/3] ASoC: tlv320adcx140: Add support for configuring
 GPIO pin
To: Camel Guo <camel.guo@axis.com>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <tiwai@suse.com>
References: <20200911080753.30342-1-camel.guo@axis.com>
 <20200911080753.30342-2-camel.guo@axis.com>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <da35edb3-bc41-967c-d530-4df4363ddddf@ti.com>
Date: Tue, 15 Sep 2020 13:41:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911080753.30342-2-camel.guo@axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: alsa-devel@alsa-project.org, kernel@axis.com, linux-kernel@vger.kernel.org,
 Camel Guo <camelg@axis.com>
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
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Camel

On 9/11/20 3:07 AM, Camel Guo wrote:
> From: Camel Guo <camelg@axis.com>
>
> Add support to configure the GPIO pin to the specific configuration.
> The GPIO pin can be configured as GPO, IRQ, SDOUT2, PDMCLK, MICBASE_EN,
> GPI, MCLK, SDIN, PDMDIN1, PDMDIN2, PDMDIN3 or PDMDIN4 and the output
> drive can be configured with various configuration.
>
> Signed-off-by: Camel Guo <camelg@axis.com>
> ---
>   sound/soc/codecs/tlv320adcx140.c | 44 ++++++++++++++++++++++++++++++++
>   sound/soc/codecs/tlv320adcx140.h |  4 +++
>   2 files changed, 48 insertions(+)
>
> diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
> index f33ee604ee78..97f16fbba441 100644
> --- a/sound/soc/codecs/tlv320adcx140.c
> +++ b/sound/soc/codecs/tlv320adcx140.c
> @@ -837,6 +837,46 @@ static int adcx140_configure_gpo(struct adcx140_priv *adcx140)
>   
>   }
>   
> +static int adcx140_configure_gpio(struct adcx140_priv *adcx140)
> +{
> +	int gpio_count = 0;
> +	u32 gpio_outputs[2];

This is #defined in configure_gpo and configure_gpi would like to see 
the consistency here.

> +	u32 gpio_output_val = 0;
> +	int ret;
> +
> +	gpio_count = device_property_count_u32(adcx140->dev,
> +			"ti,gpio-config");
> +	if (gpio_count == 0)
> +		return 0;
> +
> +	if (gpio_count != 2)
Same comment as above.
> +		return -EINVAL;
> +
> +	ret = device_property_read_u32_array(adcx140->dev, "ti,gpio-config",
> +			gpio_outputs, gpio_count);
> +	if (ret)
> +		return ret;
> +
> +	if (gpio_outputs[0] > ADCX140_GPIO_CFG_MAX) {
> +		dev_err(adcx140->dev, "GPIO config out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	if (gpio_outputs[1] > ADCX140_GPIO_DRV_MAX) {
> +		dev_err(adcx140->dev, "GPIO drive out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	gpio_output_val = gpio_outputs[0] << ADCX140_GPIO_SHIFT
> +		| gpio_outputs[1];
> +
> +	ret = regmap_write(adcx140->regmap, ADCX140_GPIO_CFG0, gpio_output_val);
> +	if (ret)
> +		return ret;

Just do return regmap_write no reason to check it. It is checked by the 
caller.


Dan

