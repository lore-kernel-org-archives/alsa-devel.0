Return-Path: <SRS0=TimU=KB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5C82C433B4
	for <alsa-devel@archiver.kernel.org>; Thu,  6 May 2021 13:19:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32DCE61104
	for <alsa-devel@archiver.kernel.org>; Thu,  6 May 2021 13:19:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32DCE61104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B93E4847;
	Thu,  6 May 2021 15:18:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B93E4847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620307146;
	bh=tMZUMoXaPXPwKyjGjK34+rgfikHZygZR2dDLLskzLc8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VJRwGL+tr35UcOyfMXkdM2H6e8/O/iHaN2l491vRgW9QRZmqOm+8ed6DwgTPT10yj
	 g1konteZCt/vgSWIWKUJxmcY+l/LZ6OhOQWxzGQ2wQTL4QzuIMl7Jq6g6CN6YZYY+P
	 n/zMZgxShRh+1kpFeC6EJrThfNnuxA4jAbJ5KmL8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3E7B8F801F7;
	Thu,  6 May 2021 15:18:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1540AF8021C; Thu,  6 May 2021 15:18:14 +0200 (CEST)
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com
 [221.176.66.81])
 by alsa1.perex.cz (Postfix) with ESMTP id A365CF8007E
 for <alsa-devel@alsa-project.org>; Thu,  6 May 2021 15:18:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A365CF8007E
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by
 rmmx-syy-dmz-app12-12012 (RichMail) with SMTP id 2eec6093ec76e44-a218c;
 Thu, 06 May 2021 21:17:43 +0800 (CST)
X-RM-TRANSID: 2eec6093ec76e44-a218c
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.22.251.0])
 by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea6093ec73c9f-b0b67;
 Thu, 06 May 2021 21:17:42 +0800 (CST)
X-RM-TRANSID: 2eea6093ec73c9f-b0b67
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com
Subject: [PATCH] ASoc: Fix unused define in jz4740-i2s.h
Date: Thu,  6 May 2021 21:18:33 +0800
Message-Id: <20210506131833.27420-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
 linux-kernel@vger.kernel.org, Tang Bin <tangbin@cmss.chinamobile.com>
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

Delete unused define of JZ4740_I2S_BIT_CLK, because it is unused
in any files.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/jz4740/jz4740-i2s.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.h b/sound/soc/jz4740/jz4740-i2s.h
index 44f120160..4da14eac1 100644
--- a/sound/soc/jz4740/jz4740-i2s.h
+++ b/sound/soc/jz4740/jz4740-i2s.h
@@ -7,6 +7,4 @@
 #define JZ4740_I2S_CLKSRC_EXT 0
 #define JZ4740_I2S_CLKSRC_PLL 1
 
-#define JZ4740_I2S_BIT_CLK		0
-
 #endif
-- 
2.20.1.windows.1



