Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB83C54E49
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 14:28:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E61D20B1F
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 14:28:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Eq3jy7yK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E61D20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C0A36180F;
	Thu,  7 May 2020 16:28:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C0A36180F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588861731;
	bh=Day6GtZHdG1jC0DzOroHlEzNLO0xOgl2ggrb89xNwu8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Eq3jy7yKGt37pi8DKlxI/UJTp/x8gUwrp9sx6ii7BRmvikmiGq7pTXSc2RJmIYSQ4
	 h9Xh9vPslONk32Hp3cZkBkg+2d2S3nmUwjAhKgxsE0Q/kEhQJQhxuLgxv64OWODXXR
	 EHtziDSFToyuUbDTSlaNvNA4zV4NkchYl7rWLLpM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DACAF801D9;
	Thu,  7 May 2020 16:27:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42C7CF80162; Thu,  7 May 2020 16:27:57 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D6DCF8011C;
 Thu,  7 May 2020 16:27:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D6DCF8011C
IronPort-SDR: fOua2V/k8N7s04qIqpQWScbLVTwh4AskFH8Vlk9KzZbrQ472GsyGew5oopHBxMj/XOZg/jz50m
 LiljjdXpD34Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 May 2020 07:27:44 -0700
IronPort-SDR: FlxiV9tkifVn7SQpdJR7/GHu1h0vfLl0fpMDGosXbdVPsI4k9OWpjGR5wCx5IQQCHBfeEcRq+R
 rvv4bnW83v2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,364,1583222400"; d="scan'208";a="250105865"
Received: from kawilli2-mobl.amr.corp.intel.com (HELO [10.251.4.116])
 ([10.251.4.116])
 by fmsmga007.fm.intel.com with ESMTP; 07 May 2020 07:27:34 -0700
Subject: Re: [PATCH v2 -next] ASoC: SOF: Intel: Fix unused variable warning
To: YueHaibing <yuehaibing@huawei.com>, lgirdwood@gmail.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
 daniel.baluta@nxp.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 joe@perches.com
References: <20200507031911.38644-1-yuehaibing@huawei.com>
 <20200507072735.16588-1-yuehaibing@huawei.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <d3641489-e3c2-e525-567a-d0348c1eab4e@linux.intel.com>
Date: Thu, 7 May 2020 09:27:15 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200507072735.16588-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
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



On 5/7/20 2:27 AM, YueHaibing wrote:
> When CONFIG_SND_SOC_SOF_BAYTRAIL is not set, gcc warns:
> 
> sound/soc/sof/intel/byt.c:85:41: warning: ‘cht_debugfs’ defined but not used [-Wunused-const-variable=]
>   static const struct snd_sof_debugfs_map cht_debugfs[] = {
>                                           ^~~~~~~~~~~
> Move the variable inside #ifdef
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Thanks for the patch.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


