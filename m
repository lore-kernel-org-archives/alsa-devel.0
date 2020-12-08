Return-Path: <SRS0=8QnY=FM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD16C4361B
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 18:00:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3410A23B3E
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Dec 2020 18:00:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3410A23B3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4D40516D0;
	Tue,  8 Dec 2020 18:59:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4D40516D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607450449;
	bh=pfag8zD3heAO9gB69L1FWsR03Wfs7Hj6jJwPvqtiU1U=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rZGU4u0yQ33jgqrdRz16ITr73jRWt3szlAn6NZUa9Eo3nqC/N6UbxFCGeo/R54nve
	 jFcENRDT8lNUcc/q5r4zkhrsiHB4ZUAgPsallHIpWMvGKjCM+3jDgBY79HmMSdIGDy
	 FY+k6jqVXf84y1UXZj91BM2xR8r1iQ6r0PbIVV7I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C442CF800E1;
	Tue,  8 Dec 2020 18:59:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3E1C3F8019D; Tue,  8 Dec 2020 18:59:57 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C08F9F80130
 for <alsa-devel@alsa-project.org>; Tue,  8 Dec 2020 18:59:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C08F9F80130
IronPort-SDR: FjzZSCtB4l+3eRrFBsmw4hyF7V4D8DlxpcGrzHiz5rNrfJlRxhBYFBdtbSdwIvLgmXFUQ9q38N
 ZAkuxHdFwoVg==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="171367077"
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; d="scan'208";a="171367077"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2020 09:59:46 -0800
IronPort-SDR: Ic1dU1pc5nJGZ/IrOU1CJKLfPu25Q93BX+BmxP1GDNI2LmP9lWhwG7gpmypHnT+CphH1N5AFkr
 27iEonVWxjAw==
X-IronPort-AV: E=Sophos;i="5.78,403,1599548400"; d="scan'208";a="552315963"
Received: from jcboyle-mobl1.amr.corp.intel.com (HELO [10.209.152.139])
 ([10.209.152.139])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Dec 2020 09:59:45 -0800
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirk for ARCHOS Cesium 140
To: Chris Chiu <chiu@endlessos.org>, lgirdwood@gmail.com, broonie@kernel.org, 
 perex@perex.cz, tiwai@suse.com
References: <20201208060414.27646-1-chiu@endlessos.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <91469f2c-01b8-ec7d-8d78-497c66dcde96@linux.intel.com>
Date: Tue, 8 Dec 2020 09:12:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201208060414.27646-1-chiu@endlessos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux@endlessos.org
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



On 12/8/20 12:04 AM, Chris Chiu wrote:
> Tha ARCHOS Cesium 140 tablet has problem with the jack-sensing,
> thus the heaset functions are not working.
> 
> Add quirk for this model to select the correct input map, jack-detect
> options and channel map to enable jack sensing and headset microphone.
> This device uses IN1 for its internal MIC and JD2 for jack-detect.
> 
> Signed-off-by: Chris Chiu <chiu@endlessos.org>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>   sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index f790514a147d..cd6f7caa43c8 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -421,6 +421,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>   					BYT_RT5640_SSP0_AIF1 |
>   					BYT_RT5640_MCLK_EN),
>   	},
> +	{
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ARCHOS"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "ARCHOS 140 CESIUM"),
> +		},
> +		.driver_data = (void *)(BYT_RT5640_IN1_MAP |
> +					BYT_RT5640_JD_SRC_JD2_IN4N |
> +					BYT_RT5640_OVCD_TH_2000UA |
> +					BYT_RT5640_OVCD_SF_0P75 |
> +					BYT_RT5640_SSP0_AIF1 |
> +					BYT_RT5640_MCLK_EN),
> +	},
>   	{
>   		.matches = {
>   			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> 
