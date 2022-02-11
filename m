Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13FA4C433FE
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Feb 2022 00:22:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0B5A18E5;
	Fri, 11 Feb 2022 01:21:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0B5A18E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1644538918;
	bh=e5IiG17cQUjJ9PQOtAwSdbXG1C8VuyC2rEhJR099Nh0=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RTFr7MVwBPtSkBR3RRsKdLwq2YSr4IrmmP4jxPbax2ctRfQ1XyR1RF1sFL/N4m10P
	 g5/aQfqFBytQFYSf0KDK90MmYuN+uss+/xZOyb1u+R5eIRG3EXwPQU8Sd5qsxvOUsf
	 LanaDHJ5xSrnctPnGjrpPBiICTTHS99SR5VvsAEg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 637F9F8016C;
	Fri, 11 Feb 2022 01:21:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 03C69F8013D; Fri, 11 Feb 2022 01:21:07 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4931CF8013D
 for <alsa-devel@alsa-project.org>; Fri, 11 Feb 2022 01:20:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4931CF8013D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="SNlVMQQz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1644538861; x=1676074861;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=e5IiG17cQUjJ9PQOtAwSdbXG1C8VuyC2rEhJR099Nh0=;
 b=SNlVMQQzXTqeR4t9p/dNIFJwYGXXenfxl+SGJlDB7HIEQh+q+YY0ey1r
 AjLNI8GLehUwv1fwNxa1waW33i+nvAFoTqGWRp7sbIGqiHWwuONzDeIci
 mncRFCWMG3F90Rcda/+6XimYKXSPVKkI1r2uM09PlkCMtINr6uSl8WIfI
 aluJlDuTRO3vMyGSx9kW5/8oYG8U3bilNDvoD4RWMe6lBu2vhUe13KW5K
 F0sFmWc4g19FvrxUbMJn34TB395lAs6NSk9A83HaPJI0RBWOg+jmbXXin
 gGhlX31jytIocWiUoaEBJJn2AloxJUb/LJVfu8EvEIlw+Y7jv3Bo91dOv g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="312907731"
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="312907731"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 16:20:55 -0800
X-IronPort-AV: E=Sophos;i="5.88,359,1635231600"; d="scan'208";a="774072606"
Received: from wlincolx-mobl.amr.corp.intel.com (HELO [10.212.86.106])
 ([10.212.86.106])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2022 16:20:54 -0800
Message-ID: <d26561a1-ddd4-aea0-792d-efce104ad44f@linux.intel.com>
Date: Thu, 10 Feb 2022 18:20:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH 3/9] ASoC: Intel: bytcr_wm5102: use GFP_KERNEL
Content-Language: en-US
To: Julia Lawall <Julia.Lawall@inria.fr>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Hans de Goede <hdegoede@redhat.com>
References: <20220210204223.104181-1-Julia.Lawall@inria.fr>
 <20220210204223.104181-4-Julia.Lawall@inria.fr>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220210204223.104181-4-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, kernel-janitors@vger.kernel.org,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 linux-kernel@vger.kernel.org, Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>
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



On 2/10/22 14:42, Julia Lawall wrote:
> Platform_driver probe functions aren't called with locks held
> and thus don't need GFP_ATOMIC. Use GFP_KERNEL instead.
> 
> Problem found with Coccinelle.

Thanks Julia, indeed it's the only case where GFP_ATOMIC is used for
machine drivers.

This was already present in the initial Android driver from Intel (2013)
[1] and missed in the multiple passes to get this upstream.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

[1]
https://github.com/lenovo-yt2-dev/android_kernel_lenovo_baytrail/blob/cm-12.1/sound/soc/intel/board/byt_bl_wm5102.c

> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
> 
> ---
>  sound/soc/intel/boards/bytcr_wm5102.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/bytcr_wm5102.c b/sound/soc/intel/boards/bytcr_wm5102.c
> index 504ef4cab111..8d8e96e3cd2d 100644
> --- a/sound/soc/intel/boards/bytcr_wm5102.c
> +++ b/sound/soc/intel/boards/bytcr_wm5102.c
> @@ -389,7 +389,7 @@ static int snd_byt_wm5102_mc_probe(struct platform_device *pdev)
>  	bool sof_parent;
>  	int ret;
>  
> -	priv = devm_kzalloc(dev, sizeof(*priv), GFP_ATOMIC);
> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
>  
> 
