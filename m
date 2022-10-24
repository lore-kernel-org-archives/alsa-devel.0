Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4740FA373F
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Oct 2022 18:39:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AC2146BE3;
	Mon, 24 Oct 2022 20:38:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AC2146BE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666636756;
	bh=lZ+aB8nSn25EJPZVIxpy0/qz8bW4XnhxCKadp8Nw3QY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k3vdXpGeZQRE8tkb5PMW4ELbz4NytK/HmhK/TN8fMKJ0SM+8ilZZMrFpa1lfy5FTa
	 OWbQVxeB7m9e5Oi27Bj6SJti1LLQdUfnsrMLLwaMSobHZZeXu7O0vYxYXc0xyM9VGT
	 giT+sWPtK0Z4rk0eQmUVLICeX8lHsz9PoSreL/L0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 377FEF8052F;
	Mon, 24 Oct 2022 20:38:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B311F80533; Mon, 24 Oct 2022 20:38:25 +0200 (CEST)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 24F86F80506
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2022 20:38:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 24F86F80506
Received: by mail-oi1-f173.google.com with SMTP id p127so11738074oih.9
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2022 11:38:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ciAUyFR+42a1vYSLsFy+yot8yqPlPhT53zC6CUWjbC4=;
 b=3RnyLBpgI+5BEFpAKjR2UZEke9uK4tgJfvntcyoM1dYhFfLyDeT88xQ9Aql8B74WR6
 b9jlthIocayg+EHmwStGdbkdXCLaWjIw1/kOlXuO+GfZJNGCMGTSBpkMB3f5o41pBfSH
 crsDPn6G3y6Xg3W75iiOfgHenv/OOuq/km60T/4Ck1WKi73393+fPwAvfQyggszBy2m+
 alW0oJw5Ev3bhisPLhXCgvxQhhpPI0fKsgY8jxDG2fDiO8Pz3Y1bR3rERTY+sNC/E4fh
 /5LXXItGjo5m+DP4Np4NwrCnLRugk/FKrcIJzdGOaqJQ065KlEU4leu5R/iUKSRLPmuM
 QXqg==
X-Gm-Message-State: ACrzQf3sJ7Fr39dMI9Pjo5EOoa0YgaTL+lmOvhOzdzEQG9S95b7YKinH
 XQcJFpRoUfTXZtqx59sHAA==
X-Google-Smtp-Source: AMsMyM7TPrZafIdws9bZJlUf5Wc3/2fjYb4Lmh/WsftciJEci6PPdMXQKHLrxishbgh6ZRsM1v4DMQ==
X-Received: by 2002:aca:aa8f:0:b0:354:fc38:aeb6 with SMTP id
 t137-20020acaaa8f000000b00354fc38aeb6mr27714978oie.224.1666636696900; 
 Mon, 24 Oct 2022 11:38:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 x52-20020a9d37b7000000b00661c3846b4csm89315otb.27.2022.10.24.11.38.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Oct 2022 11:38:16 -0700 (PDT)
Received: (nullmailer pid 2023578 invoked by uid 1000);
 Mon, 24 Oct 2022 18:38:17 -0000
Date: Mon, 24 Oct 2022 13:38:17 -0500
From: Rob Herring <robh@kernel.org>
To: Trevor Wu <trevor.wu@mediatek.com>
Subject: Re: [PATCH v2 12/12] dt-bindings: mediatek: mt8188: add
 mt8188-mt6359 document
Message-ID: <20221024183817.GA2019162-robh@kernel.org>
References: <20221021082719.18325-1-trevor.wu@mediatek.com>
 <20221021082719.18325-13-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221021082719.18325-13-trevor.wu@mediatek.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, tiwai@suse.com,
 linux-kernel@vger.kernel.org,
 Project_Global_Chrome_Upstream_Group@mediatek.com, broonie@kernel.org,
 linux-mediatek@lists.infradead.org, p.zabel@pengutronix.de,
 matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
 angelogioacchino.delregno@collabora.com
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

On Fri, Oct 21, 2022 at 04:27:19PM +0800, Trevor Wu wrote:
> Add document for mt8188 board with mt6359.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
> ---
>  .../bindings/sound/mt8188-mt6359.yaml         | 64 +++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml b/Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml
> new file mode 100644
> index 000000000000..9c493a6101ff
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/mt8188-mt6359.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/mt8188-mt6359.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MediaTek MT8188 ASoC sound card driver

Drop 'driver'

> +
> +maintainers:
> +  - Trevor Wu <trevor.wu@mediatek.com>
> +
> +description:
> +  This binding describes the MT8188 sound card.

Drop, the description doesn't add anything the title didn't say.

> +
> +properties:
> +  compatible:
> +    enum:

Only 1 entry, use 'const'

> +      - mediatek,mt8188_mt6359_evb

s/_/-/

> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +  audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      A list of the connections between audio components. Each entry is a
> +      sink/source pair of strings. Valid names could be the input or output
> +      widgets of audio components, power supplies, MicBias of codec and the
> +      software switch.
> +
> +  mediatek,platform:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT8188 ASoC platform.
> +
> +  mediatek,dptx-codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT8188 Display Port Tx codec node.
> +
> +  mediatek,hdmi-codec:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: The phandle of MT8188 HDMI codec node.
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
> +    sound: mt8188-sound {
> +        compatible = "mediatek,mt8188_mt6359_evb";
> +        mediatek,platform = <&afe>;
> +        pinctrl-names = "default";
> +        pinctrl-0 = <&aud_pins_default>;
> +        audio-routing =
> +            "Headphone", "Headphone L",
> +            "Headphone", "Headphone R",
> +            "AIN1", "Headset Mic";
> +    };
> +
> +...
> -- 
> 2.18.0
> 
> 
