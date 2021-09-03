Return-Path: <SRS0=Q8D2=NZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44C9C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 09:21:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B1D460E74
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Sep 2021 09:21:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B1D460E74
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EFA2117D1;
	Fri,  3 Sep 2021 11:20:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EFA2117D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630660891;
	bh=BWZUZ0FRql3tvyEon3+xLbAuFdjuIIdivL4SUt/auk8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GGcUcFu8mWjP+swg++7rPVV0dxGp8HpMDg7JDTTFhMeBTXNLyEBAAzhAu3bftwY6F
	 EbzJL5jfJmlaQD0TpJNjPm8TNpIhNmN64C++5A1C9KtDeMgGXW82Q6MMBbGenROsGW
	 Tpjcw+78XpoLlRG1r8dg5FAQS8XIEHgg+UU0Qlk4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 754CBF80227;
	Fri,  3 Sep 2021 11:20:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C03E7F80088; Fri,  3 Sep 2021 11:20:38 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24463F80088
 for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2021 11:20:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24463F80088
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="304938683"
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; d="scan'208";a="304938683"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2021 02:20:23 -0700
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; d="scan'208";a="467868530"
Received: from pstarove-mobl4.ger.corp.intel.com (HELO [10.251.212.94])
 ([10.251.212.94])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2021 02:20:20 -0700
Subject: Re: [PATCH v3 1/2] ASoC: max98927: Handle reset gpio when probing i2c
To: Alejandro <atafalla@dnyon.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>
References: <cover.1630632805.git.atafalla@dnyon.com>
 <04a18f4115539752429da55fb857834cea0944e5.1630632805.git.atafalla@dnyon.com>
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
Message-ID: <80973391-4579-e14b-6def-ed81f367a4a5@linux.intel.com>
Date: Fri, 3 Sep 2021 12:20:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <04a18f4115539752429da55fb857834cea0944e5.1630632805.git.atafalla@dnyon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>
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



On 03/09/2021 04:49, Alejandro wrote:
> From: Alejandro Tafalla <atafalla@dnyon.com>
> 
> Drive the reset gpio if defined in the DTS node.
> 
> Signed-off-by: Alejandro Tafalla <atafalla@dnyon.com>
> ---
>  sound/soc/codecs/max98927.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
> index 8b206ee77709..daf06b503433 100644
> --- a/sound/soc/codecs/max98927.c
> +++ b/sound/soc/codecs/max98927.c
> @@ -868,6 +868,7 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
>  	int ret = 0, value;
>  	int reg = 0;
>  	struct max98927_priv *max98927 = NULL;
> +	struct gpio_desc *reset_gpio;
>  
>  	max98927 = devm_kzalloc(&i2c->dev,
>  		sizeof(*max98927), GFP_KERNEL);
> @@ -898,6 +899,19 @@ static int max98927_i2c_probe(struct i2c_client *i2c,
>  		return ret;
>  	}
>  
> +	reset_gpio
> +		= devm_gpiod_get_optional(&i2c->dev, "reset", GPIOD_OUT_LOW);

If this is a 'reset' pin then it's ACTIVE state is when it places the
device to _reset_.
GPIOD_OUT_LOW == Deasserted state of the GPIO line.

If the reset pin should be pulled low for reset (GPIO_ACTIVE_LOW) and
you want the device initially  in reset then you need GPIOD_OUT_HIGH,
because:
GPIOD_OUT_HIGH == Asserted state of the GPIO line.

Same goes for the gpiod_set_value_cansleep():
0 - deasserted
1 = asserted

and this all depends on how the gpio is defined in DT
(GPIO_ACTIVE_LOW/HIGH), which depends on how the documentation refers to
the pin...

reset pin:
low to keep the device in reset, high to release it from reset:
GPIO_ACTIVE_LOW
gpiod_set_value_cansleep(0) to enable
gpiod_set_value_cansleep(1) to disable


enable pin:
high to enable the part, low to disable
GPIO_ACTIVE_HIGH
gpiod_set_value_cansleep(1) to enable
gpiod_set_value_cansleep(0) to disable

In both cases
electrical 0: reset/disable
electrical 1: enable

> +	if (IS_ERR(reset_gpio)) {
> +		ret = PTR_ERR(reset_gpio);
> +		return dev_err_probe(&i2c->dev, ret, "failed to request GPIO reset pin");
> +	}
> +
> +	if (reset_gpio) {
> +		usleep_range(8000, 10000);
> +		gpiod_set_value_cansleep(reset_gpio, 1);
> +		usleep_range(1000, 5000);
> +	}
> +

You might want to put the device to reset on remove at minimum.

>  	/* Check Revision ID */
>  	ret = regmap_read(max98927->regmap,
>  		MAX98927_R01FF_REV_ID, &reg);
> 

-- 
Péter
