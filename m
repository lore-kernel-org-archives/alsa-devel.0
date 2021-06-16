Return-Path: <SRS0=Vkr5=LK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5852CC48BE5
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 02:46:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A70861246
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 02:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A70861246
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 41F3C1686;
	Wed, 16 Jun 2021 04:45:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 41F3C1686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623811606;
	bh=YS4UyQhh2MOYY7Ne9WcEaMHi+MACjrGXjCNCUOM52qA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SFO3+ajEhXAQKaFXiLaxXti4zAoJCUyTrH0KTlvxNCAxO/N7NWz3/c6jV5CjMN0bk
	 un4uDDGOeP0SE6e6KNBl4JDN0/dkggjIPyvfvsWLejMuz6kiJrgD8wsGvHzgqzLyUN
	 mETHo0QZlnQF4/7cnrS+6kj/nVMFB0JiRrNdHNIo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93B04F802E8;
	Wed, 16 Jun 2021 04:45:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 20CDBF80423; Wed, 16 Jun 2021 04:45:53 +0200 (CEST)
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC833F8028B
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 04:45:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC833F8028B
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R891e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=yang.lee@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UcZEGKZ_1623811542; 
Received: from
 j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0UcZEGKZ_1623811542) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Jun 2021 10:45:44 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: lgirdwood@gmail.com
Subject: [PATCH -next] SoC: codecs: wcd938x: fix boolreturn.cocci warning
Date: Wed, 16 Jun 2021 10:45:35 +0800
Message-Id: <1623811535-15841-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.com,
 broonie@kernel.org, Yang Li <yang.lee@linux.alibaba.com>
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

Return statements in functions returning bool should use true/false
instead of 1/0.

Fix the following coccicheck warning:
./sound/soc/codecs/wcd938x.c:1190:9-10: WARNING: return of 0/1 in
function 'wcd938x_volatile_register' with return type bool.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/codecs/wcd938x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
index 2cf6145..cfe00536 100644
--- a/sound/soc/codecs/wcd938x.c
+++ b/sound/soc/codecs/wcd938x.c
@@ -1187,7 +1187,7 @@ static bool wcd938x_writeable_register(struct device *dev, unsigned int reg)
 static bool wcd938x_volatile_register(struct device *dev, unsigned int reg)
 {
 	if (reg <= WCD938X_BASE_ADDRESS)
-		return 0;
+		return false;
 
 	if (reg == WCD938X_DIGITAL_SWR_TX_CLK_RATE)
 		return true;
-- 
1.8.3.1

