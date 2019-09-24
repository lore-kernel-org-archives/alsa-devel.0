Return-Path: <SRS0=SJ4a=XT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BCBC432C1
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:21:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13F44214DA
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 15:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o+BbNvyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F44214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2F44169F;
	Tue, 24 Sep 2019 17:20:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2F44169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569338486;
	bh=yS11MkR2B0E8l7/1uvgHTZJ3qAKf85UVDjGbap08xGg=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=o+BbNvyqhVQomnuRTuTJsnk3X3VW0JyLVqXsQ0W4VfU/RVUvSxaKpRYDuLOuguOEB
	 DZVI6vOz7YmuXoEtINuOXsAhGtbo1oWwBr2Nm2m/8U/g55TLsJiOfh89W/Fbi8yIze
	 iajXDXj6+bJM7w7PmMLdF5plba06cRvJpHo7uA6Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 572A2F800B4;
	Tue, 24 Sep 2019 17:20:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8213F8045F; Tue, 24 Sep 2019 17:20:34 +0200 (CEST)
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7CFFCF800B4
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2019 17:20:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7CFFCF800B4
Received: by mail-wr1-f67.google.com with SMTP id r3so2414329wrj.6
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2019 08:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BehAsP/zGvLbMGAOB59imbbS81RZk/Eob4lWno5h7ug=;
 b=mP9u6otFmsWizzNzWpsFmgiOWgJGHStHNS25Y+Vu2gmVIj2RIqQuT5qano7Qqkdp+h
 aG7cmlkgJ27TICzrIZd1lM6Ip+rZLYS+giVagfFAqv32ThOgNzZLgoh6YqgCnIOcmRuy
 cf4v5BkyuVtSKC7x3N2EZollxjKrvCdRgmxcHWi/z/qHR8ybewGNTaD90XVWtQi6xpD3
 dqm8bOLFg+x2TkSqPw25ZUXyIAOHZ6PRestU7P2ug9hcd851QV4GmdNkQv08L3yeHZtp
 U9cLeshCkPuli6xhlE2NsVSn4jgNeWx8pCv7g3fKvNcHAPatjybL7tWdRIbRDCFPlK/d
 ZlHA==
X-Gm-Message-State: APjAAAUoYa34j0Aj5YTHmAAJ/hx5rwpCGdB1NqcmKxV0LYRm/LdDHCwz
 R3X7a/QBGYiFRiBLMazCG98=
X-Google-Smtp-Source: APXvYqyy8MgFCfM7xqDj+hRCjQuQBkjKGh9FOEEQ3dNdjyah3yXeSBlkJCLDGZmzRdpOkQ9aU7M2+w==
X-Received: by 2002:adf:db06:: with SMTP id s6mr2848445wri.41.1569338431334;
 Tue, 24 Sep 2019 08:20:31 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
 by smtp.googlemail.com with ESMTPSA id g13sm2674561wrm.42.2019.09.24.08.20.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Sep 2019 08:20:30 -0700 (PDT)
Date: Tue, 24 Sep 2019 17:20:28 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <20190924152028.GD9218@pi3>
References: <CGME20190924150230eucas1p295da8f6aa018aec4acabc068f6e1afa1@eucas1p2.samsung.com>
 <20190924150146.15972-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190924150146.15972-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-samsung-soc@vger.kernel.org,
 Maciej Falkowski <m.falkowski@samsung.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [alsa-devel] [PATCH] dt-bindings: sound: Convert Samsung
 Exynos5433 TM2(E) audio complex with WM5110 codec to dt-schema
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

On Tue, Sep 24, 2019 at 05:01:46PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Convert Samsung Exynos5433 TM2(E) audio complex with WM5110 codec to newer dt-schema format.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/sound/samsung,tm2-audio.txt      | 42 ----------
>  .../bindings/sound/samsung,tm2-audio.yaml     | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
> deleted file mode 100644
> index f5ccc12ddc00..000000000000
> --- a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -Samsung Exynos5433 TM2(E) audio complex with WM5110 codec
> -
> -Required properties:
> -
> - - compatible		 : "samsung,tm2-audio"
> - - model		 : the user-visible name of this sound complex
> - - audio-codec		 : the first entry should be phandle of the wm5110 audio
> -			   codec node, as described in ../mfd/arizona.txt;
> -			   the second entry should be phandle of the HDMI
> -			   transmitter node
> - - i2s-controller	 : the list of phandle and argument tuples pointing to
> -			   I2S controllers, the first entry should be I2S0 and
> -			   the second one I2S1
> - - audio-amplifier	 : the phandle of the MAX98504 amplifier
> - - samsung,audio-routing : a list of the connections between audio components;
> -			   each entry is a pair of strings, the first being the
> -			   connection's sink, the second being the connection's
> -			   source; valid names for sources and sinks are the
> -			   WM5110's and MAX98504's pins and the jacks on the
> -			   board: HP, SPK, Main Mic, Sub Mic, Third Mic,
> -			   Headset Mic
> - - mic-bias-gpios	 : GPIO pin that enables the Main Mic bias regulator
> -
> -
> -Example:
> -
> -sound {
> -	compatible = "samsung,tm2-audio";
> -	audio-codec = <&wm5110>, <&hdmi>;
> -	i2s-controller = <&i2s0 0>, <&i2s1 0>;
> -	audio-amplifier = <&max98504>;
> -	mic-bias-gpios = <&gpr3 2 0>;
> -	model = "wm5110";
> -	samsung,audio-routing =
> -		"HP", "HPOUT1L",
> -		"HP", "HPOUT1R",
> -		"SPK", "SPKOUT",
> -		"SPKOUT", "HPOUT2L",
> -		"SPKOUT", "HPOUT2R",
> -		"Main Mic", "MICBIAS2",
> -		"IN1R", "Main Mic";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml
> new file mode 100644
> index 000000000000..377f8cbe17b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml
> @@ -0,0 +1,83 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/samsung,tm2-audio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos SoC Exynos5433 TM2(E) audio complex with WM5110 codec
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> +
> +properties:
> +  compatible:
> +    const: samsung,tm2-audio
> +
> +  model:
> +    maxItems: 1

$ref to string, then maxItems are not needed.
Add description (copy-paste).

> +
> +  audio-codec:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> +      - items:
> +          - description: |
> +              phandle of the wm5110 audio codec node,
> +              as described in ../mfd/arizona.txt;
> +          - description: phandle of the HDMI transmitter node.
> +
> +  i2s-controller:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> +      - items:
> +          - description: phandle of the I2S0.
> +          - description: phandle of the I2S1.
> +
> +  audio-amplifier:

Can you order the nodes here and in required section by name (except
compatible which should be first)?

Best regards,
Krzysztof

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
