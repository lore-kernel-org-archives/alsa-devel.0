Return-Path: <SRS0=UiOR=FO=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AB3C19425
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 02:06:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9565523C82
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Dec 2020 02:06:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9565523C82
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B77C5168E;
	Thu, 10 Dec 2020 03:06:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B77C5168E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1607566011;
	bh=5apOLPYQyNb2mpdTZXE7hOA0DX8xScrs38to6SNbQ/Y=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OIDqo4GBLQGHhHazqQ2pa8afzSyDAV5qHEukPGdLjQ+tI1i0gb4ywOhwB5df4iGQ7
	 SDqmUgQjfnHqwDwV/jHKrRRxouN/EWB5uCSe0Cyaiz/MaYmGdXSHmltpsTQ+Xd85jN
	 ulUQ9Tdibpra/uQOSU9fTXS2G4cEfgFMPSwUF2nE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3560CF800EF;
	Thu, 10 Dec 2020 03:06:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9BDCCF8020D; Thu, 10 Dec 2020 03:05:57 +0100 (CET)
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DDAE9F800EF
 for <alsa-devel@alsa-project.org>; Thu, 10 Dec 2020 03:05:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DDAE9F800EF
Received: by mail-oi1-f194.google.com with SMTP id o25so4056901oie.5
 for <alsa-devel@alsa-project.org>; Wed, 09 Dec 2020 18:05:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8GuGks7pjJoLfrOI5hpguNKWl0aw9SWAL6rU3/z+zUI=;
 b=tuhEiBM9OiIouE74O5bHhpMkqosqInnMPeeA/vqv+1UPKt2xLEHALtNNI3kdeFwbP/
 5Qe2rHEUoYdToISFXl/2JxmRdTfe9QyUjhyjmFVoIHgdZOqL+6cS+mpZMIA4IqSOXvFG
 2FmG3vlpECa5EmtOVKYRCOqtwcSyHv6109c/xFeuuSUS58EAoNjnpPHDnfrwMk29nvIl
 RIXV+4m8t/Pjh9AGrM3sW08ZNq8jWtjuVFVb4Od3hEvRyC1z1jqWFmmDlhT8plF+J7Tg
 aECScYboK4IIfWTWWMfTx+AsRlf35meAAPK4Q2bqTMkgKfdEY3S9Hps0F8JVykM+m/88
 7m2w==
X-Gm-Message-State: AOAM533GdI3KvSC0/02jNiQzGOnsrCLDwz8v+DQRq7vYehY7LJWoyXXv
 pukiIK2n4uIPZdP3u33ojg==
X-Google-Smtp-Source: ABdhPJwoARnT512h9iJ5Js1SDMsBW69jc17uvbUNL4uUBpC574j9b0Ymjg3ke21CekdWBTrNzGIxEw==
X-Received: by 2002:aca:4006:: with SMTP id n6mr3949480oia.22.1607565947425;
 Wed, 09 Dec 2020 18:05:47 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id o82sm693247oih.5.2020.12.09.18.05.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 18:05:46 -0800 (PST)
Received: (nullmailer pid 1484610 invoked by uid 1000);
 Thu, 10 Dec 2020 02:05:45 -0000
Date: Wed, 9 Dec 2020 20:05:45 -0600
From: Rob Herring <robh@kernel.org>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH 1/2] dt-bindings: add simple-audio-mux binding
Message-ID: <20201210020545.GA1480364@robh.at.kernel.org>
References: <20201205001508.346439-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201205001508.346439-1-alexandre.belloni@bootlin.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org
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

On Sat, Dec 05, 2020 at 01:15:07AM +0100, Alexandre Belloni wrote:
> Add devicetree documentation for simple audio multiplexers
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Cc: Rob Herring <robh+dt@kernel.org>
> 
>  .../bindings/sound/simple-audio-mux.yaml      | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml b/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
> new file mode 100644
> index 000000000000..5986d1fcbb54
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/simple-audio-mux.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0+ OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/simple-audio-mux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Simple Audio Multiplexer
> +
> +maintainers:
> +  - Alexandre Belloni <aleandre.belloni@bootlin.com>

typo

> +
> +description: |
> +  Simple audio multiplexers are driven using gpios, allowing to select which of
> +  their input line is connected to the output line.

What's wrong with the generic mux binding and driver(s)?

> +
> +properties:
> +  compatible:
> +    const: simple-audio-mux
> +
> +  mux-gpios:
> +    description: |
> +      GPIOs used to select the input line.
> +
> +  sound-name-prefix:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description:
> +      Used as prefix for sink/source names of the component. Must be a
> +      unique string among multiple instances of the same component.
> +
> +required:
> +  - compatible
> +  - mux-gpios
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mux {
> +        compatible = "simple-audio-mux";
> +        mux-gpios = <&gpio 3 0>;
> +    };
> -- 
> 2.28.0
> 
