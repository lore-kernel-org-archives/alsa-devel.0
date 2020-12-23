Return-Path: <SRS0=3cEE=F3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B535AC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 17:55:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0352F20E65
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 17:55:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0352F20E65
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5C7E11815;
	Wed, 23 Dec 2020 18:54:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5C7E11815
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608746140;
	bh=oPqcaaIT1m4gIwPH079KHo8KUmZzg7kgDIJDYuGMcvY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=UplPCAUYw8aGBd8yMZeoeWDD4//CZpmQjGyaJ35Z3noQVtRhUOTJh5X4tbl6/CHWI
	 he/dqWd1MQ4YfCVOahsbrKg+/kTuqL60gLvpO5hKWzR4x+5k+r2+kNFo9zwIZ1qkhF
	 nQSwrgeKeUsL55yTWSHIqlSvEox2fcICZgLAXaaQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1191F80168;
	Wed, 23 Dec 2020 18:54:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FDD6F801D5; Wed, 23 Dec 2020 18:54:49 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A5E10F800BC
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2020 18:54:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A5E10F800BC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="bGpft4Kp"
Received: by mail.kernel.org (Postfix) with ESMTPSA id C177320C56
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2020 17:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1608746080;
 bh=oPqcaaIT1m4gIwPH079KHo8KUmZzg7kgDIJDYuGMcvY=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=bGpft4Kpb7t5T4fX8lhByN60ObxwL55nWpJzhHIelAITSWX0bvXmtegxYSTJN4Zxl
 T4sw2s1rmwoiwLPiUIW7JGyIM7tfyWPnaZisRDvAs56K9bnVV2r258Zllrq3efIw60
 Xqk7ptA15HCr4vleatHRwHYA+XPQo+P9s0tUyVvqfM28vAKVchNYK9O9jkO7C/YG3J
 N3N0SD38qtziXLRLBOdDTI40f9Ewmzt3R/AhxsHnnvnilbxQYSPWroVyn6u2P8sFfD
 AHY6JNQEDjZCOeioDkjceA8EfiEeZB5mmjnxg6UiXX0BLHhkUQ1hp7GaO94jA5tBIo
 4fWkBpGhcIocg==
Received: by mail-ej1-f52.google.com with SMTP id ga15so296121ejb.4
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2020 09:54:39 -0800 (PST)
X-Gm-Message-State: AOAM531CsnBX+dxqFIL5FfMEfKEC6LRUg+JKTSODgECXp1B6hPO+uht0
 HTe5sm9tjGm5Kvh6NYYYathe1ljaLA3n3+m7Cg==
X-Google-Smtp-Source: ABdhPJz3x4J2zw5Y7TPch4DTKXpgAX9t6V701Sxc80NsHgTOESjuz9DoVFaywy8F4VyXHmox/Q09SCSZQsxP2YotFOM=
X-Received: by 2002:a17:906:4146:: with SMTP id
 l6mr25366789ejk.341.1608746078387; 
 Wed, 23 Dec 2020 09:54:38 -0800 (PST)
MIME-Version: 1.0
References: <20201222040645.1323611-1-robh@kernel.org>
 <20201222063908.GB3463004@ravnborg.org>
In-Reply-To: <20201222063908.GB3463004@ravnborg.org>
From: Rob Herring <robh@kernel.org>
Date: Wed, 23 Dec 2020 10:54:26 -0700
X-Gmail-Original-Message-ID: <CAL_JsqJLw_RtLehYDLu_HKCoxDHsx-AdGTWfN0JMJhgNqLeFng@mail.gmail.com>
Message-ID: <CAL_JsqJLw_RtLehYDLu_HKCoxDHsx-AdGTWfN0JMJhgNqLeFng@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Drop redundant maxItems/items
To: Sam Ravnborg <sam@ravnborg.org>
Content-Type: text/plain; charset="UTF-8"
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux USB List <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>
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

On Mon, Dec 21, 2020 at 11:39 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Rob,
>
> On Mon, Dec 21, 2020 at 09:06:45PM -0700, Rob Herring wrote:
> > 'maxItems' equal to the 'items' list length is redundant. 'maxItems' is
> > preferred for a single entry while greater than 1 should have an 'items'
> > list.
> >
> > A meta-schema check for this is pending once these existing cases are
> > fixed.
> >
> > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Mark Brown <broonie@kernel.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Jassi Brar <jaswinder.singh@linaro.org>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: dmaengine@vger.kernel.org
> > Cc: alsa-devel@alsa-project.org
> > Cc: linux-usb@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
>
> With one comment below,
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>
> > ---
> > diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> > index 737c1f47b7de..54c361d4a7af 100644
> > --- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> > +++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> > @@ -74,11 +74,8 @@ properties:
> >
> >    phys:
> >      maxItems: 1
> > -    items:
> > -      - description: phandle + phy specifier pair.
>
> The description may help some people, so keeping the
> description and deleting maxItems would maybe be better.

Do we really want to describe 'phys' hundreds of times? No. The
question I ask on the descriptions is could it be generated instead.

Rob
