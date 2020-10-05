Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A06DC4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:41:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41E4220776
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="bt5Id+er";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AXAmvxEc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41E4220776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76CE317E7;
	Mon,  5 Oct 2020 16:40:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76CE317E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601908890;
	bh=1SjhJ/6uMtSElnu5XBPgSgCo1FlUJP7BgyspznmXQNU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=bt5Id+erlZ18ow1WJDKpyEW25t/ou1mxYMkIfieE3LH+8bbMGANxAD/tHYcSTxca+
	 oMm9UBkThIj1dp/LuXqgBbeRscUKlV5Xdy67WzMsE99Ekw/fF7oIxltYLIicHT2yEp
	 Qu08/Vs+6u3uqjzirhDdtL1zIoMox4ZoKPmPcuRs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6A589F802E7;
	Mon,  5 Oct 2020 16:38:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A95ADF8025A; Mon,  5 Oct 2020 10:26:51 +0200 (CEST)
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com
 [IPv6:2607:f8b0:4864:20::e44])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B276FF800EF
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 10:26:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B276FF800EF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org
 header.b="AXAmvxEc"
Received: by mail-vs1-xe44.google.com with SMTP id g11so3770170vsp.13
 for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2020 01:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=41Y6sjMmjcMlV2JauZyN/TxOh6umZ/keewCU2mb8LIc=;
 b=AXAmvxEcZgWulidtPjWzcdr2Qm2OYOtZA0wDa8FmovT91MPeLRIwIVCT8lx9v5UNlG
 SctQfxm1GmrUHlaNPX+RFUQtBHXdidJ0/CU1C9clQS0l30cTxEkteaWVnvPQuLuFSdee
 4MV2Fpon9L5TsVQGS1K3gSKttvhofJOiwA9P0bVAeb/tNn5WAcwRk5Be/IAOdU2QkdYn
 VFrey16k5OCZxA1L7Q1xqspPxsd/+WYGgx9scKUGZYuyhxSBuKF1PhH1KfSOoQx2J5OY
 401UuKSNx0/BKxG4Vky36hMzFvsFJwDUWIuAQewHgLK5qqZWGGWEkqztdK9+VC+FKpcj
 S9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=41Y6sjMmjcMlV2JauZyN/TxOh6umZ/keewCU2mb8LIc=;
 b=H6tUEYzwlX9lqcUvbQQfjqT0tGeEglj8RNrbMqAFEbifI8UjIMWwUEHF21Fedxfvcb
 mIBYhHSxQt+qb9fqbG7h3JtO4UCHyxDSdQi/4e6PEHAxv/nY71E4e/C9jLxNdWNshGl7
 Dm0YNHXM1k+gHd1i27Nu11Qe6gbDmWWHSA2Cf43TtEKxaBUE8NJYey9ZB4cuMn8Dtjs6
 4+LIJlEpjqEHBXXO3KAdn7rm1OsYpQnikaD/hbJTj+BYzDzPl3gBN7gXXTQ/aQzkXP4z
 fc6ORRzmi7XBz6vi6c6pvZs0xJyy0qdKPQ04yuucJti06zDxk4COXNMj3caJEWz1dKuA
 3kow==
X-Gm-Message-State: AOAM531BIIfRdzCr8yD8BhUQxjHYqntCDktjYTQW2o3O6DGDRgKU1k+u
 yuOu1VyaaqNjLRaH8DD5RZ2db2woct/JzLXZY7eLbw==
X-Google-Smtp-Source: ABdhPJxlPMGygHVTcnGIf5MQvmk2y9YM/OMFZ7y/LPtKUwwQZxTgA80YvlEMQPDfoWIYZailBQzIdWarus99WB2IvNI=
X-Received: by 2002:a67:ec9a:: with SMTP id h26mr6751269vsp.34.1601886397228; 
 Mon, 05 Oct 2020 01:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <20201002234143.3570746-1-robh@kernel.org>
In-Reply-To: <20201002234143.3570746-1-robh@kernel.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 5 Oct 2020 10:26:01 +0200
Message-ID: <CAPDyKFq=ZUiYhm0-K5ZVYS1FH2O5e-+Gt6Dftf=LmL9ABa7CaA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Another round of adding missing
 'additionalProperties'
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Mon, 05 Oct 2020 16:38:46 +0200
Cc: alsa-devel@alsa-project.org, linux-iio@vger.kernel.org,
 Linux PCI <linux-pci@vger.kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-remoteproc@vger.kernel.org,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Lee Jones <lee.jones@linaro.org>,
 linux-clk <linux-clk@vger.kernel.org>, linux-leds@vger.kernel.org,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-stm32@st-md-mailman.stormreply.com,
 "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
 linux-serial@vger.kernel.org, linux-mips@vger.kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 DTML <devicetree@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 openipmi-developer@lists.sourceforge.net,
 Bjorn Andersson <bjorn.andersson@linaro.org>, linux-hwmon@vger.kernel.org,
 Stephen Boyd <sboyd@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux USB List <linux-usb@vger.kernel.org>,
 "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-spi@vger.kernel.org,
 Vinod Koul <vkoul@kernel.org>, netdev <netdev@vger.kernel.org>,
 Baolin Wang <baolin.wang7@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jonathan Cameron <jic23@kernel.org>
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

On Sat, 3 Oct 2020 at 01:41, Rob Herring <robh@kernel.org> wrote:
>
> Another round of wack-a-mole. The json-schema default is additional
> unknown properties are allowed, but for DT all properties should be
> defined.
>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Baolin Wang <baolin.wang7@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-clk@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-spi@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-hwmon@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Cc: openipmi-developer@lists.sourceforge.net
> Cc: linux-leds@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-rockchip@lists.infradead.org
> Cc: linux-stm32@st-md-mailman.stormreply.com
> Cc: linux-mips@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> Cc: netdev@vger.kernel.org
> Cc: linux-pci@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: linux-remoteproc@vger.kernel.org
> Cc: linux-serial@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>
> I'll take this thru the DT tree.
>

[...]

>  .../bindings/mmc/mmc-pwrseq-emmc.yaml         |  2 ++
>  .../bindings/mmc/mmc-pwrseq-sd8787.yaml       |  2 ++
>  .../bindings/mmc/mmc-pwrseq-simple.yaml       |  2 ++

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
