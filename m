Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C0F0C43217
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Nov 2022 14:57:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A1AF1690;
	Wed, 16 Nov 2022 15:56:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A1AF1690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668610636;
	bh=wWCK+Y19lEF7YpFpwJxFrIM1ytkV+8PcgQrVa4jhem0=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OVAXWYWZQOKctYxRmEucD6C8ynzGf1ogJk/rl4cRhiuCW5srPLhYhzhLgI7EJvc9w
	 coJInRtq+FCfuT1DjcjijNLfCZRkfpTyta43SiFYymzylyDZs0QXn9OBlAe34gTs4f
	 7maXgxI1UmPaVqeg5lSNh7TZnryEttyFGfm+sab4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EB5FF800B5;
	Wed, 16 Nov 2022 15:56:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CBC93F8032D; Wed, 16 Nov 2022 15:56:25 +0100 (CET)
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com
 [209.85.210.50])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66DA1F800B5
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 15:56:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66DA1F800B5
Received: by mail-ot1-f50.google.com with SMTP id
 g51-20020a9d12b6000000b0066dbea0d203so514764otg.6
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 06:56:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LiYE3Mo0zFHleDYSNTS5o0x4eaonhEzzEYL0UrDWPyA=;
 b=YOSfsFQ+8AMic6virm1nnf/ajjGAByYf6ZkhiPDhkO1+NILMZi9kMRh+4LLTbUjxJq
 GtxLSj44nJBbFG7J/dXs+N8+pAMxG4alyXvIc2bW4d5jf39nGO4VvDgW1nUBcydEiiS5
 IR0KaOklHNJrkinJ7zA8/s+6UGsHefK6Ecs9FBdSK3mGAg8zcq/oMErm3qm+aHk+5G6l
 2MXzy224OjpCo50M6E/77DEpFu+H2yl/2wB/hOfh4qkb+vptYudFkj7x/5m0RVoega6t
 W/aEyZ7gbLSMFNNlpEPhPyDQPv6UPjGUXCzJ5OK4Wg0yh1oO5/pKY1ZupADuEtGDf94g
 QRsQ==
X-Gm-Message-State: ANoB5plaJ9Vm257/jtztzlLd9mRwwMgm3gZx4YXcqsXjMK+H3GsHQA2Q
 yGQIjgn4883h+D9/x8XA3A==
X-Google-Smtp-Source: AA0mqf5RT5ifXvwgs+cEfR5EXTxUpg8KtBEflAExFGC+l5ZALD7D9ZYjC+utdFwLwC5MP2euW+cPoA==
X-Received: by 2002:a9d:605:0:b0:66c:9db8:8f7e with SMTP id
 5-20020a9d0605000000b0066c9db88f7emr11220476otn.155.1668610580427; 
 Wed, 16 Nov 2022 06:56:20 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 d65-20020a9d2947000000b0066c4092ae4csm6646650otb.10.2022.11.16.06.56.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Nov 2022 06:56:19 -0800 (PST)
Received: (nullmailer pid 3838368 invoked by uid 1000);
 Wed, 16 Nov 2022 14:56:22 -0000
Date: Wed, 16 Nov 2022 08:56:21 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 10/11] ASoC: dt-bindings: qcom, q6apm-lpass-dais: Split
 to separate schema
Message-ID: <166861058156.3838310.6244657242742834715.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-11-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-11-krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-msm@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Andy Gross <agross@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Mark Brown <broonie@kernel.org>, Banajit Goswami <bgoswami@quicinc.com>,
 quic_plai@quicinc.com, quic_srivasam@quicinc.com
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


On Tue, 15 Nov 2022 13:02:34 +0100, Krzysztof Kozlowski wrote:
> The Qualcomm DSP LPASS Audio DAIs are a bit different than Qualcomm DSP
> Audio FrontEnd (Q6AFE) DAIs - they do not use children nodes for each
> DAI.  None of other properties from qcom,q6dsp-lpass-ports.yaml apply
> here as well, so move the qcom,q6apm-lpass-dais compatible to its own
> binding.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: quic_srivasam@quicinc.com
> Cc: quic_plai@quicinc.com
> ---
>  .../bindings/sound/qcom,q6apm-lpass-dais.yaml | 32 +++++++++++++++++++
>  .../sound/qcom,q6dsp-lpass-ports.yaml         |  1 -
>  2 files changed, 32 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm-lpass-dais.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
