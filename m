Return-Path: <SRS0=T8Ko=BQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A938EC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:40:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75B0323105
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Aug 2020 14:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="k0tOngR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75B0323105
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ABC81820;
	Thu,  6 Aug 2020 16:39:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ABC81820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596724821;
	bh=czzKMbY2Z69kWtMFwsANFOaSfRExtTSO8rmTfRfYAuc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k0tOngR+jHBmKx8AGHr+vehE3BDTfnQoCF/HWgM8Z+VR0ln9vqgTV+kvbs7HYuVOI
	 3BrZQ/MeK8WzANdmF0mAeS+OiHiepa+LA8wIFb6BQR/MALc4s4F+fd5+X2BXfa19xa
	 Db2CZJwPRJYM1Gy+ywbyzEIv4uW2sxa5IKkZ11kM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 337F2F80124;
	Thu,  6 Aug 2020 16:39:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C430FF80159; Thu,  6 Aug 2020 16:39:29 +0200 (CEST)
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com
 [209.85.166.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 93CB9F80124
 for <alsa-devel@alsa-project.org>; Thu,  6 Aug 2020 16:39:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 93CB9F80124
Received: by mail-io1-f65.google.com with SMTP id j8so37474318ioe.9
 for <alsa-devel@alsa-project.org>; Thu, 06 Aug 2020 07:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xk1+TxcE3QnIGMOvPraXoKHV6uIacnJL3Sj3a6NYZPM=;
 b=HTZDDDxbQxlo9DmCIlJTEsCV7kZDKHmbXTfJ+yHJ5WQ4khjuHxOVsclbViP7qP9vY1
 U/P44dsyXFgomC0Ru5+A0BsEqk8M9iV0xzBfOMPmBKbe0XRUM/8+1z5BkMxbXQhG/Z1d
 4qcKNyg5owe03XqijtuKpfzi9kSceVU6QmJZg34hIUwHdZBTM3EK5oqnvxAVmfFh4Lov
 0MnzQ55TgfHprzMYaOZMNjCQC6aShO7IgW2wiW28aFxAyL+GfyrMf6sht0m+aJuGjnQB
 pZtKMFSQ9FaVQ0qzP88OT0WH94Cy3Ei8N5bf9SJIuiSiEtBM678f5R9ylRUuZ2VOF3KP
 NGTA==
X-Gm-Message-State: AOAM531YKOZcUy9/YRJEG+hSFuaKpOXGomhehWUeK7OiNBcO1/lU9OGh
 zdP3tz59rgI4rGxxmUH+YQ==
X-Google-Smtp-Source: ABdhPJywUa1fS+mhDPPCoUj+LuP94rGkcgwbq8VHiTsnW6mBNPkpA3uSHzABW0gjnvpFFTpk6c+lhA==
X-Received: by 2002:a05:6602:24d5:: with SMTP id
 h21mr10407216ioe.108.1596724757598; 
 Thu, 06 Aug 2020 07:39:17 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id a18sm4061245ilp.52.2020.08.06.07.39.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 07:39:16 -0700 (PDT)
Received: (nullmailer pid 822114 invoked by uid 1000);
 Thu, 06 Aug 2020 14:39:12 -0000
Date: Thu, 6 Aug 2020 08:39:12 -0600
From: Rob Herring <robh@kernel.org>
To: Cheng-Yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH v4 1/2] ASoC: qcom: dt-bindings: Add sc7180 machine
 bindings
Message-ID: <20200806143912.GA816294@bogus>
References: <20200803040122.2063634-1-cychiang@chromium.org>
 <20200803040122.2063634-2-cychiang@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803040122.2063634-2-cychiang@chromium.org>
Cc: Taniya Das <tdas@codeaurora.org>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Stephan Gerhold <stephan@gerhold.net>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-arm-msm@vger.kernel.org, Patrick Lai <plai@codeaurora.org>,
 Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
 tzungbi@chromium.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
 Mark Brown <broonie@kernel.org>, Rohit kumar <rohitkr@codeaurora.org>,
 Andy Gross <agross@kernel.org>, dianders@chromium.org,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>, dgreid@chromium.org,
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

On Mon, Aug 03, 2020 at 12:01:21PM +0800, Cheng-Yi Chiang wrote:
> Add devicetree bindings documentation file for sc7180 sound card.
> 
> Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> ---
>  .../bindings/sound/qcom,sc7180.yaml           | 113 ++++++++++++++++++
>  1 file changed, 113 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> new file mode 100644
> index 000000000000..c74f0fe9fb3b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,sc7180.yaml
> @@ -0,0 +1,113 @@
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
> +    contains:
> +      const: qcom,sc7180-sndcard
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
> +  aux-dev:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle of the codec for headset detection
> +
> +patternProperties:
> +  "^dai-link(@[0-9]+)?$":
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
> +        description: dai link address.
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        maxItems: 1
> +
> +      cpu:
> +        description: Holds subnode which indicates cpu dai.
> +        type: object
> +        properties:
> +          sound-dai: true
> +
> +      codec:
> +        description: Holds subnode which indicates codec dai.
> +        type: object
> +        properties:
> +          sound-dai: true
> +
> +    required:
> +      - link-name
> +      - cpu
> +      - codec
> +
> +    additionalProperties: false

Nothing required?

Add:

additionalProperties: false

(And you'll need to define #address-cells and #size-cells)

> +
> +examples:
> +
> +  - |
> +    sound {
> +        compatible = "qcom,sc7180-sndcard";
> +        model = "sc7180-snd-card";
> +
> +        audio-routing =
> +                    "Headphone Jack", "HPOL",
> +                    "Headphone Jack", "HPOR";
> +
> +        aux-dev = <&alc5682>;
> +
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        dai-link@0 {
> +            link-name = "MultiMedia0";
> +            reg = <0>;
> +            cpu {
> +                sound-dai = <&lpass_cpu 0>;
> +            };
> +
> +            codec {
> +                sound-dai = <&alc5682 0>;
> +            };
> +        };
> +
> +        dai-link@1 {
> +            link-name = "MultiMedia1";
> +            reg = <1>;
> +            cpu {
> +                sound-dai = <&lpass_cpu 1>;
> +            };
> +
> +            codec {
> +                sound-dai = <&max98357a>;
> +            };
> +        };
> +    };
> -- 
> 2.28.0.163.g6104cc2f0b6-goog
> 
