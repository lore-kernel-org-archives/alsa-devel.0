Return-Path: <SRS0=Gs4n=N5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0170AC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Sep 2021 22:59:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 802C161132
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Sep 2021 22:59:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 802C161132
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EEA51711;
	Wed,  8 Sep 2021 00:58:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EEA51711
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631055540;
	bh=rQrKFSMCQCB+itKs7Ce9xivSfg4AK4wgII36oPsSBQM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mnA7G2dp4NQSFxOWZ+o9ZCPBi+kYqn/N0lRQgv6dpdWhQZm5xrNoFiLru5DUeF1NF
	 5kZWaVAk3NYgHGElmaDZoRYR1KpH7M0UF5o69HVULLGYtjl5rFtYP6M2B72jiGi7hM
	 0iH+IbVt0PLgmKVenhU77A2Al6Sb6swFCSj8YGvs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABB7FF80217;
	Wed,  8 Sep 2021 00:58:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 651B9F80224; Wed,  8 Sep 2021 00:58:08 +0200 (CEST)
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com
 [209.85.167.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 48A37F800C7
 for <alsa-devel@alsa-project.org>; Wed,  8 Sep 2021 00:57:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 48A37F800C7
Received: by mail-oi1-f175.google.com with SMTP id q39so514621oiw.12
 for <alsa-devel@alsa-project.org>; Tue, 07 Sep 2021 15:57:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=5/vfs21gG9mxPJ0jjyAgg1EpmoqQhpgC8XfjBg41YRI=;
 b=hUgnFG+zGwmJV20sJDkJOhLaVcdHb9S8ABUvh0CZ+xfpqUZvH0/ymNRHOJa7d/H/JX
 iTfbIlRzXMwq0XSXKKE55TMUFczcUTKnClS+yI9WtWQ86tLCSCIJ9ccBofVaoqy5USdO
 zAYUxY087vMarjLXA7DN23pwhL4oQ0QeXqUMm2RfkEIMmqEtDmRfTeqz6CVLXdvbl1Yy
 r4WjagyZIwbmnOyKWckoZxW+JUBdLLvpuZVxjpJJdV4W30j9xEIfKQv+CkmVspL24tIM
 7cC+gOLUpwjqjXPTggtw5bvO39GxKoJkS6V40SEnzvoEix+zcs6PA4ksT7WFGIWgKU15
 65hg==
X-Gm-Message-State: AOAM532WpDXbcDYUVdTzgaQujc6QIkiQLO6Gd63kUbsK0E7qr0eoxwJh
 MBFa1C1LGFJXeXtwPLa76g==
X-Google-Smtp-Source: ABdhPJzov9SlSluO21QrxH6boZeS6hQvPs8+nHK8ZUG3Lxqkqj6DqhTYXVWJ3uPURu1Essj01zaFlQ==
X-Received: by 2002:aca:c48d:: with SMTP id u135mr399288oif.106.1631055477626; 
 Tue, 07 Sep 2021 15:57:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id q10sm74743otn.47.2021.09.07.15.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Sep 2021 15:57:57 -0700 (PDT)
Received: (nullmailer pid 516744 invoked by uid 1000);
 Tue, 07 Sep 2021 22:57:56 -0000
Date: Tue, 7 Sep 2021 17:57:56 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v5 12/21] ASoC: dt-bindings: lpass-clocks: add q6prm
 clocks compatible
Message-ID: <YTfudKWILc6kTvz4@robh.at.kernel.org>
References: <20210903112032.25834-1-srinivas.kandagatla@linaro.org>
 <20210903112032.25834-13-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210903112032.25834-13-srinivas.kandagatla@linaro.org>
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

On Fri, Sep 03, 2021 at 12:20:23PM +0100, Srinivas Kandagatla wrote:
> On AudioReach audio Framework access to LPASS ports is via Q6PRM
> (Proxy Resource Manager) service, so add a dedicated lpass-clock compatible
> string for this.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../sound/qcom,q6dsp-lpass-clocks.yaml         | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
> index 589c3f1e2008..9f3de2307d1c 100644
> --- a/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6dsp-lpass-clocks.yaml
> @@ -16,6 +16,7 @@ properties:
>    compatible:
>      enum:
>        - qcom,q6afe-clocks
> +      - qcom,q6prm-lpass-clocks
>  
>    reg:
>      maxItems: 1
> @@ -54,3 +55,20 @@ examples:
>              };
>          };
>        };
> +
> +  - |
> +    #include <dt-bindings/soc/qcom,gpr.h>
> +    gpr {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        gpr-service@2 {
> +            reg = <GPR_PRM_MODULE_IID>;
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +            q6prmcc@2 {

clock-controller@2

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> +              compatible = "qcom,q6prm-lpass-clocks";
> +              reg = <2>;
> +              #clock-cells = <2>;
> +            };
> +        };
> +      };
> -- 
> 2.21.0
> 
> 
