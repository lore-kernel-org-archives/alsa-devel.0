Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21079C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Dec 2021 20:21:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48D9D1B3C;
	Wed, 15 Dec 2021 21:20:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48D9D1B3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1639599681;
	bh=hwYXsKxj6cc7Zdi1v+/l+aYeMhyzfjCWT0FbcOA1/qs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=D+3q+R9Sf4mx3RLSJvcCXEP4lm8G7WL0L1eeKgLeBJYxTfVSp78jc+BsidmWq0R06
	 PLdXH1C2OpLB8QUAr2gRPpf88dJO4sGya5XvZxILGNuUmnTk0GIKCAYG+UKscbQOCz
	 a7G/ctWihrhBVIC6Y7nzA0V1kCq3R9sphA6FoeFI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CA2BDF80158;
	Wed, 15 Dec 2021 21:20:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A6405F8019D; Wed, 15 Dec 2021 21:20:29 +0100 (CET)
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D13F6F80157
 for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2021 21:20:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D13F6F80157
Received: by mail-oo1-f53.google.com with SMTP id
 w15-20020a4a9d0f000000b002c5cfa80e84so6254383ooj.5
 for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2021 12:20:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m/MkamMJ2gnp9jj0ba2joAFe3nG5g9Koxv3aRFuFEjQ=;
 b=d0ll4ia026YahrPQ1Z6sLt518goHQAUvdsJJ+W03+ugqQR1undStukIhJ0XcqPUnvz
 +qm6bUnb9ykXopyizxDJ+s8sww+fVPTSJroRO4a5T14Zqg+qAZEYZQr0OQuf44MNhLIx
 lBzDiR/OCoT5e2wsmlKuo9sJ+HrgimROkAQCoiT/2ZD5LfrgKcsVKDDJECTWGYDS7syy
 1I6uiAgtGkqzf9CLNnBMAVsxwMnY7uf19jMHnyHF8QV3bXqWCTbvv8J2SNFggumdvOGJ
 SJtkIygOfSkaIM1pGaybYGi/R074Q8WeJ9HYnTh/NMO2r0/GfCNh7C8ALvvw++DeJP8I
 m4/w==
X-Gm-Message-State: AOAM532EMEUln1mXGzWpoU5bxMw+k9zGJy/K1Q/Fxek8jRIhYLwcyw81
 7dxOSa5L+JewPkXJ5cgKrg==
X-Google-Smtp-Source: ABdhPJwEAvzXsXtw8f6DVigz6LL33eng2DJNCj7/ufeI5f5gYGpPYXHdH5ttSoHheEIv1aVgILb6bA==
X-Received: by 2002:a4a:e288:: with SMTP id k8mr8644935oot.23.1639599621165;
 Wed, 15 Dec 2021 12:20:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id r3sm601243oti.51.2021.12.15.12.20.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Dec 2021 12:20:20 -0800 (PST)
Received: (nullmailer pid 1770384 invoked by uid 1000);
 Wed, 15 Dec 2021 20:20:19 -0000
Date: Wed, 15 Dec 2021 14:20:19 -0600
From: Rob Herring <robh@kernel.org>
To: Vincent Knecht <vincent.knecht@mailoo.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: codecs: Add bindings for ak4375
Message-ID: <YbpOA4Y18lCiIAn9@robh.at.kernel.org>
References: <20211213155914.2558902-1-vincent.knecht@mailoo.org>
 <20211213155914.2558902-3-vincent.knecht@mailoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213155914.2558902-3-vincent.knecht@mailoo.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 obayerd@eurocomposant.fr, stephan@gerhold.net, tiwai@suse.com,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, lgirdwood@gmail.com,
 broonie@kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org
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

On Mon, 13 Dec 2021 16:59:13 +0100, Vincent Knecht wrote:
> AK4375 is an audio DAC with headphones amplifier controlled via I2C.
> Add simple device tree bindings that describe how to set it up.
> 
> Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
> ---
>  .../devicetree/bindings/sound/ak4375.yaml     | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/ak4375.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
