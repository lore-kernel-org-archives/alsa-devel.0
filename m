Return-Path: <SRS0=rm39=JM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A88E3C433ED
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 16:40:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255CA613BB
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Apr 2021 16:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255CA613BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ACC5F9F6;
	Thu, 15 Apr 2021 18:39:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ACC5F9F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618504814;
	bh=KQZaEMK069V4HzUzCwPnHrUWAzAwfRy3J1+ep5oa47U=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Trj79FGE+2YPmL6nuEqIzDohQGQ3KzYpGKFR74AdT+0Ie9ybki3ECK3C/4DQtSlEd
	 TV9dEinPFbUBDos2i8XMrXM1b6OjwbuYKXJdMf9VsDltcu37Hab+x2JNdGZfW/NtHW
	 pZC1prNhFNkbEZ2+nlC3t7+XqAULZqvqS53Tjkr0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32CAEF8021D;
	Thu, 15 Apr 2021 18:39:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34DD1F8022B; Thu, 15 Apr 2021 18:39:22 +0200 (CEST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BC431F80128
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 18:39:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC431F80128
Received: by mail-ot1-f47.google.com with SMTP id
 a2-20020a0568300082b029028d8118b91fso4656603oto.2
 for <alsa-devel@alsa-project.org>; Thu, 15 Apr 2021 09:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZpKNZqJMtuMERJQ2AbPwF8sZgkJqLPk+S+d3HTR1z9Y=;
 b=Nc3riBH7/nPzZGkOdfiyu5aDX0URD6gCa0QDkVQnhbP36RWnhFHO/uO28VEnTMRuRd
 APf1/rEVdHsia5w5EeA0RMbY1I30fAs86mnpDOcCBWsfJG2dzxLzC9CoSctWe/XE9KMs
 Mbh9jrtf0fdMHq2cJOk+5n0KDTVxtTvh/yAJAUXRI9rqgLdZTa8r4sgacgeNqsQzRmvN
 6kQB59rrhLqkZ7RF7Pa5G+gKe3oAsxH4DgIwvwnFk/w9qDSxwsKJPsyF/s6DpWbtwIG4
 Toqy24/W83EaHfAyQ2ry1oH6yRBRuzPyoWKn5gMdGnCdeVcH7OaMe9AOsWgkSZ7RARnf
 6ssA==
X-Gm-Message-State: AOAM53144GgCt3vtvgPt1KPyrEZtvE81elOg3ul2VoFSAiQOI9SL5sud
 vRm/lyb5Pqil7rqn2jzq5g==
X-Google-Smtp-Source: ABdhPJxfrT1TEsqC3ayPTt5SJKenn6259qEOzXxjhfz6tyEYwEVQfneK+liMC8rKdst2Q11qlP7W+Q==
X-Received: by 2002:a05:6830:2491:: with SMTP id
 u17mr147988ots.198.1618504753664; 
 Thu, 15 Apr 2021 09:39:13 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id m3sm700725oiw.27.2021.04.15.09.39.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Apr 2021 09:39:13 -0700 (PDT)
Received: (nullmailer pid 1533253 invoked by uid 1000);
 Thu, 15 Apr 2021 16:39:12 -0000
Date: Thu, 15 Apr 2021 11:39:12 -0500
From: Rob Herring <robh@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v4 4/9] ASoC: dt-bindings: wcd938x-sdw: add bindings for
 wcd938x-sdw
Message-ID: <20210415163912.GA1524320@robh.at.kernel.org>
References: <20210414154845.21964-1-srinivas.kandagatla@linaro.org>
 <20210414154845.21964-5-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414154845.21964-5-srinivas.kandagatla@linaro.org>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org, broonie@kernel.org
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

On Wed, Apr 14, 2021 at 04:48:40PM +0100, Srinivas Kandagatla wrote:
> Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC
> connected over SoundWire. This device has two SoundWire devices RX and
> TX respectively. This bindings is for those slave devices on WCD9380/WCD9385.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wcd938x-sdw.yaml      | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml b/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
> new file mode 100644
> index 000000000000..fff33c65491b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd938x-sdw.yaml
> @@ -0,0 +1,61 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,wcd938x-sdw.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for Qualcomm SoundWire Slave devices on WCD9380/WCD9385
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  Qualcomm WCD9380/WCD9385 Codec is a standalone Hi-Fi audio codec IC.
> +  It has RX and TX Soundwire slave devices. This bindings is for the
> +  slave devices.
> +
> +properties:
> +  compatible:
> +    const: sdw20217010d00
> +
> +  reg:
> +    maxItems: 1
> +
> +  qcom,direction:
> +    description: direction of the SoundWire device instance
> +    enum:
> +      - rx
> +      - tx

Was thinking these were some established bus properties...

This would just be implied by the 'reg' property index. You could define 
'reg-names' too I guess.

> +
> +  qcom,port-mapping:
> +    description: |
> +      Specifies static port mapping between slave and master ports.
> +      In the order of slave port index.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 4
> +    maxItems: 5

qcom,rx-port-mapping and qcom,tx-port-mapping?

Or keep a single property and the driver knows how many slave ports for 
each direction. IOW, an array of 9 with first 4 entries for tx and last 
5 for rx.

> +
> +required:
> +  - compatible
> +  - reg
> +  - qcom,direction
> +  - qcom,port-mapping
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soundwire@3230000 {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        reg = <0x03230000 0x2000>;
> +
> +        codec@0,3 {
> +            compatible = "sdw20217010d00";
> +            reg  = <0 3>;
> +            qcom,direction = "tx";
> +            qcom,port-mapping = <2 3 4 5>;
> +        };
> +    };
> +
> +...
> -- 
> 2.21.0
> 
