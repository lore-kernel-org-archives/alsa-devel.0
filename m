Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAF2BC25B06
	for <alsa-devel@archiver.kernel.org>; Sun, 14 Aug 2022 21:11:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1CDDB823;
	Sun, 14 Aug 2022 23:10:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1CDDB823
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1660511485;
	bh=rplr3Hsiuahf5fWX8KWx4wK3bLyx7COFvALdsuUcfAw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VARpD1aSNsW5f2JGFkw4MbTc7TQNtYopo1pNqqplUvMQOf2yR0MJZzq67wfzEfYuG
	 GPQpZZZcXn89y0or6ULgObFQUFWF2PFnxlu/VqJ46rY6azvFfTXhG2KkqGrbG4av65
	 ZdUM9QAME31Vcto3WxWLv7eiIQb6AWInoEyE+hNo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8CF07F80245;
	Sun, 14 Aug 2022 23:10:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 240CEF800B8; Sun, 14 Aug 2022 23:10:32 +0200 (CEST)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0722FF800CB
 for <alsa-devel@alsa-project.org>; Sun, 14 Aug 2022 23:10:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0722FF800CB
Received: by mail-oi1-f171.google.com with SMTP id s199so6919019oie.3
 for <alsa-devel@alsa-project.org>; Sun, 14 Aug 2022 14:10:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=NgZLm2cWgYFq+9oanwDv8zaUrcdQCdnFsnMaWhgPe20=;
 b=o5Lf5S/5br5/PXuqQ9Ob2+f7wTSe7wfmO4sialgyGZ5NVDaolGi1LhKnqQsZBExkgL
 +N1wUghp9vwvHA33o1PzzJJw9tkowEN5LyIlDJ+8hGyX+BPhfSpQvVJASXHsXYLQGCgy
 4RJbychxu/bElnKw0db2mWpPZ0jjtz8wxV8Q14tmzd11mQ971PdwHFJSy3heSZqPJM4A
 HcJztbNEMFCrR96WgtWr2sjCDOhJAu4TYngEhteghpXQMSmkxiG/46u4mad5Q69BRjO1
 4pElmONKJ1bvlqnrgDR1uMC5u51TgwnYoFiFlF8I4cRl2ZRHEyKgBCT+jUhwtQOobIEc
 sZCQ==
X-Gm-Message-State: ACgBeo0beeXLT2sOc1w+EsiX0MsUlU58UBQ/yPO/JTJAJhZVwWXBSrKT
 bmi9aOj5KkoFPgNEslvTDA==
X-Google-Smtp-Source: AA6agR5MTEa1TMRTzJKx2Kru9JKl91A72OXDu1QQBPhfyNV94oMqdRGcpcBZHYhlMtdRXgP+tIAGlg==
X-Received: by 2002:a05:6808:118e:b0:337:b6f3:67ca with SMTP id
 j14-20020a056808118e00b00337b6f367camr5544667oil.111.1660511419988; 
 Sun, 14 Aug 2022 14:10:19 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.176.57])
 by smtp.gmail.com with ESMTPSA id
 19-20020aca0d13000000b0033ad6ea8d11sm1492702oin.47.2022.08.14.14.10.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Aug 2022 14:10:19 -0700 (PDT)
Received: (nullmailer pid 715238 invoked by uid 1000);
 Sun, 14 Aug 2022 21:10:15 -0000
Date: Sun, 14 Aug 2022 15:10:15 -0600
From: Rob Herring <robh@kernel.org>
To: Matt Flax <flatmax@flatmax.com>
Subject: Re: [PATCH v2] ASoC: codecs: dt bind. doc for the new TI SRC4392 codec
Message-ID: <20220814211015.GA712258-robh@kernel.org>
References: <20220810221232.1596488-1-flatmax@flatmax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220810221232.1596488-1-flatmax@flatmax.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, broonie@kernel.org
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

On Thu, Aug 11, 2022 at 08:12:32AM +1000, Matt Flax wrote:
> Signed-off-by: Matt Flax <flatmax@flatmax.com>
> ---
> 
> Notes:
>     v2:
>     * Added myself as the maintainer
> 
>  .../devicetree/bindings/sound/src4xxx.yaml    | 50 +++++++++++++++++++

ti,src4xxx.yaml

>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/src4xxx.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/src4xxx.yaml b/Documentation/devicetree/bindings/sound/src4xxx.yaml
> new file mode 100644
> index 000000000000..368bb4ba1a77
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/src4xxx.yaml
> @@ -0,0 +1,50 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings. (GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/src4xxx.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Texas Instruments SRC4392 Device Tree Bindings
> +
> +description: |
> +  The SRC4392 is a digital audio codec that can be connected via
> +  I2C or SPI. Currently, only I2C bus is supported.
> +
> +maintainers:
> +  - Matt Flax <flatmax@flatmax.com>
> +
> +allOf:
> +  - $ref: name-prefix.yaml#
> +
> +properties:
> +  compatible:
> +    const: ti,src4392
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  reg:
> +    description:
> +      The I2C address of the device

No need for generic descriptions.

> +    maxItems: 1
> +
> +required:
> +  - "#sound-dai-cells"
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        src4392@70 {

audio-codec@70

> +            #sound-dai-cells = <0>;
> +            compatible = "ti,src4392";
> +            reg = <0x70>;
> +        };
> +    };
> +...
> -- 
> 2.34.1
> 
> 
