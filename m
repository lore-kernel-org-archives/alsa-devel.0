Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E52D2C433FE
	for <alsa-devel@archiver.kernel.org>; Wed,  9 Nov 2022 13:40:05 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 030A53E8;
	Wed,  9 Nov 2022 14:39:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 030A53E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668001203;
	bh=ig2AAvmJ4d5/ScWgFInIfDGDvmUqTlDzptDrlLKqlNo=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RS7VQyPEBiGu0HRIBBqYbmu/vs5z9ZJcVqR0OcnJRbzWLRMpJ5PItJrnpLg0cGYtq
	 nAMc9eWGaIUPVIRMdohDkJEMP9gX5hQ7/uG8CJ/coGvN5g/DJ2kj4fDNaDWYvG3mTf
	 1imM0Fc6CrEl5cQ8EkHvFQoBJE8WzvskWmGMYGmM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93726F80166;
	Wed,  9 Nov 2022 14:39:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 45901F80217; Wed,  9 Nov 2022 14:39:11 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD610F800EC
 for <alsa-devel@alsa-project.org>; Wed,  9 Nov 2022 14:39:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD610F800EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="L1lOYSDA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668001147; x=1699537147;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=ig2AAvmJ4d5/ScWgFInIfDGDvmUqTlDzptDrlLKqlNo=;
 b=L1lOYSDAYNxt2oCfHjqCkHpvJXM/hwkXFPLxYkGUYxue1PbMXeAm502z
 Pud0q8XY2WUjfHjy78kg0+DZ0Xon18HpI/z6UoKv6rMqvRfBqoDi0hhjv
 dfq1nPam0LpR1bv2DmyQhhgA/eUYtkpCM1HONRt0hRs8jZCP8TT1ioxFe
 UGT+fi2ayeK0u2U2vrxuioqSI6yYMK+AKlb64jSqS6I4ef5q5lf03kCc3
 TBiLqHZqrGBmBwnCYE/1HGNqEeazT+PDuxOOJZm+p/zEC92mx+IYByM/a
 ABxFIw4TFrQGeaCma3Mm9V0oaiWhKkZt15qZvN7L9fR+IOUUKmyTPwJXi Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="309687916"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; d="scan'208";a="309687916"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2022 05:38:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="700358654"
X-IronPort-AV: E=Sophos;i="5.96,150,1665471600"; d="scan'208";a="700358654"
Received: from bsdoyle-mobl1.amr.corp.intel.com (HELO [10.252.0.23])
 ([10.252.0.23])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2022 05:38:55 -0800
Message-ID: <94717ffd-11b0-7242-b145-baff9035092a@linux.intel.com>
Date: Wed, 9 Nov 2022 15:39:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.2
Subject: Re: [PATCH linux-next v2] ASoC: SOF: remove duplicated included
 sof-audio.h
To: yang.yang29@zte.com.cn, pierre-louis.bossart@linux.intel.com
References: <202211092130548796460@zte.com.cn>
Content-Language: en-US
From: =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>
In-Reply-To: <202211092130548796460@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 ranjani.sridharan@linux.intel.com, broonie@kernel.org, xu.panda@zte.com.cn,
 yung-chuan.liao@linux.intel.com
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



On 09/11/2022 15:30, yang.yang29@zte.com.cn wrote:
> From: Xu Panda <xu.panda@zte.com.cn>
> 
> The sof-audio.h is included more than once.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Xu Panda <xu.panda@zte.com.cn>
> Signed-off-by: Yang Yang <yang.yang29@zte.com>
> Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

> 
> ---
> change for v2
>  - add maintainers and the alsa-devel mailing list in CC.  
> ---
> 
>  sound/soc/sof/amd/acp-common.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/sof/amd/acp-common.c b/sound/soc/sof/amd/acp-common.c
> index 27b95187356e..348e70dfe2a5 100644
> --- a/sound/soc/sof/amd/acp-common.c
> +++ b/sound/soc/sof/amd/acp-common.c
> @@ -13,7 +13,6 @@
>  #include "../sof-priv.h"
>  #include "../sof-audio.h"
>  #include "../ops.h"
> -#include "../sof-audio.h"
>  #include "acp.h"
>  #include "acp-dsp-offset.h"
> 

-- 
Péter
