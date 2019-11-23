Return-Path: <SRS0=uL/f=ZP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66066C432C0
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Nov 2019 00:10:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD25020714
	for <alsa-devel@archiver.kernel.org>; Sat, 23 Nov 2019 00:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kjWoLeqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD25020714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0A479184A;
	Sat, 23 Nov 2019 01:09:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0A479184A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1574467833;
	bh=Io0z6mS78vLpScCZxasqyiVce+QZ9uxrpGHID+uPxJE=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kjWoLeqQIBegGeVXrQnxJQSckJO9SlMaPmeo9qLJ55EWXrTnJjkQwTWRUYVTyOJvz
	 Xzfh9l4De5b/C1R4TawieG5fZxAXEVtxoAktRH22IDqFjz9qdugQfkwyWJlyKAU3X3
	 MiUYnmToCaaIFlWK9Htr4srTRHlXT6vOrUU3Rc74=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C0C2F8013F;
	Sat, 23 Nov 2019 01:09:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CFA71F80140; Sat, 23 Nov 2019 01:09:40 +0100 (CET)
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C985F800F0
 for <alsa-devel@alsa-project.org>; Sat, 23 Nov 2019 01:09:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C985F800F0
Received: by mail-ot1-f68.google.com with SMTP id 94so7728741oty.8
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2019 16:09:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=CGWjpDGzyUOYwEt0Dc6PSe57AXzajvuc/FnHMXylxJ4=;
 b=jYfWIGBh5lft9ZvD+3sxLWLd7Z4l1WGeYa86XcUTSLzpA9QMUtIJgK39gIi/74RANQ
 QOHXgcYa5vuFGaqzA9hoJug0IL0NnmBpQPuaS9pFVRMMjGGl07de2D966T3PGfWd0rxj
 K5OHii1tFB+KMWpm4FnbwWprC3QV91GeRXvBpgRG1byPs8lEmS3ua+e0yfu57bTjbtbL
 7BcVduhsWOJWdfmOicjvYlLjqxzY3MNhb3p0zq2Eb3TPKa+6fdgfmocVwQYYiNTgUQWk
 NRM7/skBUbhcpiUctMdN+efZ9jGwEYITbfxubBbJ8voriGUOkSTqY8h9cwMNWCMReZOt
 3Zxw==
X-Gm-Message-State: APjAAAWXeGwVdQZMtvzHITWDCC2YD/FI7YdG3hrrq5tTdMdM78jES+Ne
 b99XeB9ufNqytBsujG4SVA==
X-Google-Smtp-Source: APXvYqwG0ZCNJRh0x4/KDrbttT0DNuGmTMw67FdWOi3jmALsWc6tyN7zUAKOMHcy6+7bvS+PY3CObg==
X-Received: by 2002:a05:6830:1b65:: with SMTP id
 d5mr12220774ote.122.1574467775783; 
 Fri, 22 Nov 2019 16:09:35 -0800 (PST)
Received: from localhost ([2607:fb90:bd7:3743:c9ec:246b:67b7:9768])
 by smtp.gmail.com with ESMTPSA id l18sm2725815oti.11.2019.11.22.16.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Nov 2019 16:09:35 -0800 (PST)
Date: Fri, 22 Nov 2019 18:09:33 -0600
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <20191123000933.GA30441@bogus>
References: <20191121170509.10579-1-srinivas.kandagatla@linaro.org>
 <20191121170509.10579-3-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191121170509.10579-3-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 bgoswami@codeaurora.org, vinod.koul@linaro.org, linus.walleij@linaro.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, broonie@kernel.org,
 lee.jones@linaro.org, spapothi@codeaurora.org
