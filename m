Return-Path: <SRS0=PysP=C7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C60C4727C
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:41:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 641852395B
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Sep 2020 15:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Wamvkeqx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 641852395B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A94A171E;
	Tue, 22 Sep 2020 17:40:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A94A171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600789284;
	bh=KFrvDEq/8TqB+9RYqLZtje/rGaAWyDrwgCKimpJ4yQU=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=WamvkeqxTjMDfIXeKcMVc+ecanthb/Poyz7FyaeBmqePIVYa56EBwfBFWVsoOQh9g
	 qLDxENpRhe6S1U8SHlUbwINOVGKlM8rgn4h4D/TXB/pjrP3IGxZR+S28Egv5kXYVOY
	 i9CNDKJm6PBny5+nm1LbjR6MkLgZPRbhIF5INYz0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 19616F80229;
	Tue, 22 Sep 2020 17:40:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B1360F8010A; Tue, 22 Sep 2020 17:40:32 +0200 (CEST)
Received: from mail-il1-f196.google.com (mail-il1-f196.google.com
 [209.85.166.196])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 65DC2F8010A
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2020 17:40:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 65DC2F8010A
Received: by mail-il1-f196.google.com with SMTP id t12so17730090ilh.3
 for <alsa-devel@alsa-project.org>; Tue, 22 Sep 2020 08:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8GdJRN6siN1K/3VUt/RzQ7dwFh0PUHODAfHPAkJXVec=;
 b=eP1YKsbdakSHPKDrOEKcLl9PbvBIOlZYau4ruiHc+2kZAXKxhLR7JYWj5omGX5X87L
 0Sz6rcRD+Mwb7NR2iYl8eBjtEIygANt+M6y11OK0PBLJIwVoK8TM+S+X7STOPc1yBE43
 o+jQC2ePhXCBHrM7MAuwK0aTLsjwsw6Jo8qQe9sS/6XOD+2B6bDye1i9VyY4h9kkZixH
 b1GmxbNQbUrjxlAJWaeWzAkYlv2G3GzqovP5qRMW3TU/vM1ZsU3/pkHxSbL0CKoPN0iQ
 9tgPKEDz+vr1LjYjN3hyq11jsSbA3GIdC//FpDdGIi9sxA6NEVnDOHqkO273nBfGcSR1
 c8Hg==
X-Gm-Message-State: AOAM530gGao1+sT2uyum4HSt6UwrqiiCidrNby1wVEHpdCZXt1bkj6Gj
 8u0D0k35rf0FkOSFI8A0iQ==
X-Google-Smtp-Source: ABdhPJyREJxSIdBKii6r07HwAtgscFY+xZM0Hzr/ADdWxpwvmnoH8SQzW6oBqLEpp2gzISGF/n+Kjw==
X-Received: by 2002:a92:b503:: with SMTP id f3mr4935318ile.23.1600789220548;
 Tue, 22 Sep 2020 08:40:20 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id e4sm7533543iom.14.2020.09.22.08.40.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 08:40:19 -0700 (PDT)
Received: (nullmailer pid 2730094 invoked by uid 1000);
 Tue, 22 Sep 2020 15:40:18 -0000
Date: Tue, 22 Sep 2020 09:40:18 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 01/13] dt-bindings: gpio: add common schema for GPIO
 controllers
Message-ID: <20200922154018.GA2657058@bogus>
References: <20200917165301.23100-1-krzk@kernel.org>
 <20200917165301.23100-2-krzk@kernel.org>
 <CAL_JsqJCLgf6syqV=jNPHPyu02ygwWCDDV+U9VCm0qRpLkirSQ@mail.gmail.com>
 <20200920193915.GA31074@kozik-lap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200920193915.GA31074@kozik-lap>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Fabio Estevam <festevam@gmail.com>, "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>,
 devicetree@vger.kernel.org, Ray Jui <rjui@broadcom.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-unisoc@lists.infradead.org,
 "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
 Scott Branden <sbranden@broadcom.com>,
 "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "open list:MEDIA DRIVERS FOR RENESAS - FCP"
 <linux-renesas-soc@vger.kernel.org>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Shawn Guo <shawnguo@kernel.org>
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

On Sun, Sep 20, 2020 at 09:39:15PM +0200, Krzysztof Kozlowski wrote:
> On Fri, Sep 18, 2020 at 08:30:02AM -0600, Rob Herring wrote:
> > On Thu, Sep 17, 2020 at 10:53 AM Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > Convert parts of gpio.txt bindings into common dtschema file for GPIO
> > > controllers.  The schema enforces proper naming of GPIO controller nodes
> > > and GPIO hogs.
> > 
> > Did you not see my previous reply about a common schema? We already
> > have a common GPIO and hog schema in dtschema. Please add to it
> > whatever is missing.
> 
> Indeed, I'll enhance the dt-schema.
> 
> The trouble is that each in-kernel YAML file still has to mention
> possible gpio-hogs nodes. Is the proper solution to put them in common
> YAML inside kernel sources?

Currently, the gpio.yaml schema is applied to all nodes. That has the 
advantage that GPIO related properties are always checked whether we 
have a device specific schema or not. It has the disadvantage that you 
can't do some constraints like required properties or what's in child 
nodes.

We could (and probably should) change it to be referenced by specific 
gpio controller schemas like we do for i2c, spi, etc. Then you can 
define required properties there and do something like:

"-hogs$":
  type: object
  $ref: gpio-hogs.yaml#


> > My goal is all common schema end up in dtschema, but I haven't pushed
> > folks to do that yet. Ones I've done are there though. One issue is
> > what's in dtschema should be GPL/BSD and the existing text bindings
> > are default GPL, so there's a relicensing exercise. In some cases, the
> > schema is there but I haven't copied over the descriptions.
> 
> Right, I'll skip the descriptions when posting to dt-schema.

I was hoping someone would add the descriptions. :)

Rob
