Return-Path: <SRS0=Hwg1=7K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10D7C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 28 May 2020 14:06:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723EE20721
	for <alsa-devel@archiver.kernel.org>; Thu, 28 May 2020 14:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kSiHve0B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723EE20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BC39E179F;
	Thu, 28 May 2020 16:05:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BC39E179F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590674790;
	bh=y1z9dlJ3EhIXj2RWA0vbMrF2xmkbQlAPyyia0RW25Rc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kSiHve0BOu7culcm3qVjG5YB2+NIU3xVoDW9CFvYOkeQS+k6mn/DF55Fq31IWmn4C
	 0TG6PmMG3ut6PzgbhieI4ZbS2pDB6HKusbIsOmQ2UIigSLVF9h/rM8JddLm7UKUVPW
	 6XeVRGDTzDZbFQvpE336U9ahSM7gIVRQpxUN8kB4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33BEBF8014A;
	Thu, 28 May 2020 16:05:40 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EF554F80150; Thu, 28 May 2020 16:05:38 +0200 (CEST)
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71545F800FF
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2020 16:05:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71545F800FF
Received: by mail-io1-f65.google.com with SMTP id d7so30113520ioq.5
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2020 07:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=SLMEy6Ytljxjg8a2KXQ/FizRno8giPzwlWNr4nIvO0E=;
 b=klSkSpzHHIOH7v3/048m5LbXM1uWpdA3cV7qtvB6c1hN7SJFgDiogpV0ExaEx8Bm4D
 ZDzgS4RQy58oCEC1nNfumzd57jOUpS0BVMFXwLkznKKqP3esvSGVd9FYMHpd5O9pXOrF
 73fhysmCpCLDFAHpf/vnsL6w82zYKToxbR5TXcwaLUqP0AUUJwqnMnznAmRpe2x3JUAd
 0fpGw753z4yhXs4jAoijUrhMlhEEWvX+HVPRlXPadJBaeT1PNa5VSM5JFTChsy4p/ylV
 LrnnYNTnD5fr5JZpMKtSycl5ePt7wMtIEeFecAUDu3wJ++3KuGNUqLu0Lkpwd0bm0BXN
 p6Ng==
X-Gm-Message-State: AOAM533wfMn+VDUG/WlKWfUji3QCGQ2whCzUZ5iObkLDsrsMiW8Q93Uv
 kyMX7X3cUgx2T9qNatcT5w==
X-Google-Smtp-Source: ABdhPJzoX/OrRJgrF0RLFSzW9vlhDIhoXc7lQcsFo+49D/RYaTtv2OthkVdqcft8AlGIdyG+p7PixA==
X-Received: by 2002:a5d:9dd2:: with SMTP id 18mr2468310ioo.196.1590674728083; 
 Thu, 28 May 2020 07:05:28 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id n27sm3317522ild.76.2020.05.28.07.05.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 07:05:26 -0700 (PDT)
Received: (nullmailer pid 4173461 invoked by uid 1000);
 Thu, 28 May 2020 14:05:25 -0000
Date: Thu, 28 May 2020 08:05:25 -0600
From: Rob Herring <robh@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: sound: tlv320adcx140: Add GPI config
 property
Message-ID: <20200528140525.GA4166160@bogus>
References: <20200526200917.10385-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526200917.10385-1-dmurphy@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
 broonie@kernel.org
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

On Tue, May 26, 2020 at 03:09:16PM -0500, Dan Murphy wrote:
> Add an array property that configures the General Purpose Input (GPI)
> register.  The device has 4 GPI pins and each pin can be configured in 1
> of 7 different ways.

Dan seems to have trouble running get_maintainers.pl and Cc'ing the DT 
list. Running 'make dt_binding_check' also seems to be a problem. Now 
linux-next has these warnings:

/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/tlv320adcx140.example.dt.yaml: codec@4c: ti,gpi-config:0:0: 4 is greater than the maximum of 1
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/tlv320adcx140.example.dt.yaml: codec@4c: ti,gpi-config:0:1: 5 is greater than the maximum of 1
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/tlv320adcx140.example.dt.yaml: codec@4c: ti,gpi-config:0:2: 6 is greater than the maximum of 1
/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/sound/tlv320adcx140.example.dt.yaml: codec@4c: ti,gpi-config:0:3: 7 is greater than the maximum of 1

Please send a fix.

> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../bindings/sound/tlv320adcx140.yaml         | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
> index daa6cc0e031b..e8a69b1c7ca9 100644
> --- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
> +++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
> @@ -86,6 +86,32 @@ properties:
>            maximum: 1
>          default: [0, 0, 0, 0]
>  
> +  ti,gpi-config:
> +    description: |
> +       Defines the configuration for the general purpose input pins (GPI).
> +       The array is defined as <GPI1 GPI2 GPI3 GPI4>.
> +
> +       0 - (default) disabled
> +       1 - GPIX is configured as a general-purpose input (GPI)
> +       2 - GPIX is configured as a master clock input (MCLK)
> +       3 - GPIX is configured as an ASI input for daisy-chain (SDIN)
> +       4 - GPIX is configured as a PDM data input for channel 1 and channel
> +            (PDMDIN1)
> +       5 - GPIX is configured as a PDM data input for channel 3 and channel
> +            (PDMDIN2)
> +       6 - GPIX is configured as a PDM data input for channel 5 and channel
> +            (PDMDIN3)
> +       7 - GPIX is configured as a PDM data input for channel 7 and channel
> +            (PDMDIN4)
> +
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
> +      - minItems: 1
> +        maxItems: 4
> +        items:
> +          maximum: 1

I believe you want '7' here.

> +        default: [0, 0, 0, 0]
> +
>  required:
>    - compatible
>    - reg
> @@ -101,6 +127,7 @@ examples:
>          reg = <0x4c>;
>          ti,mic-bias-source = <6>;
>          ti,pdm-edge-select = <0 1 0 1>;
> +        ti,gpi-config = <4 5 6 7>;
>          reset-gpios = <&gpio0 14 GPIO_ACTIVE_HIGH>;
>        };
>      };
> -- 
> 2.26.2
> 
