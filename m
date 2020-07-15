Return-Path: <SRS0=Rw3p=A2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADC4BC433E4
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:13:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5CD2064B
	for <alsa-devel@archiver.kernel.org>; Wed, 15 Jul 2020 18:13:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dQ5ItKyX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5CD2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 823FA15E5;
	Wed, 15 Jul 2020 20:13:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 823FA15E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594836832;
	bh=fcQDgyyGhKHA92TYesU44H0lTyF4CEkwxG576vw2ga8=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dQ5ItKyXT9VKY73Pc6SMcbf+fh+uzIliC6ssi+YWt1dww+IyF3TkM9ASRmbWO3EN5
	 MHMROjkh+u2g6S4XY6rClRaFfeA2jE/JND8B9UaRQVafKmjEzSRagLVmohfANE8hgd
	 RvCp6i6oWP4XEuHpihLDDWkJGR2UWunZrA+mTH9I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1CDDAF80217;
	Wed, 15 Jul 2020 20:13:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87BB7F8021D; Wed, 15 Jul 2020 20:13:00 +0200 (CEST)
Received: from mail-io1-f68.google.com (mail-io1-f68.google.com
 [209.85.166.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D7C6F800E8
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 20:12:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D7C6F800E8
Received: by mail-io1-f68.google.com with SMTP id q74so3282505iod.1
 for <alsa-devel@alsa-project.org>; Wed, 15 Jul 2020 11:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=U4JqWAJUqAlytAcvwdFiI+dvQqxz5t1soB/hFAm5OjQ=;
 b=UjmWOZY7E/3P+6BIPpkah4DMB+FmwxHo+jbOqO3/+sEpLQCREomOYwFDVey6bs66tU
 zN5ODPfxZp34uI4radpOmkHXamjp6ppJakKQE16tsE8oHRxjIPvjTuSSrG6BjYAdjAT8
 95Lbd1e3NUUG4UhTOJl09pn1pqzLi4Rf4SWXw2kMLcunFFpfPAFsYysP2W7wXvy0v3Ca
 KEncmnuaYHTixWyOrrOhd3mg/akiVNxptElIwqIR/8rrzaNku6+Bvds+4c0oc+ikE0PY
 /edVDA0Y4brRw+6u+atz6o++tJPKLdgDoi68JEUD7TGkKEWG8tAEvm8suEibZXE0tr5r
 AkEA==
X-Gm-Message-State: AOAM531ZmLopH8fOvNHQT+T0fM3/I4qwkzWG8Lah2Re9aR83Yx0H4320
 zIPE6M1IxxsuZQ+JXfvrFA==
X-Google-Smtp-Source: ABdhPJxxgQ53vC9zVBi4XB7WdDH+bHdKBpexEFln2Bz9WLXLPsN+v2YsSm0PlI2wwA+pwM3cWthaUg==
X-Received: by 2002:a5d:9c0e:: with SMTP id 14mr519954ioe.109.1594836768497;
 Wed, 15 Jul 2020 11:12:48 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id k3sm1414030ils.8.2020.07.15.11.12.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 11:12:47 -0700 (PDT)
Received: (nullmailer pid 545010 invoked by uid 1000);
 Wed, 15 Jul 2020 18:12:47 -0000
Date: Wed, 15 Jul 2020 12:12:47 -0600
From: Rob Herring <robh@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: tas2770: Convert tas2770 binding to yaml
Message-ID: <20200715181247.GA535887@bogus>
References: <20200612171342.25364-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612171342.25364-1-dmurphy@ti.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, tiwai@suse.com, lgirdwood@gmail.com,
 broonie@kernel.org, shifu0704@thundersoft.com
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

On Fri, Jun 12, 2020 at 12:13:41PM -0500, Dan Murphy wrote:
> Convert the tas2770 binding to yaml format.
> Add in the reset-gpio to the binding as it is in the code but not
> documented in the binding.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  .../devicetree/bindings/sound/tas2770.txt     | 37 ---------
>  .../devicetree/bindings/sound/tas2770.yaml    | 76 +++++++++++++++++++
>  2 files changed, 76 insertions(+), 37 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/tas2770.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/tas2770.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/tas2770.txt b/Documentation/devicetree/bindings/sound/tas2770.txt
> deleted file mode 100644
> index ede6bb3d9637..000000000000
> --- a/Documentation/devicetree/bindings/sound/tas2770.txt
> +++ /dev/null
> @@ -1,37 +0,0 @@
> -Texas Instruments TAS2770 Smart PA
> -
> -The TAS2770 is a mono, digital input Class-D audio amplifier optimized for
> -efficiently driving high peak power into small loudspeakers.
> -Integrated speaker voltage and current sense provides for
> -real time monitoring of loudspeaker behavior.
> -
> -Required properties:
> -
> - - compatible:	   - Should contain "ti,tas2770".
> - - reg:		       - The i2c address. Should contain <0x4c>, <0x4d>,<0x4e>, or <0x4f>.
> - - #address-cells  - Should be <1>.
> - - #size-cells     - Should be <0>.
> - - ti,asi-format:  - Sets TDM RX capture edge. 0->Rising; 1->Falling.
> - - ti,imon-slot-no:- TDM TX current sense time slot.
> - - ti,vmon-slot-no:- TDM TX voltage sense time slot.
> -
> -Optional properties:
> -
> -- interrupt-parent: the phandle to the interrupt controller which provides
> -                     the interrupt.
> -- interrupts: interrupt specification for data-ready.
> -
> -Examples:
> -
> -    tas2770@4c {
> -                compatible = "ti,tas2770";
> -                reg = <0x4c>;
> -                #address-cells = <1>;
> -                #size-cells = <0>;
> -                interrupt-parent = <&msm_gpio>;
> -                interrupts = <97 0>;
> -                ti,asi-format = <0>;
> -                ti,imon-slot-no = <0>;
> -                ti,vmon-slot-no = <2>;
> -        };
> -
> diff --git a/Documentation/devicetree/bindings/sound/tas2770.yaml b/Documentation/devicetree/bindings/sound/tas2770.yaml
> new file mode 100644
> index 000000000000..8c667fd37a57
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/tas2770.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)

Do you have rights to relicense? The old binding defaults to 
GPL-2.0-only. If so, great.

Either way, GPL-2.0-only not GPL-2.0+.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +# Copyright (C) 2019-20 Texas Instruments Incorporated
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/sound/tas2770.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Texas Instruments TAS2770 Smart PA
> +
> +maintainers:
> +  - Shi Fu <shifu0704@thundersoft.com>
> +
> +description: |
> +  The TAS2770 is a mono, digital input Class-D audio amplifier optimized for
> +  efficiently driving high peak power into small loudspeakers.
> +  Integrated speaker voltage and current sense provides for
> +  real time monitoring of loudspeaker behavior.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - ti,tas2770
> +
> +  reg:
> +    maxItems: 1
> +    description: |
> +       I2C address of the device can be one of these 0x4c, 0x4d, 0x4e or 0x4f
> +
> +  reset-gpio:
> +    description: GPIO used to reset the device.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  ti,imon-slot-no:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: TDM TX current sense time slot.
> +
> +  ti,vmon-slot-no:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: TDM TX voltage sense time slot.
> +
> +  ti,asi-format:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: Sets TDM RX capture edge.
> +    enum:
> +          - 0 # Rising edge
> +          - 1 # Falling edge
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
> +       compatible = "ti,tas2770";
> +       reg = <0x4c>;
> +       #sound-dai-cells = <1>;
> +       interrupt-parent = <&gpio1>;
> +       interrupts = <14>;
> +       reset-gpio = <&gpio1 15 0>;
> +       ti,imon-slot-no = <0>;
> +       ti,vmon-slot-no = <2>;
> +     };
> +   };
> +
> -- 
> 2.26.2
> 
