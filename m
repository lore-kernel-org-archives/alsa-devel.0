Return-Path: <SRS0=ZrTp=W5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A4A0C3A59E
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 13:40:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68F3216C8
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Sep 2019 13:40:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Xiy8HN9Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68F3216C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E899016BF;
	Mon,  2 Sep 2019 15:39:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E899016BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567431607;
	bh=fEzn31ovoNrGUKtIG6GYFDMtX92JDhqdBLb5edCP6Xg=;
	h=Date:From:To:References:In-Reply-To:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Xiy8HN9YPiJWApsfV2XDUwYoPQqc8LQJ9rxEljyc+5dxD+uZsgrFSa+U8/52CEi3F
	 y4zp+KfQ1q5xkLvSdCjtBATSVUzPrTnw/BqK22HsLcGQ3yoGan5MZx2dVHNtwN0P8Z
	 RbVL8znccVLKty/LRsNQN4qPJ7LlH48jlUtJEx74=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7C955F80394;
	Mon,  2 Sep 2019 15:39:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CCB9FF803D0; Mon,  2 Sep 2019 15:39:14 +0200 (CEST)
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3BA47F802E0
 for <alsa-devel@alsa-project.org>; Mon,  2 Sep 2019 15:39:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3BA47F802E0
Received: by mail-wm1-f67.google.com with SMTP id d16so14655039wme.2
 for <alsa-devel@alsa-project.org>; Mon, 02 Sep 2019 06:39:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=viDwZpOARz1cFM6lOwQ1Yo70h5ns2nY224fON3ziGZ0=;
 b=ijkJdJ06lb6zOCGRIDMtulxkjC+/NIrXNbq+CaKILyFft7EZvEamqG0mOkigR/p/L4
 K2wNUhzqnF+BaFuAh2eYXgcPFcsNUFWFTUnQyaOvEM3AbLWfjeNK/8Eh6BEG9av/6z/E
 wvKLYIfL/2NCemdZACmsbDiAcbEH6vTA5N/e1JvC9eIFktTWlrjukr7qdBh6mf2ox0w1
 6SOjQWOi/leGxjIRUDwYsjAZKVpIwsvjFa9To4KjHRKziN/60cOxN4Hip59mcu2r6q14
 UcOMrLwehYRokI+4Xlr5pMzcW9zjmUXoKgLY4ZEZclnPJWYCKOpfhDhhFBzyFej+Ads+
 gFYA==
X-Gm-Message-State: APjAAAUkieo4eVQZklpcs9DQXQv7jMMwIMcz2qWp9jnbc6/wN/pTlyat
 8tFL+TZjqsRdJyUzAdbPEA==
X-Google-Smtp-Source: APXvYqxdFPgNrwKSJzlloeKFZWB965JRx6jQia5i73v3szd87dRMibiKtLQqdaSZgMepWZVR2jwaZw==
X-Received: by 2002:a7b:c7cc:: with SMTP id z12mr16711817wmk.80.1567431551009; 
 Mon, 02 Sep 2019 06:39:11 -0700 (PDT)
Received: from localhost ([212.187.182.166])
 by smtp.gmail.com with ESMTPSA id m23sm19628786wml.41.2019.09.02.06.39.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Sep 2019 06:39:10 -0700 (PDT)
Date: Mon, 02 Sep 2019 14:39:09 +0100
From: Rob Herring <robh@kernel.org>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Message-ID: <20190902044231.GA17348@bogus>
References: <20190830210607.22644-1-miquel.raynal@bootlin.com>
 <20190830210607.22644-2-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190830210607.22644-2-miquel.raynal@bootlin.com>
X-Mutt-References: <20190830210607.22644-2-miquel.raynal@bootlin.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 alexandre@bootlin.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Michal Simek <michal.simek@xilinx.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [alsa-devel] [PATCH 2/3] dt-bindings: sound: Add Xilinx
 logicPD-I2S FPGA IP bindings
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

On Fri, Aug 30, 2019 at 11:06:06PM +0200, Miquel Raynal wrote:
> Document the logicPD I2S FPGA block bindings in yaml.
> 
> Syntax verified with dt-doc-validate.
> 
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---
>  .../bindings/sound/xlnx,logicpd-i2s.yaml      | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/xlnx,logicpd-i2s.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/xlnx,logicpd-i2s.yaml b/Documentation/devicetree/bindings/sound/xlnx,logicpd-i2s.yaml
> new file mode 100644
> index 000000000000..cbff641af199
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/xlnx,logicpd-i2s.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/xlnx,logicpd-i2s.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Device-Tree bindings for Xilinx logicPD I2S FPGA block
> +
> +maintainers:
> +  - Miquel Raynal <miquel.raynal@bootlin.com>
> +
> +description: |
> +  The IP supports I2S playback/capture audio. It acts as a slave and
> +  clocks should come from the codec. It only supports two channels and
> +  S16_LE format.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: xlnx,logicpd-i2s
> +
> +  reg:
> +    maxItems: 1
> +    description:
> +      Base address and size of the IP core instance.
> +
> +  interrupts:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description: tx interrupt
> +      - description: rx interrupt
> +    description:
> +      Either the Tx interruption or the Rx interruption or both.

The schema says either tx or both. Doesn't really matter here as it's 
just numbers.

> +
> +  interrupt-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: tx
> +      - const: rx

But here it does matter.

The easiest way to express this is:

oneOf:
  - items:
      - enum: [ tx, rx ]
  - items:
      - const: tx
      - const: rx

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - interrupts-controller
> +
> +examples:
> +  - |
> +    logii2s_dai: logii2s-dai@43c10000 {
> +        reg = <0x43c10000 0x1000>;
> +        compatible = "xlnx,logicpd-i2s-dai";
> +        interrupt-parent = <&intc>;
> +        interrupts = <0 29 IRQ_TYPE_LEVEL_HIGH>, <0 30 IRQ_TYPE_LEVEL_HIGH>;
> +        interrupt-names = "rx", "tx";
> +    };
> -- 
> 2.20.1
> 

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
