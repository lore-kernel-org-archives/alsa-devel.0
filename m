Return-Path: <SRS0=/2j+=HM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 654E9C433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 22:18:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68BD264EAC
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 22:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68BD264EAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B15BA16DA;
	Wed, 10 Feb 2021 23:17:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B15BA16DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612995486;
	bh=vC8ICWrNSxJurAGuPrtPAbr7/Hjx9GImwO+NHaaXU2I=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CahV+9MEpnaT6BRobW0gMbjs99sOpeTLyy0dy65Q5cEH5e/r3ls46tJWQ3cYeCTtC
	 fqGkoXql6sFedCJf8OLtn2K4qfn8n5FHKRttb7rEmkexkOP912JGub9v9Yo2vQS4k+
	 dlb+OP6vxSwNQnI7FUiFcG5HnSCVYN+K50sgcJLY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3C7BDF800F1;
	Wed, 10 Feb 2021 23:17:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF359F8022B; Wed, 10 Feb 2021 23:17:14 +0100 (CET)
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com
 [209.85.167.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D52A5F80165
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2021 23:17:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D52A5F80165
Received: by mail-oi1-f171.google.com with SMTP id l3so3914799oii.2
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2021 14:17:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X/+AS1PnO/pIi25zgPnySrTJigYkK7rUzHnIa2wA10c=;
 b=CKAKfiGw34hDjbPmNAU0mjPcY6jcCA5K1sFa17D80kjQX4x+TO3nv15BBoldk0HAec
 +0/ucltPYe+lgaMQQXnxIJg1saY2CAT1eq3zt/5GYLE93spPkKhkvsL/M+3rU4Zqq5AT
 72hQv6io/cmB75mLlHhrhc8ylU+nWIV5LprQBK/BN4PMnSz2hbF1f3Z07UCW2WjAVIcd
 yTRsJP8bL4+sCJbNxADTBc0bipNixXrDPdmx60Rdo/Tzs7Q1YYmEMzIFXIa7OSJ9D1yY
 ui5vrw7zU7Sq6BWrCpdj6xn/tLPf0xO/7kUCYdYQfDCpbM1A6GJMHCL2wz2MfcPBoCGu
 hQ0g==
X-Gm-Message-State: AOAM530vSC6fmqPW+s+IW+rtx3sbntQw3cmW1vtkh6nJjXEvhFVGX8Yp
 lGzdJtrNYGXWfdjUHK6rFw==
X-Google-Smtp-Source: ABdhPJwBaK5/uRRp67UJ2r6hTbPKpERNoPUPShLujM3MmLo48Htw1DUx13FzI0PYRRUmqbkp9mKjSg==
X-Received: by 2002:aca:ab89:: with SMTP id u131mr818003oie.170.1612995426687; 
 Wed, 10 Feb 2021 14:17:06 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id a20sm155592oid.47.2021.02.10.14.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Feb 2021 14:17:05 -0800 (PST)
Received: (nullmailer pid 2901206 invoked by uid 1000);
 Wed, 10 Feb 2021 22:17:04 -0000
Date: Wed, 10 Feb 2021 16:17:04 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 7/7] ASoC: dt-bindings: imx-rpmsg: Add binding doc for
 rpmsg machine driver
Message-ID: <20210210221704.GA2894134@robh.at.kernel.org>
References: <1612693435-31418-1-git-send-email-shengjiu.wang@nxp.com>
 <1612693435-31418-8-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612693435-31418-8-git-send-email-shengjiu.wang@nxp.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, timur@kernel.org,
 lgirdwood@gmail.com, linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, nicoleotsuka@gmail.com,
 broonie@kernel.org, festevam@gmail.com
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

On Sun, Feb 07, 2021 at 06:23:55PM +0800, Shengjiu Wang wrote:
> Imx-rpmsg is a new added machine driver for supporting audio on Cortex-M
> core. The Cortex-M core will control the audio interface, DMA and audio
> codec, setup the pipeline, the audio driver on Cortex-A core side is just
> to communitcate with M core, it is a virtual sound card and don't touch
> the hardware.

I don't understand why there are 2 nodes for this other than you happen 
to want to split this into 2 Linux drivers. It's 1 h/w thing. 

> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  .../bindings/sound/imx-audio-rpmsg.yaml       | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml b/Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml
> new file mode 100644
> index 000000000000..b941aeb80678
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/imx-audio-rpmsg.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/imx-audio-rpmsg.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: NXP i.MX audio complex with rpmsg
> +
> +maintainers:
> +  - Shengjiu Wang <shengjiu.wang@nxp.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fsl,imx-audio-rpmsg
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: User specified audio sound card name
> +
> +  audio-cpu:
> +    description: The phandle of an CPU DAI controller
> +
> +  rpmsg-out:
> +    description: |
> +      This is a boolean property. If present, the transmitting function
> +      will be enabled,
> +
> +  rpmsg-in:
> +    description: |
> +      This is a boolean property. If present, the receiving function
> +      will be enabled.
> +
> +required:
> +  - compatible
> +  - model
> +  - audio-cpu
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sound-rpmsg {
> +        compatible = "fsl,imx-audio-rpmsg";
> +        model = "ak4497-audio";
> +        audio-cpu = <&rpmsg_audio>;
> +        rpmsg-out;
> +    };
> -- 
> 2.27.0
> 
