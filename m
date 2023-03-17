Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AD99C74A5B
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Mar 2023 16:43:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 10BA7F05;
	Fri, 17 Mar 2023 17:42:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 10BA7F05
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1679071396;
	bh=8VOBWUlIxTGYHOTQ1DvNFk+VPv0OIYZ0/kgzfs5MFS8=;
	h=Date:From:To:Subject:References:In-Reply-To:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=HDV0yHwq50YCeGzg93eo1RetbIfg1Mjtx6k2Ln2YMIr5MCb1XOl0xFDKZKIk8hYUi
	 F3HQ5Qelm3Z7t0ISXT97WrQ3NQjmHXuogl7Ih42dY/WWM1ImrgjLUQW385ACPU60yX
	 /D3wFPc+tmkzPqF1UudGfUDrlNM1b/iDslWutd1E=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E5320F80557;
	Fri, 17 Mar 2023 17:41:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3694DF80563; Fri, 17 Mar 2023 17:41:13 +0100 (CET)
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com
 [209.85.166.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B8D1AF80557
	for <alsa-devel@alsa-project.org>; Fri, 17 Mar 2023 17:41:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8D1AF80557
Received: by mail-il1-f176.google.com with SMTP id l15so1499765ilv.4
        for <alsa-devel@alsa-project.org>;
 Fri, 17 Mar 2023 09:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679071266;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JsD8feDbQZLtjXXEjZG2Ph7500rlDWruAYhK5c5wrE=;
        b=pB0587kUCNSvIyNa4+3AhpWO5kA8xuoA2AflypbUSh0JOctxmdt/AcBKEU07xPhkd5
         eFwbDFJHX8ewjgifSJdMTxSPWXpJgThYlrk5aFhYglxCePMtXYdSyJYkw+lQOViYGW6I
         iwhrHMkla0ynTy9OXzlBOEj4spokCAxaCE9gSTlrnn0HfSDwS/hhUjQEKxfcgU5Inepz
         ET19sTTzYI37NNdcD1cXHlXiYPuqsCvojhPQr2kL8KtGn+S3da23ByqpDY565dXbB48i
         /5Xkt0x3jTlhsP7HVi/sG4yAh13pwhQxA4yCYHzmmZdZ0IbNfDvf+n6VkboXqgzJ38J0
         Bjqg==
X-Gm-Message-State: AO0yUKW805HZzxRpR84Yc2aQjZP4GIQaAV03AIYzuUt/9k1il/qaVqDe
	rEs1HEgigpsz8MdAFUdMyw==
X-Google-Smtp-Source: 
 AK7set+MXeUFUtWOYXoESItpHOi86+6ZLYrQddJXCu1lZhgin68dfwt9vEBhHA/wYZyRhB34XRDOdg==
X-Received: by 2002:a92:c9cb:0:b0:316:b0b2:beff with SMTP id
 k11-20020a92c9cb000000b00316b0b2beffmr90722ilq.4.1679071266001;
        Fri, 17 Mar 2023 09:41:06 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id
 i17-20020a056e020ed100b00322f4c434e8sm719716ilk.44.2023.03.17.09.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Mar 2023 09:41:05 -0700 (PDT)
Received: (nullmailer pid 2443655 invoked by uid 1000);
	Fri, 17 Mar 2023 16:41:04 -0000
Date: Fri, 17 Mar 2023 11:41:04 -0500
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 8/9] ASoC: dt-bindings: qcom,lpass-wsa-macro: Add
 SM8550 WSA macro
Message-ID: <167907126181.2443521.14287104885709088314.robh@kernel.org>
References: <20230313075445.17160-1-krzysztof.kozlowski@linaro.org>
 <20230313075445.17160-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313075445.17160-8-krzysztof.kozlowski@linaro.org>
Message-ID-Hash: I6W3Q3CPKRSZSJR5KXQHJCJSBLSHZKW7
X-Message-ID-Hash: I6W3Q3CPKRSZSJR5KXQHJCJSBLSHZKW7
X-MailFrom: robherring2@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, alsa-devel@alsa-project.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
 linux-arm-msm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 devicetree@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
 Takashi Iwai <tiwai@suse.com>, Banajit Goswami <bgoswami@quicinc.com>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I6W3Q3CPKRSZSJR5KXQHJCJSBLSHZKW7/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>


On Mon, 13 Mar 2023 08:54:44 +0100, Krzysztof Kozlowski wrote:
> Add the WSA macro codec on Qualcomm SM8550, which comes without NPL clock
> exposed.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/sound/qcom,lpass-wsa-macro.yaml  | 23 +++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

