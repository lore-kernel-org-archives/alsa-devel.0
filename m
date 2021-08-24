Return-Path: <SRS0=yNKw=NP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365D7C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 16:55:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C42A61357
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Aug 2021 16:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C42A61357
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A0E21687;
	Tue, 24 Aug 2021 18:54:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A0E21687
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629824131;
	bh=+Ae2hJzwKabWBC/dCIci9nXRDGTo/6ZOeNaG9uY5fN0=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HSPDezcJlO2KWmwugK8s6+2jjQq+YTe/jsvsYwS7ke7AKxuoyG37YlgYHfQYp1TYK
	 hcqeOFA1pXB21XXLFetlnMLGwooBukNvh4Uq2EDTYUoWeAmR8iLMKnahXrFFoL7LK7
	 abDffzJjLoZkur+RDSk0XGJcTHmeougbybD5WS2Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 691F7F80431;
	Tue, 24 Aug 2021 18:53:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8975F80171; Tue, 24 Aug 2021 18:53:55 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2E457F80171;
 Tue, 24 Aug 2021 18:53:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2E457F80171
X-IronPort-AV: E=McAfee;i="6200,9189,10086"; a="217076303"
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; d="scan'208";a="217076303"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2021 09:53:34 -0700
X-IronPort-AV: E=Sophos;i="5.84,347,1620716400"; d="scan'208";a="685433440"
Received: from jlrivera-mobl1.amr.corp.intel.com (HELO [10.212.8.132])
 ([10.212.8.132])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2021 09:53:33 -0700
Subject: Re: [PATCH linux-next] ASoC: SOF: intel: remove duplicate include
To: CGEL <cgel.zte@gmail.com>
References: <20210824030015.57267-1-deng.changcheng@zte.com.cn>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <b352affd-7b20-633f-de81-ca0196e5004d@linux.intel.com>
Date: Tue, 24 Aug 2021 11:27:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210824030015.57267-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 alsa-devel@alsa-project.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Changcheng Deng <deng.changcheng@zte.com.cn>,
 Daniel Baluta <daniel.baluta@nxp.com>, Bard Liao <bard.liao@intel.com>,
 sound-open-firmware@alsa-project.org
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



On 8/23/21 10:00 PM, CGEL wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Clean up the following includecheck warning:
> 
> ./sound/soc/sof/intel/pci-tng.c: shim.h is included more than once.
> 
> No functional change.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/sof/intel/pci-tng.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/sof/intel/pci-tng.c b/sound/soc/sof/intel/pci-tng.c
> index 4ee1da3..4bded66 100644
> --- a/sound/soc/sof/intel/pci-tng.c
> +++ b/sound/soc/sof/intel/pci-tng.c
> @@ -15,7 +15,6 @@
>  #include <sound/sof.h>
>  #include "../ops.h"
>  #include "atom.h"
> -#include "shim.h"
>  #include "../sof-pci-dev.h"
>  #include "../sof-audio.h"
>  
> 
