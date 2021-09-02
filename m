Return-Path: <SRS0=0EZw=NY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 418A3C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 19:29:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21AF760F21
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Sep 2021 19:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 21AF760F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B4A6717D6;
	Thu,  2 Sep 2021 21:28:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B4A6717D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630610953;
	bh=klsLa7MbihvSQKpBYtNJjhuhcONdzzWPl6eCi+IXKFI=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tnNPV7FlP3IBD6gOQLy+w2y6oagZoM3SKwBKYpnkWC6sDUk6/wRywOUGb0ZN3uVR4
	 5sv5GXoomgPkUVAsc7MEb6W8rNq84uGWgjPKzoO7T3q47IOnu6GqtjkItZXTryWPIi
	 vGBCuKav3DWjrzlMpP20hAMNFqUA+0OoroplTZ/g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 144CAF80290;
	Thu,  2 Sep 2021 21:28:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 928B0F804B3; Thu,  2 Sep 2021 21:28:19 +0200 (CEST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2421F80269
 for <alsa-devel@alsa-project.org>; Thu,  2 Sep 2021 21:28:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2421F80269
Received: by mail-ot1-f48.google.com with SMTP id
 l7-20020a0568302b0700b0051c0181deebso3893578otv.12
 for <alsa-devel@alsa-project.org>; Thu, 02 Sep 2021 12:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=m/WVOkYf8zMCeB0Htd9Y4czHm4q56hYufFumoOKAa78=;
 b=I30GDs3S1O11CYW5vrLEaPj4ZafZdTB4feqPuiPSgx+5+qeiYBfOEnCmEX1bZtxCHl
 oKKmBhzXxxvdTCeFvBw3IFnfSm3Xtg+5rA1+4STeQduM3yHtubhDFG4EuHULX4seIjce
 BbOtL5a4mfaCZ8fSrpNz6/N2nFXJUQPSoWgdXa9JcrrFKnMMAKO/lDx70Ksc8pHCBN7Z
 Hd0I4OXkH33yLjbPIus4C2MhNMPyTNxuP0R4EWfDzqvPNknmpTxqegMo0z05qx5Rj9mk
 c9obBxqJmMVhMfbRkRpY28fu5NM0dXD0adFUZmp9l3FGLCBHSbgjD45W3/ldvdqBLaqC
 lEgw==
X-Gm-Message-State: AOAM531XZ55QsUaGTQpy6taP+kSjATocuPz2+C6RlJBCcxd4cSxmHCkt
 TmjzatbcpI1xWLkqrLlR8A==
X-Google-Smtp-Source: ABdhPJzrIgQcHIrxJDMYkFaoqLDV9CU+oZ0ddQ2nDFfqe3jdbik2bk1LWsjDAFVLoB9iKneiwv/EtQ==
X-Received: by 2002:a05:6830:3115:: with SMTP id
 b21mr4251122ots.240.1630610887169; 
 Thu, 02 Sep 2021 12:28:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id l3sm540732ooo.7.2021.09.02.12.28.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Sep 2021 12:28:06 -0700 (PDT)
Received: (nullmailer pid 1248879 invoked by uid 1000);
 Thu, 02 Sep 2021 19:28:05 -0000
Date: Thu, 2 Sep 2021 14:28:05 -0500
From: Rob Herring <robh@kernel.org>
To: Sameer Pujar <spujar@nvidia.com>
Subject: Re: [PATCH v2 2/3] ASoC: Use schema reference for sound-name-prefix
Message-ID: <YTElxe4wwe8LPQqE@robh.at.kernel.org>
References: <1630562033-13231-1-git-send-email-spujar@nvidia.com>
 <1630562033-13231-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630562033-13231-3-git-send-email-spujar@nvidia.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 stephan@gerhold.net, lgirdwood@gmail.com, broonie@kernel.org,
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, jonathanh@nvidia.com,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org, jbrunet@baylibre.com
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

On Thu, 02 Sep 2021 11:23:52 +0530, Sameer Pujar wrote:
> Use schema reference for 'sound-name-prefix' property wherever
> necessary.
> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Jerome Brunet <jbrunet@baylibre.com>
> Cc: Stephan Gerhold <stephan@gerhold.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
>  .../devicetree/bindings/sound/nvidia,tegra186-dspk.yaml          | 9 +++------
>  .../devicetree/bindings/sound/nvidia,tegra210-dmic.yaml          | 9 +++------
>  Documentation/devicetree/bindings/sound/nvidia,tegra210-i2s.yaml | 9 +++------
>  Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml         | 9 +++------
>  Documentation/devicetree/bindings/sound/rt5659.txt               | 2 +-
>  Documentation/devicetree/bindings/sound/simple-audio-mux.yaml    | 9 +++------
>  6 files changed, 16 insertions(+), 31 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
