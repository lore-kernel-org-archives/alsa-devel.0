Return-Path: <SRS0=3cEE=F3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4FEC433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 17:49:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FC65207D2
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 17:49:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FC65207D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9AE9E17E0;
	Wed, 23 Dec 2020 18:48:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9AE9E17E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608745787;
	bh=qt4fd8kyPLRYqphlWNaaozWM8NiBWkUzLZdGPp/+wsg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nCBRpj0EgTbB7JYncQL5Q1TUJZuWXWEzMlqbbtfHcrCUoQj7RfdM6r51Aj+lMC3UX
	 WG+IaIFg6pZedrDhq0VWuFew42a7pYkzUjb5znDYUcMnsTOxpaB7C1+Knsm1eiNXWG
	 Gq59a7cvInEfuJ6TFFRxy/ERxYase9PwpiV4pE5s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7CF19F80506;
	Wed, 23 Dec 2020 18:45:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1913BF80224; Tue, 22 Dec 2020 17:40:16 +0100 (CET)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com
 [IPv6:2607:f8b0:4864:20::62d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 102ACF80116
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2020 17:40:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 102ACF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.b="XBZl/fP8"
Received: by mail-pl1-x62d.google.com with SMTP id j1so7708132pld.3
 for <alsa-devel@alsa-project.org>; Tue, 22 Dec 2020 08:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=XA14ElTeUosr9Ce812CRm87QO2rKQtr679G385v8kMg=;
 b=XBZl/fP8JfaKjImHJU56Okh7Pmq6oSlqsbjWtruce/kIO+jNbne6lPveMeQNQxnp5g
 +pLF+j+xuYF+XItUHD9rfD7VgypsMkmaK4nZpJHJen72knZ1pLBtdHdXDQxE0BC9Abuo
 mDIHGzkXvFPSxBY8Van6Xt+9NYy1KH+7/f6nWtI7nfPVkJpq3+bCiVwi6NIsm96Hi7cL
 xoYGhxL+b298xlYDlZyhkmbOYST4O3GRlyHcQOjcGS/uADxtKhbdw+TofsHeS4LqtMAc
 aKrOjvIvuZtyW07CYTs1Goinb3iDKTwpMNyt6HXSEU2k/xhq895exHFUv2vhPgKJJLjF
 Qr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=XA14ElTeUosr9Ce812CRm87QO2rKQtr679G385v8kMg=;
 b=jcJVrM/oBbGKigi1K+91yuA+cPLN9LeQTVpshDmPHqz2fRB9Gd+mF/luJvAKAAxd8z
 eRJ58T1ZWXwaGpSsIOp6QRbkhauSXvVc5poIPbOv1n4Hhrny5+ixC2vP9wxoHjKHJyzc
 hBEyrauwz8Is0W6hiunxHVk2yB/RhOPv3HRc4PrYA0LpIeEQBWxT5rDpEMV+XK132yeK
 p4+qbP2pelUFlWc1O7qwAKeFmhFRCZutA0cxcRG3ofQKSflulAxUdKd3BAyiBxUp3dZR
 FHZV+FHw31ss6H8uyVwBr8hDk+Beo5OF2FNbGHgburlAxYU3LrvZ7MO/ixDPh82zxxBi
 VA3A==
X-Gm-Message-State: AOAM5338Hso1dBID0ByJyygX/7xrZ3vp5hP1pQDpVaz6aTsNWmhqCZ+P
 5cdrv3WGPG6NJnTJCMmHCv4VPQYT81zki2t2pJk=
X-Google-Smtp-Source: ABdhPJzIwF2uyoRs5h3zHcpXR9B8X/+Kqf1ghnirkIrgLeEnyEAF8eGlnlscDztG0W09G5UHgi1pkkPM9Nt/7w4z4jE=
X-Received: by 2002:a17:902:82c7:b029:da:cb88:38f8 with SMTP id
 u7-20020a17090282c7b02900dacb8838f8mr22192274plz.49.1608655205691; Tue, 22
 Dec 2020 08:40:05 -0800 (PST)
MIME-Version: 1.0
References: <20201222040645.1323611-1-robh@kernel.org>
In-Reply-To: <20201222040645.1323611-1-robh@kernel.org>
From: Jassi Brar <jassisinghbrar@gmail.com>
Date: Tue, 22 Dec 2020 10:39:55 -0600
Message-ID: <CABb+yY0Q+7vqoVsHJEdP4r9+RwhjEKoBHnKRtGqKc3BNAP_SCQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: Drop redundant maxItems/items
To: Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailman-Approved-At: Wed, 23 Dec 2020 18:45:49 +0100
Cc: Devicetree List <devicetree@vger.kernel.org>, alsa-devel@alsa-project.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 dri-devel@lists.freedesktop.org, Jassi Brar <jaswinder.singh@linaro.org>,
 Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 dmaengine@vger.kernel.org
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

On Mon, Dec 21, 2020 at 10:10 PM Rob Herring <robh@kernel.org> wrote:
>
> 'maxItems' equal to the 'items' list length is redundant. 'maxItems' is
> preferred for a single entry while greater than 1 should have an 'items'
> list.
>
> A meta-schema check for this is pending once these existing cases are
> fixed.
>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jassi Brar <jaswinder.singh@linaro.org>
> Cc: dri-devel@lists.freedesktop.org
> Cc: dmaengine@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-usb@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/display/xlnx/xlnx,zynqmp-dpsub.yaml    | 1 -
>  Documentation/devicetree/bindings/dma/renesas,rcar-dmac.yaml   | 1 -
>  Documentation/devicetree/bindings/mailbox/arm,mhu.yaml         | 1 -
>  .../devicetree/bindings/sound/nvidia,tegra30-hda.yaml          | 2 --
>  Documentation/devicetree/bindings/usb/renesas,usb-xhci.yaml    | 1 -
>  Documentation/devicetree/bindings/usb/renesas,usbhs.yaml       | 3 ---
>  6 files changed, 9 deletions(-)

Acked-by: Jassi Brar <jassisinghbrar@gmail.com>
