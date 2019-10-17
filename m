Return-Path: <SRS0=vl9c=YK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34588C4CECE
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 07:52:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A894C21925
	for <alsa-devel@archiver.kernel.org>; Thu, 17 Oct 2019 07:52:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MpaL1pWC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A894C21925
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=free.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 98AFA84F;
	Thu, 17 Oct 2019 09:51:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 98AFA84F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1571298737;
	bh=aYt0kQb4CzGlWUCfdZ1Z/ujrHot5PGhXwdlsfY9OXy8=;
	h=To:References:From:Date:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MpaL1pWCBMGNdL8tgMUsdGaZams5VkA2qrCRWXO/zCv/c1ZM1WmWKYsBSQMHwINC7
	 vl4Xxl2MT8yaOdp+Kxd1Bazxs30w9WMhe8eij9tLYHvrIoNbrZE1MA9IaxiyRJu6AC
	 RBVj/27aNfeFvnGzZn2T5O+wXruB+iNaLG0ri89Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2864CF80276;
	Thu, 17 Oct 2019 09:51:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1D92F804AA; Thu, 17 Oct 2019 09:51:25 +0200 (CEST)
Received: from ns.iliad.fr (ns.iliad.fr [212.27.33.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6A250F80276
 for <alsa-devel@alsa-project.org>; Thu, 17 Oct 2019 09:51:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6A250F80276
Received: from ns.iliad.fr (localhost [127.0.0.1])
 by ns.iliad.fr (Postfix) with ESMTP id 74FEA204C8;
 Thu, 17 Oct 2019 09:51:22 +0200 (CEST)
Received: from [192.168.108.37] (freebox.vlq16.iliad.fr [213.36.7.13])
 by ns.iliad.fr (Postfix) with ESMTP id 5E37B204A6;
 Thu, 17 Oct 2019 09:51:22 +0200 (CEST)
To: YueHaibing <yuehaibing@huawei.com>
References: <20190928081641.44232-1-yuehaibing@huawei.com>
From: Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <97c5adeb-ce12-f50a-f3e5-e187985ef073@free.fr>
Date: Thu, 17 Oct 2019 09:51:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190928081641.44232-1-yuehaibing@huawei.com>
Content-Language: en-US
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ;
 Thu Oct 17 09:51:22 2019 +0200 (CEST)
Cc: alsa-devel@alsa-project.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [alsa-devel] [PATCH -next] ASoC: atmel: Fix build error
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On 28/09/2019 10:16, YueHaibing wrote:

> when do randbuilding, I got this error:
> 
> sound/soc/atmel/atmel_ssc_dai.o: In function `atmel_ssc_set_audio':
> (.text+0x12f6): undefined reference to `atmel_pcm_pdc_platform_register'
> 
> This is because SND_ATMEL_SOC_SSC_DMA=y, SND_ATMEL_SOC_SSC=y,
> but SND_ATMEL_SOC_SSC_PDC=m. Fix it bt reintroducing the default Kconfig.

A default doesn't prevent a user from picking the problematic config.
Shouldn't there be some kind of "depends on" clause?


> Reported-by: Hulk Robot <hulkci@huawei.com>
> Fixes: 18291410557f ("ASoC: atmel: enable SOC_SSC_PDC and SOC_SSC_DMA in Kconfig")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  sound/soc/atmel/Kconfig | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/sound/soc/atmel/Kconfig b/sound/soc/atmel/Kconfig
> index f118c22..79e45f2 100644
> --- a/sound/soc/atmel/Kconfig
> +++ b/sound/soc/atmel/Kconfig
> @@ -12,10 +12,14 @@ if SND_ATMEL_SOC
>  config SND_ATMEL_SOC_PDC
>  	tristate
>  	depends on HAS_DMA
> +	default m if SND_ATMEL_SOC_SSC_PDC=m && SND_ATMEL_SOC_SSC=m
> +	default y if SND_ATMEL_SOC_SSC_PDC=y || (SND_ATMEL_SOC_SSC_PDC=m && SND_ATMEL_SOC_SSC=y)
>  
>  config SND_ATMEL_SOC_DMA
>  	tristate
>  	select SND_SOC_GENERIC_DMAENGINE_PCM
> +	default m if SND_ATMEL_SOC_SSC_DMA=m && SND_ATMEL_SOC_SSC=m
> +	default y if SND_ATMEL_SOC_SSC_DMA=y || (SND_ATMEL_SOC_SSC_DMA=m && SND_ATMEL_SOC_SSC=y)
>  
>  config SND_ATMEL_SOC_SSC
>  	tristate
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
