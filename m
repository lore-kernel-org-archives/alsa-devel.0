Return-Path: <SRS0=yO1c=XV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 463B1C4360C
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Sep 2019 13:51:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 436DF21A4A
	for <alsa-devel@archiver.kernel.org>; Thu, 26 Sep 2019 13:51:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dnTpVPun"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 436DF21A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E32331745;
	Thu, 26 Sep 2019 15:50:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E32331745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569505880;
	bh=EV6Rwd4iKSXKWdxp7qSfCZat5hs4kREM2dGQlVf6qDw=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=dnTpVPuneWEUAAURSWlHaj3Th5sa9rTl0tLtb5dYyd2ZSJJZWo24jFtkhS+j6Lq4g
	 SuKcMiTmFAjUu6VrXBSadWaOXAPXwuH92HNSmuKUS0965iOrg0q2SOkwfgTj7jdDBG
	 9XAjN9Og4W4/XhzZ/tXjbxnku7BrqVdlRvf+qNs4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B882F80213;
	Thu, 26 Sep 2019 15:50:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 874CEF803F4; Thu, 26 Sep 2019 15:50:27 +0200 (CEST)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BA2DFF80213
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2019 15:50:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BA2DFF80213
Received: by mail-wm1-f67.google.com with SMTP id v17so2657370wml.4
 for <alsa-devel@alsa-project.org>; Thu, 26 Sep 2019 06:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=D/8T5m7hbGHRf18FTM0IPCMPxpbgEnnIkFO3iBtgMoI=;
 b=PFj5VyKEtykcf3W1zRSl79n9+ubGYwKs0lSyPYawgh1LCefE6aCnehIk/5P327u+1w
 sVY54DC+CfcnH7eMmirQ2ppab4LD8ZQKnYtBOS1A0Ynk53CoRkAb8dY+MrLfWfr+wL4A
 +XX/Qh7yVbkUcPDezvba9w0GuJA+q1dv6xuFCxtdAjWJX0RCY9o+re4ovoy6hmNI56fR
 5IBJakseRKwwxgOzyANzfm2bX6g6/Fo2aeQEpFXp+QgYIGjWCKpVcdC+PiCbUR5aSFqT
 GTe2mUo64lAaCKGutI/o9YN8ofdaQs57yPzkFHtC044KZVrsOKpwkmUMo+Rvw1br8Nox
 B6cw==
X-Gm-Message-State: APjAAAX9tKPijbzNsLcMzy8pXyE+ONY8e7SYV5SaFhL8sQ2f8kw5Dcl/
 ZCYfxdg0+YIRGF+LxU2leQA=
X-Google-Smtp-Source: APXvYqzdU1cIa3FD+JAPYVAaH707n4teHQKT/IIvZ7iBM1sXGF77mTWqzqflvK9u9d6gvprBoDLiEg==
X-Received: by 2002:a7b:c949:: with SMTP id i9mr2903344wml.136.1569505823617; 
 Thu, 26 Sep 2019 06:50:23 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
 by smtp.googlemail.com with ESMTPSA id l9sm2945985wme.45.2019.09.26.06.50.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 06:50:22 -0700 (PDT)
Date: Thu, 26 Sep 2019 15:50:20 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <20190926135020.GB15876@pi3>
References: <CGME20190926120115eucas1p20280a4e50c826d43bea7bfe5d670aebe@eucas1p2.samsung.com>
 <20190926120111.8478-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190926120111.8478-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 Maciej Falkowski <m.falkowski@samsung.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [PATCH] dt-bindings: sound: Convert Samsung Exynos
 Odroid XU3/XU4 audio complex to dt-schema
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

