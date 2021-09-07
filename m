Return-Path: <SRS0=Gs4n=N5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB187C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Sep 2021 22:57:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 096B761102
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Sep 2021 22:57:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 096B761102
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 94F101719;
	Wed,  8 Sep 2021 00:57:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 94F101719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631055476;
	bh=thPZsCJV1uvv7DeT1SyTtP9QSzP/ZpDeDq2OXkB+Jv0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ekdy4afYxXqDazg9q9LYesv6VIzRpuLX5jEkaOpTDMbHZaIwAofu1DpPcx4c9DERU
	 ld8sGyw8sHmhNEyjIb5OVYVrtoVTj3/b/TnHswMY99VQ6EAk7mOXSwEoHOf6qgLfEx
	 qBdo8ihRhfyhymo5Oo269qvlLwGRdyC1s9AGUjeQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0D4D7F800BC;
	Wed,  8 Sep 2021 00:56:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 30E2EF800BC; Wed,  8 Sep 2021 00:56:55 +0200 (CEST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E77F7F800BC
 for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2021 00:56:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E77F7F800BC
Received: by mail-oi1-f180.google.com with SMTP id p2so570579oif.1
 for <alsa-devel@alsa-project.org>; Tue, 07 Sep 2021 15:56:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GdSJ4oPnHTzno9balxH3QixzXlfpDdLWJYh9sK35SuU=;
 b=4S8YnqMm+SOePPDmqeyUcGQrnlsDw+v8eXz1TQutshs79znQzTmEevAkjr8SSLK7kt
 dRcfSxClQlm/yxXMZVLqygba4UyW0ycn3iaaoXtu2gdl2b/BMgkTU1ZSLNW1K6PFOJfU
 /y6MXeq/+BuoPvO5IcwprFjzdGeUyhOS2Ka86sWy0jlbSf1t45jTovSfrMVGmNY4er/z
 +sfqtquBKuyRJUqjZiGy9bjXLsVfvC+J2DDme0Bs33RDqnJxNN1q1+dY6XIszWpb3QOQ
 TazPl0ycH1iA+s9imwEOFczXImGi551C6aRnFcYtUgfmYyf1MbxwzYZjkDjWeXvgvejm
 2Tfg==
X-Gm-Message-State: AOAM533Cjv0Vu5knjqccNSb5SVzdBrqd2A1CNk61Mq6h1vQo03fwqB/z
 q4QLaM89VQHXA0jzDkiNJ4SIgDy1Nw==
X-Google-Smtp-Source: ABdhPJyQH5ykl7SVUA+/i9J4TXTCI/gm1rUgetil/5rlbN9PeZxdZe+YOpPGA0X0HRRsXXQOXkgllA==
X-Received: by 2002:aca:c6ce:: with SMTP id w197mr412575oif.6.1631055405356;
 Tue, 07 Sep 2021 15:56:45 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id x198sm71734ooa.43.2021.09.07.15.56.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Sep 2021 15:56:44 -0700 (PDT)
Received: (nullmailer pid 515097 invoked by uid 1000);
 Tue, 07 Sep 2021 22:56:43 -0000
Date: Tue, 7 Sep 2021 17:56:43 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 11/21] ASoC: dt-bindings: q6dsp: add q6apm-lpass-dai
 compatible
Message-ID: <YTfuK6vcEf5P2aM9@robh.at.kernel.org>
References: <20210903112032.25834-1-srinivas.kandagatla@linaro.org>
 <20210903112032.25834-12-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903112032.25834-12-srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com, bjorn.andersson@linaro.org, broonie@kernel.org
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

On Fri, 03 Sep 2021 12:20:22 +0100, Srinivas Kandagatla wrote:
> on AudioReach audio Framework access to LPASS ports is via
> Q6APM(Audio Process Manager) service, so add a dedicated compatible
> string for this.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../sound/qcom,q6dsp-lpass-ports.yaml         | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
