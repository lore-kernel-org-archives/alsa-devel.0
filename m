Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4759DC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:23:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB5802074B
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 13:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="u7rrAp96"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB5802074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F23C10E;
	Thu, 16 Jul 2020 15:22:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F23C10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594905816;
	bh=S9LoufUhBfT42S79UEX5HuSFyUV1GHfnz0vgVs5e9uw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=u7rrAp96NCvAy28MPllTKi6LkqBnZtHeYKk6F3ZL4JI2hrvtqxQgwwtn4TX7OHCoS
	 G2Z4ftRhfC0SKjGfZ7fVHmmCDhc4HieZrJh8sI/Z3AZmqZX4IVJcCozjJNJSCONnSg
	 4umcyAL3VhOSQf28t3BWiF65r6qcbprgNpo4XeXQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBC6BF80110;
	Thu, 16 Jul 2020 15:22:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87E8DF801EC; Thu, 16 Jul 2020 15:22:44 +0200 (CEST)
Received: from huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7AB32F80110
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 15:22:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7AB32F80110
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id E1ACDF1C77EE7C3B6E82;
 Thu, 16 Jul 2020 21:22:29 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Thu, 16 Jul 2020 21:22:22 +0800
From: Jing Xiangfeng <jingxiangfeng@huawei.com>
To: <jbrunet@baylibre.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
 <perex@perex.cz>, <tiwai@suse.com>, <khilman@baylibre.com>,
 <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH] ASoC: meson: add the missed kfree() for
 axg_card_add_tdm_loopback
Date: Thu, 16 Jul 2020 21:25:58 +0800
Message-ID: <20200716132558.33932-1-jingxiangfeng@huawei.com>
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

axg_card_add_tdm_loopback() misses to call kfree() in an error path. Add
the missed function call to fix it.

Fixes: c84836d7f650 ("ASoC: meson: axg-card: use modern dai_link style")
Signed-off-by: Jing Xiangfeng <jingxiangfeng@huawei.com>
---
 sound/soc/meson/axg-card.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
index 89f7f64747cd..6eac22ba8b99 100644
--- a/sound/soc/meson/axg-card.c
+++ b/sound/soc/meson/axg-card.c
@@ -121,8 +121,10 @@ static int axg_card_add_tdm_loopback(struct snd_soc_card *card,
 		return -ENOMEM;
 
 	dlc = devm_kzalloc(card->dev, 2 * sizeof(*dlc), GFP_KERNEL);
-	if (!dlc)
+	if (!dlc) {
+		kfree(lb->name);
 		return -ENOMEM;
+	}
 
 	lb->cpus = &dlc[0];
 	lb->codecs = &dlc[1];
-- 
2.17.1

