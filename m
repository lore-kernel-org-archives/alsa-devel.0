Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53AEBC433FE
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Nov 2022 14:40:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 263B81690;
	Wed, 16 Nov 2022 15:39:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 263B81690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668609626;
	bh=Fft/8UoKMlnLXmvlmw1nYeccn/nzu2eN1P9pzqYviZo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uYVPy4ruS+pSqF/jc16vawHw4+J0pAtfCiGE/Tn+LYMBNynM27JwZpM+Bocf1u7ed
	 3jIuodE2LtUnHUDa+j8m5ZJEBKdNknYvuYRCvohdoXuwCy6aeDC4P1MzC+AbmLOUcy
	 VpG7NvFBIu08LSPKrKUwcXI92JzJw+ePzl2rDGQE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CF895F80163;
	Wed, 16 Nov 2022 15:39:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E3EFF80169; Wed, 16 Nov 2022 15:39:34 +0100 (CET)
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com
 [209.85.210.51])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 902FAF80089
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 15:39:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 902FAF80089
Received: by mail-ot1-f51.google.com with SMTP id
 m7-20020a9d6447000000b0066da0504b5eso4186895otl.13
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2022 06:39:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IiowHcJ1MfORS7VHAIgm0o5kAFmeRPc8RrgjNd7UdFA=;
 b=C0FZfvAXDixYlzMmN7WaVbd7UexGfOldlRu0gdzyV1E5ck21l+32bJsY99iwR6FrNW
 0h4xergn7kiFQUu7r7x5Rny76sKutyRdWbshEHhcz4VBQvz4jSs8hDePvFsm2EwQMONm
 5n5S5wvRjqC5Hdd7IthMdRxxGdhS9k5C9HzGZx/O1Tg+WenVzzod3kVHYPx1wIPpOWTf
 2jwIzz5VZaytp9z4PTIwHXE8/H6qLY17cMHeVWvtO2ORtpSjjxRuhT7eEN0R+Ow269n9
 JQLnl+K4nEn798h/Jku9HDhY3donJ/WUrIX27hSok6dPU+fvne2eDAOL+7Upj8JYB8A2
 J2Yg==
X-Gm-Message-State: ANoB5plSI4OmdgXgbECIPVTbaNJc1LGpdfWgK3tF0c23YnIJrzaUOkOK
 F4xKTcLEKeysADiPTsgF5w==
X-Google-Smtp-Source: AA0mqf4y2wvAVlc41qBrXyNrAl0Yy0o00bCnDZSiALjTS7JNRnvMYXYjenLSTMR2DZd/ee6m6ljJtg==
X-Received: by 2002:a05:6830:18c6:b0:66c:312d:472c with SMTP id
 v6-20020a05683018c600b0066c312d472cmr11107299ote.339.1668609566572; 
 Wed, 16 Nov 2022 06:39:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 ek24-20020a056870f61800b0013b1301ce42sm8048434oab.47.2022.11.16.06.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Nov 2022 06:39:26 -0800 (PST)
Received: (nullmailer pid 3817519 invoked by uid 1000);
 Wed, 16 Nov 2022 14:39:27 -0000
Date: Wed, 16 Nov 2022 08:39:27 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 04/11] ASoC: dt-bindings: qcom,q6afe: Split to
 separate schema
Message-ID: <166860954376.3817005.4583146687894570337.robh@kernel.org>
References: <20221115120235.167812-1-krzysztof.kozlowski@linaro.org>
 <20221115120235.167812-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221115120235.167812-5-krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@quicinc.com>, linux-arm-msm@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Andy Gross <agross@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, quic_plai@quicinc.com,
 quic_srivasam@quicinc.com
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


On Tue, 15 Nov 2022 13:02:28 +0100, Krzysztof Kozlowski wrote:
> The APR/GPR bindings with services got complicated so move out the Q6AFE
> service to its own binding.  Previously the compatible was documented in
> qcom,apr.yaml.  Move most of the examples from its children to this new
> file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Cc: quic_srivasam@quicinc.com
> Cc: quic_plai@quicinc.com
> ---
>  .../devicetree/bindings/sound/qcom,q6afe.yaml | 68 +++++++++++++++++++
>  .../sound/qcom,q6dsp-lpass-clocks.yaml        | 40 +----------
>  .../sound/qcom,q6dsp-lpass-ports.yaml         | 56 +++------------
>  3 files changed, 80 insertions(+), 84 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6afe.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
