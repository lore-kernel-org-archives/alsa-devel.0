Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62D06C04FF3
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 11:52:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4B3F6109F
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 11:52:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4B3F6109F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84C751697;
	Mon, 24 May 2021 13:51:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84C751697
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621857151;
	bh=hu4+KZ8xVdlx/vRomknwNPFDYe0pJ/bVJ35PGqHj0n4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KIn6e8wE6g9zidyz/qYUOlJHWdBl+n+m4z/3O1vzguR5kALiMeI8NxmHtdqw63JbF
	 cqwqG+xV6Z0f13/DOrFw+Z3mTdyPZ57HuumxAxv6AJIS8UPRwtlJHhSgqURaGsK2VL
	 xfgCB4wpe+JqICPIwhcf/ckjRMg2nbTVSa7nZGio=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1B407F8021D;
	Mon, 24 May 2021 13:51:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4795BF8022B; Mon, 24 May 2021 13:51:39 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2422F80137
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 13:51:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2422F80137
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fpb8B3V35zwSqY;
 Mon, 24 May 2021 19:48:42 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:51:32 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 24
 May 2021 19:51:32 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [PATCH -next] ASoC: tlv320aic26: use DEVICE_ATTR_RW macro
Date: Mon, 24 May 2021 19:51:31 +0800
Message-ID: <20210524115131.46288-1-yuehaibing@huawei.com>
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

Use DEVICE_ATTR_RW() helper instead of plain DEVICE_ATTR(),
which makes the code a bit shorter and easier to read.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/tlv320aic26.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic26.c b/sound/soc/codecs/tlv320aic26.c
index c7baef8948d4..077415a57225 100644
--- a/sound/soc/codecs/tlv320aic26.c
+++ b/sound/soc/codecs/tlv320aic26.c
@@ -261,8 +261,8 @@ static const struct snd_kcontrol_new aic26_snd_controls[] = {
  * SPI device portion of driver: sysfs files for debugging
  */
 
-static ssize_t aic26_keyclick_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
+static ssize_t keyclick_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
 {
 	struct aic26 *aic26 = dev_get_drvdata(dev);
 	int val, amp, freq, len;
@@ -276,9 +276,9 @@ static ssize_t aic26_keyclick_show(struct device *dev,
 }
 
 /* Any write to the keyclick attribute will trigger the keyclick event */
-static ssize_t aic26_keyclick_set(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
+static ssize_t keyclick_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t count)
 {
 	struct aic26 *aic26 = dev_get_drvdata(dev);
 
@@ -288,7 +288,7 @@ static ssize_t aic26_keyclick_set(struct device *dev,
 	return count;
 }
 
-static DEVICE_ATTR(keyclick, 0644, aic26_keyclick_show, aic26_keyclick_set);
+static DEVICE_ATTR_RW(keyclick);
 
 /* ---------------------------------------------------------------------
  * SoC CODEC portion of driver: probe and release routines
-- 
2.17.1

