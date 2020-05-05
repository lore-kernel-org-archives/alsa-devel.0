Return-Path: <SRS0=O8MK=6T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96418C47247
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 22:07:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C19206B8
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 22:07:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IN1NvbBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C19206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 726F61762;
	Wed,  6 May 2020 00:06:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 726F61762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588716453;
	bh=PkQeGxkbmXscFKocF9rMq+++TNPHxe34qLPXgLvqlRo=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IN1NvbBvaE442M3X/JaqflTo49WWa+Xy13wdFmMGDXOaEj4w/ZEIn/1wYB7FOZ5QV
	 TRieisHJGp6w883ecu8ki2D3mXPtSVi7mKfdZMxEYaYgD94kEvRBbMFjaWpoohiegR
	 tl51ZtTNGq4UIg+j4a+ktCGfQmIQFzkeBn0qeINw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD99DF80291;
	Wed,  6 May 2020 00:05:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 47A22F8025E; Wed,  6 May 2020 00:04:33 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DD5A7F8015B
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2020 00:04:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DD5A7F8015B
IronPort-SDR: B0AYs4WUIikZDaxsmy3vIQcCCIIX1NyJh4Ck0xrBdF1vdEHtrn9rRSfoZk5umtKlXfhJmZWQ4v
 YsNYV5zd6bHg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2020 15:04:20 -0700
IronPort-SDR: NZhn9tyqngAvheTArHGlxPoQg4/LLKYzgFT41JNNgiHGKQNCuRBuxjOcn6/q3Zmrfclzv02AWM
 T37BOJc2uigg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,356,1583222400"; d="scan'208";a="278022606"
Received: from krogers-mobl1.amr.corp.intel.com (HELO [10.255.229.42])
 ([10.255.229.42])
 by orsmga002.jf.intel.com with ESMTP; 05 May 2020 15:04:19 -0700
Subject: Re: [PATCH 09/14] ASoC: amd: add Renoir ACP PCI driver PM ops
To: Alex Deucher <alexdeucher@gmail.com>, alsa-devel@alsa-project.org,
 broonie@kernel.org, vijendar.mukunda@amd.com, tiwai@suse.de
References: <20200505205327.642282-1-alexander.deucher@amd.com>
 <20200505205327.642282-10-alexander.deucher@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7a675344-e5be-0570-f56e-6def475d19b8@linux.intel.com>
Date: Tue, 5 May 2020 16:48:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505205327.642282-10-alexander.deucher@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Alex Deucher <alexander.deucher@amd.com>
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



> diff --git a/sound/soc/amd/renoir/rn-pci-acp3x.c b/sound/soc/amd/renoir/rn-pci-acp3x.c
> index 362409ef0d85..6d013a1bffa6 100644
> --- a/sound/soc/amd/renoir/rn-pci-acp3x.c
> +++ b/sound/soc/amd/renoir/rn-pci-acp3x.c
> @@ -10,6 +10,7 @@
>   #include <linux/delay.h>
>   #include <linux/platform_device.h>
>   #include <linux/interrupt.h>
> +#include <linux/pm_runtime.h>
>   
>   #include "rn_acp3x.h"
>   
> @@ -233,6 +234,12 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
>   		ret = PTR_ERR(adata->pdev);
>   		goto unregister_devs;
>   	}
> +	pm_runtime_set_autosuspend_delay(&pci->dev, ACP_SUSPEND_DELAY_MS);
> +	pm_runtime_use_autosuspend(&pci->dev);
> +	pm_runtime_set_active(&pci->dev);

is the set_active() needed? I haven't seen this in the other PCI audio 
drivers?

> +	pm_runtime_put_noidle(&pci->dev);
> +	pm_runtime_enable(&pci->dev);

same, is the _enable() needed()?

> +	pm_runtime_allow(&pci->dev);
>   	return 0;
>   
>   unregister_devs:
> @@ -250,6 +257,42 @@ static int snd_rn_acp_probe(struct pci_dev *pci,
>   	return ret;
>   }
>   

