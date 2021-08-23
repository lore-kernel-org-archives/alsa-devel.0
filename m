Return-Path: <SRS0=lo3o=NO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CED9DC4338F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 17:37:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8720C6136F
	for <alsa-devel@archiver.kernel.org>; Mon, 23 Aug 2021 17:37:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8720C6136F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43EEF112;
	Mon, 23 Aug 2021 19:36:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43EEF112
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629740239;
	bh=ayG/k7F918HELQvXsaI7p8lKf39mbTqSCuwoPf/Or4Q=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ibiitJdxPP9XLhGrzlyE0nQScnGSypra+pE/wqow9VHtdMUrxFTIFNNbkad9rGBV1
	 gYtuAtj+w9edZ3e/syhE8BS3hsqOU1if2L0hUt+PrlvuC7W3h+p5znV6YqxIURUdFS
	 UOPWANphSEFTiKEjp2j+wbybfitbirA0lMKOKZvE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7649F800B6;
	Mon, 23 Aug 2021 19:36:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94E6AF8020C; Mon, 23 Aug 2021 19:36:27 +0200 (CEST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66980F800B6
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 19:36:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66980F800B6
Received: by mail-ot1-f41.google.com with SMTP id
 o16-20020a9d2210000000b0051b1e56c98fso23562345ota.8
 for <alsa-devel@alsa-project.org>; Mon, 23 Aug 2021 10:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0uu/qRmiaveg5OXmKGJu7wUbjS4DkO9J3oLG/+RhLjo=;
 b=MDw+W9x+AD+4O3lxi7cAfLbc06LLhy0Qu/UmXtdpgZ269iv37Ie5bCP1Dvom5BATiR
 4YhjSJ1MNaCcDnUtEwB477jXRIzmoJ8CGwwbImqTVZkjcgMZbfjUeolvxDz1230fNPBM
 wlo7nN2+BlkCOu7AhaFIQ3MlQvwDtxNnJXstGcc1nMqu/xysn9/VKIZyCZommbudzl+E
 hBHZHhB4PeZN745gETCi4OONVdrljtP4jeYBMcIIFgZKiTJn7swO1E0mLCZiIWBw7eZc
 hHFwwyYciWFSJtbBEwggrZ1BJPZMZ1Hh91n8l2B5CUrto5OmTGoFtNw2KchIEbubkmjk
 1tXQ==
X-Gm-Message-State: AOAM530XhEdcx4jL8LE2+m8zRv2hAWb3VQwQ8i75kZznXJHmoAomj0Or
 6QEMkBkQkA/D0L129Myd4A==
X-Google-Smtp-Source: ABdhPJzxNu7vQjCCQQ+lFTIt44LyottIgRBnx8/87Z4bi0rH3Du9CTiqIdTchQRYLX9R+i2P7dkMCw==
X-Received: by 2002:a9d:7dd4:: with SMTP id k20mr27971832otn.68.1629740178875; 
 Mon, 23 Aug 2021 10:36:18 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id i9sm3895014otp.18.2021.08.23.10.36.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Aug 2021 10:36:18 -0700 (PDT)
Received: (nullmailer pid 2390403 invoked by uid 1000);
 Mon, 23 Aug 2021 17:36:17 -0000
Date: Mon, 23 Aug 2021 12:36:17 -0500
From: Rob Herring <robh@kernel.org>
To: Sugar Zhang <sugar.zhang@rock-chips.com>
Subject: Re: [PATCH 15/15] ASoC: dt-bindings: rockchip: i2s: Document
 property 'clk-trcm'
Message-ID: <YSPckWacS4kk270r@robh.at.kernel.org>
References: <1629715710-21137-1-git-send-email-sugar.zhang@rock-chips.com>
 <1629716132-21544-1-git-send-email-sugar.zhang@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629716132-21544-1-git-send-email-sugar.zhang@rock-chips.com>
Cc: linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org,
 broonie@kernel.org, heiko@sntech.de, devicetree@vger.kernel.org
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

On Mon, Aug 23, 2021 at 06:55:32PM +0800, Sugar Zhang wrote:
> This patch documents property 'rockchip,clk-trcm' which is used
> to specify the lrck.
> 
> Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
> Change-Id: I648142c57c568bbed209f2b9188b1f539a3285b2

Drop this.

> ---
>  Documentation/devicetree/bindings/sound/rockchip-i2s.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
> index 11e911a..8d9dfed 100644
> --- a/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
> +++ b/Documentation/devicetree/bindings/sound/rockchip-i2s.yaml
> @@ -72,6 +72,15 @@ properties:
>    resets:
>      maxItems: 2
>  
> +  rockchip,clk-trcm:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 0
> +    description:
> +      tx and rx lrck/bclk common use.
> +      0: both tx_lrck/bclk and rx_lrck/bclk are used
> +      1: only tx_lrck/bclk is used
> +      2: only rx_lrck/bclk is used

Sounds like constraints. Make a schema.

> +
>    rockchip,capture-channels:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      default: 2
> -- 
> 2.7.4
> 
> 
> 
> 
