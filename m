Return-Path: <SRS0=TlZm=FT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6FD5C2BB48
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 09:42:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B412226A
	for <alsa-devel@archiver.kernel.org>; Tue, 15 Dec 2020 09:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B412226A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=metafoo.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 06548175C;
	Tue, 15 Dec 2020 10:41:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 06548175C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608025328;
	bh=phTtKGyoDqxr7oWYkWZJGpXm1UvQxi+3Dz/hkRA2k1c=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ELVMZtlSyA18dl69dc3tbv9JK+pXHWK6+dbfNLXbd0N+tGXHp6tgemwT+6MLvbnIY
	 QmqUhcmgoQ6rOmbMcmaPemAsICfeYrOGtQpQRkxDP+6X/HbxsdoSDV1WqptTGykD7m
	 wziMWr9pirNuJGMEir9DBupAOKv1iY/zeEtDrME8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 86FA8F80259;
	Tue, 15 Dec 2020 10:41:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DA0AFF80278; Tue, 15 Dec 2020 10:41:12 +0100 (CET)
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43746F8014B
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2020 10:41:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43746F8014B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de
 header.b="ZIiJeXmm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de; 
 s=default2002;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID;
 bh=4WtR+RUOoThGrkkM/s4XkBEwXrVIbHbd/JdvpLJuFBk=; b=ZIiJeXmmdeKmQnH28jDf5A25vs
 qhSlel4v2EReYSe6+YEuaL//+EU+fKmFb2iC3BZ1v7GFJja3BAurOE2glTTKX1RtMcIm4XZ5gGGED
 zDvGHwynmaCigYzh7tSP/n/EC3zxq2Y5gU1GMmnJoqsNzoYRemEhtNxMEAHK3x/aw7s8pPfdINp5V
 DUXOLk4WGPe+wcP6CUxt1Iy0T9zXWJN8Og5tVU4dN+E/2xeH+WHxsLEXQlaNELWwankKTPLW21llh
 gjEeVjgEs+DbTGLtXHufYsqTWL3mJ1f9XjQ7/fSgLmOezkIv4C1BF16vPNjwZiHZbrMhz1hz5jlgU
 1rVjgasA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
 by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <lars@metafoo.de>)
 id 1kp6pK-0006Qz-VO; Tue, 15 Dec 2020 10:41:03 +0100
Received: from [62.216.202.54] (helo=[192.168.178.20])
 by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <lars@metafoo.de>)
 id 1kp6pK-000TGf-Qf; Tue, 15 Dec 2020 10:41:02 +0100
Subject: Re: [PATCH 2/2] ASoC: Intel: KMB: Enable DMA transfer mode
To: Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 alsa-devel@alsa-project.org
References: <20201215053307.24128-1-michael.wei.hong.sit@intel.com>
 <20201215053307.24128-3-michael.wei.hong.sit@intel.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b8c0cc0b-d355-7b28-093b-29e8629056b7@metafoo.de>
Date: Tue, 15 Dec 2020 10:41:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201215053307.24128-3-michael.wei.hong.sit@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26017/Mon Dec 14 15:33:39 2020)
Cc: cezary.rojewski@intel.com, tiwai@suse.com, jee.heng.sia@intel.com,
 pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com,
 broonie@kernel.org
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

On 12/15/20 6:33 AM, Michael Sit Wei Hong wrote:
> [...]
> +static inline void kmb_i2s_enable_dma(struct kmb_i2s_info *kmb_i2s, u32 stream)
> +{
> +	u32 dma_reg;
> +
> +	dma_reg = readl(kmb_i2s->i2s_base + I2S_DMACR);
> +	/* Enable DMA handshake for stream */
> +	if (stream == SNDRV_PCM_STREAM_PLAYBACK)
> +		dma_reg |= I2S_DMAEN_TXBLOCK;
> +	else
> +		dma_reg |= I2S_DMAEN_RXBLOCK;
> +
> +	writel(dma_reg, kmb_i2s->i2s_base + I2S_DMACR);
> +}
> +
> +static inline void kmb_i2s_disable_dma(struct kmb_i2s_info *kmb_i2s, u32 stream)
> +{
> +	u32 dma_reg;
> +
> +	dma_reg = readl(kmb_i2s->i2s_base + I2S_DMACR);
> +	/* Disable DMA handshake for stream */
> +	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		dma_reg &= ~I2S_DMAEN_TXBLOCK;
> +		writel(1, kmb_i2s->i2s_base + I2S_RTXDMA);
> +	} else {
> +		dma_reg &= ~I2S_DMAEN_RXBLOCK;
> +		writel(1, kmb_i2s->i2s_base + I2S_RRXDMA);
> +	}
> +	writel(dma_reg, kmb_i2s->i2s_base + I2S_DMACR);

Does this need locking? I believe it is possible for the startup 
callback of the playback and capture stream to be called concurrently.

> +}
> +
>   static void kmb_i2s_start(struct kmb_i2s_info *kmb_i2s,
>   			  struct snd_pcm_substream *substream)
>   {
> @@ -356,7 +405,11 @@ static void kmb_i2s_start(struct kmb_i2s_info *kmb_i2s,
>   	else
>   		writel(1, kmb_i2s->i2s_base + IRER);
>   
> -	kmb_i2s_irq_trigger(kmb_i2s, substream->stream, config->chan_nr, true);
> +	if (kmb_i2s->use_pio)
> +		kmb_i2s_irq_trigger(kmb_i2s, substream->stream,
> +				    config->chan_nr, true);
> +	else
> +		kmb_i2s_enable_dma(kmb_i2s, substream->stream);
>   
>   	if (kmb_i2s->master)
>   		writel(1, kmb_i2s->i2s_base + CER);
[...]