On Thu, Sep 26, 2019 at 02:01:11PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Convert Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
> to newer dt-schema format.
> 
> 'clocks' property is unneeded in the bindings and is left undefined in 'properties'.
> 
> 'samsung,audio-widgets' and 'samsung,audio-routing' are optional from driver
> perspective and they are set as unrequired.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/sound/samsung,odroid.txt         | 54 -----------
>  .../bindings/sound/samsung,odroid.yaml        | 91 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/samsung,odroid.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,odroid.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.txt b/Documentation/devicetree/bindings/sound/samsung,odroid.txt
> deleted file mode 100644
> index e9da2200e173..000000000000
> --- a/Documentation/devicetree/bindings/sound/samsung,odroid.txt
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
> -
> -Required properties:
> -
> - - compatible - "hardkernel,odroid-xu3-audio" - for Odroid XU3 board,
> -		"hardkernel,odroid-xu4-audio" - for Odroid XU4 board (deprecated),
> -		"samsung,odroid-xu3-audio" - for Odroid XU3 board (deprecated),
> -		"samsung,odroid-xu4-audio" - for Odroid XU4 board (deprecated)
> - - model - the user-visible name of this sound complex
> - - clocks - should contain entries matching clock names in the clock-names
> -    property
> - - samsung,audio-widgets - this property specifies off-codec audio elements
> -   like headphones or speakers, for details see widgets.txt
> - - samsung,audio-routing - a list of the connections between audio
> -   components;  each entry is a pair of strings, the first being the
> -   connection's sink, the second being the connection's source;
> -   valid names for sources and sinks are the MAX98090's pins (as
> -   documented in its binding), and the jacks on the board
> -
> -   For Odroid X2:
> -     "Headphone Jack", "Mic Jack", "DMIC"
> -
> -   For Odroid U3, XU3:
> -     "Headphone Jack", "Speakers"
> -
> -   For Odroid XU4:
> -     no entries
> -
> -Required sub-nodes:
> -
> - - 'cpu' subnode with a 'sound-dai' property containing the phandle of the I2S
> -    controller
> - - 'codec' subnode with a 'sound-dai' property containing list of phandles
> -    to the CODEC nodes, first entry must be corresponding to the MAX98090
> -    CODEC and the second entry must be the phandle of the HDMI IP block node
> -
> -Example:
> -
> -sound {
> -	compatible = "hardkernel,odroid-xu3-audio";
> -	model = "Odroid-XU3";
> -	samsung,audio-routing =
> -		"Headphone Jack", "HPL",
> -		"Headphone Jack", "HPR",
> -		"IN1", "Mic Jack",
> -		"Mic Jack", "MICBIAS";
> -
> -	cpu {
> -		sound-dai = <&i2s0 0>;
> -	};
> -	codec {
> -		sound-dai = <&hdmi>, <&max98090>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
> new file mode 100644
> index 000000000000..db6d3ea3180e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/samsung,odroid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: hardkernel,odroid-xu3-audio
> +
> +      - const: hardkernel,odroid-xu4-audio
> +        deprecated: true
> +
> +      - const: samsung,odroid-xu3-audio
> +        deprecated: true
> +
> +      - const: samsung,odroid-xu4-audio
> +        deprecated: true
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: The user-visible name of this sound complex.
> +
> +  cpu:

Continuing discussion from TM2 audio, these are not standard properties,
so they can be in some reasonable order. Ordering might not only bring
readability but also solve conflicts of simultaneous edits.  The same in
"required" section (except compatible).

> +    type: object
> +    properties:
> +      sound-dai:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        description: phandles to the I2S controllers
> +
> +  codec:
> +    type: object
> +    properties:
> +      sound-dai:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        description: |
> +          List of phandles to the CODEC nodes,
> +          first entry must be corresponding to the MAX98090 CODEC and
> +          the second entry must be the phandle of the HDMI IP block node.
> +
> +  samsung,audio-widgets:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description: |
> +      This property specifies off-codec audio elements
> +      like headphones or speakers, for details see widgets.txt
> +
> +  samsung,audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description: |
> +      List of the connections between audio

Too early word wrap.

Rest looks good to me, so with the changes:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
