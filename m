Return-Path: <SRS0=4tTe=BK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8766C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:25:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588B62245C
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 15:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qHUIuE7j";
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="i2dfvPtg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588B62245C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9B36715F9;
	Fri, 31 Jul 2020 17:24:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9B36715F9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596209147;
	bh=VZdKdBvbpBsm2kscc8Vu12l0xPHh+0EHF+z3+/VAmKQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qHUIuE7jvNUu7laKbAHbDdmEGqk3czyw/ZUI+oZuQy5kvJwyXA/c+V/1uafllcHGy
	 k5kPQ1OHDHF3Jti+sfB/eBrRAANUbvRZ8aMZWOzixFQgi92TgOKAE7BfGDiQEDmESf
	 KfqcZDwSSrAtb6+Qj+yOXV2rBdZJI1aFp89cHFg8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13A12F8015C;
	Fri, 31 Jul 2020 17:24:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1FDEF801EB; Fri, 31 Jul 2020 17:24:54 +0200 (CEST)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44C21F80111
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 17:24:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44C21F80111
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com
 header.b="i2dfvPtg"
Received: from pendragon.bb.dnainternet.fi (81-175-216-236.bb.dnainternet.fi
 [81.175.216.236])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id A71229B1;
 Fri, 31 Jul 2020 17:24:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1596209087;
 bh=VZdKdBvbpBsm2kscc8Vu12l0xPHh+0EHF+z3+/VAmKQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=i2dfvPtgr45m1r1J+dA9/G/u/uUOZEn8jahysQDpxbD2FF2MCoBjFxPfxJGwbiUvh
 3x81jpg2Zd9B7l2F/55IKMTPNLJIFvrRTqcRucGQICnl1PYMBB6SO0KkTNyl6k9FMx
 yMbT9HkTE/7GEaeXbae5jvX/uUtel8Y+4QVp7O/Y=
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
 alsa-devel@alsa-project.org
Subject: [PATCH v2 1/3] rapidio: Replace 'select' DMADEVICES 'with depends on'
Date: Fri, 31 Jul 2020 18:24:31 +0300
Message-Id: <20200731152433.1297-2-laurent.pinchart@ideasonboard.com>
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
 drivers/rapidio/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
index e4c422d806be..b9f8514909bf 100644
--- a/drivers/rapidio/Kconfig
+++ b/drivers/rapidio/Kconfig
@@ -37,7 +37,7 @@ config RAPIDIO_ENABLE_RX_TX_PORTS
 config RAPIDIO_DMA_ENGINE
 	bool "DMA Engine support for RapidIO"
 	depends on RAPIDIO
-	select DMADEVICES
+	depends on DMADEVICES
 	select DMA_ENGINE
 	help
 	  Say Y here if you want to use DMA Engine frameork for RapidIO data
-- 
Regards,

Laurent Pinchart

