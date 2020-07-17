Return-Path: <SRS0=vkql=A4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EA2C433E1
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 08:20:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706FA2074B
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Jul 2020 08:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CPIM/xiD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706FA2074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 02C02167D;
	Fri, 17 Jul 2020 10:19:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 02C02167D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594974015;
	bh=pzUN2Ov4biKzc5lYCqS8hlrROz0sJBM+ebPZ/iKV4SI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CPIM/xiDc/jvtgSzO59ZdH0I7zlkFE5lxY3/YAdTlPUbqKfVQ+QgFSrRYhUyAC0Kn
	 AnFS76REkM4JbA3ksmEmxb7s2LVBahLgXZFEy2s8hRjAmRl5mlLXRXmbevLyd8NlpC
	 hDgMrY62K42wDUaUOR7q+RlCPmd6dve/WQhLdExg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 92108F8014E;
	Fri, 17 Jul 2020 10:19:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D752DF80227; Fri, 17 Jul 2020 10:19:22 +0200 (CEST)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B9F18F801D8
 for <alsa-devel@alsa-project.org>; Fri, 17 Jul 2020 10:19:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B9F18F801D8
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 536C352A645CA3F5BF09;
 Fri, 17 Jul 2020 16:19:10 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Fri, 17 Jul 2020 16:19:02 +0800
From: Jing Xiangfeng <jingxiangfeng@huawei.com>
To: <jbrunet@baylibre.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <perex@perex.cz>, <tiwai@suse.com>, <khilman@baylibre.com>,
 <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH v2] ASoC: meson: fixes the missed kfree() for
 axg_card_add_tdm_loopback
Date: Fri, 17 Jul 2020 16:22:42 +0800
Message-ID: <20200717082242.130627-1-jingxiangfeng@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Cc: linux-amlogic@lists.infradead.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 jingxiangfeng@huawei.com
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

axg_card_add_tdm_loopback() misses to call kfree() in an error path. We
can use devm_kasprintf() to fix the issue, also improve maintainability.
So use it instead.

Fixes: c84836d7f650 ("ASoC: meson: axg-card: use modern dai_link style")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 sound/soc/meson/axg-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 89f7f64747cd..47f2d93224fe 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -116,7 +116,7 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
 
 	lb = &card->dai_link[*index + 1];
 
-	lb->name = kasprintf(GFP_KERNEL, "%s-lb", pad->name);
+	lb->name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-lb", pad->name);
 	if (!lb->name)
 		return -ENOMEM;
 
-- 
2.17.1

