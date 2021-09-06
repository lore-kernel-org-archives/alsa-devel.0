Return-Path: <SRS0=AHG6=N4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC856C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Sep 2021 10:41:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6857D60EBA
	for <alsa-devel@archiver.kernel.org>; Mon,  6 Sep 2021 10:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6857D60EBA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2C5C815E2;
	Mon,  6 Sep 2021 12:40:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2C5C815E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1630924881;
	bh=DDPfs7HWdQxUNn6g1tSkQLKbmCHfs6sAw/+UHBIdi/M=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BxfDyeeXkpUi9Sbozt+pKdXsnPt9MRwooxlNxoO1LeIBGqnWcwdxtm/OLZBS2QjY5
	 nAGgyC2I1iRAspw7KWD0TdxeR3nA75itW8IZkKfzlNQq/IlFp/kE+Bxpx05+ptc2AG
	 KYvXJpWaB9WBg9YhsMOjklbQpgyt/mq/tMf9knGE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9A578F8026C;
	Mon,  6 Sep 2021 12:40:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FDF1F802E7; Mon,  6 Sep 2021 12:40:28 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5D374F800B5
 for <alsa-devel@alsa-project.org>; Mon,  6 Sep 2021 12:40:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5D374F800B5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="Th9BCpYB"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1920B60EBA;
 Mon,  6 Sep 2021 10:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1630924818;
 bh=DDPfs7HWdQxUNn6g1tSkQLKbmCHfs6sAw/+UHBIdi/M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=Th9BCpYBnVmKPtw+yozEi03DflXbpHZnsOAy4Jc0WTQbi+twSgb1XrzHHguyEtFuD
 unLwYfRWOgpMIlwzUdVta6PvLtBhb/hhKQ5qEENKV7U9Q2LFFvwWeMqWPPk6Ap99ke
 t2pEWUD6KxAncNF8dArN3EdFE4wFqS1pAblmOOdgP+5BvHtbm3NKW50g544B2Y1M7A
 0XwU7gfX6Z1zYK/ZPcefKlnE2u5JqlMtdYXMpq/QSt/s/+ZJTfO/4ugaIfwejhWnlB
 f5vXatWtRfzOn3a/PJ5ZMIbaUJ+VquKa0OnNdFXWmQbxRvwTPgstQShQxiAmi1QiQD
 A+2M66YfjlnIQ==
Date: Mon, 6 Sep 2021 12:40:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Use 'enum' instead of 'oneOf' plus 'const'
 entries
Message-ID: <20210906124011.66b8e9f3@coco.lan>
In-Reply-To: <20210824202014.978922-1-robh@kernel.org>
References: <20210824202014.978922-1-robh@kernel.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: alsa-devel@alsa-project.org, Vignesh R <vigneshr@ti.com>,
 linux-pci@vger.kernel.org, linux-i2c@vger.kernel.org,
 linux-phy@lists.infradead.org, Lee Jones <lee.jones@linaro.org>,
 Marc Zyngier <maz@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Kishon Vijay Abraham I <kishon@ti.com>, linux-serial@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, linux-media@vger.kernel.org,
 devicetree@vger.kernel.org, Maxime Ripard <mripard@kernel.org>,
 Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
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

Em Tue, 24 Aug 2021 15:20:14 -0500
Rob Herring <robh@kernel.org> escreveu:

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

For media:

Acked-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thanks,
Mauro
