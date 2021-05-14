Return-Path: <SRS0=jeAA=KJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEB77C433ED
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 13:08:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E747061451
	for <alsa-devel@archiver.kernel.org>; Fri, 14 May 2021 13:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E747061451
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0165B176C;
	Fri, 14 May 2021 15:07:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0165B176C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620997685;
	bh=S0BbTK/mQHJgtqU/+EcRYAuw61mt17Dc0nZEz2PHMq8=;
	h=From:To:In-Reply-To:References:Subject:Date:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=j5qqDCEWaucg2WW9+Dg3IcoGwdSmiC8ujUzFcdpFBKNQkozWYxy7Klo2qdF9uXGST
	 1m48/5c77sUifuNjEP81c4UhV8Ya0jV8zNIOxFEwc6mAK6HzpVznNwBSqPUDmrWjgE
	 E2+/sckjGN3cTDnj+gAwTnkkm1Fjzuc4dQJ7Lxfw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A71FF8020C;
	Fri, 14 May 2021 15:07:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A892CF80240; Fri, 14 May 2021 15:07:12 +0200 (CEST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B794F8013A
 for <alsa-devel@alsa-project.org>; Fri, 14 May 2021 15:07:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B794F8013A
Received: by mail-ot1-f53.google.com with SMTP id
 r26-20020a056830121ab02902a5ff1c9b81so26395803otp.11
 for <alsa-devel@alsa-project.org>; Fri, 14 May 2021 06:07:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
 :message-id;
 bh=xGVTJIe3IpvtYlWDXjmgrXNvgrVnvtut7WrcSggOBcA=;
 b=fAqnCFrH/vkkD3wuQuw7pGJxq+mDRMxn501gtInuFAPGWegx35/4nJoqR0gDvgMWe4
 tacVAbs799tFItD6gJKE3E7xFa4ucndfTHkQ3pAJkYGWS97wyQOmZVpyFEcCXa06x6FV
 N6UAaHtJ7RMgpptjeq2/ESXy0/8x4rilPoCS43cDRRs/R+rGg3DBIIZ+Z7eWXoTNn+Uv
 MiwH/nAQGpQhHNNAkd1PQcYl5zyfW5rsjURPQTbMA6/NtMhTjRdmaEX6qxPxco1B3jvP
 0Lde68S+1JhvdlMycmjUoHjkKIdfI8e2i6IZmX76TKo0yZbni3Mq8eycKlZYIBJVz4s+
 yoFQ==
X-Gm-Message-State: AOAM533DX/vf4LXLCCnDVLC9ZNUo85sQDkX3r/AedjqJJuq5sEKJ9XbJ
 uWudCTQ06A4xHlx1njArow==
X-Google-Smtp-Source: ABdhPJwqX2eYj0l12uVBWQ1hPm0AcmqocVEheIW3yuo8nFdY+rUt4unWcqrsga7ds2xsj4uzighyzA==
X-Received: by 2002:a9d:4911:: with SMTP id e17mr39944015otf.38.1620997622254; 
 Fri, 14 May 2021 06:07:02 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id d207sm1262089oob.7.2021.05.14.06.07.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 May 2021 06:07:01 -0700 (PDT)
Received: (nullmailer pid 3936696 invoked by uid 1000);
 Fri, 14 May 2021 13:06:56 -0000
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20210514103405.29927-2-srinivas.kandagatla@linaro.org>
References: <20210514103405.29927-1-srinivas.kandagatla@linaro.org>
 <20210514103405.29927-2-srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 1/9] ASoC: dt-bindings: wcd938x: add bindings for
 wcd938x
Date: Fri, 14 May 2021 08:06:56 -0500
Message-Id: <1620997616.615521.3936695.nullmailer@robh.at.kernel.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org,
 linux-kernel@vger.kernel.org, lgirdwood@gmail.com
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

On Fri, 14 May 2021 11:33:57 +0100, Srinivas Kandagatla wrote:
> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire device RX and
> TX respectively, supporting 4 x ADCs, ClassH, Ear, Aux PA, 2xHPH,
> 7 x TX diff inputs, 8 DMICs, MBHC.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd938x.yaml          | 149 ++++++++++++++++++
>  1 file changed, 149 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml: properties:qcom,mbhc-buttons-vthreshold-microvolt: 'anyOf' conditional failed, one must be fixed:
	'$ref' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('$ref' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	1 was expected
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml: ignoring, error in schema: properties: qcom,mbhc-buttons-vthreshold-microvolt
warning: no schema found in file: ./Documentation/devicetree/bindings/sound/qcom,wcd938x.yaml
Documentation/devicetree/bindings/sound/qcom,wcd938x.example.dt.yaml:0:0: /example-0/codec: failed to match any schema with compatible: ['qcom,wcd9380-codec']

See https://patchwork.ozlabs.org/patch/1478395

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

