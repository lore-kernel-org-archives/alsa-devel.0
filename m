Return-Path: <SRS0=EqiG=CR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 638A9C43461
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:35:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A61DC208FE
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Sep 2020 20:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ty+UHnzH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A61DC208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C587B1704;
	Tue,  8 Sep 2020 22:34:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C587B1704
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599597306;
	bh=oeMukUNCsEcmOKOZa4BXbmL4i8tsEpncJUS7M3Q9Uz4=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ty+UHnzH/ZxJSFEKoWdUzHAUp2xGQ1syzeLb5KUKueFOhVnvwsAPL0oOQLngbyYRS
	 4uUOOWm1dzrae1mtQz8Xd2yCudgn/8rK6CqV/zH4dEKmcsKTE/bZ8N+xZYMDUcOtH0
	 toX1CMdYzex/UjpEOlQioPIVSF2ixJf42JbT4Fas=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 43FF0F800FD;
	Tue,  8 Sep 2020 22:34:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D06C8F80264; Tue,  8 Sep 2020 22:34:14 +0200 (CEST)
Received: from mail-il1-f194.google.com (mail-il1-f194.google.com
 [209.85.166.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A115DF800FD
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2020 22:34:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A115DF800FD
Received: by mail-il1-f194.google.com with SMTP id t16so165511ilf.13
 for <alsa-devel@alsa-project.org>; Tue, 08 Sep 2020 13:34:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=gleTakc4Nn6mTISuQkejPMu6ISZTqy+j8/Bxw7G61oU=;
 b=Ckqs5LfPCPjXJ+KBrMovnttJMvUn+Gc3w7AoJaxVro0XNhlH9xGhz9hfiSOkAyaYUm
 lLcUjweFCodwObkgBs2vk6czG1II+A24tIQDrvXnrR56oGo2jrFzPrgUvemh5jjbw/5T
 5iSoEBnekbgdFJX8mDwUz/t9M98LDFJeLjFD0eRxGAjbodb0u3A8pH2kcNb62BQuqJnA
 PePjMIKcboG2W4GdpV4jVKyo8+whn5t7FfZ0nMCIzZ2YnP6UHGxKDh7i6d3MbFRTPEz2
 izfpeR1AiejE9e5YCwXMDAfCagKscRTALZ6tVfJy5wiSJR1kW36FT5WsyQEDphEUhHGK
 dAZw==
X-Gm-Message-State: AOAM533Lwk9jjYvDaUSlAGZFhczxgSB8OaTTlO+hbxwlgZOsMddo3lHS
 r/p9Soh0lpSBFRNeyiiXEQ==
X-Google-Smtp-Source: ABdhPJzCHoj/ZvrJj7t400J/VsMUBFrd75e5tcT3ln+3OZZL67b775TNHUe3xKteGxNcW5bAkZ322A==
X-Received: by 2002:a92:c049:: with SMTP id o9mr483817ilf.193.1599597242634;
 Tue, 08 Sep 2020 13:34:02 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
 by smtp.gmail.com with ESMTPSA id k14sm217738ioa.7.2020.09.08.13.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 13:34:02 -0700 (PDT)
Received: (nullmailer pid 868500 invoked by uid 1000);
 Tue, 08 Sep 2020 20:33:57 -0000
Date: Tue, 8 Sep 2020 14:33:57 -0600
From: Rob Herring <robh@kernel.org>
To: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH v7 2/3] ASoC: qcom: dt-bindings: Add sc7180 machine
 bindings
Message-ID: <20200908203357.GA861143@bogus>
References: <20200907100039.1731457-1-cychiang@chromium.org>
 <20200907100039.1731457-3-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907100039.1731457-3-cychiang@chromium.org>
Cc: Taniya Das <tdas@codeaurora.org>, alsa-devel@alsa-project.org,
 Banajit Goswami <bgoswami@codeaurora.org>, Heiko Stuebner <heiko@sntech.de>,
 Takashi Iwai <tiwai@suse.com>, Rohit kumar <rohitkr@codeaurora.org>,
 Patrick Lai <plai@codeaurora.org>, linux-rockchip@lists.infradead.org,
 Andy Gross <agross@kernel.org>, dgreid@chromium.org,
 devicetree@vger.kernel.org, tzungbi@chromium.org,
 Stephan Gerhold <stephan@gerhold.net>, linux-arm-msm@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>
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

On Mon, Sep 07, 2020 at 06:00:38PM +0800, Cheng-Yi Chiang wrote:
> Add devicetree bindings documentation file for sc7180 sound card.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  .../bindings/sound/qcom,sc7180.yaml           | 143 ++++++++++++++++++
>  1 file changed, 143 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> new file mode 100644
> index 000000000000..ae809346ca80
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> @@ -0,0 +1,143 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,sc7180.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies Inc. SC7180 ASoC sound card driver
> +
> +maintainers:
> +  - Rohit kumar <rohitkr@codeaurora.org>
> +  - Cheng-Yi Chiang <cychiang@chromium.org>
> +
> +description:
> +  This binding describes the SC7180 sound card which uses LPASS for audio.
> +
> +properties:
> +  compatible:
> +    const: qcom,sc7180-sndcard
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
> +  headset-jack:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle of the codec for headset detection
> +
> +  hdmi-jack:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle of the codec for hdmi jack detection

You already have links to these devices. Why duplicate it here? 

What if you had 2 headsets? This doesn't scale.

Rob
