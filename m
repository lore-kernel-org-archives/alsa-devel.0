Return-Path: <SRS0=rgkk=NH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB2CC4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 18:41:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E0060F36
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Aug 2021 18:41:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 90E0060F36
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A27316B3;
	Mon, 16 Aug 2021 20:40:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A27316B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629139283;
	bh=2Ub8Ku+h4nm9vHBqpQP9yfo9PXbtBQpBRJmRgyeSeJE=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dF40Ft1cjcK5Wd0VuuTm48JoANPM5cmNWFKUxclAA8KmbDchWVKu05N6xq6rapnlE
	 Ec3a70sm3NZC0ixVDDhia60JVbcG/D6GDlUYqqSEuuA0fv94mt8VBtwkxp09JMLBLM
	 jjs7ipgD3TWfbEI4tfx883en3NFLRLvQCtfSX554=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19ED2F804AC;
	Mon, 16 Aug 2021 20:39:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E577FF804DA; Mon, 16 Aug 2021 20:39:55 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15F68F80134
 for <alsa-devel@alsa-project.org>; Mon, 16 Aug 2021 20:39:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15F68F80134
X-IronPort-AV: E=McAfee;i="6200,9189,10078"; a="195501391"
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; d="scan'208";a="195501391"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2021 11:39:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,326,1620716400"; d="scan'208";a="470893283"
Received: from vmartin1-mobl1.amr.corp.intel.com (HELO [10.212.120.166])
 ([10.212.120.166])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2021 11:39:43 -0700
Subject: Re: [PATCH] ASoC: Intel: bytcr_rt5640: Use cfg-lineout:2 in the
 components string
To: Hans de Goede <hdegoede@redhat.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
References: <20210816114722.107363-1-hdegoede@redhat.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <98e5c033-93d4-1d80-6770-914af26da6eb@linux.intel.com>
Date: Mon, 16 Aug 2021 08:32:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816114722.107363-1-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org
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



On 8/16/21 6:47 AM, Hans de Goede wrote:
> Use "cfg-lineout:2" in the components string on boards with a lineout
> instead of "cfg-lineout:1", this better mirrors the speaker part of
> the components string where we use "cfg-spk:1" for devices with a single
> speaker and "cfg-spk:2" for stereo speakers.
> 
> The lineout is stereo by default, so using ":2" makes more sense, this
> way we keep ":1" reserved in case we ever encounter a device with
> a mono lineout.
> 
> We can make this change without breaking userspace because no kernel
> has shipped with "cfg-lineout:1" in the component-string yet; and there
> also are no userspace bits (UCM profiles) checking for this yet.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/intel/boards/bytcr_rt5640.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 369642c07a5d..f79234f49c7c 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -1688,7 +1688,7 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
>  		if (byt_rt5640_quirk & BYT_RT5640_LINEOUT_AS_HP2)
>  			lineout_string = " cfg-hp2:lineout";
>  		else
> -			lineout_string = " cfg-lineout:1";
> +			lineout_string = " cfg-lineout:2";
>  	}
>  
>  	if (byt_rt5640_quirk & BYT_RT5640_HSMIC2_ON_IN1)
> 
