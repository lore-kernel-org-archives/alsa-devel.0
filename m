Return-Path: <SRS0=puNT=PR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53549C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 02:14:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1091361051
	for <alsa-devel@archiver.kernel.org>; Fri, 29 Oct 2021 02:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1091361051
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B0F7B16DD;
	Fri, 29 Oct 2021 04:13:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B0F7B16DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635473658;
	bh=CQ214FmikX9u4kKCZmpuZG/ovlw5f+mYjdNxYzKvdUg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JtEUrrhu88UGRayrB/vFfaPCHcb1lSxIlAWsd1tdYzdt/rBRE7Eso1ckYRE5QsG6z
	 tDoLGKE08M2aRGPAQ+etoZ+oU5JivoEnizqVgv1b/mBkn+ylt+cQRKLN0qc3MWlxs3
	 lYyla3xaO4NDVAvVXZRpzvNdTyKcgGLKYZikGflo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3BD2EF801EC;
	Fri, 29 Oct 2021 04:13:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 49350F8025A; Fri, 29 Oct 2021 04:13:22 +0200 (CEST)
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA95BF8010A
 for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2021 04:13:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DA95BF8010A
Received: by mail-ot1-f41.google.com with SMTP id
 v2-20020a05683018c200b0054e3acddd91so11466797ote.8
 for <alsa-devel@alsa-project.org>; Thu, 28 Oct 2021 19:13:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vM3EiRXQ2OSu4mmD6bWP+EUG0mzB9TpPF/rDTHfYIj8=;
 b=Kky/NOQBaeRARHB3M6a6AW7gB05MsrqBINFEGYkuCucqP3QcNSmtlsDFoJnJGD4lam
 yvk9vtm7n+d6C9xXZ9aTx2HGxDKEHnU8GCx5s1V1W9AD5fyJCytF/Hgw8aq0ikKZ0+Gp
 ALKJBVBINNXSUSOxH+08sL0WEv9GGxpe45qsHcgmtK3i4M5IbSlugG2eAleDAC9m8lK1
 qj98W5wJX7PkzOiSwyOC4gR9APnLGTzPU60vN5q+4d/XKi4yq9vo+pq/k8cayQinxFn5
 qmiPpww9V8VQn21EA/rUoAOZTxf23LHcbyZj3xepQxFfniG5wO/JuJhjbN24Km2PKmvs
 8MEg==
X-Gm-Message-State: AOAM530gGS0+IVM9ygJ+q60vhVIncQWTReF+TFCbQw083nYZD2xkoq24
 Wlo2+m+Y1HRLh4eE9k1URg==
X-Google-Smtp-Source: ABdhPJyMHDvpVhYUlm/I6enpqef/qbWhYuWCe25Mv9RYKjQCgibt2oEWqsEAdKdJakD46cNOTl/6Lg==
X-Received: by 2002:a05:6830:3155:: with SMTP id
 c21mr6450826ots.104.1635473592353; 
 Thu, 28 Oct 2021 19:13:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id bo35sm727867oib.40.2021.10.28.19.13.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Oct 2021 19:13:11 -0700 (PDT)
Received: (nullmailer pid 1021491 invoked by uid 1000);
 Fri, 29 Oct 2021 02:13:10 -0000
Date: Thu, 28 Oct 2021 21:13:10 -0500
From: Rob Herring <robh@kernel.org>
To: Vincent Knecht <vincent.knecht@mailoo.org>
Subject: Re: [PATCH v1 3/4] ASoC: dt-bindings: nxp, tfa989x: Add rcv-gpios
 property for tfa9897
Message-ID: <YXtYtsPCeh937oF6@robh.at.kernel.org>
References: <20211024085840.1536438-1-vincent.knecht@mailoo.org>
 <20211024085840.1536438-4-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211024085840.1536438-4-vincent.knecht@mailoo.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 stephan@gerhold.net, linux-kernel@vger.kernel.org, tiwai@suse.com,
 lgirdwood@gmail.com, broonie@kernel.org, ~postmarketos/upstreaming@lists.sr.ht
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

On Sun, Oct 24, 2021 at 10:58:39AM +0200, Vincent Knecht wrote:
> Add optional rcv-gpios property specific to tfa9897 receiver mode.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../devicetree/bindings/sound/nxp,tfa989x.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> index 7667471be1e4..a9e15baedafd 100644
> --- a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> +++ b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
> @@ -12,6 +12,16 @@ maintainers:
>  allOf:
>    - $ref: name-prefix.yaml#
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: nxp,tfa9897
> +    then:
> +      properties:
> +        rcv-gpios:
> +          description: optional GPIO to be asserted when receiver mode is enabled.

Did you test this works? 

You have to define the property outside the if/then schema at the top 
level. Then use an if/then schema to restrict it (rcv-gpios: false).

> +
>  properties:
>    compatible:
>      enum:
> -- 
> 2.31.1
> 
> 
> 
> 
