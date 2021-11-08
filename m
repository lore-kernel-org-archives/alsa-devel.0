Return-Path: <SRS0=zqBf=P3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B49C4332F
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Nov 2021 21:05:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1565619A6
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Nov 2021 21:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B1565619A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4EA8915F9;
	Mon,  8 Nov 2021 22:05:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4EA8915F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636405551;
	bh=Oa194Ks0RK46X5nRKkBW1JWjMOniOqTWY4pcuuCIa1A=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KYbS7uIA0hIl4/WyIBxBOvdBTCGXhNov4HfL84wwLI0+T54zYOydiMsorgk/LOFsw
	 2qszIpdGhiZztwYX2Jc4cULkWpm7DcVQpyKpWazw8OVOStpUOWT4aF+2i77KotfHGE
	 urxCnvfgAH/fV3/lQ6IvG4WyPbfDkFp02ya7GPQk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D158BF80227;
	Mon,  8 Nov 2021 22:05:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 41826F8049E; Mon,  8 Nov 2021 22:04:59 +0100 (CET)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 66EF5F801D8
 for <alsa-devel@alsa-project.org>; Mon,  8 Nov 2021 22:04:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 66EF5F801D8
Received: by mail-oi1-f171.google.com with SMTP id q124so29764837oig.3
 for <alsa-devel@alsa-project.org>; Mon, 08 Nov 2021 13:04:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dLj06l1wmESDNcs8MD+tMJu6hG5JZ+huSjOUnPTWIms=;
 b=o8GU4axySIJhbRhnTTgPU37bXUK2RhGZcOAYM3cq/ii7VYMXmz1N0quLP9LtRlw7AV
 4KOIQNLrwKdy7Cx98FJj9xR16f7UVtGrDvFhhQmWPoWDpXsGMHlnI0xR5ncTKTiBxeJd
 RD0EN9vKpJBdpqUpFYSC/LpOy2eFjCO7bErPzPgj/z4/RVj9vU/cCw5ChsWW/Z+o0WkI
 APJVfkFzKRmH5lb5out8ujERlHqaWAXItYYtO7ekkk/Q9r9vY85Vec3+M0UQOvzGNwQo
 areajVRIaiYY+9BprWN+rm2OJXPTxp2FS52xWndPZpvhKPaZwI12XBgo1x143XNWBfVn
 opig==
X-Gm-Message-State: AOAM531IHZszcvM4TinBmSxTi3aOAkHvKSbCgTlHkRMgkJJ3pvZv00bX
 kJU4OkVey6SphLX5OIrj9w==
X-Google-Smtp-Source: ABdhPJzgvZiyH3h067LzXWI0cQ4/N1FWjU0WpFR4uRRAaF0ibj9cAeUsZYzrHJXzWGQ7Y2Wdivex9Q==
X-Received: by 2002:aca:3e86:: with SMTP id l128mr1169280oia.120.1636405487943; 
 Mon, 08 Nov 2021 13:04:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id k4sm6359902oic.48.2021.11.08.13.04.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Nov 2021 13:04:46 -0800 (PST)
Received: (nullmailer pid 16501 invoked by uid 1000);
 Mon, 08 Nov 2021 21:04:44 -0000
Date: Mon, 8 Nov 2021 15:04:44 -0600
From: Rob Herring <robh@kernel.org>
To: David Heidelberg <david@ixit.cz>
Subject: Re: [PATCH v2] dt-bindings: sound: gtm601: convert to YAML
Message-ID: <YYmQ7OCIIb2AbnjY@robh.at.kernel.org>
References: <20211030121753.50191-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211030121753.50191-1-david@ixit.cz>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, - <kernel@puri.sm>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
 Mark Brown <broonie@kernel.org>, phone-devel@vger.kernel.org,
 ~okias/devicetree@lists.sr.ht
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

On Sat, Oct 30, 2021 at 02:17:52PM +0200, David Heidelberg wrote:
> Convert GTM601 binding to the YAML format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> v2:
>  - add #sound-dai-cells
>  - put kernel@puri.sm into maintainers
> 
>  .../devicetree/bindings/sound/gtm601.txt      | 19 ----------
>  .../devicetree/bindings/sound/gtm601.yaml     | 36 +++++++++++++++++++
>  2 files changed, 36 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/gtm601.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/gtm601.txt b/Documentation/devicetree/bindings/sound/gtm601.txt
> deleted file mode 100644
> index efa32a486c4a..000000000000
> --- a/Documentation/devicetree/bindings/sound/gtm601.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -GTM601 UMTS modem audio interface CODEC
> -
> -This device has no configuration interface. The sample rate and channels are
> -based on the compatible string
> -	"option,gtm601" = 8kHz mono
> -	"broadmobi,bm818" = 48KHz stereo
> -
> -Required properties:
> -
> -  - compatible : one of
> -	"option,gtm601"
> -	"broadmobi,bm818"
> -
> -
> -Example:
> -
> -codec: gtm601_codec {
> -	compatible = "option,gtm601";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/gtm601.yaml b/Documentation/devicetree/bindings/sound/gtm601.yaml
> new file mode 100644
> index 000000000000..e81a6aa75522
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/gtm601.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/gtm601.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GTM601 UMTS modem audio interface CODEC
> +
> +maintainers:
> +  - kernel@puri.sm
> +
> +description: >
> +  This device has no configuration interface. The sample rate and channels are
> +  based on the compatible string
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: broadmobi,bm818
> +          - const: option,gtm601

This does not match what the binding originally said. And generally this 
combined with the one below should never be valid.

> +      - items:
> +          - enum:
> +              - broadmobi,bm818  # 48 kHz stereo
> +              - option,gtm601  # 8 kHz mono
> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gtm601_codec {
> +        compatible = "option,gtm601";
> +    };
> -- 
> 2.33.0
> 
> 
