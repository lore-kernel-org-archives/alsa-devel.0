Return-Path: <SRS0=37Wv=BV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9715C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 22:53:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53045206DA
	for <alsa-devel@archiver.kernel.org>; Tue, 11 Aug 2020 22:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tSlOnRfE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="B2xWAqX1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53045206DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D382F84B;
	Wed, 12 Aug 2020 00:52:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D382F84B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597186395;
	bh=2OPvRjIhJuE9NtcniD8wieCQ1jdfZIaegrNpOuRGiZY=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tSlOnRfE0LVae8mxg9VljmqjxPRqrg2m2mQphqre4hcr2ADJAbMs0LnIgnjyXdfmK
	 crD1biO/R7JlOEdzpPmOXCzbZ/616vrFvRDcGVyuHP8Yvstb8E9IpxRngr5KKdsGZ4
	 cQ1gek+lVjlav6yK05/NkKOfvitS92oduLHI1zu0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6AD1AF80118;
	Wed, 12 Aug 2020 00:52:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 693C4F8015B; Wed, 12 Aug 2020 00:52:23 +0200 (CEST)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16D2EF80118
 for <alsa-devel@alsa-project.org>; Wed, 12 Aug 2020 00:52:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16D2EF80118
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com
 header.b="B2xWAqX1"
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi
 [62.78.145.57])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id CDB4E9A8;
 Wed, 12 Aug 2020 00:52:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1597186337;
 bh=2OPvRjIhJuE9NtcniD8wieCQ1jdfZIaegrNpOuRGiZY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=B2xWAqX1E5oyXWPJ2/MkeHzN/O8Mq3q8XoxLNjZ5A0lGqVhsgQBIhbuNjtwi1+imu
 2e4ugFRHx284hGV5ZM2xHtKPBT/DGOLxQlIV3m1QhHWLc4KCdNjeGO7TDx67FbPhlk
 rNTM1cFyHiw+aPbEEqnT3DtLFRZAR0ou8VDV07T8=
Date: Wed, 12 Aug 2020 01:52:03 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 0/3] Fix Kconfig dependency issue with DMAENGINES
 selection
Message-ID: <20200811225203.GG17446@pendragon.ideasonboard.com>
References: <20200731152433.1297-1-laurent.pinchart@ideasonboard.com>
 <20200731164744.GF12965@vkoul-mobl>
 <20200731204206.GC24315@pendragon.ideasonboard.com>
 <20200802064409.GH12965@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200802064409.GH12965@vkoul-mobl>
Cc: alsa-devel@alsa-project.org, Hyun Kwon <hyun.kwon@xilinx.com>,
 Randy Dunlap <rdunlap@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>,
 dri-devel@lists.freedesktop.org, Michal Simek <michal.simek@xilinx.com>,
 Alexandre Bounine <alex.bou9@gmail.com>, Mark Brown <broonie@kernel.org>,
 dmaengine@vger.kernel.org, Matt Porter <mporter@kernel.crashing.org>
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

Hi Vinod,

On Sun, Aug 02, 2020 at 12:14:09PM +0530, Vinod Koul wrote:
> On 31-07-20, 23:42, Laurent Pinchart wrote:
> > On Fri, Jul 31, 2020 at 10:17:44PM +0530, Vinod Koul wrote:
> > > On 31-07-20, 18:24, Laurent Pinchart wrote:
> > > > Hello,
> > > > 
> > > > This small series fixes a Kconfig dependency issue with the recently
> > > > merged Xilixn DPSUB DRM/KMS driver. The fix is in patch 3/3, but
> > > > requires a separate fixes in patches 1/3 and 2/3 to avoid circular
> > > > dependencies:
> > > > 
> > > >         drivers/i2c/Kconfig:8:error: recursive dependency detected!
> > > >         drivers/i2c/Kconfig:8:  symbol I2C is selected by FB_DDC
> > > >         drivers/video/fbdev/Kconfig:63: symbol FB_DDC depends on FB
> > > >         drivers/video/fbdev/Kconfig:12: symbol FB is selected by DRM_KMS_FB_HELPER
> > > >         drivers/gpu/drm/Kconfig:80:     symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
> > > >         drivers/gpu/drm/Kconfig:74:     symbol DRM_KMS_HELPER is selected by DRM_ZYNQMP_DPSUB
> > > >         drivers/gpu/drm/xlnx/Kconfig:1: symbol DRM_ZYNQMP_DPSUB depends on DMA_ENGINE
> > > >         drivers/dma/Kconfig:44: symbol DMA_ENGINE depends on DMADEVICES
> > > >         drivers/dma/Kconfig:6:  symbol DMADEVICES is selected by SND_SOC_SH4_SIU
> > > >         sound/soc/sh/Kconfig:30:        symbol SND_SOC_SH4_SIU is selected by SND_SIU_MIGOR
> > > >         sound/soc/sh/Kconfig:60:        symbol SND_SIU_MIGOR depends on I2C
> > > >         For a resolution refer to Documentation/kbuild/kconfig-language.rst
> > > >         subsection "Kconfig recursive dependency limitations"
> > > > 
> > > > Due to the DPSUB driver being merged in v5.9, this is a candidate fix
> > > > for v5.9 as well. 1/3 and 2/3 can be merged independently, 3/3 depends
> > > > on the first two. What's the best course of action, can I merge this all
> > > > in a single tree, or should the rapidio and ASoC patches be merged
> > > > independently early in the -rc cycle, and the DRM patch later on top ? I
> > > > don't expect conflicts (especially in 2/3 and 3/3), so merging the whole
> > > > series in one go would be simpler in my opinion.
> > > 
> > > Acked-By: Vinod Koul <vkoul@kernel.org>
> > 
> > Thank you.
> > 
> > As Mark as queued the sound fix in his for-next branch for v5.9, could
> > you queue the dmaengine fix for v5.9 too ?
> 
> Dmaengine? I see three patches none of which touch dmaengine..
> Did I miss something?

I'm not sure what I was thinking... It's the rapidio patch that needs to
be merged.

Matt, Alexandre, can you either merge the patch as a v5.9 fix, or give
me an ack to get it merged through the DRM tree ?

-- 
Regards,

Laurent Pinchart
