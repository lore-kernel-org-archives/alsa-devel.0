Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB71C47255
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 01:08:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BEBA20674
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 01:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="rMceHaYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BEBA20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D66D69F6;
	Tue, 12 May 2020 03:07:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D66D69F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589245715;
	bh=PIpK/m6MHqp35xcHk6gTQLjNyzx+pajofjvxkVXj8I8=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rMceHaYZSEh0CBzQrceBYUKQ/rn9rxna99q4ibh561MRRRNpe/6CCrEFuteGuFRV+
	 uqWFpXsaaTrv/zPux16LkgMtgEorp53SCODwPHcb6+h2pFDmwUZwXtNTl0GQJQNxWL
	 D2G3uz+xpviEzA7jHR8gc8ZO2xthngXmJds/xo60=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A833F8027B;
	Tue, 12 May 2020 00:37:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F08D3F8027D; Tue, 12 May 2020 00:37:53 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CE96AF8022D
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 00:37:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CE96AF8022D
IronPort-SDR: stvGxck6sG8Qq4qQcE2gcuj8wPBq7sYB+fYinSgfG9QorvC6qs9b8l5NUpkB4idyJkBJJ+qPY/
 nsEtf+WQbcJA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 May 2020 15:37:44 -0700
IronPort-SDR: MFmjZQYDIjRfgpqbGvXERom4jAnx7w529KtW0ZGWI6v9ScsgpwtNqjJ1uJ0QbqHs9avsQjI8oO
 5FUJLwlvMR/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; d="scan'208";a="252717103"
Received: from xshi16-mobl2.amr.corp.intel.com (HELO [10.254.96.249])
 ([10.254.96.249])
 by fmsmga008.fm.intel.com with ESMTP; 11 May 2020 15:37:44 -0700
Subject: Re: [PATCH v2 08/14] ASoC: amd: add ACP PDM DMA driver dai ops
To: Alex Deucher <alexdeucher@gmail.com>, alsa-devel@alsa-project.org,
 broonie@kernel.org, vijendar.mukunda@amd.com, tiwai@suse.de
References: <20200511212014.2359225-1-alexander.deucher@amd.com>
 <20200511212014.2359225-9-alexander.deucher@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <3c1a08a0-31e8-dc0c-a903-190861b7fa11@linux.intel.com>
Date: Mon, 11 May 2020 17:12:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511212014.2359225-9-alexander.deucher@amd.com>
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




> +static int start_pdm_dma(void __iomem *acp_base)
> +{
> +	u32 pdm_enable;
> +	u32 pdm_dma_enable;
> +	int timeout;
> +
> +	pdm_enable = 0x01;
> +	pdm_dma_enable  = 0x01;
> +
> +	enable_pdm_clock(acp_base);
> +	rn_writel(pdm_enable, acp_base + ACP_WOV_PDM_ENABLE);
> +	rn_writel(pdm_dma_enable, acp_base + ACP_WOV_PDM_DMA_ENABLE);
> +	pdm_dma_enable = 0x00;
> +	timeout = 0;
> +	while (++timeout < ACP_COUNTER) {
> +		pdm_dma_enable = rn_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
> +		if ((pdm_dma_enable & 0x02) == ACP_PDM_DMA_EN_STATUS)
> +			return 0;
> +		udelay(DELAY_US);
> +	}
> +	return -ETIMEDOUT;
> +}
> +
> +static int stop_pdm_dma(void __iomem *acp_base)
> +{
> +	u32 pdm_enable, pdm_dma_enable, pdm_fifo_flush;
> +	int timeout;
> +
> +	pdm_enable = 0x00;
> +	pdm_dma_enable  = 0x00;
> +	pdm_fifo_flush = 0x00;
> +
> +	pdm_enable = rn_readl(acp_base + ACP_WOV_PDM_ENABLE);
> +	pdm_dma_enable = rn_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
> +	if (pdm_dma_enable & 0x01) {
> +		pdm_dma_enable = 0x02;
> +		rn_writel(pdm_dma_enable, acp_base + ACP_WOV_PDM_DMA_ENABLE);
> +		pdm_dma_enable = 0x00;
> +		timeout = 0;
> +		while (++timeout < ACP_COUNTER) {
> +			pdm_dma_enable = rn_readl(acp_base +
> +						  ACP_WOV_PDM_DMA_ENABLE);
> +			if ((pdm_dma_enable & 0x02) == 0x00)
> +				break;
> +			udelay(DELAY_US);
> +		}
> +		if (timeout == ACP_COUNTER)

if you reach this point, timeout is by construction equal to ACP_COUNTER 
so this test is useless

You could also use a helper where you check if the value is 
ACP_PDM_DMA_EN_STATUS or zero so that you don't copy the same logic twice.

