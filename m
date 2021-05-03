Return-Path: <SRS0=hTuJ=J6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B045C433B4
	for <alsa-devel@archiver.kernel.org>; Mon,  3 May 2021 17:01:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 254EE61075
	for <alsa-devel@archiver.kernel.org>; Mon,  3 May 2021 17:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 254EE61075
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A243A1689;
	Mon,  3 May 2021 19:00:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A243A1689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620061300;
	bh=IoqGH1xRzhuiYK3opt++hOa29dkSpz07yip1I3JB3vg=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ABxzwEoIYMhWl0uS91MOEDIWbyPGF+xUfWRUuwTSfhLcA49wq/5OT2zfvZcGEnErH
	 q4ZqT15Qr/+LfOhMgR7LIyukvNR32MQyGuRIDUerjfMNXCypgP9XBLqC0sFXXHaQ1X
	 dOcrazV8mPAqfJ9Dfdoa8+6zrNAO0rRN2+jhU7w8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 34C37F80257;
	Mon,  3 May 2021 19:00:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EFFA2F8025F; Mon,  3 May 2021 19:00:43 +0200 (CEST)
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com
 [209.85.210.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7235BF80111
 for <alsa-devel@alsa-project.org>; Mon,  3 May 2021 19:00:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7235BF80111
Received: by mail-ot1-f53.google.com with SMTP id
 x54-20020a05683040b6b02902a527443e2fso5707183ott.1
 for <alsa-devel@alsa-project.org>; Mon, 03 May 2021 10:00:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MpWS97nnXbRs49r1fForFBwiCI3FlCAOFGO2IucCbgI=;
 b=pkz2X5IWj3D2HvZ0fFFeW0mXqkBFmbsZUBFOpVQcQjk54i2YF+4KX7WOAG63VpQiY7
 TdJimjwi6CE7z1wqVrBJewQYE8i6CuvfyDJEFtZEsLHUHmSDzXJA3xiK+2KxiSvy/1JL
 8OxwzeZ2GrcFSiOAszlaftJjC3BhgQLPbJcaCukbUcG7zWGC9rwz4mmno1kxbq5w9h+O
 UiA42DX7LlmvIKaxxh0ccf2tftzckhjG76z0FPzNm+YWCE8OeGJJzi5M9Zt8FA3J1oOD
 dYas9aGu/A3ZQ3iGLbBEI4JBcNAT8JpCEsLU6OmLmkjKavShFUtj5tN26C67VT1vtwp7
 S0lA==
X-Gm-Message-State: AOAM532CRPdMtu3FJRgiZsszwOG6XypdZS1waZuEtORpljqPs287D0L1
 EMB3Pv6rilOn0bDHYNGvxg==
X-Google-Smtp-Source: ABdhPJz3axdorHwGCwuPSEqF9Bw80gZAqMDgQOmNpRuGn93hjcvSZSCtx5vibHriB9CdGrpMOJJZig==
X-Received: by 2002:a9d:7085:: with SMTP id l5mr15416541otj.345.1620061233291; 
 Mon, 03 May 2021 10:00:33 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t25sm71651oic.23.2021.05.03.10.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 May 2021 10:00:32 -0700 (PDT)
Received: (nullmailer pid 2008247 invoked by uid 1000);
 Mon, 03 May 2021 17:00:30 -0000
Date: Mon, 3 May 2021 12:00:30 -0500
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH 2/2] ASoC: dt-bindings: imx-akcodec: Add binding doc for
 akcodec machine driver
Message-ID: <20210503170030.GA1987906@robh.at.kernel.org>
References: <1619157107-3734-1-git-send-email-shengjiu.wang@nxp.com>
 <1619157107-3734-2-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1619157107-3734-2-git-send-email-shengjiu.wang@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 shawnguo@kernel.org, s.hauer@pengutronix.de, linuxppc-dev@lists.ozlabs.org,
 tiwai@suse.com, lgirdwood@gmail.com, nicoleotsuka@gmail.com,
 broonie@kernel.org, linux-imx@nxp.com, kernel@pengutronix.de,
 festevam@gmail.com, linux-kernel@vger.kernel.org
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

On Fri, Apr 23, 2021 at 01:51:47PM +0800, Shengjiu Wang wrote:
> Imx-akcodec is a new added machine driver for supporting
> ak4458/ak5558/ak5552/ak4497 codec on i.MX platforms.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../bindings/sound/imx-audio-akcodec.yaml     | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml b/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> new file mode 100644
> index 000000000000..7419bf7224e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/imx-audio-akcodec.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/imx-audio-akcodec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX audio complex with AK4458/AK5558/AK5552/AK4497 codec

Looks like the existing fsl-asoc-card.txt? You should convert to schema 
and use that. Otherwise, my comments are based on this all being 'new'.

> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx8mq-audio-ak4458
> +      - fsl,imx8mq-audio-ak4497
> +      - fsl,imx8mq-audio-ak5558
> +      - fsl,imx-audio-ak4497
> +      - fsl,imx-audio-ak4458
> +      - fsl,imx-audio-ak5558
> +      - fsl,imx-audio-ak5552

I continue to not understand why audio bindings need the codec(s) in the 
compatible strings. Can't you look up the codec thru the audio-codec 
property?

> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +  audio-cpu:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of a CPU DAI controller
> +
> +  audio-codec:
> +    description: The phandle of Codec DAI controllers, there are two
> +                 controllers maximum.

We have the common 'sound-dai' property. See the simple-card.yaml 
binding. 

> +
> +  audio-asrc:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of ASRC. It can be absent if there's no
> +                 need to add ASRC support via DPCM.

Needs a vendor prefix.

> +
> +  fsl,tdm:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      This is a boolean property. If present, the TDM mode is enabled.

But this one seems like something that could or should be common.

> +
> +required:
> +  - compatible
> +  - model
> +  - audio-cpu
> +  - audio-codec
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sound-ak4458 {
> +        compatible = "fsl,imx-audio-ak4458";
> +        model = "ak4458-audio";
> +        audio-cpu = <&sai1>;
> +        audio-codec = <&ak4458_1>, <&ak4458_2>;
> +    };
> -- 
> 2.17.1
> 
