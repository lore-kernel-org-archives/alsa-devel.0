Return-Path: <SRS0=/2j+=HM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF9CC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 22:14:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6903964DF0
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 22:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6903964DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BEEA16D8;
	Wed, 10 Feb 2021 23:13:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BEEA16D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612995237;
	bh=0PPF55qHncdS1L58gVX8MKBB88p4hQnjr9jiZis6UZw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JAD298PehMxNUAD/JluffJWJ7vZyKK2RC9pISj4Ke1yWKi5u0FE9kQVhLhTd2pKXd
	 c+ewXKYrA6DZNhnFvbJBvYO3e1w8fhF4OUJde2Nufjzt12D/eyRPINY/krNNVOUaE4
	 I70LJ6A2rIAa4cQXfKkUb64AbuTB9zSV9GQwspcA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 87C9EF800F1;
	Wed, 10 Feb 2021 23:13:06 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89443F8022B; Wed, 10 Feb 2021 23:13:04 +0100 (CET)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3B72CF800F1
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2021 23:12:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3B72CF800F1
Received: by mail-ot1-f48.google.com with SMTP id i20so3367611otl.7
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2021 14:12:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=DTXg6CwDth7i/nqcv+euFr50pt7fVzpIfVZ9mbO1Zq0=;
 b=kqMwBgfcRYPUzoiow6fQaZLVNHqCG/XOtUgJCd0V8oxl2q1rHcVMphCJ1qwRvHQTjv
 zCs0GJNTYsJdAUr+DupEn/v8VRoYx2xDJrljy6mwACe/h/F3qGguJMU+23gdaYuua8UE
 zJp01DPtBekWau6J9fXfp6WW5KihkXjC2/bEx6PCvV2O+DHW74BVZKrRN1zVQm3k0qMX
 4OyUoKJksj2qGU29bbYbzRuYxqFGG2oMvfJgQTF51LNtrfdbgFwsOgEZifJ7x7enqI6x
 cXW/+TOz4TslEruLkVw0VuzD3kwo6vxepFNW5hfXKDYTapsy7kl2XD5cwhbscofuBM4d
 9Nrw==
X-Gm-Message-State: AOAM530FBeQvPpWr9dGs1UaOzAA0BEgkfNr68M6MSNfZamWWTUIHI1+c
 MshH6fbY5y3YpgQHpksOig==
X-Google-Smtp-Source: ABdhPJzi/+7SeOHhZnHUBL4PJ6P0lIk8i2F6Ep3p3sFUaaO0qUGBJ/J5giqeNfq2byHxecLoX+o25A==
X-Received: by 2002:a9d:6b1a:: with SMTP id g26mr3792095otp.49.1612995174877; 
 Wed, 10 Feb 2021 14:12:54 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id z8sm613408oon.10.2021.02.10.14.12.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Feb 2021 14:12:54 -0800 (PST)
Received: (nullmailer pid 2893717 invoked by uid 1000);
 Wed, 10 Feb 2021 22:12:52 -0000
Date: Wed, 10 Feb 2021 16:12:52 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 3/7] ASoC: dt-bindings: fsl_rpmsg: Add binding doc for
 rpmsg cpu dai driver
Message-ID: <20210210221252.GA2885308@robh.at.kernel.org>
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-4-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612693435-31418-4-git-send-email-shengjiu.wang@nxp.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@kernel.org,
 lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, nicoleotsuka@gmail.com,
 broonie@kernel.org, festevam@gmail.com
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

On Sun, Feb 07, 2021 at 06:23:51PM +0800, Shengjiu Wang wrote:
> fsl_rpmsg cpu dai driver is driver for rpmsg audio, which is mainly used
> for getting the user's configuration from device tree and configure the
> clocks which is used by Cortex-M core. So in this document define the
> needed property.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../devicetree/bindings/sound/fsl,rpmsg.yaml  | 80 +++++++++++++++++++
>  1 file changed, 80 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> new file mode 100644
> index 000000000000..2d3ce10d42fc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/fsl,rpmsg.yaml
> @@ -0,0 +1,80 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/fsl,rpmsg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP Audio RPMSG CPU DAI Controller
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx7ulp-rpmsg
> +      - fsl,imx8mn-rpmsg
> +      - fsl,imx8mm-rpmsg
> +      - fsl,imx8mp-rpmsg

rpmsg is a protocol. What's the h/w block?

> +
> +  clocks:
> +    items:
> +      - description: Peripheral clock for register access
> +      - description: Master clock
> +      - description: DMA clock for DMA register access
> +      - description: Parent clock for multiple of 8kHz sample rates
> +      - description: Parent clock for multiple of 11kHz sample rates
> +    minItems: 5
> +
> +  clock-names:
> +    items:
> +      - const: ipg
> +      - const: mclk
> +      - const: dma
> +      - const: pll8k
> +      - const: pll11k
> +    minItems: 5
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  fsl,audioindex:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: instance index for rpmsg image
> +
> +  fsl,version:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: rpmsg image version index

What are these 2 used for?

> +
> +  fsl,buffer-size:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: pre allocate dma buffer size
> +
> +  fsl,enable-lpa:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: enable low power audio path.
> +
> +  fsl,codec-type:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Sometimes the codec is registered by
> +                 driver not the device tree, this items
> +                 can be used to distinguish codecs

0-2^32 are valid values?

> +
> +required:
> +  - compatible
> +  - fsl,audioindex
> +  - fsl,version
> +  - fsl,buffer-size
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    rpmsg_audio: rpmsg_audio {
> +        compatible = "fsl,imx8mn-rpmsg";
> +        fsl,audioindex = <0> ;
> +        fsl,version = <2>;
> +        fsl,buffer-size = <0x6000000>;
> +        fsl,enable-lpa;
> +        status = "okay";

Don't show status in examples.

> +    };
> -- 
> 2.27.0
> 
