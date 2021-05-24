Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9ADC04FF3
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 12:03:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 724326109F
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 12:03:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724326109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E643316CB;
	Mon, 24 May 2021 14:02:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E643316CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621857781;
	bh=EePrrE0RUvoC/KhqegCkYoYHBRxOvbaoqIQuuj/Mkj8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cBFR9QYu4Ts5hgBBb/sVXyysrHqDV7a9d943zc8mzzWT5SODIMrc+3IG1EmJLZmQZ
	 +jGSGNNTYJcwUHFMpsEDmsDHg2OZsCou3f2KsylX/nhNkGYIQ0JwohJAwGjHSSQqX9
	 BWL/XEBq78A6WtIyRPnMbD5uKG/pMBJmN+2U7Omo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE5E3F80430;
	Mon, 24 May 2021 14:00:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 57D0CF80431; Mon, 24 May 2021 14:00:48 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6962EF80424
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 14:00:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6962EF80424
Received: from dggems705-chm.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FpbKp1095zmkh2;
 Mon, 24 May 2021 19:57:02 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems705-chm.china.huawei.com (10.3.19.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 20:00:29 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 24
 May 2021 20:00:29 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>
Subject: [PATCH -next] ALSA: pcm: use DEVICE_ATTR_RO macro
Date: Mon, 24 May 2021 20:00:07 +0800
Message-ID: <20210524120007.39728-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Use DEVICE_ATTR_RO() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/core/pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/pcm.c b/sound/core/pcm.c
index b163164a83ec..6fd3677685d7 100644
--- a/sound/core/pcm.c
+++ b/sound/core/pcm.c
@@ -1004,7 +1004,7 @@ void snd_pcm_detach_substream(struct snd_pcm_substream *substream)
 	substream->pstr->substream_opened--;
 }
 
-static ssize_t show_pcm_class(struct device *dev,
+static ssize_t pcm_class_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
 	struct snd_pcm_str *pstr = container_of(dev, struct snd_pcm_str, dev);
@@ -1024,7 +1024,7 @@ static ssize_t show_pcm_class(struct device *dev,
 	return sprintf(buf, "%s\n", str);
 }
 
-static DEVICE_ATTR(pcm_class, 0444, show_pcm_class, NULL);
+static DEVICE_ATTR_RO(pcm_class);
 static struct attribute *pcm_dev_attrs[] = {
 	&dev_attr_pcm_class.attr,
 	NULL
-- 
2.17.1

