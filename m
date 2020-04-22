Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE0AC55189
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 07:19:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 416292075A
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 07:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JQWse/Aj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 416292075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A226816CC;
	Wed, 22 Apr 2020 09:19:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A226816CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587539993;
	bh=uCKLVtVafHit6YZTB9HA8cBS5fbPRhAnBsvJJkpHysI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=JQWse/AjCAuKHPISbTqj4sQogSJLX4mowYlr1M/mPL0uAaVnYPe4K331uLiySrzQ0
	 hQaUGWP+68wLt1bNDGH7I6y1QU3CY5tIc/LtsN1yDenHc1Jmu+QiRL6MVhXfMGFkq0
	 Nho5E1pJWr2nClc3+CgvfO5YAjkH9wfpCLSL1VhA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3DA64F801D9;
	Wed, 22 Apr 2020 09:19:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A842CF80142; Wed, 22 Apr 2020 09:19:00 +0200 (CEST)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7C4C8F80142
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 09:18:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7C4C8F80142
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 4190FA8636B45EF33076;
 Wed, 22 Apr 2020 15:18:47 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Wed, 22 Apr 2020
 15:18:36 +0800
From: Jason Yan <yanaijie@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <kuninori.morimoto.gx@renesas.com>,
 <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] ASoC: soc-core: return true,
 false in snd_soc_volsw_is_stereo()
Date: Wed, 22 Apr 2020 15:18:05 +0800
Message-ID: <20200422071805.48793-1-yanaijie@huawei.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Cc: Jason Yan <yanaijie@huawei.com>
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

Fix the following coccicheck warning:

include/sound/soc.h:1271:9-10: WARNING: return of 0/1 in function
'snd_soc_volsw_is_stereo' with return type bool

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 include/sound/soc.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 946f88a6c63d..d1e9a526363e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1268,13 +1268,13 @@ static inline void *snd_soc_card_get_drvdata(struct snd_soc_card *card)
 static inline bool snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
 {
 	if (mc->reg == mc->rreg && mc->shift == mc->rshift)
-		return 0;
+		return false;
 	/*
 	 * mc->reg == mc->rreg && mc->shift != mc->rshift, or
 	 * mc->reg != mc->rreg means that the control is
 	 * stereo (bits in one register or in two registers)
 	 */
-	return 1;
+	return true;
 }
 
 static inline unsigned int snd_soc_enum_val_to_item(struct soc_enum *e,
-- 
2.21.1

