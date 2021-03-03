Return-Path: <SRS0=LSvA=IB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94A13C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 09:09:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F026A64EE3
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 09:09:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F026A64EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 46B7018BF;
	Wed,  3 Mar 2021 10:08:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 46B7018BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614762551;
	bh=KERnG//G9B1o/qPOGM921jPpj4tuvV+tE5EAaJx7Zms=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W5t+CCUn64vvCkqNpZS5bqKCcEAw+6R+F38Q9XcpBdjzi/cNN6qSgf9lEXy0SNxPR
	 jeP8y6+DRHbRS++dBRsBqhPjl/vZonG7/eu89AxbIgdldeKWqr0u3Y/z9Y8p0bfb7w
	 ws42IRtIEFr7Iqus/KIRyvF1AAAct+Bq/iHXMkvE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C222BF80257;
	Wed,  3 Mar 2021 10:08:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AD081F8025E; Wed,  3 Mar 2021 10:08:19 +0100 (CET)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D3FEDF800B2
 for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2021 10:08:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D3FEDF800B2
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R251e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04420; MF=yang.lee@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0UQDrPLL_1614762482; 
Received: from
 j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0UQDrPLL_1614762482) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 03 Mar 2021 17:08:02 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: lgirdwood@gmail.com
Subject: [PATCH] SoC: codecs: fix platform_no_drv_owner.cocci warnings
Date: Wed,  3 Mar 2021 17:08:01 +0800
Message-Id: <1614762481-102466-1-git-send-email-yang.lee@linux.alibaba.com>
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

./sound/soc/codecs/lpass-rx-macro.c:3588:3-8: No need to set .owner here. 
The core will do it.

Remove .owner field if calls are used which set it automatically

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/codecs/lpass-rx-macro.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index c9c21d22..5b9d4e9 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -3585,7 +3585,6 @@ static int rx_macro_remove(struct platform_device *pdev)
 static struct platform_driver rx_macro_driver = {
 	.driver = {
 		.name = "rx_macro",
-		.owner = THIS_MODULE,
 		.of_match_table = rx_macro_dt_match,
 		.suppress_bind_attrs = true,
 	},
-- 
1.8.3.1

