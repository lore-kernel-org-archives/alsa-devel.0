Return-Path: <SRS0=J9ZO=6P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 355E6C35280
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 20:08:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2A1B2137B
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 20:08:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ZzKhJrB6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2A1B2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF11916AA;
	Fri,  1 May 2020 22:07:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF11916AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588363695;
	bh=2uziUSHJmNqySrfaFlykT76ZKo5dSuMGro2/1PoILRs=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZzKhJrB6tvDGyN2oJe0xirEH/7/AhTeaAqjaOTNDuew/JsmLh4M4TA0BDM9xiQHkS
	 o9nAlq1xPsvWVrmYMbYT8xaa/v2Leem+4EF7S4175P935gT4mvV5fvpOouI4HSc5Xf
	 ZYnC+qsiWOlLYaxETVrOZc0rUCBPkl+GvRihzoFo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 553C6F800B9;
	Fri,  1 May 2020 22:07:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 579C2F8022B; Fri,  1 May 2020 22:07:22 +0200 (CEST)
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15C41F800B9
 for <alsa-devel@alsa-project.org>; Fri,  1 May 2020 22:07:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15C41F800B9
Received: by mail-oi1-f194.google.com with SMTP id o24so770030oic.0
 for <alsa-devel@alsa-project.org>; Fri, 01 May 2020 13:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=OZmL6pHrV2p1Bxgz7svMOgmRRS5pUlroNV1WaQOUaxQ=;
 b=P7+SWcOy14HkJxbucwigk+oJSbmxEwtoJwnAdOBdfH8MlKZ1RS66aca3HisPgS8/zF
 JS8Yx9kAHGAdduy58RV0koh108osglGZLV2bMWPAHsTyfUw80C7IJKrH190BP6EGc2Nj
 KM1hFttUww15ZnY8zvoAa+9lJJAMdqh1vxD+oEOoqybamXTq1n8Cu9hdNe8N+oci/V5k
 yvB1TZVVcfkREMqzEDFvK0GnGdbysOcVmOBZDugGGCbmKE1qSiVqoDHQiDjvY80pSoZs
 1iXRv21IXNE8rfYgaUckG1F/AWCYq8pN32XACPBBnak7viniqmDsLzusaOwD+vvenPk5
 jguQ==
X-Gm-Message-State: AGi0PuYLHIO/yiwCxGfQQD5lFZqpRsIFhjI0NqwlyCkdMbub4N+MWk5K
 n2vc2bWBBi+OzSWznH4sXg==
X-Google-Smtp-Source: APiQypLUn2+MduxPj4oNeoQvxlzltP4rKeE6pd1r2NWqUGvaeJ2zkquejlimjcK5+QvQvNQFomWbBw==
X-Received: by 2002:aca:4a45:: with SMTP id x66mr970859oia.48.1588363632490;
 Fri, 01 May 2020 13:07:12 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id a27sm1077844oos.37.2020.05.01.13.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2020 13:07:05 -0700 (PDT)
Received: (nullmailer pid 7973 invoked by uid 1000);
 Fri, 01 May 2020 20:06:52 -0000
Date: Fri, 1 May 2020 15:06:52 -0500
From: Rob Herring <robh@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH] ASoC: dt-bindings: ak4613: switch to yaml base
 Documentation
Message-ID: <20200501200652.GA13287@bogus>
References: <87imhtv2mh.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imhtv2mh.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
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

On Tue, Apr 21, 2020 at 02:17:43PM +0900, Kuninori Morimoto wrote:
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> This patch switches from .txt base to .yaml base Document.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../devicetree/bindings/sound/ak4613.txt      | 27 --------
>  .../devicetree/bindings/sound/ak4613.yaml     | 65 +++++++++++++++++++
>  2 files changed, 65 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/ak4613.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/ak4613.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/ak4613.txt b/Documentation/devicetree/bindings/sound/ak4613.txt
> deleted file mode 100644
> index 49a2e74fd9cb..000000000000
> --- a/Documentation/devicetree/bindings/sound/ak4613.txt
> +++ /dev/null
> @@ -1,27 +0,0 @@
> -AK4613 I2C transmitter
> -
> -This device supports I2C mode only.
> -
> -Required properties:
> -
> -- compatible : "asahi-kasei,ak4613"
> -- reg : The chip select number on the I2C bus
> -
> -Optional properties:
> -- asahi-kasei,in1-single-end	: Boolean. Indicate input / output pins are single-ended.
> -- asahi-kasei,in2-single-end	  rather than differential.
> -- asahi-kasei,out1-single-end
> -- asahi-kasei,out2-single-end
> -- asahi-kasei,out3-single-end
> -- asahi-kasei,out4-single-end
> -- asahi-kasei,out5-single-end
> -- asahi-kasei,out6-single-end
> -
> -Example:
> -
> -&i2c {
> -	ak4613: ak4613@10 {
> -		compatible = "asahi-kasei,ak4613";
> -		reg = <0x10>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/sound/ak4613.yaml b/Documentation/devicetree/bindings/sound/ak4613.yaml
> new file mode 100644
> index 000000000000..b5929239505e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/ak4613.yaml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/ak4613.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AK4613 I2C transmitter Device Tree Bindings
> +
> +maintainers:
> +  - Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> +
> +properties:
> +  compatible:
> +    const: asahi-kasei,ak4613
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  # for OF-graph
> +  port:
> +    $ref: "audio-graph-card.yaml#definitions/port"
> +  ports:
> +    $ref: "audio-graph-card.yaml#definitions/ports"

There was no indication any of this applied on the old binding.

I'd rather not get into these arbitrary custom definitions. I think the 
above file probably needs to be split between the card and codec 
schemas. Then in each codec you have just:

allOf:
  - $ref: audio-codec.yaml#

A codec binding should work whether the codec is part of a simple-card 
or graph-card.

> +
> +# use patternProperties to avoid naming "xxx,yyy" issue

What's the issue other than you need a 'description'?

We need to fix it rather than find holes in the meta-schema.

> +patternProperties:
> +  "^asahi-kasei,in1-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +  "^asahi-kasei,in2-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +  "^asahi-kasei,out1-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +  "^asahi-kasei,out2-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +  "^asahi-kasei,out3-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +  "^asahi-kasei,out4-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +  "^asahi-kasei,out5-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag
> +  "^asahi-kasei,out6-single-end$":
> +    $ref: /schemas/types.yaml#/definitions/flag

Though you could make these an actual pattern: in[1-2] and out[1-6]

> +
> +required:
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
> +        ak4613: ak4613@10 {

audio-codec@10

> +            compatible = "asahi-kasei,ak4613";
> +            reg = <0x10>;
> +        };
> +    };
> -- 
> 2.17.1
> 
