Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43922C54EBD
	for <alsa-devel@archiver.kernel.org>; Sun,  8 Jan 2023 18:11:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D6BEDD4E2;
	Sun,  8 Jan 2023 19:10:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D6BEDD4E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673201460;
	bh=HsTtT0ZOoMTzLLRZMtkKeZr5CvBqg597KljtCq55lLo=;
	h=Date:From:To:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=T/p0Ql6G73DupcjnL4BwUBuRCorid+qVAruGF/2243p1GMHMl6j5XKD7LZrxyKy7l
	 BZJnU3Jy+vmp+V+9QtbC8HVNEZ5RQ4geTTAyZT53J0+Sh7XAWlt0A5D7Uxmh8M/aqG
	 6Qq1U9ekib85auz/ON4nZyt0kJSaIrpuswaAmqdI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E8AAF804DC;
	Sun,  8 Jan 2023 19:10:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58EBBF804DC; Sun,  8 Jan 2023 19:10:09 +0100 (CET)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com
 [209.85.166.179])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4295F80245
 for <alsa-devel@alsa-project.org>; Sun,  8 Jan 2023 19:10:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4295F80245
Received: by mail-il1-f179.google.com with SMTP id g2so3844249ila.4
 for <alsa-devel@alsa-project.org>; Sun, 08 Jan 2023 10:10:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JiDtm4dg6sBcZvEsrtZDf8KneTPB6egmjNiY/UbVENE=;
 b=PRWg9Xy8xQsiY4Xt3cy14LGB/7V3bA+nk5VnGMDtklr9Ro1ZMyWT1938/VPZ/Am395
 loncjbtBUEiyosFxr7pRBvpDgJKThR4hF3VFaddxMObQJ6o4iYJwap8C6uUTLlD/vg6s
 Dn5cnIz54mFGXN+SbtVz9oeELnpuTQ9ZJTuTzlsNLRgqJuAQsm8RTN56myCMw0TK82ZZ
 Rnqrg2dutGlXwTyaBjgJSItZMkJtfw8CzKL35SvOksuxkvl0Pw2Z+QV68XNckyjUsOMb
 4DXDvA2QUB4/IgpGyoKzHmeOaq+wl8NW3oLoSZrQBHfVC0uTumzyaR3p+F2gi8wjqchi
 1axQ==
X-Gm-Message-State: AFqh2kp1JGjrWHVQ1ehCHidwSUxpRZroSNVXRkgppn7BgDDO88zjFXVM
 UjKB+H4ivvzAJ9xxjhb0Jw==
X-Google-Smtp-Source: AMrXdXsTb3xz2g05XmKI/Rwa/5xKheM+PvRs63uDP3nLe5Saz66r8IjIA0dJsxAiyvyJTh36ORb2Pg==
X-Received: by 2002:a92:d448:0:b0:30b:f758:22db with SMTP id
 r8-20020a92d448000000b0030bf75822dbmr46852324ilm.2.1673201404490; 
 Sun, 08 Jan 2023 10:10:04 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:8069:516a:f2b0:691e:4315:7c0f])
 by smtp.gmail.com with ESMTPSA id
 w8-20020a056e0213e800b0030c2667fe17sm2112283ilj.80.2023.01.08.10.10.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jan 2023 10:10:04 -0800 (PST)
Received: (nullmailer pid 153586 invoked by uid 1000);
 Sun, 08 Jan 2023 18:10:01 -0000
Date: Sun, 8 Jan 2023 12:10:01 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: qcom,lpass-tx-macro: correct
 clocks on SC7280
Message-ID: <167320139670.153361.17614063062571302381.robh@kernel.org>
References: <20221225115907.55250-1-krzysztof.kozlowski@linaro.org>
 <20221225115907.55250-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221225115907.55250-2-krzysztof.kozlowski@linaro.org>
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@quicinc.com>,
 Andy Gross <agross@kernel.org>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


On Sun, 25 Dec 2022 12:59:07 +0100, Krzysztof Kozlowski wrote:
> On SC7280 ADSP bypassed platform, there are only three clocks for TX
> macro.  This is already reflected in "clock-names" but not in "clocks"
> property:
> 
>   sc7280-herobrine-zombie-lte.dtb: codec@3220000: clocks: [[219, 8], [219, 7], [220]] is too short
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/sound/qcom,lpass-tx-macro.yaml        | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
