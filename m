Return-Path: <SRS0=4tTe=BK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95C5FC433E3
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192EC208E4
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="F/vHsn2H";
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IupZ5z4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192EC208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9FAD15F2;
	Fri, 31 Jul 2020 17:26:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9FAD15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596209248;
	bh=UqaLHXGEvWF6bf+r1UT6gPxJ23EEhgK8OJfXiuRbETQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=F/vHsn2HUEzrwJhfJPgTNWtO212nWo/4QTheXoGktTGvgjpd1bqjqES8NjO5gcR9K
	 31Ws24h3bDUC+2INojjKSG5kPcr7BALy6qXsCFGQJEMMtBdW4zNu3tfpuSNxkYbF0N
	 nQqH/GsqIdrjof3HPgWc7YhPDNRjnxLQ47jhfQlg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C0FC0F80292;
	Fri, 31 Jul 2020 17:25:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A0AAF8028D; Fri, 31 Jul 2020 17:24:57 +0200 (CEST)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79DD3F80161
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 17:24:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79DD3F80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com
 header.b="IupZ5z4l"
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi
 [81.175.216.236])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 84D85B83;
 Fri, 31 Jul 2020 17:24:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1596209088;
 bh=UqaLHXGEvWF6bf+r1UT6gPxJ23EEhgK8OJfXiuRbETQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IupZ5z4l9m5M8A7SQqy2LlPfrGEPnAoeLvQDXo+/Er/nfrMrOI8dH0jzy0DsEIq9S
 1zXnG+Ag0JrhXe2edF5vAdpicAB1A5vfqzViEjVtY88Fe18xKuAd00L6sRkEimiyVF
 y3gIsntuXI7AnDrI56IWFuAo/rXG3R6KGPCz/eT8=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
 alsa-devel@alsa-project.org
Subject: [PATCH v2 2/3] ASoC: sh: Replace 'select' DMADEVICES 'with depends on'
Date: Fri, 31 Jul 2020 18:24:32 +0300
Message-Id: <20200731152433.1297-3-laurent.pinchart@ideasonboard.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200731152433.1297-1-laurent.pinchart@ideasonboard.com>
References: <20200731152433.1297-1-laurent.pinchart@ideasonboard.com>
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

Enabling a whole subsystem from a single driver 'select' is frowned
upon and won't be accepted in new drivers, that need to use 'depends on'
instead. Existing selection of DMADEVICES will then cause circular
dependencies. Replace them with a dependency.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
---
 sound/soc/sh/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/Kconfig b/sound/soc/sh/Kconfig
index dc20f0f7080a..ef8a29b9f641 100644
--- a/sound/soc/sh/Kconfig
+++ b/sound/soc/sh/Kconfig
@@ -30,8 +30,8 @@ config SND_SOC_SH4_FSI
 config SND_SOC_SH4_SIU
 	tristate
 	depends on ARCH_SHMOBILE && HAVE_CLK
+	depends on DMADEVICES
 	select DMA_ENGINE
-	select DMADEVICES
 	select SH_DMAE
 	select FW_LOADER
 
-- 
Regards,

Laurent Pinchart

