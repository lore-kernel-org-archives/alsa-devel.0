Return-Path: <SRS0=3CTx=DO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3E2CC41604
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:27:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 136E820708
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uVNFr+jn";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bUsOf0bM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136E820708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0950C16A1;
	Wed,  7 Oct 2020 18:26:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0950C16A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602088028;
	bh=cMNF5BaEAQ/zzPIeIM4YPMRm9mBWkHw0U5fvGHhhHSU=;
	h=Subject:To:References:From:Date:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uVNFr+jnxStdK8k5yyUe/fWjo4OSLAyFnu7iNFtOtLPreuzr5A0pcI5y7LmOUincT
	 BLS8B8iNfwrfbPPgT3WBD6eKIjF5rSexarSmXKhJhCqLYWEqftE6kn5Rci38Jsr+f7
	 FMbA29ndDnWecf+NIRtmLeigDEqWequIjVIW3lao=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0E44F80128;
	Wed,  7 Oct 2020 18:26:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5FBF3F8016A; Wed,  7 Oct 2020 18:26:16 +0200 (CEST)
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:8b0:10b:1236::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F3DAF80090
 for <alsa-devel@alsa-project.org>; Wed,  7 Oct 2020 18:26:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F3DAF80090
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org
 header.b="bUsOf0bM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description;
 bh=4aUwhYiL14/onvJbUa3pnBgw1DGqYhrOPMmrEFm5Og4=; b=bUsOf0bMj5Uy+NzKjZmug5GEry
 APb2LhIe/wuzj2n3qB/zAFoLyVzrjmNwBzAXkWoLYm3ftFj/EtmP55IwjXVjjUS3esUBXjExpSDlC
 ScbXRbNWo05A9rvdQrOFXwml4uZhBwX5WmpFQIeUYMgwiunncwZ50IvDLvSQsHMgk5KF7tkbvj1T0
 6jAjmAGLTnmuigRKvu9NmCBTNruSBADUueKbyZyP+YVFbkHt//5eZjE+SIeOMXqTffFIPHu4EqUi8
 HbBNiSmjTsBCTGWMrNrOSippi/gmdwfqYj/YJZG8nrbvvrCPvWVaicg1NZFD6C9V1PAfxa2/PZXKn
 aNsC3K3Q==;
Received: from [2601:1c0:6280:3f0::2c9a]
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQCGM-0002fO-Gq; Wed, 07 Oct 2020 16:25:59 +0000
Subject: Re: [PATCH 2/2] ASoC: Intel: catpt: Add explicit DMADEVICES kconfig
 dependency
To: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org
References: <20201007135701.20372-1-cezary.rojewski@intel.com>
 <20201007135701.20372-2-cezary.rojewski@intel.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b4895043-2a88-5eb2-443c-b5640bf90aee@infradead.org>
Date: Wed, 7 Oct 2020 09:25:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201007135701.20372-2-cezary.rojewski@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Cc: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com
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

On 10/7/20 6:57 AM, Cezary Rojewski wrote:
> catpt selects DW_DMAC_CORE which requires DMADEVICES. Fix unmet direct
> dependencies warning by updating driver's depends-on list.
> 
> Fixes: 6cbfa11d2694 ("ASoC: Intel: Select catpt and deprecate haswell")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  sound/soc/intel/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 1278bea4e1be..a5b446d5af19 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -21,7 +21,7 @@ config SND_SOC_INTEL_SST
>  config SND_SOC_INTEL_CATPT
>  	tristate "Haswell and Broadwell"
>  	depends on ACPI || COMPILE_TEST
> -	depends on SND_DMA_SGBUF
> +	depends on DMADEVICES && SND_DMA_SGBUF
>  	select DW_DMAC_CORE
>  	select SND_SOC_ACPI_INTEL_MATCH
>  	help
> 


-- 
~Randy

