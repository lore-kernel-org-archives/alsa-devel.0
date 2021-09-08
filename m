Return-Path: <SRS0=cWdV=N6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35D29C433F5
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Sep 2021 11:59:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE8D561100
	for <alsa-devel@archiver.kernel.org>; Wed,  8 Sep 2021 11:59:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DE8D561100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABAC1844;
	Wed,  8 Sep 2021 13:58:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABAC1844
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631102376;
	bh=zDRrMBN68aPNDe+773TWwQI1Xrr9fYbaBtcBuD+8XLE=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=B9+YYLTiP3qjyyq61USgWZsPgQPFLELBpmhVOM2207rusfAYFwnuOoXs8CylgCJrD
	 W9qYXIbbBynUbuhm9nN84datIbr0ufVryc4hSgvZgyTQaGL5I1fZJX6Di9DMt7A5fG
	 nRuGdkhX0mfdMlIzNBd8uWPwPeVwOT46K9xEpgf0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B1A0F8026C;
	Wed,  8 Sep 2021 13:58:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8DF3EF80149; Wed,  8 Sep 2021 13:58:44 +0200 (CEST)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7EA5FF80149
 for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2021 13:58:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7EA5FF80149
Received: by mail-ot1-f48.google.com with SMTP id
 v33-20020a0568300921b0290517cd06302dso2543766ott.13
 for <alsa-devel@alsa-project.org>; Wed, 08 Sep 2021 04:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ekrKhUAapVQLGpaPmyUUbCRHL9+ABWjyycmWN96rdJs=;
 b=05j81p1Wpy1vred1Ve0WqCAJTHbCgGYAtzO+PGZ+bztGlbojdSo0kGytDS/3Y56FVc
 wnLRAs0Gro8Rh6aLE5/YfqLEaCnQhjP1rjdkikV0w/H1YUkZEu1pmJGltvV9fF6tGSdJ
 OFktzJhJsY3OBC9uWON8BHl+qVGWvv5Y/wWLG/Kl8305LQso9FjtxLjCGEFa8GESSnq6
 yUqppDVMAtQsp1mFytrGF302XUJ2C3NrqYlKoIABwzINUwAP0hvbJ6s8j3byNp7og6c2
 eh+6+iSzlFo+rocVttL3g0EG2nzT5NXHUwLiQzAI41+2w2mlP02ZFvOdtdsOHLMN7s6v
 Ud3w==
X-Gm-Message-State: AOAM530DHV08v8WcgR39DP8QaHoNkQCbS+G5dqUAngAyqh9F0jaTedYc
 bM/1Tz9F2g8YN6mEnFiyFQ==
X-Google-Smtp-Source: ABdhPJycXJ0u9QA4j0lrlZKBHFJrB1V1ZSxBH0NWyBQdl7YyQIjicbTn5la2rQPRTllWck6Ojg3Rtg==
X-Received: by 2002:a05:6830:82c:: with SMTP id
 t12mr2696272ots.33.1631102311602; 
 Wed, 08 Sep 2021 04:58:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id e2sm378876ooh.40.2021.09.08.04.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Sep 2021 04:58:30 -0700 (PDT)
Received: (nullmailer pid 1849807 invoked by uid 1000);
 Wed, 08 Sep 2021 11:58:29 -0000
Date: Wed, 8 Sep 2021 06:58:29 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 13/21] ASoC: dt-bindings: add q6apm digital audio
 stream bindings
Message-ID: <YTilZXhtzVojg5bM@robh.at.kernel.org>
References: <20210903112032.25834-1-srinivas.kandagatla@linaro.org>
 <20210903112032.25834-14-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903112032.25834-14-srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, tiwai@suse.de, plai@codeaurora.org,
 lgirdwood@gmail.com, broonie@kernel.org, bjorn.andersson@linaro.org
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

On Fri, Sep 03, 2021 at 12:20:24PM +0100, Srinivas Kandagatla wrote:
> On AudioReach audio Framework, Audio Streams (PCM/Compressed) are managed by
> Q6APM(Audio Process Manager) service. This patch adds bindings for this DAIs
> exposed by the DSP.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,q6apm-dai.yaml        | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
> new file mode 100644
> index 000000000000..75431d1c0b2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6apm-dai.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/sound/qcom,q6apm-dai.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Qualcomm Audio Process Manager Digital Audio Interfaces binding
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  This binding describes the Qualcomm APM DAIs in DSP
> +
> +properties:
> +  compatible:
> +    const: qcom,q6apm-dais
> +
> +  reg:
> +    maxItems: 1
> +
> +  iommus:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - iommus
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gpr {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        gprservice@1 {

service@1

Might want to put a compatible in the gpr node so this is checked.

> +          compatible = "qcom,q6apm";
> +          reg = <1>;
> +
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          apm@1 {
> +            compatible = "qcom,q6apm-dais";
> +            iommus = <&apps_smmu 0x1801 0x0>;
> +            reg = <1>;
> +          };
> +        };
> +    };
> -- 
> 2.21.0
> 
> 
