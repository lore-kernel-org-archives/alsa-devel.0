Return-Path: <SRS0=kM0A=OA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0B9CC433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Sep 2021 09:27:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C42B6101A
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Sep 2021 09:27:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1C42B6101A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9928F16A8;
	Fri, 10 Sep 2021 11:26:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9928F16A8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631266061;
	bh=sN66snqGba5yT0Mn9bCXWvEjSBHDYvs/3VvjX67XUhA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lfwb6aNhRMSJs/KCFOyiltwGVmuw57YpWnyTbz1fYZuaEmDy2pNVJ19yp9eNU8OT+
	 U18TuuI+NsMGvIayF28mScPm2DBeO5WjTxHAmsUOltNovkv+FUtE8EsLq27QHJtMQv
	 fo5GoB3VQUp2kZK0ywoRnrWA/tzx/d0UGUiZRhKE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93D4EF804B3;
	Fri, 10 Sep 2021 11:26:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB4E8F804E4; Fri, 10 Sep 2021 11:26:32 +0200 (CEST)
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B9BBF804B3
 for <alsa-devel@alsa-project.org>; Fri, 10 Sep 2021 11:26:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B9BBF804B3
X-UUID: 30a0599609814a07a9fbc573b5fead1d-20210910
X-UUID: 30a0599609814a07a9fbc573b5fead1d-20210910
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by
 mailgw01.mediatek.com (envelope-from <trevor.wu@mediatek.com>)
 (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
 with ESMTP id 909894693; Fri, 10 Sep 2021 17:26:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 10 Sep 2021 17:26:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via
 Frontend Transport; Fri, 10 Sep 2021 17:26:14 +0800
From: Trevor Wu <trevor.wu@mediatek.com>
To: <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>
Subject: [PATCH v2] ASoC: mediatek: common: handle NULL case in suspend/resume
 function
Date: Fri, 10 Sep 2021 17:26:13 +0800
Message-ID: <20210910092613.30188-1-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK: N
Cc: linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 trevor.wu@mediatek.com, dan.carpenter@oracle.com
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

When memory allocation for afe->reg_back_up fails, reg_back_up can't
be used.
Keep the suspend/resume flow but skip register backup when
afe->reg_back_up is NULL, in case illegal memory access happens.

Fixes: 283b612429a2 ("ASoC: mediatek: implement mediatek common structure")
Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Change since v1:
  add Reported-by tag
---
 sound/soc/mediatek/common/mtk-afe-fe-dai.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/sound/soc/mediatek/common/mtk-afe-fe-dai.c b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
index baaa5881b1d4..e95c7c018e7d 100644
--- a/sound/soc/mediatek/common/mtk-afe-fe-dai.c
+++ b/sound/soc/mediatek/common/mtk-afe-fe-dai.c
@@ -334,9 +334,11 @@ int mtk_afe_suspend(struct snd_soc_component *component)
 			devm_kcalloc(dev, afe->reg_back_up_list_num,
 				     sizeof(unsigned int), GFP_KERNEL);
 
-	for (i = 0; i < afe->reg_back_up_list_num; i++)
-		regmap_read(regmap, afe->reg_back_up_list[i],
-			    &afe->reg_back_up[i]);
+	if (afe->reg_back_up) {
+		for (i = 0; i < afe->reg_back_up_list_num; i++)
+			regmap_read(regmap, afe->reg_back_up_list[i],
+				    &afe->reg_back_up[i]);
+	}
 
 	afe->suspended = true;
 	afe->runtime_suspend(dev);
@@ -356,12 +358,13 @@ int mtk_afe_resume(struct snd_soc_component *component)
 
 	afe->runtime_resume(dev);
 
-	if (!afe->reg_back_up)
+	if (!afe->reg_back_up) {
 		dev_dbg(dev, "%s no reg_backup\n", __func__);
-
-	for (i = 0; i < afe->reg_back_up_list_num; i++)
-		mtk_regmap_write(regmap, afe->reg_back_up_list[i],
-				 afe->reg_back_up[i]);
+	} else {
+		for (i = 0; i < afe->reg_back_up_list_num; i++)
+			mtk_regmap_write(regmap, afe->reg_back_up_list[i],
+					 afe->reg_back_up[i]);
+	}
 
 	afe->suspended = false;
 	return 0;
-- 
2.18.0

