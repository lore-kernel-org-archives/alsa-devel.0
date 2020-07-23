Return-Path: <SRS0=vWr5=BC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	BODY_QUOTE_MALF_MSGID,DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E8AC433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:19:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FFC0207BB
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 20:19:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kZI9fFSy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FFC0207BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E739B1681;
	Thu, 23 Jul 2020 22:18:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E739B1681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595535567;
	bh=OKaS1P28nJxxtCAWZB+HdxF8uwxJI3GOsJdAJpz1Wb8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kZI9fFSyv2KYrKd9sVPcms239pf50NeUm0QqDBhm7+IJ/dSaGMGTZh4B16fqtjmP2
	 ic8U5HzwtN1PsbALL7wiM/WYT3Zy6h7NizojaVB2iTyzVpCj3i9ZEZFLpbEpZoNTTE
	 5JB0bQ+vODAtC8GuovUDo/qu3djsSogpmdsxhDIs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E87FF80212;
	Thu, 23 Jul 2020 22:18:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6A70CF80268; Thu, 23 Jul 2020 22:18:35 +0200 (CEST)
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 22223F80090
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2020 22:18:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 22223F80090
Received: by mail-io1-f65.google.com with SMTP id s189so369342iod.2
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2020 13:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=A+bs3OlS8UQmhllIUhonZMM/+IfllG/gM+l8StXXg04=;
 b=bslVgQr+hVX0uxqxsTxE3OIDAdy/uqwi80ZWFOypyJ0hUereaqPLO27zvM+SoKaQOB
 mNAOzUA5PfCFpYNIqY6W+O+OucRyY9Lt/YgVomOh2/GnI6hPl7XWXHQEuzpFLsgRGs+I
 VQ4Dpj2QWm4XWI7cgmQwy5lxZzN2Ih3DEwDLn1x1xr62BBh/h+ZKeJfG7Gi0Gcx7KN91
 1wfTMav8E5D7ry1DGGv3uYbnNEa0oUJ6bpBThripNhb7wr2ReklGlNj8XRDmcmzxgc8d
 U7sOIqp+BMjrojnmEwyJVzVd/VfQMbbmIaW9CdmiOWPz6NfAdLcF3wut16yB6K7hj4Be
 cS7g==
X-Gm-Message-State: AOAM5339NsfaIers1iZn51c/4HQcjA4mpUxKKGCgjhnBLPJGaAz9I8Te
 DiuwOGN/nejo9V8YX8am5Q==
X-Google-Smtp-Source: ABdhPJx40znh6EFlcwp+i/5XHaqEwUcM8wAzVExw4KY1VjVYL+2q03d6mC37eNjFzhZiBelEbH+gdA==
X-Received: by 2002:a02:7786:: with SMTP id g128mr4182617jac.45.1595535502832; 
 Thu, 23 Jul 2020 13:18:22 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id u65sm2019040iod.45.2020.07.23.13.18.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2020 13:18:21 -0700 (PDT)
Received: (nullmailer pid 793895 invoked by uid 1000);
 Thu, 23 Jul 2020 20:18:19 -0000
Date: Thu, 23 Jul 2020 14:18:19 -0600
From: Rob Herring <robh@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: tas2562: Convert the tas2562 binding
 to yaml
Message-ID: <20200723201819.GA783613@bogus>
References: <20200722154706.9657-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722154706.9657-1-dmurphy@ti.com>
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

On Wed, Jul 22, 2020 at 10:47:05AM -0500, Dan Murphy wrote:
> Convert the TAS2562 text file to yaml format.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v2 - Updated the shutdown-gpio to shutdown-gpios and fixed licensing to be
> GPL-2.0-only.
> 
>  .../devicetree/bindings/sound/tas2562.yaml    | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/tas2562.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/tas2562.yaml b/Documentation/devicetree/bindings/sound/tas2562.yaml
> new file mode 100644
> index 000000000000..8d75a798740b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tas2562.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2019 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/sound/tas2562.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Texas Instruments TAS2562 Smart PA
> +
> +maintainers:
> +  - Dan Murphy <dmurphy@ti.com>
> +
> +description: |
> +  The TAS2562 is a mono, digital input Class-D audio amplifier optimized for
> +  efficiently driving high peak power into small loudspeakers.
> +  Integrated speaker voltage and current sense provides for
> +  real time monitoring of loudspeaker behavior.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tas2562
> +      - ti,tas2563
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +       I2C address of the device can be one of these 0x4c, 0x4d, 0x4e or 0x4f
> +
> +  shut-down-gpios:
> +    description: GPIO used to control the state of the device.
> +    deprecated: true

I think you should just remove this given it never worked with any 
released kernel. Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +
> +  shutdown-gpios:
> +    description: GPIO used to control the state of the device.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,imon-slot-no:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: TDM TX current sense time slot.
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +   #include <dt-bindings/gpio/gpio.h>
> +   i2c0 {
> +     #address-cells = <1>;
> +     #size-cells = <0>;
> +     codec: codec@4c {
> +       compatible = "ti,tas2562";
> +       reg = <0x4c>;
> +       #sound-dai-cells = <1>;
> +       interrupt-parent = <&gpio1>;
> +       interrupts = <14>;
> +       shutdown-gpios = <&gpio1 15 0>;
> +       ti,imon-slot-no = <0>;
> +     };
> +   };
> +
> -- 
> 2.27.0
> 
