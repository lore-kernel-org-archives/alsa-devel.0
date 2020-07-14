Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CEB5C433E0
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 02:44:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C258208FE
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 02:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xywr+b8S"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C258208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 808A815F2;
	Tue, 14 Jul 2020 04:43:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 808A815F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594694649;
	bh=1+M10Jin3eQBE5PZKLsX668YHN2e/FUp1Sbk0u+78Oo=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xywr+b8SanswR21QmvYA62Mci0jqGq4jVBFaXZSHXqU/RvaXtKgOrQnqnacBcHUxP
	 yq+BjGfyhDkWrCrhw0aJPuJizVN4dHGKINBFIL4HBqCy+dw+abjBYmdCcjnzeaQ+Xe
	 5Ih7t0bfRDEkoIVadLvorXhemnUevnHVvDEwOCn4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0793DF8016F;
	Tue, 14 Jul 2020 04:43:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F3E6F8019B; Tue, 14 Jul 2020 04:43:17 +0200 (CEST)
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9AE66F800E5
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 04:43:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9AE66F800E5
Received: by mail-il1-f194.google.com with SMTP id h16so12973982ilj.11
 for <alsa-devel@alsa-project.org>; Mon, 13 Jul 2020 19:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xqtDm2mhhrQr4POykVjXpWXd6bdcMg+HFqdOsT5mp4s=;
 b=F2ZHPbuH253p0ifTpHa0WnSw2ShFXSopfD0bXR7mO7iz9Hiz642c/ID2aDXyWjm4BH
 xWrF1HP3IXOXMXeANu1k1PoA7GTRPXLRKJ6uXx+q3NY16kwWjAkrz1eSdklRG5ULirrU
 gtxLxsxnYvOhpfZZ8KiIWgX3K979RIEnzK5yfTGlemkVjPaeCBS5HAkY8faFBm+7RUpd
 D43RbW7k2LvFlUpGSHZ/A8v30Z7T/5+tNTh4TxVjQij4msk9h99NxcJJNNRoh0Px4zP7
 HuhEil5ZUWYKD0u4/cCBrW0QFwvPNHdQt9q9jQKxL6uzf9lVrPBnHlR5j0/Jlu0l7Wzb
 44xA==
X-Gm-Message-State: AOAM533NJncIecSiQuj33Ua3QyWwIYGcVi34bwzqENDAiVIcNUYO20QL
 cQgLmQlVu2zgvibEhYW59w==
X-Google-Smtp-Source: ABdhPJwP7oyW5vo0EP1nShAgwRfmyppCEeoygTDpvF7Z3GyAh6grDk8GD7NYUcoOANS6Zg6ngUJgQg==
X-Received: by 2002:a92:4856:: with SMTP id v83mr2661419ila.125.1594694588463; 
 Mon, 13 Jul 2020 19:43:08 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id e1sm9272037ilr.23.2020.07.13.19.43.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2020 19:43:07 -0700 (PDT)
Received: (nullmailer pid 1178708 invoked by uid 1000);
 Tue, 14 Jul 2020 02:43:07 -0000
Date: Mon, 13 Jul 2020 20:43:07 -0600
From: Rob Herring <robh@kernel.org>
To: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Re: [PATCH v2] dt-bindings: sound: convert rk3328 codec binding to
 yaml
Message-ID: <20200714024307.GA1175068@bogus>
References: <20200630135412.718447-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200630135412.718447-1-katsuhiro@katsuster.net>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Heiko Stuebner <heiko@sntech.de>, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
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

On Tue, Jun 30, 2020 at 10:54:12PM +0900, Katsuhiro Suzuki wrote:
> This patch converts Rockchip rk3328 audio codec binding to DT schema.
> And adds description about "mclk" clock and fixes some errors in
> original example.
> 
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  .../bindings/sound/rockchip,rk3328-codec.txt  | 28 --------
>  .../bindings/sound/rockchip,rk3328-codec.yaml | 70 +++++++++++++++++++
>  2 files changed, 70 insertions(+), 28 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.yaml

Need to Cc Mark Brown...

> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.txt b/Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.txt
> deleted file mode 100644
> index 1ecd75d2032a..000000000000
> --- a/Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.txt
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -* Rockchip Rk3328 internal codec
> -
> -Required properties:
> -
> -- compatible: "rockchip,rk3328-codec"
> -- reg: physical base address of the controller and length of memory mapped
> -  region.
> -- rockchip,grf: the phandle of the syscon node for GRF register.
> -- clocks: a list of phandle + clock-specifer pairs, one for each entry in clock-names.
> -- clock-names: should be "pclk".
> -- spk-depop-time-ms: speak depop time msec.
> -
> -Optional properties:
> -
> -- mute-gpios: GPIO specifier for external line driver control (typically the
> -              dedicated GPIO_MUTE pin)
> -
> -Example for rk3328 internal codec:
> -
> -codec: codec@ff410000 {
> -	compatible = "rockchip,rk3328-codec";
> -	reg = <0x0 0xff410000 0x0 0x1000>;
> -	rockchip,grf = <&grf>;
> -	clocks = <&cru PCLK_ACODEC>;
> -	clock-names = "pclk";
> -	mute-gpios = <&grf_gpio 0 GPIO_ACTIVE_LOW>;
> -	spk-depop-time-ms = 100;
> -};
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.yaml b/Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.yaml
> new file mode 100644
> index 000000000000..525b48c2f5de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rockchip,rk3328-codec.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/rockchip,rk3328-codec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip rk3328 internal codec
> +
> +maintainers:
> +  - Heiko Stuebner <heiko@sntech.de>
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3328-codec
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: clock for audio codec
> +      - description: clock for I2S master clock
> +
> +  clock-names:
> +    items:
> +      - const: pclk
> +      - const: mclk
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      The phandle of the syscon node for the GRF register.
> +
> +  spk-depop-time-ms:
> +    $ref: /schemas/types.yaml#/definitions/uint32

Don't need a type with standard unit suffixes.

> +    default: 200

Is there a range of values? Surely 2^32 would be too long.

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>

> +    description:
> +      Speaker depop time in msec.
> +
> +  mute-gpios:
> +    maxItems: 1
> +    description:
> +      GPIO specifier for external line driver control (typically the
> +      dedicated GPIO_MUTE pin)
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - rockchip,grf
> +  - "#sound-dai-cells"
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/clock/rk3328-cru.h>
> +    codec: codec@ff410000 {
> +      compatible = "rockchip,rk3328-codec";
> +      reg = <0xff410000 0x1000>;
> +      clocks = <&cru PCLK_ACODECPHY>, <&cru SCLK_I2S1>;
> +      clock-names = "pclk", "mclk";
> +      rockchip,grf = <&grf>;
> +      mute-gpios = <&grf_gpio 0 GPIO_ACTIVE_LOW>;
> +      spk-depop-time-ms = <100>;
> +      #sound-dai-cells = <0>;
> +    };
> -- 
> 2.27.0
> 
