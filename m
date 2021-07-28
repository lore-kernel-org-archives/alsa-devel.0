Return-Path: <SRS0=/xSo=MU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D84C4338F
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 12:45:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4904660F9C
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jul 2021 12:45:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4904660F9C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04C6217E2;
	Wed, 28 Jul 2021 14:44:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04C6217E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627476306;
	bh=Od7x43PRDE523BuYnPr+RcBXW0vl/1+nr+bt3Xftas8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LHx2QQrMbsak1yxMUkoyw77y+5UDGSWeaHG2U+JjojeCUsC5yIgr0cPaqjJkqblh+
	 UruRuur76SL8ggiQKDpX8ABWJe04HE8pwMRLcy7N5rTPgyh1NZlqh9oMOG80LWlTRE
	 ErpxQleFPxU/oqBBdcg57ZTCVI+6WVUzcz9iEkVk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7E00BF80253;
	Wed, 28 Jul 2021 14:44:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 92DC1F8025A; Wed, 28 Jul 2021 14:44:13 +0200 (CEST)
Received: from cmccmta3.chinamobile.com (cmccmta3.chinamobile.com
 [221.176.66.81])
 by alsa1.perex.cz (Postfix) with ESMTP id CFE67F80127
 for <alsa-devel@alsa-project.org>; Wed, 28 Jul 2021 14:44:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFE67F80127
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by
 rmmx-syy-dmz-app10-12010 (RichMail) with SMTP id 2eea610150e41ed-a7a23;
 Wed, 28 Jul 2021 20:43:19 +0800 (CST)
X-RM-TRANSID: 2eea610150e41ed-a7a23
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee5610150e4de6-d3396;
 Wed, 28 Jul 2021 20:43:19 +0800 (CST)
X-RM-TRANSID: 2ee5610150e4de6-d3396
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
 rjui@broadcom.com, sbranden@broadcom.com
Subject: [PATCH] ASoC: bcm: cygnus-pcm: Fix unused assignment about 'rc'
Date: Wed, 28 Jul 2021 20:44:11 +0800
Message-Id: <20210728124411.3168-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Tang Bin <tangbin@cmss.chinamobile.com>
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

Delete unused initialized value of 'rc', because it will
be assigned by the function devm_request_irq().

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/bcm/cygnus-pcm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/bcm/cygnus-pcm.c b/sound/soc/bcm/cygnus-pcm.c
index 7ad07239f..039365f76 100644
--- a/sound/soc/bcm/cygnus-pcm.c
+++ b/sound/soc/bcm/cygnus-pcm.c
@@ -830,7 +830,7 @@ static struct snd_soc_component_driver cygnus_soc_platform = {
 int cygnus_soc_platform_register(struct device *dev,
 				 struct cygnus_audio *cygaud)
 {
-	int rc = 0;
+	int rc;
 
 	dev_dbg(dev, "%s Enter\n", __func__);
 
-- 
2.20.1.windows.1



