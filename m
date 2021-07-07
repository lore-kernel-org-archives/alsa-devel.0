Return-Path: <SRS0=Jhnj=L7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BCFC07E95
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 16:37:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E37D961CC9
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Jul 2021 16:37:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E37D961CC9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 762A8828;
	Wed,  7 Jul 2021 18:36:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 762A8828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1625675844;
	bh=AqRxgKiHIaC3JQ9wnPnsAwA/Tv+aT40xW9bARZCHcxI=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KYaRlBpZVTh+PzvVE4FGm8nTnycz2iEUX2KWqgo9yWtLWMPP8p844Q8lbJgfPHy3u
	 ycTv33L75cncw5PA1fUjKyNz8HwcnBsOlOu78hn/fVzNFP1UTKIm1bDcc19yXtauU+
	 qEjKpWoBPN+jjEyiJgElTczzTJRtCBfSEPkkQPIk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F453F804DA;
	Wed,  7 Jul 2021 18:35:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B06EDF80300; Wed,  7 Jul 2021 18:35:38 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 80594F80224
 for <alsa-devel@alsa-project.org>; Wed,  7 Jul 2021 18:35:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 80594F80224
X-IronPort-AV: E=McAfee;i="6200,9189,10037"; a="209299021"
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; d="scan'208";a="209299021"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2021 09:35:32 -0700
X-IronPort-AV: E=Sophos;i="5.84,220,1620716400"; d="scan'208";a="645442779"
Received: from cmcarran-mobl.amr.corp.intel.com (HELO [10.213.189.140])
 ([10.213.189.140])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Jul 2021 09:35:31 -0700
Subject: Re: [PATCH 06/12] ASoC: amd: irq handler changes for ACP5x PCM dma
 driver
To: Vijendar Mukunda <vijendar.mukunda@amd.com>, broonie@kernel.org,
 alsa-devel@alsa-project.org
References: <20210707055623.27371-1-vijendar.mukunda@amd.com>
 <20210707055623.27371-7-vijendar.mukunda@amd.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6ae6e658-692e-70f2-6bda-ce139168aae3@linux.intel.com>
Date: Wed, 7 Jul 2021 11:20:31 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707055623.27371-7-vijendar.mukunda@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: Alexander.Deucher@amd.com, Takashi Iwai <tiwai@suse.com>,
 Sunil-kumar.Dommati@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
 open list <linux-kernel@vger.kernel.org>
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


> +static irqreturn_t i2s_irq_handler(int irq, void *dev_id)
> +{
> +	struct i2s_dev_data *vg_i2s_data;
> +	u16 play_flag, cap_flag;
> +	u32 val;
> +
> +	vg_i2s_data = dev_id;
> +	if (!vg_i2s_data)
> +		return IRQ_NONE;
> +
> +	play_flag = 0;
> +	cap_flag = 0;
> +	val = acp_readl(vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
> +	if ((val & BIT(HS_TX_THRESHOLD)) && vg_i2s_data->play_stream) {
> +		acp_writel(BIT(HS_TX_THRESHOLD), vg_i2s_data->acp5x_base +
> +			   ACP_EXTERNAL_INTR_STAT);
> +		snd_pcm_period_elapsed(vg_i2s_data->play_stream);
> +		play_flag = 1;
> +	}
> +	if ((val & BIT(I2S_TX_THRESHOLD)) &&
> +	    vg_i2s_data->i2ssp_play_stream) {
> +		acp_writel(BIT(I2S_TX_THRESHOLD),
> +			   vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
> +		snd_pcm_period_elapsed(vg_i2s_data->i2ssp_play_stream);
> +		play_flag = 1;
> +	}
> +
> +	if ((val & BIT(HS_RX_THRESHOLD)) && vg_i2s_data->capture_stream) {
> +		acp_writel(BIT(HS_RX_THRESHOLD), vg_i2s_data->acp5x_base +
> +			   ACP_EXTERNAL_INTR_STAT);
> +		snd_pcm_period_elapsed(vg_i2s_data->capture_stream);
> +		cap_flag = 1;
> +	}
> +	if ((val & BIT(I2S_RX_THRESHOLD)) &&
> +	    vg_i2s_data->i2ssp_capture_stream) {
> +		acp_writel(BIT(I2S_RX_THRESHOLD),
> +			   vg_i2s_data->acp5x_base + ACP_EXTERNAL_INTR_STAT);
> +		snd_pcm_period_elapsed(vg_i2s_data->i2ssp_capture_stream);
> +		cap_flag = 1;
> +	}
> +
> +	if (play_flag | cap_flag)

it doesn't seem terribly useful to use two variables if you can use one?

> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;
> +}
> +

