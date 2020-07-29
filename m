Return-Path: <SRS0=75ci=BI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098ECC433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:52:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87AE8206D8
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TocaWXN+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="FAdNtq4E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87AE8206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1EFBD171B;
	Wed, 29 Jul 2020 18:51:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1EFBD171B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596041524;
	bh=rJjTXG7oHTCq9+/aTzLg9irnYsb8UBgvUgtw7uNJzBA=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TocaWXN+FBSx4BnRNQRE+vvjBQ5hYkswtbkf56fzydDR/xwpN1IkFid/rjzp3FCSE
	 uiFqg7k3NwHm9D70dO9sqRQZ8WkgbBA3s43CsqXdv/69l6cUwqG+nZuqnFWHt8dpRv
	 +YywQqjpIXnAt32d3hGqM00KQVlCldRfeWAen2ts=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9B0D6F8012F;
	Wed, 29 Jul 2020 18:51:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4DAB1F801A3; Wed, 29 Jul 2020 18:51:12 +0200 (CEST)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25AA1F80125
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2020 18:51:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25AA1F80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com
 header.b="FAdNtq4E"
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi
 [81.175.216.236])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id C689D29E;
 Wed, 29 Jul 2020 18:51:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1596041461;
 bh=rJjTXG7oHTCq9+/aTzLg9irnYsb8UBgvUgtw7uNJzBA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FAdNtq4EH0NoWuCD169cmQyYZcXtNhAXKorGxiFLylch/dk6QVYdoVKygVCieRTlO
 Bz0AvNct9L6/DWmKxWGzSeSuvd0096+vmouz8VMdvqNFL5e3D1G5stsh2b+5jtONV/
 6M1wTOzkMw3bmayAEjB1Pk2TUuCV2rG3GzaVzYiQ=
Date: Wed, 29 Jul 2020 19:50:52 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 1/3] rapidio: Replace 'select' DMAENGINES 'with depends on'
Message-ID: <20200729165052.GN6183@pendragon.ideasonboard.com>
References: <20200729162910.13196-1-laurent.pinchart@ideasonboard.com>
 <20200729162910.13196-2-laurent.pinchart@ideasonboard.com>
 <20200729164326.GA1371039@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729164326.GA1371039@ravnborg.org>
Cc: alsa-devel@alsa-project.org, Hyun Kwon <hyun.kwon@xilinx.com>,
 Randy Dunlap <rdunlap@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>,
 dri-devel@lists.freedesktop.org, Michal Simek <michal.simek@xilinx.com>,
 Alexandre Bounine <alex.bou9@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>, dmaengine@vger.kernel.org,
 Matt Porter <mporter@kernel.crashing.org>
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

Hi Sam,

On Wed, Jul 29, 2020 at 06:43:26PM +0200, Sam Ravnborg wrote:
> On Wed, Jul 29, 2020 at 07:29:08PM +0300, Laurent Pinchart wrote:
> > Enabling a whole subsystem from a single driver 'select' is frowned
> > upon and won't be accepted in new drivers, that need to use 'depends on'
> > instead. Existing selection of DMAENGINES will then cause circular
> > dependencies. Replace them with a dependency.
> > 
> > Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > ---
> >  drivers/rapidio/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
> > index e4c422d806be..b9f8514909bf 100644
> > --- a/drivers/rapidio/Kconfig
> > +++ b/drivers/rapidio/Kconfig
> > @@ -37,7 +37,7 @@ config RAPIDIO_ENABLE_RX_TX_PORTS
> >  config RAPIDIO_DMA_ENGINE
> >  	bool "DMA Engine support for RapidIO"
> >  	depends on RAPIDIO
> > -	select DMADEVICES
> > +	depends on DMADEVICES
>
> $subject and changlog talks about DMAENGINES but the patch touches DMADEVICES??

Clearly a typo in the subject line, it should be DMADEVICES. I'll wait a
little bit to see if there are more comments, and will send a v2.

> >  	select DMA_ENGINE
> >  	help
> >  	  Say Y here if you want to use DMA Engine frameork for RapidIO data

-- 
Regards,

Laurent Pinchart
