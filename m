Return-Path: <SRS0=Hwg1=7K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B49C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 28 May 2020 14:18:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B1772075F
	for <alsa-devel@archiver.kernel.org>; Thu, 28 May 2020 14:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="vrZzcgZ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1772075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B980816B3;
	Thu, 28 May 2020 16:18:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B980816B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590675536;
	bh=zqc71Q27/B8/dUwRLhvm0S+/HIhHCNTNHUpNdVv+Lzc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vrZzcgZ1SX35hdKFaGcWMra+DI7SA+1ESnAUA412dXcdmEAV61k27US+aktN+uvnz
	 3Cflr9ukNqATX+PsebcmlGbHC7Aaz+TCnPGRw7TFvU0sQwtzqmOAlV6kZQM4KkiNMQ
	 JCz4HhUM5YC6ydymccrRuCAy/GOk4WBv9bsRidOY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2FA3BF8014A;
	Thu, 28 May 2020 16:18:06 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8C820F800E4; Thu, 28 May 2020 16:18:04 +0200 (CEST)
Received: from mail-io1-f67.google.com (mail-io1-f67.google.com
 [209.85.166.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C6CFF800E4
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2020 16:17:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C6CFF800E4
Received: by mail-io1-f67.google.com with SMTP id d7so30161458ioq.5
 for <alsa-devel@alsa-project.org>; Thu, 28 May 2020 07:17:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BQyivfejSNXbCqlTdGdrhX0zYMkRgbdRvewpKbUjPCY=;
 b=YMEMv2sFE0PdU1KLCs6Um8f6z0potRN71K2fdAVrgH3MlFFcyvpXeSHROVIxBc6BzN
 urh0n+PZkyrKIJQ4a8b697n73TQuifKuxN5QvB5zvRWjlyRSkATTeqNIm992BW0lC6Lh
 Uxlp4gsxGEQhMx20QHzQdQVTH/E39eKJmmbjlLZFIDjxdpOsFrqGprEwDwGTXa4J6uZY
 2LKVgUUrkMOwb8UJelRNS51KONbGU2kQW1qGGRjYx1sRCJu74Smv9qt2YwWQwqPK3OKw
 JPFAmL+SAok6KgARaUnxrSdsdkKHarNVZv92tGDZCx8j0GtUBMnRGbmcTBQZa5Ts0PPX
 5bbA==
X-Gm-Message-State: AOAM531flR361T3uViHErEO/SFp5SewqpHU0ENgoQvvOtBtRZpeIFAyg
 y7FDFOsEahzU3/nJu2W3eQ==
X-Google-Smtp-Source: ABdhPJz80onPAITqqpwaWbabl4SgfiYAPqN/MWHUc1QI9/knq0XMJmKYbmvkCambm8IbFEAYxixOHg==
X-Received: by 2002:a05:6602:2e05:: with SMTP id
 o5mr2566148iow.28.1590675470945; 
 Thu, 28 May 2020 07:17:50 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
 by smtp.gmail.com with ESMTPSA id z3sm2623657ior.45.2020.05.28.07.17.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 07:17:50 -0700 (PDT)
Received: (nullmailer pid 4189639 invoked by uid 1000);
 Thu, 28 May 2020 14:17:49 -0000
Date: Thu, 28 May 2020 08:17:49 -0600
From: Rob Herring <robh@kernel.org>
To: Steve Lee <steves.lee@maximintegrated.com>
Subject: Re: [V6 PATCH 1/2] dt-bindings: Added device tree binding for max98390
Message-ID: <20200528141749.GB4186430@bogus>
References: <20200528103755.17381-1-steves.lee@maximintegrated.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528103755.17381-1-steves.lee@maximintegrated.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 ryan.lee.maxim@gmail.com, ryans.lee@maximintegrated.com,
 steves.lee.maxim@gmail.com, lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
 broonie@kernel.org
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

On Thu, May 28, 2020 at 07:37:55PM +0900, Steve Lee wrote:
> Add DT binding of max98390 amplifier driver.
> 
> Signed-off-by: Steve Lee <steves.lee@maximintegrated.com>
> ---
> Changed since V5:
> 	* Change txt to yaml and fix up the examples.
> Changed since V4:
> 	* No changes.
> Changed since V3:
> 	* No changes.
> Changed since V2:
> 	* No changes.
> Changed since V1:
> 	* Modified sample text in example
> 
>  .../bindings/sound/maxim,max98390.yaml        | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/maxim,max98390.yaml b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> new file mode 100644
> index 000000000000..1ed4ab9e1c37
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/maxim,max98390.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/maxim,max98390.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim Integrated MAX98390 Speaker Amplifier with Integrated Dynamic Speaker Management
> +
> +maintainers:
> +  - Steve Lee <steves.lee@maximintegrated.com>
> +
> +properties:
> +  compatible:
> +      const: maxim,max98390
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the device.
> +
> +  temperature_calib:

s/_/-/

And missing 'maxim' prefix.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: The calculated temperature data was measured while doing the calibration. Data : Temp / 100 * 2^12

Any constraints? 0-2^32 are valid values?

> +
> +  r0_calib:

Same here.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description: This is r0 calibration data which was measured in factory mode.
> +
> +required:
> +  - compatible
> +  - reg

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    max98390: amplifier@38 {
> +            compatible = "maxim,max98390";
> +            reg = <0x38>;
> +            maxim,temperature_calib = <1024>;
> +            maxim,r0_calib = <100232>;
> +    };
> -- 
> 2.17.1
> 
