Return-Path: <SRS0=FemE=DN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10BFC4363D
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 20:44:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F63920866
	for <alsa-devel@archiver.kernel.org>; Tue,  6 Oct 2020 20:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Cti1yV2+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F63920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C84EA16D6;
	Tue,  6 Oct 2020 22:43:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C84EA16D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1602017085;
	bh=20Ppm3eXqL31Dyc98b9cqyG6F2Kb9nNC7ZM9dhbQrdM=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Cti1yV2+0crWNKtE2B1QXGyxXMHsGaRy6vBnxdwn715tV6O363t6EejzG6ne4GkeV
	 FF0nTphw+ReehovZK5BAHGP6A4UhgXT8eE1tPfwCmEUO1H8q2F2M7Idew03WzG4zMH
	 8Vv9ysSp6n1dHyPykwgiG9utDyX1oGSS50uo4f80=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 54D59F80129;
	Tue,  6 Oct 2020 22:43:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8B0DCF8012A; Tue,  6 Oct 2020 22:43:54 +0200 (CEST)
Received: from mail-ot1-f65.google.com (mail-ot1-f65.google.com
 [209.85.210.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60E9BF80127
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2020 22:43:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60E9BF80127
Received: by mail-ot1-f65.google.com with SMTP id o8so108798otl.4
 for <alsa-devel@alsa-project.org>; Tue, 06 Oct 2020 13:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4LMhyTOT+VAAaRU5CJODNmpQONO/RSgV3tZAx3nzv1s=;
 b=p+26tsGe6AK46+3gP+bNCH2I+NKuzrCE3fgzFiyT/vikVBfolsUZtVH1KXYrsDDQyq
 +eFUgYRO8NwzIojQbuxFqgUtggfD39qL2HOgy7aiEL0rInfFfk6reANEaUZgzyhMDWWr
 99MLOovBARb9ZvbEhN4BA4Vx6kRM1m+hY7nb6cK8tq/htyjxDiWqtE8BkQDxIFL1cOXL
 nmlAPIiqtAnT0aIJG5fWEXJmLYHG3f9GNJDWuII1yILtESTR1anKInXWiuyBKz0CISJu
 xsWoZaEd/j85Mf37eKdCcDzfoz4jDb6SATQdbev/r4Tm5NQtIo7TVMZY749J94qGoXnK
 gdBw==
X-Gm-Message-State: AOAM532NXRQKm2YAZFiW+kI3YP5YshEmrWZopx68zzhqFnmfdcEKCSS6
 j5dYwj0bSoOTWpzSF5r2NQ==
X-Google-Smtp-Source: ABdhPJxcFTHl/Zxl9qzw0vdVU0w3yDGzsHIJvGPcCAWCrYTm8MbmtyeEQMqz1oTH2yBnSUGZBdrqmA==
X-Received: by 2002:a05:6830:1be2:: with SMTP id
 k2mr675329otb.70.1602017026150; 
 Tue, 06 Oct 2020 13:43:46 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id o205sm1822353oig.8.2020.10.06.13.43.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 13:43:45 -0700 (PDT)
Received: (nullmailer pid 2804669 invoked by uid 1000);
 Tue, 06 Oct 2020 20:43:44 -0000
Date: Tue, 6 Oct 2020 15:43:44 -0500
From: Rob Herring <robh@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH 5/5] dt-bindings: mediatek: mt8192: add
 mt8192-mt6358-rt1015-rt5682 document
Message-ID: <20201006204344.GA2791644@bogus>
References: <1601624142-18991-1-git-send-email-jiaxin.yu@mediatek.com>
 <1601624142-18991-6-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601624142-18991-6-git-send-email-jiaxin.yu@mediatek.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, shane.chien@mediatek.com, tiwai@suse.com,
 maowenan@huawei.com, tzungbi@google.com, broonie@kernel.org,
 linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org
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

On Fri, Oct 02, 2020 at 03:35:42PM +0800, Jiaxin Yu wrote:
> This patch adds document for the machine board with mt6358, rt1015 and rt5682.
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  .../sound/mt8192-mt6359-rt1015-rt5682.yaml    | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
> new file mode 100644
> index 0000000000000..dff5004cd0368
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
> @@ -0,0 +1,44 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mt8192-mt6359-rt1015-rt5682.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek MT8192 with MT6359, RT1015 and RT5682 ASoC sound card driver
> +
> +maintainers:
> +   - Jiaxin Yu <jiaxin.yu@mediatek.com>
> +   - Shane Chien <shane.chien@mediatek.com>
> +
> +description:
> +  This binding describes the MT8192 sound card.
> +
> +properties:
> +  compatible:
> +    contains:

Drop this. Other strings shouldn't be allowed.

> +      const: mediatek,mt8192_mt6359_rt1015_rt5682

Just a list of part numbers? A different codec would be a different 
compatible and driver? You should have a link to the codec and you can 
read it's compatible to get what codec you have.

> +
> +  mediatek,platform:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    description: |
> +     The DT/OF node which is used to specify the link's platform driver.

What's "link's platform driver"? A DT doesn't have drivers.

> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - mediatek,platform
> +
> +examples:
> +  - |
> +
> +    sound: mt8192-sound {
> +        compatible = "mediatek,mt8192-mt6359-rt1015-rt5682";
> +        mediatek,platform = <&afe>;
> +        pinctrl-names = "aud_clk_mosi_off",
> +                        "aud_clk_mosi_on";
> +        pinctrl-0 = <&aud_clk_mosi_off>;
> +        pinctrl-1 = <&aud_clk_mosi_on>;
> +    };
> +
> +...
> -- 
> 2.18.0
