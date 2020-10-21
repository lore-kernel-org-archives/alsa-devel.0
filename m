Return-Path: <SRS0=H+KG=D4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE532C388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:54:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9795422283
	for <alsa-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MAisKctN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9795422283
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E7537174E;
	Wed, 21 Oct 2020 16:53:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E7537174E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1603292038;
	bh=pDjcVOVNZI0Bcu13bVSQg5DyZURCJnf7t4klLXw/FgA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MAisKctNKy/yRTFm6lhOa/Fxt00N+M51XwJMKiFHQfEsdNTjNGuA0MYhSIKkfzUBF
	 VegYfVg0XjT+rTN6V7wCCIs1qSvSl37DaCUGMaGU4Qrj8BKyPsX23K9ARhzpb6hzBV
	 T87JtfbP+sYVvjxBbTAq5x5F608O4D1ryRQoEaOc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70DFFF80253;
	Wed, 21 Oct 2020 16:53:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 07C60F80264; Wed, 21 Oct 2020 16:53:06 +0200 (CEST)
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com
 [209.85.161.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E6E70F80247
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2020 16:52:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6E70F80247
Received: by mail-oo1-f66.google.com with SMTP id v123so606185ooa.5
 for <alsa-devel@alsa-project.org>; Wed, 21 Oct 2020 07:52:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=99z2vGoCi1tpnvfGwZuqAszQUrFfL3I1H9eFr7nC/HY=;
 b=nGFtqaVh7vtOdSIcEERIYeUIFkYsKghCd3VNetfm4w4jc9pAAc61D8EVx2BKbsX19r
 wBKjro4abHOu61CiXfjF9XRF7NfDzUGm3EFbZI3XkcyB7d9i3GW+UVMu7AD8wSy3zHtU
 qzp1/6TElIEh5z860yHO7Q83TxUPQ9YGA1fLF7/BDVM+7kS07ewb74nRHYuUmC6ZTlK0
 YaiXSepDGUnwuUidOOJuo76PQYBhs8MRIaas7aCgK+Z0XiFnBWH6T4cUdn6jVdqWkena
 CxIfctGFnzsaPbZhjNuiV9hY/B5dqQa4xtJab1FOeoDL+0rJkRz7k4bJf0ZFXjAUqrWb
 nyaA==
X-Gm-Message-State: AOAM533p6BfS9aL8Vo6FPyddl5VsPxkbJtZA4YRjgFGilWKMZDaDNeKK
 uX/91fNYaOWZ7wVHBumSQQ==
X-Google-Smtp-Source: ABdhPJyBz33K6vdvmgzKSmqSsK58IDBw5UYbGfCek0n6YPE6yQv1h/QpGWEBeK3DUpW+23Ogj8xDKQ==
X-Received: by 2002:a4a:b443:: with SMTP id h3mr2876908ooo.45.1603291977458;
 Wed, 21 Oct 2020 07:52:57 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t29sm649052otd.51.2020.10.21.07.52.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2020 07:52:56 -0700 (PDT)
Received: (nullmailer pid 2775005 invoked by uid 1000);
 Wed, 21 Oct 2020 14:52:55 -0000
Date: Wed, 21 Oct 2020 09:52:55 -0500
From: Rob Herring <robh@kernel.org>
To: Jiaxin Yu <jiaxin.yu@mediatek.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: mediatek: mt8192: add audio afe
 document
Message-ID: <20201021145255.GA2770956@bogus>
References: <1603270435-3548-1-git-send-email-jiaxin.yu@mediatek.com>
 <1603270435-3548-4-git-send-email-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603270435-3548-4-git-send-email-jiaxin.yu@mediatek.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 kuninori.morimoto.gx@renesas.com, shane.chien@mediatek.com, tiwai@suse.com,
 tzungbi@google.com, broonie@kernel.org, linux-mediatek@lists.infradead.org,
 p.zabel@pengutronix.de, matthias.bgg@gmail.com,
 linux-arm-kernel@lists.infradead.org
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

On Wed, Oct 21, 2020 at 04:53:53PM +0800, Jiaxin Yu wrote:
> This patch adds mt8192 audio afe document.
> 
> This patch depends on following series that has not been accepted:
> https://patchwork.kernel.org/cover/11752231
> (dt-bindings/clock/mt8192-clk.h is included in it.)
> https://patchwork.kernel.org/patch/11755895
> (dt-bindings/power/mt8192-power.h is included in it.)
> https://lore.kernel.org/patchwork/patch/1321118
> (dt-bindings/reset-controller/mt8192-resets.h is included in it.)
> 
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  .../bindings/sound/mt8192-afe-pcm.yaml        | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> new file mode 100644
> index 0000000000000..7c2f07b8b66dd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)

GPL-2.0-only OR BSD-2-Clause

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mt8192-afe-pcm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Mediatek AFE PCM controller for mt8192
> +
> +maintainers:
> +   - Jiaxin Yu <jiaxin.yu@mediatek.com>
> +   - Shane Chien <shane.chien@mediatek.com>
> +
> +properties:
> +  compatible:
> +      const: mediatek,mt8192-audio
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    const: audiosys
> +
> +  mediatek,apmixedsys:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    maxItems: 1

A 'phandle' is already 1 item. Drop 'maxItems'.

> +    description: The phandle of the mediatek apmixedsys controller
> +
> +  mediatek,infracfg:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    maxItems: 1
> +    description: The phandle of the mediatek infracfg controller
> +
> +  mediatek,topckgen:
> +    $ref: "/schemas/types.yaml#/definitions/phandle"
> +    maxItems: 1
> +    description: The phandle of the mediatek topckgen controller
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: AFE clock
> +      - description: ADDA DAC clock
> +      - description: ADDA DAC pre-distortion clock
> +      - description: audio infra sys clock
> +      - description: audio infra 26M clock
> +
> +  clock-names:
> +    items:
> +      - const: aud_afe_clk
> +      - const: aud_dac_clk
> +      - const: aud_dac_predis_clk
> +      - const: aud_infra_clk
> +      - const: aud_infra_26m_clk
> +
> +required:
> +  - compatible
> +  - interrupts
> +  - resets
> +  - reset-names
> +  - mediatek,apmixedsys
> +  - mediatek,infracfg
> +  - mediatek,topckgen
> +  - power-domains
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/mt8192-clk.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/mt8192-power.h>
> +    #include <dt-bindings/reset-controller/mt8192-resets.h>
> +
> +    afe: mt8192-afe-pcm {
> +        compatible = "mediatek,mt8192-audio";
> +        interrupts = <GIC_SPI 202 IRQ_TYPE_LEVEL_HIGH>;
> +        resets = <&watchdog MT8192_TOPRGU_AUDIO_SW_RST>;
> +        reset-names = "audiosys";
> +        mediatek,apmixedsys = <&apmixedsys>;
> +        mediatek,infracfg = <&infracfg>;
> +        mediatek,topckgen = <&topckgen>;
> +        power-domains = <&scpsys MT8192_POWER_DOMAIN_AUDIO>;
> +        clocks = <&audsys CLK_AUD_AFE>,
> +                 <&audsys CLK_AUD_DAC>,
> +                 <&audsys CLK_AUD_DAC_PREDIS>,
> +                 <&infracfg CLK_INFRA_AUDIO>,
> +                 <&infracfg CLK_INFRA_AUDIO_26M_B>;
> +        clock-names = "aud_afe_clk",
> +                      "aud_dac_clk",
> +                      "aud_dac_predis_clk",
> +                      "aud_infra_clk",
> +                      "aud_infra_26m_clk";
> +    };
> +
> +...
> -- 
> 2.18.0
