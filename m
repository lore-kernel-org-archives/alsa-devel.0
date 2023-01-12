Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3FA8C54EBD
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Jan 2023 12:23:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 961328326;
	Thu, 12 Jan 2023 13:22:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 961328326
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1673526200;
	bh=2crn5sxrqzCdGb43jdV91iTLgeObnzl1FzjlSjxxpjw=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=dgc1l3wYW7ykSb9qUA4Yy1KRkji5N9rqjIrgP7eaJX6MKclJ+ul034PBMc2WF6if+
	 n/7Q1pxKLo1gFe0Rb0Dygn8KIhtfMVHprVg+P4ipb9+YSqqZu2AnqxI9Rq+slUImSw
	 M7rHG6MbmXgCtyoSb7ij+0nG6ljG9HSrA8P7guNs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 49E5EF804BD;
	Thu, 12 Jan 2023 13:22:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6F4A0F804DC; Thu, 12 Jan 2023 13:22:28 +0100 (CET)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8B2B6F8019B
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2023 13:22:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B2B6F8019B
Received: by mail-oi1-f173.google.com with SMTP id e205so15099641oif.11
 for <alsa-devel@alsa-project.org>; Thu, 12 Jan 2023 04:22:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=date:subject:message-id:references:in-reply-to:cc:to:from
 :mime-version:content-transfer-encoding:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rtINNytsd/zxKdxtXoOSr+cNhhKcWFohemXYweWGB1E=;
 b=HCQEIIsJUnSpgLsowYF1eZYXIuBpbdSK3VaXdNpfP9vMsOwb48RJkHWQEZe2zqkSub
 EOptvbMXKZ1CNAv54d7lfm6YvYu5tgomJ1pscNAJip5j7Fj13A7iUqI8eAaa1TnsJJ6G
 QOMS9Fx5yJLK0Yb/3SZJS9IdwbAsHQPCGAezdwgUyj4JGqZmFtPIZNdxIyqB+BAV9ZKj
 sZQ2LtZM0mKbB2nGPSBld5qgM3MqrtRRfWGl0dFPoJ0bPRrI/ZRNfnU8bjbCBBfQDRDs
 OFo3sEbKMzu5BPDBxNykbEQrOgj6JmifjOLgJx3VZgJjRXp6ceadSV3K/Nb4uIRzAyFb
 ak5Q==
X-Gm-Message-State: AFqh2kqpNvJ0ux3hkW8wCUoTyhjiL8ynq5y1X1ynoVDVV/IFe0ygjjzg
 z2KjdETVzgn4ckoLGuzUFg==
X-Google-Smtp-Source: AMrXdXteLOgISZYsRPd/H/T+nOQmYks3iSGq+eTi5zkTvXm+MXN1FfdkAJP6d7iBRIfwnuBL4ngLxA==
X-Received: by 2002:a05:6808:2226:b0:364:2adb:2680 with SMTP id
 bd38-20020a056808222600b003642adb2680mr14431577oib.5.1673526143997; 
 Thu, 12 Jan 2023 04:22:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 n24-20020a9d7118000000b00661ad8741b4sm9030832otj.24.2023.01.12.04.22.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Jan 2023 04:22:23 -0800 (PST)
Received: (nullmailer pid 3055045 invoked by uid 1000);
 Thu, 12 Jan 2023 12:22:22 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Rob Herring <robh@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <878ri84lc6.wl-kuninori.morimoto.gx@renesas.com>
References: <87358hj2ub.wl-kuninori.morimoto.gx@renesas.com>
 <878ri84lc6.wl-kuninori.morimoto.gx@renesas.com>
Message-Id: <167352605035.3051151.10083276065810564823.robh@kernel.org>
Subject: Re: [PATCH 11/10] ASoC: dt-bindings: renesas, rsnd: tidyup rcar_sound,
 src
Date: Thu, 12 Jan 2023 06:22:22 -0600
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>


On Thu, 12 Jan 2023 01:01:45 +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> Some SRC is not implemented on some SoC, thus
> interrupts/dmas/dma-names are not mandatory.
> This patch solve it. Without this patch we will get below error
> when 'make DT_CHECKER_FLAGS=-m dt_binding_check'.
> 
> dtschema/dtc warnings/errors:
> ${LINUX}/Documentation/devicetree/bindings/sound/renesas,rsnd.example.dtb: \
>  sound@ec500000: Unevaluated properties are not allowed ('rcar_sound,src' was unexpected)
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml
> 
> Link: https://lore.kernel.org/r/167344317928.394453.14105689826645262807.robh@kernel.org
> Reported-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  Documentation/devicetree/bindings/sound/renesas,rsnd.yaml | 4 ----
>  1 file changed, 4 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/renesas,rsnd.example.dtb: sound@ec500000: Unevaluated properties are not allowed ('port' was unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/renesas,rsnd.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/878ri84lc6.wl-kuninori.morimoto.gx@renesas.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

