Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE7AC2D0A3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:46:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D976022384
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="H0B+L1VT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D976022384
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32A0E1745;
	Tue,  3 Nov 2020 08:45:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32A0E1745
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604389575;
	bh=HNHT6Xx1TpQ9QcnZTV4nnV0YTwlWP7TpOX7tNCwsa3g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H0B+L1VTfYqHM9fa7mNivkxpIhEp9BCRrtuJF9fBDeushxDCbGKr5wHndFgKquXL2
	 3if1LrYdS433WdBWi5bbGsHSfMf+aRujZgbbZUhJnNMLgJpzPWfAY4I8DrC1am3org
	 OhptZr6IQ9HesAuU6ZE14u2Cu/HBO/PqBy6rq6CE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A9D0EF80162;
	Tue,  3 Nov 2020 08:45:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34B77F801D5; Fri, 30 Oct 2020 16:21:44 +0100 (CET)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 44C49F800FF
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 16:21:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 44C49F800FF
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CN5cq0yqqzkYvM;
 Fri, 30 Oct 2020 23:21:31 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 30 Oct 2020
 23:21:27 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>
Subject: [PATCH] ALSA: ac97: fix reference leak in ac97_bus_remove
Date: Fri, 30 Oct 2020 23:32:10 +0800
Message-ID: <20201030153210.92234-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 03 Nov 2020 08:45:21 +0100
Cc: alsa-devel@alsa-project.org
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

pm_runtime_get_sync() will increase pm usage counter even it
failed. We should call pm_runtime_put_noidle to decrease it
to prevent reference leak.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 sound/ac97/bus.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/ac97/bus.c b/sound/ac97/bus.c
index 7985dd8198b6..2c4779d851ad 100644
--- a/sound/ac97/bus.c
+++ b/sound/ac97/bus.c
@@ -521,8 +521,11 @@ static int ac97_bus_remove(struct device *dev)
 	int ret;
 
 	ret = pm_runtime_get_sync(dev);
-	if (ret < 0)
+	if (ret < 0) {
+		dev_err(dev, "Failed to enable device: %d\n", ret);
+		pm_runtime_put_noidle(dev);
 		return ret;
+	}
 
 	ret = adrv->remove(adev);
 	pm_runtime_put_noidle(dev);
-- 
2.17.1

