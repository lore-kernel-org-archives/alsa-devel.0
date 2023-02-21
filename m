Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA947C678DB
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Feb 2023 15:44:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A95DBDF1;
	Tue, 21 Feb 2023 16:43:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A95DBDF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676994288;
	bh=0vldkX9sbALaBuEwyzBElZYiIdiSMj/daEDafc2qL1s=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=j2dQ4ORCa4Uou/LbYteYOGZQn5JlaIpVjuooaZ1/nQCz01dIV0hq/5KaSGAKxZ/PF
	 gftRnY/5iyyYw0JmghQe8gY9T6g0UrjaVvIxrZIkj/JxSF2jjmb1VHzi3KVVJwBAHG
	 s/9s81i3SfecushXXWylkglbi3mrhlJK/+67WtmA=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E495F80266;
	Tue, 21 Feb 2023 16:43:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C600BF80266; Tue, 21 Feb 2023 16:43:36 +0100 (CET)
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com
 [209.85.160.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 6FE0DF800BA
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2023 16:43:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6FE0DF800BA
Received: by mail-oa1-f48.google.com with SMTP id
 586e51a60fabf-172334d5c8aso2175880fac.8
        for <alsa-devel@alsa-project.org>;
 Tue, 21 Feb 2023 07:43:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+9xiI3UVlHjuS+MWpZRmcoMLLLOXy9JHT1NR0U/EA8=;
        b=l9M/vJw3dmIDnnDM8gCwdqyz7X+bQ501GBn5wxBVEEnJPJFbbr/LTDK2QWj+nTueD9
         KjWfF1eWSTzgJ6/im0v6SXDctJNNFXNOkITj8v36dGILZvFZRm2uffPdBxg0E4FmZh2V
         MpLkFB1Bmig89AR88ihb55czrADPoNmBOj3TwJBq3Nu0Y/AdPhFDb/jNxLP2b3vprxLI
         h6yLFzn8IXahcLFDF/icfH89ybN9ins2aNCW8Cc3rvPAmExot5ropzCZFcPzVXh6LOHx
         n6ORH3URg4NjP/TmKdbiAXVFMqQnJufPwgAMCR3bLPbPj9ol67pVgmEkoKxHxyn8cI8f
         9a8A==
X-Gm-Message-State: AO0yUKXEVvwWkQCmXNaciOe/n6tJWWvJ4etwXQa68xS6WmuS/01FAWrn
	MpU3P15wsXSdDnsaFNGvgQ==
X-Google-Smtp-Source: 
 AK7set/LnRQPKKczNGO0zyZKysK6CC7kRbjgoTB9aYV1CEanHCh9l+x0tND5tFhKDd5DdzhFHHSegw==
X-Received: by 2002:a05:6870:b620:b0:163:58e8:77e5 with SMTP id
 cm32-20020a056870b62000b0016358e877e5mr8734321oab.52.1676994213173;
        Tue, 21 Feb 2023 07:43:33 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id
 z6-20020a05687042c600b0014866eb34cesm5304619oah.48.2023.02.21.07.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 07:43:32 -0800 (PST)
Received: (nullmailer pid 2589941 invoked by uid 1000);
	Tue, 21 Feb 2023 15:43:31 -0000
Date: Tue, 21 Feb 2023 09:43:31 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: qcom,wcd934x: Reference dai-common
Message-ID: <167699421150.2589878.754040795776366251.robh@kernel.org>
References: <20230220095643.64898-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230220095643.64898-1-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: GBQ4N3OPPFVSLXUSU4ZLUOFIJUUNVZJN
X-Message-ID-Hash: GBQ4N3OPPFVSLXUSU4ZLUOFIJUUNVZJN
X-MailFrom: robherring2@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>,
 Mark Brown <broonie@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
 Banajit Goswami <bgoswami@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GBQ4N3OPPFVSLXUSU4ZLUOFIJUUNVZJN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Mon, 20 Feb 2023 10:56:42 +0100, Krzysztof Kozlowski wrote:
> Reference common DAI properties to get sound-dai-cells description and
> allow name-prefix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>

