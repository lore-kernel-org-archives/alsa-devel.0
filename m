Return-Path: <SRS0=qqgH=3Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16018C2D0DB
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 21:24:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B11424656
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Jan 2020 21:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="X2u/2n4o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B11424656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3E0D41;
	Mon, 27 Jan 2020 22:23:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3E0D41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1580160281;
	bh=T4ca5mqKMjsouhlodTne+e/6OIB1NPk62m9AuNCjvYU=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=X2u/2n4odKie7IXmmPD6PfCF2SDnDJjipTDgfRXJMsdgkGD4t2myrtCTysW33PbkI
	 FQU/OCajRj4YnGEDkVoz//ial+O/JV8kHWZNNhHKDzbm9eqYAATwAVZ4uRjpCEMJzD
	 BOfLc4nc9rfIT58RNZcSLPg0sRIiZCzhBAIzFrlo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 123E5F8027B;
	Mon, 27 Jan 2020 22:21:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D28AFF80256; Mon, 27 Jan 2020 22:21:21 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 36429F800C8
 for <alsa-devel@alsa-project.org>; Mon, 27 Jan 2020 22:21:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 36429F800C8
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Jan 2020 13:21:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,371,1574150400"; d="scan'208";a="231649962"
Received: from ngstahl-mobl1.amr.corp.intel.com (HELO [10.254.190.105])
 ([10.254.190.105])
 by orsmga006.jf.intel.com with ESMTP; 27 Jan 2020 13:21:10 -0800
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20200127121243.15813-1-cezary.rojewski@intel.com>
 <20200127121243.15813-9-cezary.rojewski@intel.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bff9507d-c3c3-53b8-3ee2-ce737ebadfee@linux.intel.com>
Date: Mon, 27 Jan 2020 15:17:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200127121243.15813-9-cezary.rojewski@intel.com>
Content-Language: en-US
Cc: broonie@kernel.org, lgirdwood@gmail.com, tiwai@suse.com
Subject: Re: [alsa-devel] [PATCH v2 08/11] ASoC: SOF: Generic probe compress
 operations
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


> diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
> index 827b0ec92522..0fca86164472 100644
> --- a/sound/soc/sof/Kconfig
> +++ b/sound/soc/sof/Kconfig
> @@ -171,6 +171,15 @@ config SND_SOC_SOF_DEBUG_RETAIN_DSP_CONTEXT
>   	  Say Y if you want to retain DSP context for FW exceptions.
>   	  If unsure, select "N".
>   
> +config SND_SOC_SOF_DEBUG_PROBES
> +	bool "SOF enable data probing"
> +	select SND_SOC_COMPRESS
> +	help
> +	  This option enables the data probing feature that can be used to
> +	  gather data directly from specific points of the audio pipeline.
> +	  Say Y if you want to enable probes.
> +	  If unsure, select "N".
> +
>   endif ## SND_SOC_SOF_DEBUG
>   
>   endif ## SND_SOC_SOF_DEVELOPER_SUPPORT

we need to agree with firmware folks on
a) making sure the probes are enabled on all SKL+ firmware
b) we have a means to detect if probes are supported by the firmware.

I think the probes should be enabled in all distributions, even when 
using firmware signed with a production key, it doesn't impact anything 
until the root user explicitly configures probe points.

Since we explicitly advise distributions not to include developer 
options, we probably need to move this Kconfig outside. of these two 
'if' blocks.
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