Subject: Re: [alsa-devel] [PATCH v4 02/12] ASoC: dt-bindings: add dt
 bindings for WCD9340/WCD9341 audio codec
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Thu, Nov 21, 2019 at 05:04:59PM +0000, Srinivas Kandagatla wrote:
> This patch adds bindings for wcd9340/wcd9341 audio codec which can
> support both SLIMbus and I2S/I2C interface.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd934x.yaml          | 163 ++++++++++++++++++
>  1 file changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
> new file mode 100644
> index 000000000000..197a53bfa6cb
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd934x.yaml
> @@ -0,0 +1,163 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,wcd934x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for Qualcomm WCD9340/WCD9341 Audio Codec
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  Qualcomm WCD9340/WCD9341 Codec is a standalone Hi-Fi audio codec IC.
> +  It has in-built Soundwire controller, pin controller, interrupt mux and
> +  supports both I2S/I2C and SLIMbus audio interfaces.
> +
> +properties:
> +  compatible:
> +    const: slim217,250
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO spec for reset line to use
> +    maxItems: 1
> +
> +  slim-ifc-dev: true
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: extclk
> +
> +  vdd-buck-supply:
> +    description: A reference to the 1.8V buck supply
> +
> +  vdd-buck-sido-supply:
> +    description: A reference to the 1.8V SIDO buck supply
> +
> +  vdd-rx-supply:
> +    description: A reference to the 1.8V rx supply
> +
> +  vdd-tx-supply:
> +    description: A reference to the 1.8V tx supply
> +
> +  vdd-vbat-supply:
> +    description: A reference to the vbat supply
> +
> +  vdd-io-supply:
> +    description: A reference to the 1.8V I/O supply
> +
> +  vdd-micbias-supply:
> +    description: A reference to the micbias supply
> +
> +  qcom,micbias1-microvolt:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'

Don't need a type here, standard units already have a type.

> +    description: micbias1 voltage between 1800000 - 2850000 microvolt

Sounds like constraints:

minimum: 1800000
maximum: 2850000


> +
> +  qcom,micbias2-microvolt:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: micbias2 voltage between 1800000 - 2850000 microvolt
> +
> +  qcom,micbias3-microvolt:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: micbias3 voltage between 1800000 - 2850000 microvolt
> +
> +  qcom,micbias4-microvolt:
> +    $ref: '/schemas/types.yaml#/definitions/uint32'
> +    description: micbias4 voltage between 1800000 - 2850000 microvolt
> +
> +  clock-output-names:
> +    const: mclk
> +
> +  clock-frequency:
> +    description: Clock frequency of output clk in Hz
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  '#clock-cells':
> +    const: 0
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 1
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +    description: |
> +      WCD934x subnode for each slave devices. Bindings of each subnodes
> +      depends on the specific driver providing the functionality and
> +      documented in their respective bindings.
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +    required:
> +      - reg
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - slim-ifc-dev
> +  - interrupts
> +  - interrupt-controller
> +  - clock-frequency
> +  - clock-output-names
> +  - qcom,micbias1-microvolt
> +  - qcom,micbias2-microvolt
> +  - qcom,micbias3-microvolt
> +  - qcom,micbias4-microvolt
> +  - "#interrupt-cells"
> +  - "#clock-cells"
> +  - "#sound-dai-cells"
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +examples:
> +  - |
> +    codec@1,0{
> +        compatible = "slim217,250";
> +        reg  = <1 0>;
> +        reset-gpios = <&tlmm 64 0>;
> +        slim-ifc-dev  = <&wcd9340_ifd>;
> +        #sound-dai-cells = <1>;
> +        interrupt-parent = <&tlmm>;
> +        interrupts = <54 4>;
> +        interrupt-controller;
> +        #interrupt-cells = <1>;
> +        #clock-cells = <0>;
> +        clock-frequency = <9600000>;
> +        clock-output-names = "mclk";
> +        qcom,micbias1-microvolt = <1800000>;
> +        qcom,micbias2-microvolt = <1800000>;
> +        qcom,micbias3-microvolt = <1800000>;
> +        qcom,micbias4-microvolt = <1800000>;
> +        clock-names = "extclk";
> +        clocks = <&rpmhcc 2>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +
> +        gpioctrl@42 {
> +            reg = <0x42 0x2>;
> +        };
> +    };
> +
> +...
> -- 
> 2.21.0
> 
_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
