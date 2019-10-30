Return-Path: <SRS0=P70v=YX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D27B0CA9ECB
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:01:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D06BA20874
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Oct 2019 14:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ieOtyf6b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D06BA20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9ADB2202A;
	Wed, 30 Oct 2019 15:00:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9ADB2202A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572444091;
	bh=K88OgLQEm/XJjA1PPaXuxlCP1ZJFJYpNKcP4eT1J8Is=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ieOtyf6biZVYFeOKx0Tghm4OJsDYEhaKRcl0p9O6OGi0Aq9GPAmPImHfTqdAa1MeJ
	 gPRvekD4IqgRBZ6uctpNVX8A/B7fH5/sxOXWY0n57NuADrSEQnwOxH2I2fzi+4s9Cz
	 HV0XoSZnXmKqF4Pfnm/Gk6DwqV8rJxlFl2lwTdzE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 280FAF8015A;
	Wed, 30 Oct 2019 15:00:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2C27F80361; Wed, 30 Oct 2019 15:00:40 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB9BAF8015A
 for <alsa-devel@alsa-project.org>; Wed, 30 Oct 2019 15:00:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB9BAF8015A
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 30 Oct 2019 07:00:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,247,1569308400"; d="scan'208";a="351310827"
Received: from dobryson-mobl6.amr.corp.intel.com (HELO [10.251.135.212])
 ([10.251.135.212])
 by orsmga004.jf.intel.com with ESMTP; 30 Oct 2019 07:00:33 -0700
To: shumingf@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
References: <20191030085533.14299-1-shumingf@realtek.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8cb9facd-dc1c-cded-916d-fc510d6b6cf7@linux.intel.com>
Date: Wed, 30 Oct 2019 08:59:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20191030085533.14299-1-shumingf@realtek.com>
Content-Language: en-US
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, derek.fang@realtek.com, sathya.prakash.m.r@intel.com,
 flove@realtek.com
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: rt5682: improve the sensitivity
 of push button
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



On 10/30/19 3:55 AM, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
> 
> The sensitivity could improve by decreasing the HW debounce time

could be improved

> and reduce the delay time of workequeue.

typo: work queue.

> This patch added a device property for HW debounce time control.
> We could change this value to tune the sensitivity of push button.

so for an Intel platform without DT, could we set this property in the 
machine driver as done for bytcr_rt5640/51?

> 
> Signed-off-by: Shuming Fan <shumingf@realtek.com>
> ---
>   include/sound/rt5682.h    |  1 +
>   sound/soc/codecs/rt5682.c | 15 +++++++++++++++
>   2 files changed, 16 insertions(+)
> 
> diff --git a/include/sound/rt5682.h b/include/sound/rt5682.h
> index bf2ee75aabb1..bc2c31734df1 100644
> --- a/include/sound/rt5682.h
> +++ b/include/sound/rt5682.h
> @@ -31,6 +31,7 @@ struct rt5682_platform_data {
>   	enum rt5682_dmic1_data_pin dmic1_data_pin;
>   	enum rt5682_dmic1_clk_pin dmic1_clk_pin;
>   	enum rt5682_jd_src jd_src;
> +	unsigned int btndet_delay;
>   };
>   
>   #endif
> diff --git a/sound/soc/codecs/rt5682.c b/sound/soc/codecs/rt5682.c
> index c50b75ce82e0..35dcec135c8a 100644
> --- a/sound/soc/codecs/rt5682.c
> +++ b/sound/soc/codecs/rt5682.c
> @@ -44,6 +44,7 @@ static const struct rt5682_platform_data i2s_default_platform_data = {
>   	.dmic1_data_pin = RT5682_DMIC1_DATA_GPIO2,
>   	.dmic1_clk_pin = RT5682_DMIC1_CLK_GPIO3,
>   	.jd_src = RT5682_JD1,
> +	.btndet_delay = 16,
>   };
>   
>   struct rt5682_priv {
> @@ -1026,6 +1027,18 @@ static int rt5682_set_jack_detect(struct snd_soc_component *component,
>   		regmap_update_bits(rt5682->regmap, RT5682_IRQ_CTRL_2,
>   			RT5682_JD1_EN_MASK | RT5682_JD1_POL_MASK,
>   			RT5682_JD1_EN | RT5682_JD1_POL_NOR);
> +		regmap_update_bits(rt5682->regmap, RT5682_4BTN_IL_CMD_4,
> +			0x7f7f, (rt5682->pdata.btndet_delay << 8 |
> +			rt5682->pdata.btndet_delay));
> +		regmap_update_bits(rt5682->regmap, RT5682_4BTN_IL_CMD_5,
> +			0x7f7f, (rt5682->pdata.btndet_delay << 8 |
> +			rt5682->pdata.btndet_delay));
> +		regmap_update_bits(rt5682->regmap, RT5682_4BTN_IL_CMD_6,
> +			0x7f7f, (rt5682->pdata.btndet_delay << 8 |
> +			rt5682->pdata.btndet_delay));
> +		regmap_update_bits(rt5682->regmap, RT5682_4BTN_IL_CMD_7,
> +			0x7f7f, (rt5682->pdata.btndet_delay << 8 |
> +			rt5682->pdata.btndet_delay));
>   		mod_delayed_work(system_power_efficient_wq,
>   			   &rt5682->jack_detect_work, msecs_to_jiffies(250));
>   		break;
> @@ -2467,6 +2480,8 @@ static int rt5682_parse_dt(struct rt5682_priv *rt5682, struct device *dev)
>   		&rt5682->pdata.dmic1_clk_pin);
>   	device_property_read_u32(dev, "realtek,jd-src",
>   		&rt5682->pdata.jd_src);
> +	device_property_read_u32(dev, "realtek,btndet-delay",
> +		&rt5682->pdata.btndet_delay);
>   
>   	rt5682->pdata.ldo1_en = of_get_named_gpio(dev->of_node,
>   		"realtek,ldo1-en-gpios", 0);
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
