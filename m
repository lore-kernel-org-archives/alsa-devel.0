Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DB3BC32772
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Aug 2022 13:49:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A8D3C1694;
	Tue, 23 Aug 2022 15:48:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A8D3C1694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1661262551;
	bh=UQWR2rt2jTpbuHI7O+gPLQe0tUofCuUdHJShi4D7OIM=;
	h=Date:Subject:To:References:From:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EB6QfH2W7UXpVoij92pGu6MaweyYI4bhiQTISmUJHXWLL7k8rbrwRZTrVoSlE0+qz
	 EXJvDTstJDATWAACkAEP3ZzOm6qJKP9xPNThq2fCw/e4aePLiPAgfl7IxSMTkdK5ee
	 ZcrQJXdzAMMQYH3dnGo7/J4p1rJFmLyLJ+uV0Jsw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45749F8014E;
	Tue, 23 Aug 2022 15:48:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8EA04F800A7; Tue, 23 Aug 2022 15:48:20 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D1D6F800A7
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2022 15:48:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D1D6F800A7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="G6u/gMHO"
Received: by mail-lj1-x22d.google.com with SMTP id q18so12548318ljg.12
 for <alsa-devel@alsa-project.org>; Tue, 23 Aug 2022 06:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc; bh=etUNLniWHgJEJDCvw5GPxyP6mirBEPYcAYo8g53LeZg=;
 b=G6u/gMHONj31bKntnY4mYMMepTc/qL4So3m6ypkJTVSM6Qx8oF5a7AjqcKACF0T90o
 ABUxoYHTA10t/J7O8DagZehl8ZgohPjweSQbDRxeFvG0CKwaGJcJAsh7K0m+Ez5gy60a
 RnrKHF312WnBAg9ACxc1UIB4SvNn7d8s9aOH2d7Pyg86qIzn+tlaKNlwpDfLpAI29njg
 OZ9WRyx7e0k/Tbiqe6bDgOR43DH2MzXZWulM58eicHufIU36kVwe+ngKi9Xi8WGEUq26
 3xRAi6KUKa5Wh2MS0Pm3IaPjvZMtMzUE5ikE5T/s/LxFQ++UU+SXZhe1/GLxsJ+kIC+9
 NkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=etUNLniWHgJEJDCvw5GPxyP6mirBEPYcAYo8g53LeZg=;
 b=1pfXU75oKZB6ZEXP9oTxlTVHe6D1LEVSGT5CQpo+s4GdnIRyAGt5gHTcxG9Svx8S33
 BLwrFoxaI8I9QOyyihFMEUSzfm8JSAmlOZn1gDsWcP3SKfEYL7pzq2xgvW1ZxmfdyLoe
 6koB51hUn6F04ehYOPKeqbKhhaOtKDJ+5rbLfeS6sqjqcMwRleWUfK7rdRtECMyeWSzQ
 qzQDBZnAcdkxOnHbd63QA+npytLeLpfL73ZTrjrvewNRTbbg3kTeJh2QHkvmsQhUijvu
 X7k7b0WTX0xiIbqzEzSLP2GSDBYmP2R9FVvxa+ipkFq5dnzAJPJ0n/qXeQNhg+JMojCz
 3m5w==
X-Gm-Message-State: ACgBeo0/59NhlwXqrJ8nczoXkat3edPdM1voDCJWB52t6IKchv6D5EkR
 jkOvmKEFuZAjpEEnHiXVKx3Wzg==
X-Google-Smtp-Source: AA6agR7LLkgQKhdY0aEo6fL4eDcJ/ReUbDhzV9yPR1SsZVcB8imNPrMITsvk9qQ5MHab1vJPAgJbIA==
X-Received: by 2002:a2e:a812:0:b0:261:8f2d:9530 with SMTP id
 l18-20020a2ea812000000b002618f2d9530mr6450626ljq.251.1661262492350; 
 Tue, 23 Aug 2022 06:48:12 -0700 (PDT)
Received: from [192.168.0.11] (89-27-92-210.bb.dnainternet.fi. [89.27.92.210])
 by smtp.gmail.com with ESMTPSA id
 w23-20020ac24437000000b00492f6ddba59sm398330lfl.75.2022.08.23.06.48.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Aug 2022 06:48:10 -0700 (PDT)
Message-ID: <2d2511c7-760c-31d5-5283-8ab0b20849d6@linaro.org>
Date: Tue, 23 Aug 2022 16:48:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] ASoC: mediatek: dt-bindings: modify machine bindings
 for SOF
Content-Language: en-US
To: Chunxu Li <chunxu.li@mediatek.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, nfraprado@collabora.com,
 broonie@kernel.org
References: <20220820075343.13993-1-chunxu.li@mediatek.com>
 <20220820075343.13993-2-chunxu.li@mediatek.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220820075343.13993-2-chunxu.li@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, jiaxin.yu@mediatek.com, linux-kernel@vger.kernel.org,
 project_global_chrome_upstream_group@mediatek.com,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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

On 20/08/2022 10:53, Chunxu Li wrote:
> From: "chunxu.li" <chunxu.li@mediatek.com>
> 
> Add SOF related field.
> 1. Add a property "mediatek,adsp", Only when adsp phandle could be
> retrieved from DTS, the SOF related part of machine driver is executed.
> 2. Add a property "mediatek,dai-link" to support dai-links could be
> specified from DTS
> 
> Signed-off-by: chunxu.li <chunxu.li@mediatek.com>
> ---
>  .../bindings/sound/mt8186-mt6366-da7219-max98357.yaml  | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
> index 513cd28b2027..d810dfccd1f8 100644
> --- a/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
> +++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-max98357.yaml
> @@ -43,6 +43,16 @@ properties:
>      required:
>        - sound-dai
>  
> +  mediatek,adsp:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"

No need for quotes.

Best regards,
Krzysztof
