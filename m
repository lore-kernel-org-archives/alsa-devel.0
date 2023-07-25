Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AC4EB64DD
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jul 2023 02:59:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5BE0E8A;
	Tue, 25 Jul 2023 04:58:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5BE0E8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690253981;
	bh=vPb0OqfiKEN01FRYo++KYf0llgTo4S0sMvokBcrdwAo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=RZuGkWQNdcx1+WiE289VY50Ws/d0XGMrl61PrHxRFB1rBQ/o8TnLmkkthPa6p0pPS
	 mOU88DwcaOXbIj5UbVaeantQjJ68A7KRhubOxFJdWVsmFpeQucWJ3+GRYt9wTFsBDd
	 msXCzc6ktPCDnZRDtRsSq+SH+SRP6h2CX2HaD79E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C51E0F80544; Tue, 25 Jul 2023 04:58:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 333EAF8019B;
	Tue, 25 Jul 2023 04:58:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F2D8AF801F5; Tue, 25 Jul 2023 04:58:17 +0200 (CEST)
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:3::133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7713FF800C7
	for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2023 04:58:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7713FF800C7
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Yx7q9pjE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=bscdJezkW977NS2usn50EadsF7pWATnyCd2yjIB1NM8=; b=Yx7q9pjEcU59tWFBgVNSVbmLcC
	vmofQzSyukuhzwubEhtOsjx1o/DHwC3Pqyjxhb09Cihbp3ZZoHTUNmKdNN09JXaICzFzKdWMebzBc
	Ly6Pk9CLE+KafGmp7jaynS5DogDTWlT5MdkRiAsobLFvqfQV7NhZqS3xRU1U0DRGraI2I5sNQekPI
	4QJMzIWwIVumJGvpnnF86FB9LGaNFS09ejqvs2wM7gwE8PbZbX8tmb4LO2kMj182K2QSlM62DDfr6
	OAwKq3RTC9DFkmCs4xns6olYo2Sx1dBWceGDHTzmo7TvH60PpK4DiRlzOHXl/EsKQ+1fmg5K9v/uX
	RbBkvowQ==;
Received: from [2601:1c2:980:9ec0::2764]
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qO8FH-005yWd-11;
	Tue, 25 Jul 2023 02:57:55 +0000
Message-ID: <e4cc043b-76b9-5cc6-2fc7-e6a5722037ce@infradead.org>
Date: Mon, 24 Jul 2023 19:57:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 03/32] xhci: sideband: add initial api to register a
 sideband entity
Content-Language: en-US
To: Wesley Cheng <quic_wcheng@quicinc.com>, agross@kernel.org,
 andersson@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, catalin.marinas@arm.com, will@kernel.org,
 mathias.nyman@intel.com, gregkh@linuxfoundation.org, lgirdwood@gmail.com,
 broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
 Thinh.Nguyen@synopsys.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-usb@vger.kernel.org, alsa-devel@alsa-project.org,
 quic_jackp@quicinc.com, pierre-louis.bossart@linux.intel.com,
 oneukum@suse.com, albertccwang@google.com, o-takashi@sakamocchi.jp,
 Mathias Nyman <mathias.nyman@linux.intel.com>
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
 <20230725023416.11205-4-quic_wcheng@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230725023416.11205-4-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Message-ID-Hash: RFGTGO3AH4UVSUUWWDELCIVMPUOPN5R2
X-Message-ID-Hash: RFGTGO3AH4UVSUUWWDELCIVMPUOPN5R2
X-MailFrom: rdunlap@infradead.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RFGTGO3AH4UVSUUWWDELCIVMPUOPN5R2/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>



On 7/24/23 19:33, Wesley Cheng wrote:
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index c170672f847e..d9dc92bea525 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -104,6 +104,15 @@ config USB_XHCI_RZV2M
>  	  Say 'Y' to enable the support for the xHCI host controller
>  	  found in Renesas RZ/V2M SoC.
>  
> +config USB_XHCI_SIDEBAND
> +	bool "xHCI support for sideband"
> +	help
> +	  Say 'Y' to enable the support for the xHCI sideband capability.
> +	  provide a mechanism for a sideband datapath for payload associated

	  Provide

> +	  with audio class endpoints. This allows for an audio DSP to use
> +	  xHCI USB endpoints directly, allowing CPU to sleep while playing
> +	  audio

	  audio.


-- 
~Randy
