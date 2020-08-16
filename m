Return-Path: <SRS0=HN0C=B2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688BFC433E1
	for <alsa-devel@archiver.kernel.org>; Sun, 16 Aug 2020 07:56:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A97122065C
	for <alsa-devel@archiver.kernel.org>; Sun, 16 Aug 2020 07:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="K23Kixck"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A97122065C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 415FB167E;
	Sun, 16 Aug 2020 09:56:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 415FB167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597564616;
	bh=yJ/mntHS5FkM/xYl6+L3CMdwrpxDMQPdiQ+RxGiafGs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=K23KixckCEAshXugJC8Aurmw7i4uFQHHp8JnyfiBV//cKnERYzOKN2Ew5CfLKmha1
	 j421+h2H6VL++4yAIYmjn9FheWlPtY18nkzLMxCIxACbU72d13luquukS3km79sjoI
	 /aLxu0clrpf0BB8M/zj7nT6+SQKBmCO0mKT5Va7U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0BAE7F802E9;
	Sun, 16 Aug 2020 09:52:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4396DF8023F; Sun, 16 Aug 2020 09:14:27 +0200 (CEST)
Received: from huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9992DF800F0
 for <alsa-devel@alsa-project.org>; Sun, 16 Aug 2020 09:14:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9992DF800F0
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 2DC612D125E6899B1B39;
 Sun, 16 Aug 2020 15:14:04 +0800 (CST)
Received: from ubuntu.huawei.com (100.120.247.70) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Sun, 16 Aug 2020 15:13:53 +0800
From: Liang Wang <wangliang101@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] sound/isa:fix spelling mistakes in the comments
Date: Sun, 16 Aug 2020 15:13:09 +0800
Message-ID: <20200816071309.121461-1-wangliang101@huawei.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.120.247.70]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Sun, 16 Aug 2020 09:52:37 +0200
Cc: wangle6@huawei.com
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

Fix spelling mistakes in the comments:
	initailise ==> initialise
	tranfer ==> transfer
	Initialse ==> Initialise

Signed-off-by: Liang Wang <wangliang101@huawei.com>
---
 sound/isa/sscape.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 5363d88cc4b9..2e5a5c5279e8 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -308,7 +308,7 @@ static inline int verify_mpu401(const struct snd_mpu401 *mpu)
 }
 
 /*
- * This is apparently the standard way to initailise an MPU-401
+ * This is apparently the standard way to initialise an MPU-401
  */
 static inline void initialise_mpu401(const struct snd_mpu401 *mpu)
 {
@@ -339,7 +339,7 @@ static void soundscape_free(struct snd_card *c)
 }
 
 /*
- * Tell the SoundScape to begin a DMA tranfer using the given channel.
+ * Tell the SoundScape to begin a DMA transfer using the given channel.
  * All locking issues are left to the caller.
  */
 static void sscape_start_dma_unsafe(unsigned io_base, enum GA_REG reg)
@@ -803,7 +803,7 @@ static int mpu401_open(struct snd_mpu401 *mpu)
 }
 
 /*
- * Initialse an MPU-401 subdevice for MIDI support on the SoundScape.
+ * Initialise an MPU-401 subdevice for MIDI support on the SoundScape.
  */
 static int create_mpu401(struct snd_card *card, int devnum,
 			 unsigned long port, int irq)
-- 
2.27.0

