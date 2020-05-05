Return-Path: <SRS0=O8MK=6T=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7FDC47247
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 22:06:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4BF206FA
	for <alsa-devel@archiver.kernel.org>; Tue,  5 May 2020 22:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="U5PTFi8G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4BF206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F033B1766;
	Wed,  6 May 2020 00:05:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F033B1766
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588716376;
	bh=lLfovNiB3PUsqPbHUudnYWp5OpVZmpmM4GnavR14tWA=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U5PTFi8GWI7an28auJZf4JZ4gwFFR7XQyGDa/PoN0uxRqXLB00zzG161sger/cU4J
	 80BMf7qWpIZ3LGCvJGP0LCrWUkjYAq0mWSN+b1I51Xbfxtvo2yR+l6asCObKcKUYCa
	 uvlZOCuMd5G1jHR4OTumcMnyxKmAcyzu2bGgt9zk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A46E3F8015B;
	Wed,  6 May 2020 00:05:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8B78F80246; Wed,  6 May 2020 00:04:33 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 82C9AF800EE
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2020 00:04:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 82C9AF800EE
IronPort-SDR: F6IXSjwtvjMPI06S4kjLaFdhByyBOhsYjwdCYfIUtCAwNT0keg04nqE81EC/SB1LKgpRfBFz67
 cyOwIDfoEMYw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2020 15:04:22 -0700
IronPort-SDR: Eq048dK3LBe/kdnLFdT1E5Xs27WOzNQKWFyrrzu9F1Ih4jNoBgeyGWO+IiLAytMW+HhkgxW2QH
 oyl/krnsHLfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,356,1583222400"; d="scan'208";a="278022610"
Received: from krogers-mobl1.amr.corp.intel.com (HELO [10.255.229.42])
 ([10.255.229.42])
 by orsmga002.jf.intel.com with ESMTP; 05 May 2020 15:04:21 -0700
Subject: Re: [PATCH 08/14] ASoC: amd: add ACP PDM DMA driver dai ops
To: Alex Deucher <alexdeucher@gmail.com>, alsa-devel@alsa-project.org,
 broonie@kernel.org, vijendar.mukunda@amd.com, tiwai@suse.de
References: <20200505205327.642282-1-alexander.deucher@amd.com>
 <20200505205327.642282-9-alexander.deucher@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <703519fb-de83-103e-63fc-7a6c61f7c720@linux.intel.com>
Date: Tue, 5 May 2020 16:55:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505205327.642282-9-alexander.deucher@amd.com>
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
> +	while (++timeout < 20000) {
> +		pdm_dma_enable = rn_readl(acp_base + ACP_WOV_PDM_DMA_ENABLE);
> +		if ((pdm_dma_enable & 0x02) == ACP_PDM_DMA_EN_STATUS)
> +			return 0;
> +		udelay(5);
> +	}

maybe use human-readable defines for timeout and delay?
e.g.

#define TIMEOUT_MS 100
#define DELAY_US 5

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
> +		while (++timeout < 20000) {
> +			pdm_dma_enable = rn_readl(acp_base +
> +						  ACP_WOV_PDM_DMA_ENABLE);
> +			if ((pdm_dma_enable & 0x02) == 0x00)
> +				return 0;
> +			udelay(5);
> +		}
> +		if (timeout == 20000)

if this test needed, it'll be always true, no?

> +			return -ETIMEDOUT;
> +	}
> +	if (pdm_enable == ACP_PDM_ENABLE) {
> +		pdm_enable = ACP_PDM_DISABLE;
> +		rn_writel(pdm_enable, acp_base + ACP_WOV_PDM_ENABLE);
> +	}
> +	rn_writel(0x01, acp_base + ACP_WOV_PDM_FIFO_FLUSH);
> +	return 0;
> +}
> +

> +static int acp_pdm_dai_hw_params(struct snd_pcm_substream *substream,
> +				 struct snd_pcm_hw_params *params,
> +				 struct snd_soc_dai *dai)
> +{
> +	struct pdm_stream_instance *rtd;
> +	unsigned int ch_mask;
> +
> +	rtd = substream->runtime->private_data;
> +	switch (params_channels(params)) {
> +	case TWO_CH:
> +	default:
> +		ch_mask = 0x00;
> +		break;
> +	}

the switch doesn't appear very useful at the moment?

> +	config_pdm_stream_params(ch_mask, rtd->acp_base);
> +	return 0;
> +}
> +
