Return-Path: <SRS0=dtPj=J7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CF0C433B4
	for <alsa-devel@archiver.kernel.org>; Tue,  4 May 2021 19:44:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DD78613C7
	for <alsa-devel@archiver.kernel.org>; Tue,  4 May 2021 19:44:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD78613C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D231D1695;
	Tue,  4 May 2021 21:43:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D231D1695
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620157443;
	bh=GIYaL2mdsDVpPyXnTGjNHr3bdS4bdTxJiHvlq25WqZo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PNs+7EFMUOiJS1lIKTpV74uVHTHEFu5knxjvrfcayfJc3lX1nLCyAV/sIOk09DoZL
	 hl1WzvvvFaRTI+w3hxLQ2n0PndGHwwJ2H0VnDBnJ0pwyR2vQI8HApAarKb6eP5HItl
	 JkTbIxJX9LrR4mDvp1BAfNC9DwHJGKyEJMVJVm48=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57072F80114;
	Tue,  4 May 2021 21:43:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7FB2DF80162; Tue,  4 May 2021 21:43:11 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0277AF80162
 for <alsa-devel@alsa-project.org>; Tue,  4 May 2021 21:43:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0277AF80162
IronPort-SDR: 8c16jx6apVfv1FCBPvnv+Hg7H8jNcIELbk2VwxFRuc4c7q3I508xviuFvlEwR/EP+Bss9G40Ki
 GsJPzKEmN7mQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9974"; a="185197292"
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; d="scan'208";a="185197292"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2021 12:42:57 -0700
IronPort-SDR: tV0ia70qga8TjG6sVo/8j5jku/jZ55LR+zPMJKy6riNcE5VCIPBwotMin6LCbaXwD07iz3MNur
 EOKi3X6UV3lA==
X-IronPort-AV: E=Sophos;i="5.82,272,1613462400"; d="scan'208";a="390074247"
Received: from lcoronad-mobl.amr.corp.intel.com (HELO [10.212.111.147])
 ([10.212.111.147])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 May 2021 12:42:56 -0700
Subject: Re: [PATCH] ASoC: rt711-sdca: fix the function number of SDCA control
 for feature unit 0x1E
To: shumingf@realtek.com, broonie@kernel.org, lgirdwood@gmail.com
References: <20210504100424.8760-1-shumingf@realtek.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <064974e1-f792-9b2a-d28c-b8b9ad4a8993@linux.intel.com>
Date: Tue, 4 May 2021 14:42:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210504100424.8760-1-shumingf@realtek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, derek.fang@realtek.com, flove@realtek.com,
 pierre-louis.bossart@intel.com
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



On 5/4/21 5:04 AM, shumingf@realtek.com wrote:
> From: Shuming Fan <shumingf@realtek.com>
> 
> The function number should be FUNC_NUM_MIC_ARRAY(0x2) for the feature unit 0x1E.
> 
> Signed-off-by: Shuming Fan <shumingf@realtek.com>

This fixes the issue we saw, the test reports are fine with this patch. 
Thanks Shuming!

BugLink: https://github.com/thesofproject/linux/issues/2877
Fixes: ca5118c0c00f6 ('ASoC: rt711-sdca: change capture switch controls')

> ---
>   sound/soc/codecs/rt711-sdca.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/soc/codecs/rt711-sdca.c b/sound/soc/codecs/rt711-sdca.c
> index cc36739f7fcf..24a084e0b48a 100644
> --- a/sound/soc/codecs/rt711-sdca.c
> +++ b/sound/soc/codecs/rt711-sdca.c
> @@ -683,13 +683,13 @@ static int rt711_sdca_set_fu1e_capture_ctl(struct rt711_sdca_priv *rt711)
>   	ch_r = (rt711->fu1e_dapm_mute || rt711->fu1e_mixer_r_mute) ? 0x01 : 0x00;
>   
>   	err = regmap_write(rt711->regmap,
> -			SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU1E,
> +			SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT711_SDCA_ENT_USER_FU1E,
>   			RT711_SDCA_CTL_FU_MUTE, CH_L), ch_l);
>   	if (err < 0)
>   		return err;
>   
>   	err = regmap_write(rt711->regmap,
> -			SDW_SDCA_CTL(FUNC_NUM_JACK_CODEC, RT711_SDCA_ENT_USER_FU1E,
> +			SDW_SDCA_CTL(FUNC_NUM_MIC_ARRAY, RT711_SDCA_ENT_USER_FU1E,
>   			RT711_SDCA_CTL_FU_MUTE, CH_R), ch_r);
>   	if (err < 0)
>   		return err;
> 
