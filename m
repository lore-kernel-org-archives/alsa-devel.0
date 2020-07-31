Return-Path: <SRS0=4tTe=BK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD98DC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 20:43:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D42521744
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 20:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="lnvElk/1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Im3+k8u+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D42521744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C67181689;
	Fri, 31 Jul 2020 22:42:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C67181689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596228193;
	bh=TGDv3Frj4rCMmzqFPlTvoVIycIJIp6yYmbKH/jOE9mc=;
	h=Date:From:To:Subject:References:In-Reply-To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lnvElk/1JlfWEzZy4SW/5yPqcSpEVxxmhS/uUFDgdgvUUE5KoIpsj9kTrgv8W25of
	 PT5Ziak2s1Q2Icwf+eWjQ1wsL7Q9kQOEBd7B8MvU6PxEkp+IjL5b9eel2cp3rLuvXr
	 MLTVJ2d8a6pf0a4nG2WqEnkkgZ+Pw35uXHk8Bj24=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44183F80161;
	Fri, 31 Jul 2020 22:42:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F556F80171; Fri, 31 Jul 2020 22:42:21 +0200 (CEST)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ACC3FF8015C
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 22:42:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz ACC3FF8015C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com
 header.b="Im3+k8u+"
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi
 [81.175.216.236])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id DB6D353C;
 Fri, 31 Jul 2020 22:42:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1596228136;
 bh=TGDv3Frj4rCMmzqFPlTvoVIycIJIp6yYmbKH/jOE9mc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Im3+k8u+Yxa3c9UDV4VQq4DNQKg69ugyaC0/L5DmB2fFrkduhebVB6KTRG6iVWOXa
 egFJ/d36EO5mvPkd5KwvF3DNugdzJwhUdIkiLFzsp02rX3vkq8SC/KwnGOV1ia4eVw
 Bs2wh5kDTRDxiPEdhX1Rhc3bov2XSPe5p41MPOfk=
Date: Fri, 31 Jul 2020 23:42:06 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v2 0/3] Fix Kconfig dependency issue with DMAENGINES
 selection
Message-ID: <20200731204206.GC24315@pendragon.ideasonboard.com>
References: <20200731152433.1297-1-laurent.pinchart@ideasonboard.com>
 <20200731164744.GF12965@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200731164744.GF12965@vkoul-mobl>
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

On Fri, Jul 31, 2020 at 10:17:44PM +0530, Vinod Koul wrote:
> On 31-07-20, 18:24, Laurent Pinchart wrote:
> > Hello,
> > 
> > This small series fixes a Kconfig dependency issue with the recently
> > merged Xilixn DPSUB DRM/KMS driver. The fix is in patch 3/3, but
> > requires a separate fixes in patches 1/3 and 2/3 to avoid circular
> > dependencies:
> > 
> >         drivers/i2c/Kconfig:8:error: recursive dependency detected!
> >         drivers/i2c/Kconfig:8:  symbol I2C is selected by FB_DDC
> >         drivers/video/fbdev/Kconfig:63: symbol FB_DDC depends on FB
> >         drivers/video/fbdev/Kconfig:12: symbol FB is selected by DRM_KMS_FB_HELPER
> >         drivers/gpu/drm/Kconfig:80:     symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
> >         drivers/gpu/drm/Kconfig:74:     symbol DRM_KMS_HELPER is selected by DRM_ZYNQMP_DPSUB
> >         drivers/gpu/drm/xlnx/Kconfig:1: symbol DRM_ZYNQMP_DPSUB depends on DMA_ENGINE
> >         drivers/dma/Kconfig:44: symbol DMA_ENGINE depends on DMADEVICES
> >         drivers/dma/Kconfig:6:  symbol DMADEVICES is selected by SND_SOC_SH4_SIU
> >         sound/soc/sh/Kconfig:30:        symbol SND_SOC_SH4_SIU is selected by SND_SIU_MIGOR
> >         sound/soc/sh/Kconfig:60:        symbol SND_SIU_MIGOR depends on I2C
> >         For a resolution refer to Documentation/kbuild/kconfig-language.rst
> >         subsection "Kconfig recursive dependency limitations"
> > 
> > Due to the DPSUB driver being merged in v5.9, this is a candidate fix
> > for v5.9 as well. 1/3 and 2/3 can be merged independently, 3/3 depends
> > on the first two. What's the best course of action, can I merge this all
> > in a single tree, or should the rapidio and ASoC patches be merged
> > independently early in the -rc cycle, and the DRM patch later on top ? I
> > don't expect conflicts (especially in 2/3 and 3/3), so merging the whole
> > series in one go would be simpler in my opinion.
> 
> Acked-By: Vinod Koul <vkoul@kernel.org>

Thank you.

As Mark as queued the sound fix in his for-next branch for v5.9, could
you queue the dmaengine fix for v5.9 too ?

-- 
Regards,

Laurent Pinchart
