Return-Path: <SRS0=tEYa=KV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC51C2B9F7
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 12:19:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A23AC613CE
	for <alsa-devel@archiver.kernel.org>; Wed, 26 May 2021 12:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A23AC613CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 91689173E;
	Wed, 26 May 2021 14:18:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 91689173E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622031582;
	bh=t7kWHyXEAwrkhUxEmcwhbU/fbHfSnbvgivwwW+anl4w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=srdJQNzcmG/mgWQp2FMwpEl52vJQbUYwJXUIgAQ7/brfcD1qU94BR9XIx5XNt9AiU
	 jUa/ym5rEF640TAQPf9yynynfROthDGJUIB0ESlWiuKuKVnAVsJj2zbh+FAZ7Xq5T7
	 Vnk6c3/iSSjvgX3Fj8Ra4dxx5YW2/CKsqj70ugfg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2802FF8024E;
	Wed, 26 May 2021 14:18:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 89B19F8025C; Wed, 26 May 2021 14:18:50 +0200 (CEST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 84F9AF80212
 for <alsa-devel@alsa-project.org>; Wed, 26 May 2021 14:18:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 84F9AF80212
Received: from dggems703-chm.china.huawei.com (unknown [172.30.72.58])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Fqqg418LZzmZJv;
 Wed, 26 May 2021 20:16:16 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems703-chm.china.huawei.com (10.3.19.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Wed, 26 May 2021 20:18:37 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Wed, 26
 May 2021 20:18:36 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>
Subject: [PATCH -next] ALSA: core: use DEVICE_ATTR_*() macro
Date: Wed, 26 May 2021 20:18:28 +0800
Message-ID: <20210526121828.8460-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, YueHaibing <yuehaibing@huawei.com>,
 linux-kernel@vger.kernel.org
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

Use DEVICE_ATTR_*() helper instead of plain DEVICE_ATTR,
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/core/init.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/sound/core/init.c b/sound/core/init.c
index 70114fd26956..228faf9369dc 100644
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -665,17 +665,15 @@ void snd_card_set_id(struct snd_card *card, const char *nid)
 }
 EXPORT_SYMBOL(snd_card_set_id);
 
-static ssize_t
-card_id_show_attr(struct device *dev,
-		  struct device_attribute *attr, char *buf)
+static ssize_t id_show(struct device *dev,
+		       struct device_attribute *attr, char *buf)
 {
 	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
 	return scnprintf(buf, PAGE_SIZE, "%s\n", card->id);
 }
 
-static ssize_t
-card_id_store_attr(struct device *dev, struct device_attribute *attr,
-		   const char *buf, size_t count)
+static ssize_t id_store(struct device *dev, struct device_attribute *attr,
+			const char *buf, size_t count)
 {
 	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
 	char buf1[sizeof(card->id)];
@@ -703,17 +701,16 @@ card_id_store_attr(struct device *dev, struct device_attribute *attr,
 	return count;
 }
 
-static DEVICE_ATTR(id, 0644, card_id_show_attr, card_id_store_attr);
+static DEVICE_ATTR_RW(id);
 
-static ssize_t
-card_number_show_attr(struct device *dev,
-		     struct device_attribute *attr, char *buf)
+static ssize_t number_show(struct device *dev,
+			   struct device_attribute *attr, char *buf)
 {
 	struct snd_card *card = container_of(dev, struct snd_card, card_dev);
 	return scnprintf(buf, PAGE_SIZE, "%i\n", card->number);
 }
 
-static DEVICE_ATTR(number, 0444, card_number_show_attr, NULL);
+static DEVICE_ATTR_RO(number);
 
 static struct attribute *card_dev_attrs[] = {
 	&dev_attr_id.attr,
-- 
2.17.1

