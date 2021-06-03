Return-Path: <SRS0=JknX=K5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C3C47096
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 15:33:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6051D6100B
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Jun 2021 15:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6051D6100B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28A201700;
	Thu,  3 Jun 2021 17:32:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28A201700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622734416;
	bh=SD3tlsEFNk595O26ev1XUFErVXcnk5uiAa/7Jds9//4=;
	h=Subject:From:To:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r15dlUxE0rqTk/2sfvN0V4kwwOSGx7au3E5CuIPW1cllhaYkT6oHXfCjL1PJIpnSN
	 ZbXN4vGNI1o0LO4+lYkskrtDPQ2GhOv3zKwM52KpLDUbF6MSOwTANbfYd4BU2abwmq
	 LLVtGEftB0pk71u06FLSLMxLVMLOnHkH2GXwz82E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B28A2F80253;
	Thu,  3 Jun 2021 17:32:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51B69F80100; Thu,  3 Jun 2021 17:32:44 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2DA9F80100;
 Thu,  3 Jun 2021 17:32:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2DA9F80100
IronPort-SDR: lEA3Qh8++uM9PPrPVsvxQb5ccZ7L1lkgNQF2+78tFvWM15VvvyvMug5uT0Y6EP/CqCCHwKyATs
 x+VhV/P4WEhw==
X-IronPort-AV: E=McAfee;i="6200,9189,10004"; a="201055817"
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; d="scan'208";a="201055817"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 08:32:23 -0700
IronPort-SDR: qWZID5tBZ37vSk5PGxk1TeluGIpGIOstEBtNWjTBAomczxbxaFTwEXp82xKFmoK5W4uKpwGii7
 p2cLy9rm2y4g==
X-IronPort-AV: E=Sophos;i="5.83,246,1616482800"; d="scan'208";a="636276600"
Received: from camleint-mobl2.amr.corp.intel.com ([10.213.188.150])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jun 2021 08:32:23 -0700
Message-ID: <b1c971fd42af39d93de71568b3015520e8d1808a.camel@linux.intel.com>
Subject: Re: [PATCH] ASoC: SOF: Intel: Remove duplicate include of shim.h
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: Wan Jiabing <wanjiabing@vivo.com>, Pierre-Louis Bossart
 <pierre-louis.bossart@linux.intel.com>, Liam Girdwood
 <lgirdwood@gmail.com>,  Kai Vehmanen <kai.vehmanen@linux.intel.com>, Daniel
 Baluta <daniel.baluta@nxp.com>, Mark Brown <broonie@kernel.org>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Guennadi
 Liakhovetski <guennadi.liakhovetski@linux.intel.com>,  Bard Liao
 <bard.liao@intel.com>, sound-open-firmware@alsa-project.org,
 alsa-devel@alsa-project.org,  linux-kernel@vger.kernel.org
Date: Thu, 03 Jun 2021 08:32:22 -0700
In-Reply-To: <1622689193-29884-1-git-send-email-wanjiabing@vivo.com>
References: <1622689193-29884-1-git-send-email-wanjiabing@vivo.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
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

On Thu, 2021-06-03 at 10:59 +0800, Wan Jiabing wrote:
> shim.h is included twice.
> As shim.h is not related to later header file,
> keep one which has comment and remove the former one.
> 
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  sound/soc/sof/intel/pci-tng.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/sound/soc/sof/intel/pci-tng.c b/sound/soc/sof/intel/pci-
> tng.c
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
Thanks for the patch.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

