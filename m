Return-Path: <SRS0=maC8=GO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FDF7C433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 20:32:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B8F322CE3
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Jan 2021 20:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B8F322CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 147A71769;
	Mon, 11 Jan 2021 21:31:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 147A71769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1610397150;
	bh=sUAKDTKxOa8lqzm5VbWXeY1NVXUbhfmfoUZQAmmJo8E=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KMqFQ+otcv0xfMAeA6xPYR5IbrqrI+hPiPfV5TVv8/YQ4ZdFdZ8o+Sd8WQQMw8LzQ
	 n+3vFjxThXbAjHqiVguWsQ/ghwST0773yc2U5Xu5NesM/CEEZCLnx6xpsjNXQ48IO6
	 kquCpP0Qj7gB5+43z88jZMlx1uArRAg3xwJ6Yf+g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6E3E2F804EC;
	Mon, 11 Jan 2021 21:29:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0762F8026B; Mon, 11 Jan 2021 21:29:00 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BE717F8026B
 for <alsa-devel@alsa-project.org>; Mon, 11 Jan 2021 21:28:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BE717F8026B
IronPort-SDR: SpM30QeciMAuWbPXiE3n1ObpelsOtiHnRGnzqGhyCErGmhBHPXodXbeOHKQcKH6aUwu1a2ce9g
 44G025fc9Now==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="242003770"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; d="scan'208";a="242003770"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 12:28:38 -0800
IronPort-SDR: 9S9XolgBjucu9vRfXyakHknNVCatDK7ijQBmAYxPGl4PCVhsF/gfBoPH3c+Y7SViNUeBpfU+IB
 T11ts5sM+UAw==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; d="scan'208";a="344995363"
Received: from gkbech1x-mobl.amr.corp.intel.com (HELO [10.212.87.85])
 ([10.212.87.85])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 12:28:29 -0800
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Add quirks for DeeQ X5-Z8300
To: Chris Chiu <chiu@endlessos.org>, cezary.rojewski@intel.com,
 yang.jie@linux.intel.com
References: <20201216041601.5993-1-chiu@endlessos.org>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8d4f7c48-cb3e-a868-3d48-fe63a3113ea1@linux.intel.com>
Date: Mon, 11 Jan 2021 11:05:32 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201216041601.5993-1-chiu@endlessos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>,
 linux-kernel@vger.kernel.org, linux@endlessos.org,
 Hans de Goede <hdegoede@redhat.com>, Mark Brown <broonie@kernel.org>
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



On 12/15/20 10:16 PM, Chris Chiu wrote:
> DeeQ X5-Z8300 is a laptop empowered by Intel Atom Cherry Trail. Add
> quirks to select the correct input map, jack-detect options to enable
> jack sensing and internal/headset microphones.
> 
> Signed-off-by: Chris Chiu <chiu@endlessos.org>

You probably need to re-send and CC: maintainers (Mark Brown, Takashi 
Iwai) and Hans de Goede who's been supporting all those quirks.

I don't think the changes below are fully correct, most quirks start with		
.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS |

which e.g. enables the MCLK and overcurrent handling.

I wonder if what you need is

.driver_data = (void *)(BYT_RT5651_DEFAULT_QUIRKS | BYT_RT5651_IN1_IN2_MAP)

> ---
>   sound/soc/intel/boards/bytcr_rt5651.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> index 688b5e0a49e3..9df09e26b05a 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -507,6 +507,14 @@ static const struct dmi_system_id byt_rt5651_quirk_table[] = {
>   					BYT_RT5651_SSP0_AIF1 |
>   					BYT_RT5651_MONO_SPEAKER),
>   	},
> +	{
> +		.callback = byt_rt5651_quirk_cb,
> +		.matches = {
> +			DMI_MATCH(DMI_SYS_VENDOR, "DeeQ"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "X5-Z8300"),
> +		},
> +		.driver_data = (void *)(BYT_RT5651_IN1_IN2_MAP | BYT_RT5651_JD1_1),
> +	},
>   	{}
>   };
>   
> 
