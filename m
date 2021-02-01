Return-Path: <SRS0=phwE=HF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C866BC433DB
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 07:04:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2C6964E30
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Feb 2021 07:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2C6964E30
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E6FB1779;
	Wed,  3 Feb 2021 08:03:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E6FB1779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612335887;
	bh=iKjKfvr2ksM6TY9nIE4ByYoMcVjcBfv/yK8XY5Ocz8w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GNqL7U2pd8PwlYx1kOOwG3iUzpgPMSSxgcNEV6CsAALyHpn08AKMNwl342hZ3zKAA
	 HONOHStzghsVdG8dBXn69se8HHYSmqIKaviBjBG3DvcQInxlWarOssktiPAzOqZqdR
	 5xv0WMvVg8i96aRU3RMqVIqmgK3lcLYUPZenTJ48=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 768E0F802D2;
	Wed,  3 Feb 2021 08:01:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B2F4CF80224; Mon,  1 Feb 2021 09:08:48 +0100 (CET)
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D83F7F800E2
 for <alsa-devel@alsa-project.org>; Mon,  1 Feb 2021 09:08:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D83F7F800E2
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R211e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=yang.lee@linux.alibaba.com;
 NM=1; PH=DS; RN=14; SR=0; TI=SMTPD_---0UNVd4Wl_1612166910; 
Received: from
 j63c13417.sqa.eu95.tbsite.net(mailfrom:yang.lee@linux.alibaba.com
 fp:SMTPD_---0UNVd4Wl_1612166910) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 01 Feb 2021 16:08:30 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: timur@kernel.org
Subject: [PATCH] ASoC: fsl_xcvr: remove unneeded semicolon
Date: Mon,  1 Feb 2021 16:08:29 +0800
Message-Id: <1612166909-129900-1-git-send-email-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
X-Mailman-Approved-At: Wed, 03 Feb 2021 08:01:31 +0100
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 Xiubo.Lee@gmail.com, festevam@gmail.com, tiwai@suse.com, lgirdwood@gmail.com,
 nicoleotsuka@gmail.com, broonie@kernel.org,
 Yang Li <yang.lee@linux.alibaba.com>, p.zabel@pengutronix.de,
 shengjiu.wang@gmail.com, linux-kernel@vger.kernel.org
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

Eliminate the following coccicheck warning:
./sound/soc/fsl/fsl_xcvr.c:739:2-3: Unneeded semicolon

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 sound/soc/fsl/fsl_xcvr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index 3d58c88..65b388a 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -736,7 +736,7 @@ static int fsl_xcvr_load_firmware(struct fsl_xcvr *xcvr)
 			/* clean current page, including data memory */
 			memset_io(xcvr->ram_addr, 0, size);
 		}
-	};
+	}
 
 err_firmware:
 	release_firmware(fw);
-- 
1.8.3.1

