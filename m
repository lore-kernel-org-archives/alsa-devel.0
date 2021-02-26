Return-Path: <SRS0=9dS2=H4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7766C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Feb 2021 21:49:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED4C064F22
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Feb 2021 21:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED4C064F22
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDC9F168A;
	Fri, 26 Feb 2021 22:48:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDC9F168A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614376148;
	bh=v5YsP5RHU2oOgQWIxe+EnnwIKE1in+asWPO/Ev13HXo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mAg6lHmY0ray3Ve4zh+aoxCOxNmKDFpI9d6tDKRob/TIBug8aDW/HKLzOT3Sy1463
	 sUYkEgPEVP1LIFf9B/yKbFYINU53gCkP/qGP9liDEH1otYD6QmZum+jHO0XJnsMBlI
	 nyIsgxrxwsMJlxoP1TX3wcX+uzZpF37VOQELrFQA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5F4A3F80159;
	Fri, 26 Feb 2021 22:48:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20ABBF8016C; Fri, 26 Feb 2021 22:48:16 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C80A1F80159
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2021 22:48:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C80A1F80159
IronPort-SDR: O+Fgzqq8bG/EqRkOqtO8wTFh6pOndRCs3w+8mSiYqwrj/srPiaIsKNgTmak5e8V4I6uvhIGFmE
 DGBN68gh02pg==
X-IronPort-AV: E=McAfee;i="6000,8403,9907"; a="165220162"
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; d="scan'208";a="165220162"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2021 13:48:04 -0800
IronPort-SDR: 6oHz8TZzdMt38odTefZ+eHuCLyxeaaYHQPwo+2Z9V8QgR0psBlGDXOdj5KQx20YGzk9ehIdaqj
 cBYefRIvbYDQ==
X-IronPort-AV: E=Sophos;i="5.81,209,1610438400"; d="scan'208";a="433024901"
Received: from esnyder-desk.amr.corp.intel.com (HELO [10.255.230.205])
 ([10.255.230.205])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Feb 2021 13:48:02 -0800
Subject: Re: [PATCH] ASoC: rt1015p: add acpi device id for rt1015p
To: jack.yu@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
References: <20210226020517.17124-1-jack.yu@realtek.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b4af8c40-d1c6-35f2-0f70-3032fd04697f@linux.intel.com>
Date: Fri, 26 Feb 2021 15:48:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210226020517.17124-1-jack.yu@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de,
 kent_chen@realtek.com, kenny_chen@realtek.com, derek.fang@realtek.com,
 shumingf@realtek.com, flove@realtek.com
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



On 2/25/21 8:05 PM, jack.yu@realtek.com wrote:
> From: Jack Yu <jack.yu@realtek.com>
> 
> Add acpi device id for rt1015p.
> 
> Signed-off-by: Jack Yu <jack.yu@realtek.com>
> ---
>   sound/soc/codecs/rt1015p.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/sound/soc/codecs/rt1015p.c b/sound/soc/codecs/rt1015p.c
> index 671f2a2130fe..61694de080e6 100644
> --- a/sound/soc/codecs/rt1015p.c
> +++ b/sound/soc/codecs/rt1015p.c
> @@ -4,6 +4,7 @@
>   //
>   // Copyright 2020 The Linux Foundation. All rights reserved.
>   
> +#include <linux/acpi.h>
>   #include <linux/delay.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
> @@ -130,10 +131,19 @@ static const struct of_device_id rt1015p_device_id[] = {
>   MODULE_DEVICE_TABLE(of, rt1015p_device_id);
>   #endif
>   
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id rt1015p_acpi_match[] = {
> +	{ "ALCP1015", 0},

This isn't much better, ALC is not a vendor ID as defined by 
https://uefi.org/PNP_ACPI_Registry

I've ask for guidance from Intel ACPI folks on this, please stay tuned.

> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, rt1015p_acpi_match);
> +#endif
> +
>   static struct platform_driver rt1015p_platform_driver = {
>   	.driver = {
>   		.name = "rt1015p",
>   		.of_match_table = of_match_ptr(rt1015p_device_id),
> +		.acpi_match_table = ACPI_PTR(rt1015p_acpi_match),
>   	},
>   	.probe = rt1015p_platform_probe,
>   };
> 
