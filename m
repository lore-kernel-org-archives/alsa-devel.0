Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBE01C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 19:52:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E994A60F9F
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 19:52:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E994A60F9F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5717A1785;
	Mon, 13 Sep 2021 21:51:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5717A1785
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631562742;
	bh=cUc2zwyArck2vfsg97+z09GjkMmLNOsOx3HEDRfJLTc=;
	h=In-Reply-To:References:From:Date:Subject:To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IoHokAL2TcRQQ0tCCuylTh7UB+OxNhVpLT5q8wju9pQpFLToWYAmxEscemzbRkoz4
	 ukogd8IdG8DRfsCA0XDXpgWD/naiS1Rsci4kpOO/ZER7QY1KZiVzac6tscZXMfzKYy
	 /6aCkmc6wW62AE8n130+rgRCMT/MbJt/XrNFerLg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1126F80132;
	Mon, 13 Sep 2021 21:51:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9747AF80132; Mon, 13 Sep 2021 21:51:29 +0200 (CEST)
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com
 [IPv6:2607:f8b0:4864:20::330])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 584A8F80132
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 21:51:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 584A8F80132
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.b="Zodc0o0J"
Received: by mail-ot1-x330.google.com with SMTP id
 g66-20020a9d12c8000000b0051aeba607f1so14985183otg.11
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 12:51:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:in-reply-to:references:from:user-agent:date:message-id
 :subject:to; bh=7y5Kp92MxlMIM/1uVfkHDfbY3sPUaGnffDNVZpUsrD8=;
 b=Zodc0o0JSl2wPuA2Y12NHWaoDY6QABXb137QrHTXqY11BK/0mIsSmDtqRM4Zm7UmRG
 NDS8f4Q5f7Sc3gTutg/hC+SubqhccAhKu6HsGcUna0XluSh0IyQOT9ytmBIL+CvFukJv
 wuSKCsLqUBP1ML9pxEFAKZPdUExJgd3OvfLFI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:in-reply-to:references:from
 :user-agent:date:message-id:subject:to;
 bh=7y5Kp92MxlMIM/1uVfkHDfbY3sPUaGnffDNVZpUsrD8=;
 b=yyFlLZnxlKX3k09YGLTjTJd/xpNWFP1YT59blZiSunVTBudJCCR/b9O0TCGCrRZx1S
 l68wVfS/kj2x2BRJ9TRXgDV6FOqZz7G2lhEM5RlKSrmp8wKR/FQA9a1LRZoGwIid1UZQ
 Wv+dKkiy3IuPH/NB5TI1etPEq9K/QJgknvsntBhPRKWJf2zU5qwdN0p2Ez4OLTvB2D1e
 /5AEeFI/athnaiJmES2YBHunvUtd+K1h8wflFYcQyO4gUiJDbstARweMpFvhugm8H+We
 Fm1IX2GR2o2GX7O9r0fVj8YEdYI98Na4iIGssBVNaQm30rMu1mHw8kB1GEeQDLbOtLMO
 4Lug==
X-Gm-Message-State: AOAM533LFIgzS/nu7nPLQl2BgAtX5KCEXQmf0vieChagFPD1Wq9rgcpc
 n0vwO/w1hTPlCZAlD0Fslfwt8tPzUY7sKioZba7wCw==
X-Google-Smtp-Source: ABdhPJy8cOper52GzW4GbJAI4BPyVQYu27nMzrhL6XZsTO4p+Lv1yS1UiO9YJYTrQ5nwZM9IcOtzIoPX1a3xvmpfAnI=
X-Received: by 2002:a05:6830:18c7:: with SMTP id
 v7mr11189838ote.126.1631562679479; 
 Mon, 13 Sep 2021 12:51:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Sep 2021 12:51:19 -0700
MIME-Version: 1.0
In-Reply-To: <1631539062-28577-2-git-send-email-srivasam@codeaurora.org>
References: <1631539062-28577-1-git-send-email-srivasam@codeaurora.org>
 <1631539062-28577-2-git-send-email-srivasam@codeaurora.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date: Mon, 13 Sep 2021 12:51:19 -0700
Message-ID: <CAE-0n50=ABP+fs1U3JjiqMSKphfxFsZBqQQYwVH2o_iOE1Wu_g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ASoC: google: dt-bindings: Add sc7280-herobrine
 machine bindings
To: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>, agross@kernel.org,
 alsa-devel@alsa-project.org, 
 bgoswami@codeaurora.org, bjorn.andersson@linaro.org, broonie@kernel.org, 
 devicetree@vger.kernel.org, judyhsiao@chromium.org, lgirdwood@gmail.com, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, perex@perex.cz, 
 plai@codeaurora.org, robh+dt@kernel.org, rohitkr@codeaurora.org, 
 srinivas.kandagatla@linaro.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
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

Quoting Srinivasa Rao Mandadapu (2021-09-13 06:17:41)
> diff --git a/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> new file mode 100644
> index 0000000..e0d705f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/google,sc7280-herobrine.yaml
> @@ -0,0 +1,169 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/google,sc7280-herobrine.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Google SC7280-Herobrine ASoC sound card driver
> +
> +maintainers:
> +  - Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> +  - Judy Hsiao <judyhsiao@chromium.org>
> +
> +description:
> +  This binding describes the SC7280 sound card which uses LPASS for audio.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - google,sc7280-herobrine
> +
> +  audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description:
> +      A list of the connections between audio components. Each entry is a
> +      pair of strings, the first being the connection's sink, the second
> +      being the connection's source.
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^dai-link@[0-9a-f]$":
> +    description:
> +      Each subnode represents a dai link. Subnodes of each dai links would be
> +      cpu/codec dais.
> +
> +    type: object
> +
> +    properties:
> +      link-name:
> +        description: Indicates dai-link name and PCM stream name.
> +        $ref: /schemas/types.yaml#/definitions/string
> +        maxItems: 1
> +
> +      reg:
> +        maxItems: 1
> +        description: dai link address.
> +
> +      cpu:
> +        description: Holds subnode which indicates cpu dai.
> +        type: object
> +        properties:
> +          sound-dai: true

Shouldn't sound-dai be required?

> +
> +      codec:
> +        description: Holds subnode which indicates codec dai.
> +        type: object
> +        properties:
> +          sound-dai: true

Shouldn't sound-dai be required? I don't know but maybe also additional
properties is false for this node too?

> +
> +    required:
> +      - link-name
> +      - cpu
> +      - codec

Should 'reg' be required?

> +
> +    additionalProperties: false
