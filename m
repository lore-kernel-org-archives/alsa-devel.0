Return-Path: <SRS0=75ci=BI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E177C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:31:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCC9F2075D
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Jul 2020 16:31:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R3ISnR4z";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Uugcdx1/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCC9F2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E5F4171E;
	Wed, 29 Jul 2020 18:30:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E5F4171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596040287;
	bh=ky9DdYcs8gLDC1IG0uwgloj/Z1cLoF/ZRIs6ecPdHus=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R3ISnR4zeZzn0xuibxE2kxxRc+7+WCSkYj+SmQpmM4/jVESYXdTbZ1JADpysQ0tPO
	 /GHItZ4dL+Cz1IvbWpvTlWGZgCIPIy32zZyYCvpnjwzxuVY5kugU9TpUEF+k5JR0zi
	 uj3RvhGRIU7VE/cf48CABC91ZCouaHrpwHBjSgfA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1AD4AF801EB;
	Wed, 29 Jul 2020 18:29:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4240F801D9; Wed, 29 Jul 2020 18:29:40 +0200 (CEST)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3C67BF80125
 for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2020 18:29:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3C67BF80125
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com
 header.b="Uugcdx1/"
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi
 [81.175.216.236])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id BACAF31F;
 Wed, 29 Jul 2020 18:29:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1596040163;
 bh=ky9DdYcs8gLDC1IG0uwgloj/Z1cLoF/ZRIs6ecPdHus=;
 h=From:To:Cc:Subject:Date:From;
 b=Uugcdx1/LAvrRUZ9Kweh+Ey8aE+BmmSZHuhKhidkOGdn0M5bD1NfpWIGAYfGB3QzU
 MsiCcoywrtkclTvpDW3wBOoHK17ZMA+vPuOjPcSQh1RUIStWpyjkbEGTpjwiUqG3RK
 Iyai1KRfJ/qXwhBxnyj26JVeP0i9akwQZaxBz4FE=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
 alsa-devel@alsa-project.org
Subject: [PATCH 0/3] Fix Kconfig dependency issue with DMAENGINES selection
Date: Wed, 29 Jul 2020 19:29:07 +0300
Message-Id: <20200729162910.13196-1-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Hyun Kwon <hyun.kwon@xilinx.com>, Randy Dunlap <rdunlap@infradead.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Michal Simek <michal.simek@xilinx.com>,
 Alexandre Bounine <alex.bou9@gmail.com>, Vinod Koul <vkoul@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matt Porter <mporter@kernel.crashing.org>
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

Hello,

This small series fixes a Kconfig dependency issue with the recently
merged Xilixn DPSUB DRM/KMS driver. The fix is in patch 3/3, but
requires a separate fixes in patches 1/3 and 2/3 to avoid circular
dependencies:

	drivers/i2c/Kconfig:8:error: recursive dependency detected!
	drivers/i2c/Kconfig:8:  symbol I2C is selected by FB_DDC
	drivers/video/fbdev/Kconfig:63: symbol FB_DDC depends on FB
	drivers/video/fbdev/Kconfig:12: symbol FB is selected by DRM_KMS_FB_HELPER
	drivers/gpu/drm/Kconfig:80:     symbol DRM_KMS_FB_HELPER depends on DRM_KMS_HELPER
	drivers/gpu/drm/Kconfig:74:     symbol DRM_KMS_HELPER is selected by DRM_ZYNQMP_DPSUB
	drivers/gpu/drm/xlnx/Kconfig:1: symbol DRM_ZYNQMP_DPSUB depends on DMA_ENGINE
	drivers/dma/Kconfig:44: symbol DMA_ENGINE depends on DMADEVICES
	drivers/dma/Kconfig:6:  symbol DMADEVICES is selected by SND_SOC_SH4_SIU
	sound/soc/sh/Kconfig:30:        symbol SND_SOC_SH4_SIU is selected by SND_SIU_MIGOR
	sound/soc/sh/Kconfig:60:        symbol SND_SIU_MIGOR depends on I2C
	For a resolution refer to Documentation/kbuild/kconfig-language.rst
	subsection "Kconfig recursive dependency limitations"

Due to the DPSUB driver being merged in v5.9, this is a candidate fix
for v5.9 as well. 1/3 and 2/3 can be merged independently, 3/3 depends
on the first two. What's the best course of action, can I merge this all
in a single tree, or should the rapidio and ASoC patches be merged
independently early in the -rc cycle, and the DRM patch later on top ? I
don't expect conflicts (especially in 2/3 and 3/3), so merging the whole
series in one go would be simpler in my opinion.

Laurent Pinchart (3):
  rapidio: Replace 'select' DMAENGINES 'with depends on'
  ASoC: sh: Replace 'select' DMAENGINES 'with depends on'
  drm: xlnx: dpsub: Fix DMADEVICES Kconfig dependency

 drivers/gpu/drm/xlnx/Kconfig | 1 +
 drivers/rapidio/Kconfig      | 2 +-
 sound/soc/sh/Kconfig         | 2 +-
 3 files changed, 3 insertions(+), 2 deletions(-)

-- 
Regards,

Laurent Pinchart

