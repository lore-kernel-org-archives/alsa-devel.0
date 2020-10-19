Return-Path: <SRS0=W2oN=D2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C2DC433E7
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:26:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B53C1223FD
	for <alsa-devel@archiver.kernel.org>; Mon, 19 Oct 2020 20:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="flkUbll1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B53C1223FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A70216ED;
	Mon, 19 Oct 2020 22:25:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A70216ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603139187;
	bh=UmuR+lAYPC2zey8It1Rgj9hPN3pN6XOxOhlMLkS35VE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=flkUbll1sslU+t7HAJ4TiLMYkyDeKgBlXQrdmQ0o/JYs0XZoq89ZcGc5FkK2+5BYx
	 8NqQvhPiL7QYzszQ5YoCRYI2z3xbOjJUgUX7+H18MP8hN2ugbbWgHMY4G4zhUQPp4U
	 P17vsQGPNtHiuX20gtKTp2GKSd4nWdT4vRzf6jEU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BDC7F801D5;
	Mon, 19 Oct 2020 22:25:37 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08A28F80247; Mon, 19 Oct 2020 22:25:36 +0200 (CEST)
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3657BF8010F
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2020 22:25:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3657BF8010F
Received: by mail-oi1-f193.google.com with SMTP id m128so1412924oig.7
 for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2020 13:25:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2eJvh+OiDExYcnw0fjD4IRdxMtw5g7kaSI+P1n3wmsQ=;
 b=qoaMtvZvZdJjHz/BdfIobahA3g2hkXo1mKmwgXjK0eUjArbnRsXMFNHIO/6dw1YfHS
 lgBayd34JcrV7AFWaCS3Oq3R9BP3qK4hFAXeVG0Zc0gKroEfX62O5gg973G+LlUaszEg
 45B/IXyRfqiNANb73VJM7L/3ZeSLsiDlhjGXPH+qtiWMMP110ttgtdDUOX9KsyACt5Xy
 1PR+/QnaWGxSMV0wQA+QaqoRoXayp2MvjNJfktvqU7b6RnfotVoN0HFhiwCbKeI9dWEB
 3/DWrUzyqJ8Pa9bvGvmfUXXegfUfPZ4Otnyu6YNR7kmUCxEkEOlupe+lCJ1cw6oUcQoQ
 TfZw==
X-Gm-Message-State: AOAM531NtOB9VqocVQsxvGMun+tvwxHgAUkVnLD6Iuk7hI+TMO1P9oOw
 Xn3AaFOJ9y3YxlSPZPRmxw==
X-Google-Smtp-Source: ABdhPJztogXjATiDScTQzUAmCLK5ItkQoRw7qffd7jiZfUIT0HmuWhenym77skh/v47Cj3OLzspmqQ==
X-Received: by 2002:aca:5058:: with SMTP id e85mr799620oib.79.1603139126431;
 Mon, 19 Oct 2020 13:25:26 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id p10sm225896oig.37.2020.10.19.13.25.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2020 13:25:25 -0700 (PDT)
Received: (nullmailer pid 3547145 invoked by uid 1000);
 Mon, 19 Oct 2020 20:25:19 -0000
Date: Mon, 19 Oct 2020 15:25:19 -0500
From: Rob Herring <robh@kernel.org>
To: Olivier Moysan <olivier.moysan@st.com>
Subject: Re: [PATCH 1/1] ASoC: dt-bindings: stm32: convert audio dfsdm to
 json-schema
Message-ID: <20201019202519.GA3541912@bogus>
References: <20201014123531.6991-1-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201014123531.6991-1-olivier.moysan@st.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, alexandre.torgue@st.com,
 linux-kernel@vger.kernel.org, arnaud.pouliquen@st.com, tiwai@suse.com,
 lgirdwood@gmail.com, broonie@kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
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

On Wed, Oct 14, 2020 at 02:35:31PM +0200, Olivier Moysan wrote:
> Convert the STM32 DFSDM audio bindings to DT schema format
> using json-schema.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
> ---
>  .../bindings/sound/st,stm32-adfsdm.txt        | 63 -------------------
>  .../bindings/sound/st,stm32-adfsdm.yaml       | 42 +++++++++++++
>  2 files changed, 42 insertions(+), 63 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/st,stm32-adfsdm.yaml

This is almost already documented in 
Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml. You 
should either make that complete or reference this.

Rob
