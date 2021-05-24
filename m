Return-Path: <SRS0=TLt2=KT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D04C04FF3
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 11:41:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CF5A61028
	for <alsa-devel@archiver.kernel.org>; Mon, 24 May 2021 11:41:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CF5A61028
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0BC37166A;
	Mon, 24 May 2021 13:40:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0BC37166A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621856507;
	bh=Dt0r6MNHL/NjuGXD8UeOdlRZCry+9vCvIWJYTa62/4o=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KSFDO/GUNAbxe6WNHbL0g4Hgr3HbesKDJELFC3OctcpnQy9QroDJqEPed6yTZXifM
	 +cvWfxHl5c7daifsctWaRjrqvVH5YNlUhkreCBkXJ+KHxZSesPoKmlMA2/u+1DCBmB
	 daZVxlQXAjpJQGnkqLL8Ddk9Va+0gu4npMRbULcw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8BFEEF8021D;
	Mon, 24 May 2021 13:40:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F619F8022B; Mon, 24 May 2021 13:40:55 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3D494F80137
 for <alsa-devel@alsa-project.org>; Mon, 24 May 2021 13:40:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D494F80137
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FpZtm1CDYzNydt;
 Mon, 24 May 2021 19:37:04 +0800 (CST)
Received: from dggema769-chm.china.huawei.com (10.1.198.211) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Mon, 24 May 2021 19:40:39 +0800
Received: from localhost (10.174.179.215) by dggema769-chm.china.huawei.com
 (10.1.198.211) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Mon, 24
 May 2021 19:40:39 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <james.schulman@cirrus.com>, <david.rhodes@cirrus.com>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [PATCH -next] ASoC: cs43130: Use DEVICE_ATTR_RO macro
Date: Mon, 24 May 2021 19:40:17 +0800
Message-ID: <20210524114017.18672-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema769-chm.china.huawei.com (10.1.198.211)
X-CFilter-Loop: Reflected
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org
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
 sound/soc/codecs/cs43130.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index de7fa3e4bfbb..44b20c1ef851 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -1672,14 +1672,14 @@ static int cs43130_show_dc(struct device *dev, char *buf, u8 ch)
 				 cs43130->hpload_dc[ch]);
 }
 
-static ssize_t cs43130_show_dc_l(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t hpload_dc_l_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	return cs43130_show_dc(dev, buf, HP_LEFT);
 }
 
-static ssize_t cs43130_show_dc_r(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t hpload_dc_r_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	return cs43130_show_dc(dev, buf, HP_RIGHT);
 }
@@ -1719,22 +1719,22 @@ static int cs43130_show_ac(struct device *dev, char *buf, u8 ch)
 	}
 }
 
-static ssize_t cs43130_show_ac_l(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t hpload_ac_l_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	return cs43130_show_ac(dev, buf, HP_LEFT);
 }
 
-static ssize_t cs43130_show_ac_r(struct device *dev,
-				 struct device_attribute *attr, char *buf)
+static ssize_t hpload_ac_r_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
 {
 	return cs43130_show_ac(dev, buf, HP_RIGHT);
 }
 
-static DEVICE_ATTR(hpload_dc_l, 0444, cs43130_show_dc_l, NULL);
-static DEVICE_ATTR(hpload_dc_r, 0444, cs43130_show_dc_r, NULL);
-static DEVICE_ATTR(hpload_ac_l, 0444, cs43130_show_ac_l, NULL);
-static DEVICE_ATTR(hpload_ac_r, 0444, cs43130_show_ac_r, NULL);
+static DEVICE_ATTR_RO(hpload_dc_l);
+static DEVICE_ATTR_RO(hpload_dc_r);
+static DEVICE_ATTR_RO(hpload_ac_l);
+static DEVICE_ATTR_RO(hpload_ac_r);
 
 static struct attribute *hpload_attrs[] = {
 	&dev_attr_hpload_dc_l.attr,
-- 
2.17.1

