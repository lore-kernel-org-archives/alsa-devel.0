Return-Path: <SRS0=AHG6=N4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA8EC433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Sep 2021 09:34:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD84E60E76
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Sep 2021 09:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DD84E60E76
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C2717173C;
	Mon,  6 Sep 2021 11:33:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C2717173C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630920884;
	bh=Uqc2eiKS0G4mpieSadwIi5HbWx5nH0ZaVy1KN0ZjcfA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GkdX7I+1dtIjV3fXSJUg/60GZkWquOm1uzRS6hukXAYkeXRnmNBi1odLMpbUoAlj4
	 Hnno+hELesfvrICkdq64/AEH8PxyjOOirlM8Qrg0tJTNyQ2EdKNiigsBAItD9qMXGH
	 aBq9T85d6Gb3BHrYj999G+cr4Rq55ENpG7FCBuN8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EE79F8026C;
	Mon,  6 Sep 2021 11:33:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5851FF802E7; Mon,  6 Sep 2021 11:33:53 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D9C8F800C7
 for <alsa-devel@alsa-project.org>; Mon,  6 Sep 2021 11:33:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D9C8F800C7
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="q9eDwDZx"
Received: by mail-wr1-x433.google.com with SMTP id q26so7926770wrc.7
 for <alsa-devel@alsa-project.org>; Mon, 06 Sep 2021 02:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=i2+NvsBgnBTOZ+uAcUxvlIaM13WedkLbcL6bup+H1UM=;
 b=q9eDwDZxue+JjKYKIP+w/ygZ5RrOIy/6a/V0xWsuwzRdA+DY9pSefRgNpnnYpm5BQZ
 jcdsEFl+fmxv1rv5K31l4dvYsDgRRwrUDRSzPK+5TxnLrRKkeZrRIMX8t00nTTDrCsNi
 uf638hMv8OsnzcALsgDmG4mf5Gq7vuKLtqqOIWfbZSTBJC9+5AAZImMHCH6jbKGweNZY
 0rFAtFa8MeWkgidZTVKx5NAsJxCv7TwpC8fsiZdr5uQa0ixm8d4bVKAPP52HXRvZ99cf
 Q+yyT+iPmmajoU/79Hm6iTVhB2TuOulKMfd2QGm1q9pIns3NH7VucMIJue0cMY68rhls
 XvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=i2+NvsBgnBTOZ+uAcUxvlIaM13WedkLbcL6bup+H1UM=;
 b=o51cl3qsHpReaus/ju9AEYSJ1JOg9d+FJVaDacQEbm9F/JW0c7xGH2HMBWpwSW5+Kz
 1X9BWOg9xkTx1UWH4VTI+kFRXDiXN2GbWMPwp98+7IcbjbrfZ5wgFx5d4zrr/aRBKbwW
 BEe1Kb5yW6PKR7jQNIxfluakKO6sO+lhiBFBRsrrNj3A1fV7iHmDsTdmE0n45rs9NSA+
 O5fSLnSKCOiBd7UpQsr+ipaMwOK6pdaA9/pCOyUX25ONtFJ26FX6+th5EipB18TuRHhC
 ksD8d/KMWBC1XP6TSDwzGuAoHu9w/TZBOOFayi1ZE4ebdJxrsiqUK01sB5uuWdHGhSmf
 Nh5Q==
X-Gm-Message-State: AOAM531ckZR+mrRHtlXgM5/k/Z6DilWpzai1OkcsHhRXf57T7+VJI7/8
 MhPMVDHEMPed/vk36Z+SZ1TpPA==
X-Google-Smtp-Source: ABdhPJzzIakAt8tQ+64AcWO9lDYlr4Dh32B1+kDEcgR0qe3zm7ry+opFn+4PQ93e0dV7eey6Ev0dkg==
X-Received: by 2002:adf:8006:: with SMTP id 6mr12342436wrk.38.1630920822630;
 Mon, 06 Sep 2021 02:33:42 -0700 (PDT)
Received: from google.com ([31.124.24.187])
 by smtp.gmail.com with ESMTPSA id i21sm7106080wrb.62.2021.09.06.02.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Sep 2021 02:33:42 -0700 (PDT)
Date: Mon, 6 Sep 2021 10:33:39 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Use 'enum' instead of 'oneOf' plus 'const'
 entries
Message-ID: <YTXgc/GhZVKzJR9H@google.com>
References: <20210824202014.978922-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210824202014.978922-1-robh@kernel.org>
Cc: alsa-devel@alsa-project.org, Vignesh R <vigneshr@ti.com>,
 linux-pci@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-phy@lists.infradead.org, Marc Zyngier <maz@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Kishon Vijay Abraham I <kishon@ti.com>, linux-serial@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 linux-spi@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, netdev@vger.kernel.org,
 dmaengine@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

On Tue, 24 Aug 2021, Rob Herring wrote:

> 'enum' is equivalent to 'oneOf' with a list of 'const' entries, but 'enum'
> is more concise and yields better error messages.
> 
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Vignesh R <vigneshr@ti.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: dmaengine@vger.kernel.org
> Cc: linux-i2c@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-phy@lists.infradead.org
> Cc: linux-serial@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/display/msm/dsi-phy-10nm.yaml           |  6 +++---
>  .../bindings/display/msm/dsi-phy-14nm.yaml           |  6 +++---
>  .../bindings/display/msm/dsi-phy-28nm.yaml           |  8 ++++----
>  .../bindings/dma/allwinner,sun6i-a31-dma.yaml        | 12 ++++++------
>  .../devicetree/bindings/firmware/arm,scpi.yaml       |  6 +++---
>  .../devicetree/bindings/i2c/ti,omap4-i2c.yaml        | 10 +++++-----
>  .../interrupt-controller/loongson,liointc.yaml       |  8 ++++----
>  .../devicetree/bindings/media/i2c/mipi-ccs.yaml      |  8 ++++----
>  .../devicetree/bindings/mfd/ti,lp87565-q1.yaml       |  6 +++---

Acked-by: Lee Jones <lee.jones@linaro.org>

>  .../devicetree/bindings/net/realtek-bluetooth.yaml   |  8 ++++----
>  .../bindings/net/ti,k3-am654-cpsw-nuss.yaml          |  8 ++++----
>  .../devicetree/bindings/net/ti,k3-am654-cpts.yaml    |  6 +++---
>  Documentation/devicetree/bindings/pci/loongson.yaml  |  8 ++++----
>  .../devicetree/bindings/phy/intel,lgm-emmc-phy.yaml  |  6 +++---
>  .../devicetree/bindings/serial/8250_omap.yaml        |  9 +++++----
>  .../devicetree/bindings/sound/qcom,sm8250.yaml       |  6 +++---
>  .../devicetree/bindings/sound/tlv320adcx140.yaml     |  8 ++++----
>  .../devicetree/bindings/spi/realtek,rtl-spi.yaml     | 12 ++++++------
>  .../devicetree/bindings/timer/arm,sp804.yaml         |  6 +++---
>  19 files changed, 74 insertions(+), 73 deletions(-)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
