Return-Path: <SRS0=u8hq=O7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44EA1C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 08:59:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6824360F57
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Oct 2021 08:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6824360F57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 39E8B1661;
	Mon, 11 Oct 2021 10:58:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 39E8B1661
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633942777;
	bh=wHU019fbJVAsSktUZooMbdr7tTMuKVgiphXB72AwWOQ=;
	h=Subject:From:To:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Misgu8K78IpfgPGizBCKoHwC6T4EwnZyOz6IejJWED9j9RCWMRMQDH/G3QG+oap6u
	 HI0AO/JBFSzFGJf/vve5YC/itcWT56YAoZQR+dFYCkVircHIHJ/4y+DFOxD8fUMd9j
	 WkIFOWKbaSvIreSdHsNn6uikGQ1CbSgWoST9YPYM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C73ECF8025B;
	Mon, 11 Oct 2021 10:58:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8AC0BF80269; Mon, 11 Oct 2021 10:58:45 +0200 (CEST)
Received: from smtprelay.hostedemail.com (smtprelay0161.hostedemail.com
 [216.40.44.161])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 94D5CF8016D
 for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2021 10:58:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 94D5CF8016D
Received: from omf08.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
 by smtprelay06.hostedemail.com (Postfix) with ESMTP id A19B9180498C4;
 Mon, 11 Oct 2021 08:58:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by
 omf08.hostedemail.com (Postfix) with ESMTPA id BCA631A29FC; 
 Mon, 11 Oct 2021 08:58:35 +0000 (UTC)
Message-ID: <e71f1db7fecefa1f8eccd29d5a6cad3c126a1753.camel@perches.com>
Subject: Re: [PATCH 06/13] ASoC: amd: add acp6x irq handler
From: Joe Perches <joe@perches.com>
To: Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org, 
 alsa-devel@alsa-project.org
Date: Mon, 11 Oct 2021 01:58:34 -0700
In-Reply-To: <20211011055621.13240-7-Vijendar.Mukunda@amd.com>
References: <20211011055621.13240-1-Vijendar.Mukunda@amd.com>
 <20211011055621.13240-7-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: BCA631A29FC
X-Stat-Signature: ekf4w1htyoc117ttotrgwqhc66msjcy8
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19emX/HhWPToL33rXhnSxB272awpFz6qdk=
X-HE-Tag: 1633942715-698277
Cc: Sunil-kumar.Dommati@amd.com, Richard.Gong@amd.com,
 Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mario.Limonciello@amd.com,
 Alexander.Deucher@amd.com, open list <linux-kernel@vger.kernel.org>
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

On Mon, 2021-10-11 at 11:26 +0530, Vijendar Mukunda wrote:
> Add ACP6x irq handler for handling irq events for ACP IP.
> Add pdm irq events handling.
> Whenever audio data equal to the PDM watermark level are consumed,
> interrupt is generated. Acknowledge the interrupt.

> diff --git a/sound/soc/amd/yc/pci-acp6x.c b/sound/soc/amd/yc/pci-acp6x.c
[]
> @@ -116,6 +118,33 @@ static int acp6x_deinit(void __iomem *acp_base)
>  	return 0;
>  }
> 
> +static irqreturn_t acp6x_irq_handler(int irq, void *dev_id)
> +{
> +	struct acp6x_dev_data *adata;
> +	struct pdm_dev_data *yc_pdm_data;
> +	u16 irq_flag;

irq_flag seems unnecessary.

> +	u32 val;
> +
> +	adata = dev_id;
> +	if (!adata)
> +		return IRQ_NONE;
> +
> +	irq_flag = 0;
> +	val = acp6x_readl(adata->acp6x_base + ACP_EXTERNAL_INTR_STAT);
> +	if (val & BIT(PDM_DMA_STAT)) {
> +		yc_pdm_data = dev_get_drvdata(&adata->pdev[0]->dev);
> +		acp6x_writel(BIT(PDM_DMA_STAT), adata->acp6x_base + ACP_EXTERNAL_INTR_STAT);
> +		if (yc_pdm_data->capture_stream)
> +			snd_pcm_period_elapsed(yc_pdm_data->capture_stream);
> +		irq_flag = 1;

Could be:

		return IRQ_HANDLED;

> +	}
> +
> +	if (irq_flag)
> +		return IRQ_HANDLED;
> +	else
> +		return IRQ_NONE;

and
	return IRQ_NONE;

> +}


