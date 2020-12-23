Return-Path: <SRS0=3cEE=F3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB9BC43381
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 17:58:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA3B221FA
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Dec 2020 17:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA3B221FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 785B7181A;
	Wed, 23 Dec 2020 18:57:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 785B7181A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1608746304;
	bh=aIE8xGXf1HCeioV2CtalepWGwUaG6UD1DR44h6nu1dw=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LXmeRQrY/1gO7Fi0uEsQKRoUIziPWMPbFWhVmMou2cNKFG1S+GL1tduTdVpOp6ZaI
	 H2Qy+Kp1nuCY9vMU7o+8C0kzWWJXAGzHwzByLN8oDXozQR9Lx4HhgIrByNtgvXiL+V
	 lpZouwqL3pjg8Ze3hvAftwfyVSpa5oT/yI/Pdclo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EC480F80168;
	Wed, 23 Dec 2020 18:57:33 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A5A7F801D5; Wed, 23 Dec 2020 18:57:32 +0100 (CET)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C7408F8013F
 for <alsa-devel@alsa-project.org>; Wed, 23 Dec 2020 18:57:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C7408F8013F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com
 header.b="q984DeWn"
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi
 [62.78.145.57])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 663CE9E6;
 Wed, 23 Dec 2020 18:57:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1608746243;
 bh=aIE8xGXf1HCeioV2CtalepWGwUaG6UD1DR44h6nu1dw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=q984DeWns2WpIpS44Mmf+NBIdwZ0VKyg0sn0lxei+qgt/rfO6sWAZCb1+DVvQDi9o
 InOBPu2fmLsVSlUtYnX5YK6WtH1oGzHcsyyF5jg0UJ1C7Zr11yWf/HAantErvmp/qN
 OE98sGc1W7JKZP2xFooqGJIBJ0Zkab3u+qIoO3Hc=
Date: Wed, 23 Dec 2020 19:57:15 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: Drop redundant maxItems/items
Message-ID: <X+OE+6VNC5bCMBlD@pendragon.ideasonboard.com>
References: <20201222040645.1323611-1-robh@kernel.org>
 <20201222063908.GB3463004@ravnborg.org>
 <CAL_JsqJLw_RtLehYDLu_HKCoxDHsx-AdGTWfN0JMJhgNqLeFng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAL_JsqJLw_RtLehYDLu_HKCoxDHsx-AdGTWfN0JMJhgNqLeFng@mail.gmail.com>
Cc: devicetree@vger.kernel.org, Linux-ALSA <alsa-devel@alsa-project.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux USB List <linux-usb@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Jassi Brar <jaswinder.singh@linaro.org>, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "open list:DMA GENERIC OFFLOAD ENGINE SUBSYSTEM" <dmaengine@vger.kernel.org>,
 Sam Ravnborg <sam@ravnborg.org>
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

On Wed, Dec 23, 2020 at 10:54:26AM -0700, Rob Herring wrote:
> On Mon, Dec 21, 2020 at 11:39 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Hi Rob,
> >
> > On Mon, Dec 21, 2020 at 09:06:45PM -0700, Rob Herring wrote:
> > > 'maxItems' equal to the 'items' list length is redundant. 'maxItems' is
> > > preferred for a single entry while greater than 1 should have an 'items'
> > > list.
> > >
> > > A meta-schema check for this is pending once these existing cases are
> > > fixed.
> > >
> > > Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > > Cc: Vinod Koul <vkoul@kernel.org>
> > > Cc: Mark Brown <broonie@kernel.org>
> > > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Cc: Jassi Brar <jaswinder.singh@linaro.org>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Cc: dmaengine@vger.kernel.org
> > > Cc: alsa-devel@alsa-project.org
> > > Cc: linux-usb@vger.kernel.org
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > With one comment below,
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> >
> > > ---
> > > diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> > > index 737c1f47b7de..54c361d4a7af 100644
> > > --- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
> > > @@ -74,11 +74,8 @@ properties:
> > >
> > >    phys:
> > >      maxItems: 1
> > > -    items:
> > > -      - description: phandle + phy specifier pair.
> >
> > The description may help some people, so keeping the
> > description and deleting maxItems would maybe be better.
> 
> Do we really want to describe 'phys' hundreds of times? No. The
> question I ask on the descriptions is could it be generated instead.

I agree. If the description had mentioned why particular PHY was
referenced, I would have kept that, but "the phy is a phy" is probably
not something we want to duplicate everywhere.

-- 
Regards,

Laurent Pinchart
