Return-Path: <SRS0=Vkr5=LK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0C7C48BDF
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 02:52:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C86F61159
	for <alsa-devel@archiver.kernel.org>; Wed, 16 Jun 2021 02:52:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C86F61159
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADB241686;
	Wed, 16 Jun 2021 04:51:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADB241686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623811939;
	bh=XSsJ5fw6nl7hGUihgwPAmGhHyhUdv5YYIoSmKuCWb6U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sXMDsCTBO+pzyxT9oY/XlcMBdK4DaBr2FKxvyN0+MyX6fetThx7Bf6kF7wc55KKVD
	 /yZyKsknexgrCnn+zeEuPA2x2xoZLBgIxqCLyCoh5S7xp5Zn9F5a/c3zD3a7cFYkd6
	 PqRAoX9dWymethouczowggBY/d7GeflVftDqz5f8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3952EF80165;
	Wed, 16 Jun 2021 04:51:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88647F80423; Wed, 16 Jun 2021 04:51:25 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E6F4FF80165
 for <alsa-devel@alsa-project.org>; Wed, 16 Jun 2021 04:51:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6F4FF80165
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4G4V424bJDzZfBy;
 Wed, 16 Jun 2021 10:48:18 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 16 Jun 2021 10:51:13 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 16 Jun
 2021 10:51:13 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH -next] ALSA: fm801: Fix missing pci_release_regions() on error
 in snd_fm801_create()
Date: Wed, 16 Jun 2021 10:55:07 +0800
Message-ID: <20210616025507.2120103-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Cc: broonie@kernel.org, tiwai@suse.com
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

Fix the missing pci_release_regions() before return
from snd_fm801_create() in the error handling case.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/pci/fm801.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/pci/fm801.c b/sound/pci/fm801.c
index ed9dae87145b..adac9c6a67f0 100644
--- a/sound/pci/fm801.c
+++ b/sound/pci/fm801.c
@@ -1254,6 +1254,7 @@ static int snd_fm801_create(struct snd_card *card,
 				IRQF_SHARED, KBUILD_MODNAME, chip)) {
 			dev_err(card->dev, "unable to grab IRQ %d\n", pci->irq);
 			snd_fm801_free(chip);
+			pci_release_regions(pci);
 			return -EBUSY;
 		}
 		chip->irq = pci->irq;
@@ -1266,6 +1267,7 @@ static int snd_fm801_create(struct snd_card *card,
 	err = snd_device_new(card, SNDRV_DEV_LOWLEVEL, chip, &ops);
 	if (err < 0) {
 		snd_fm801_free(chip);
+		pci_release_regions(pci);
 		return err;
 	}
 
@@ -1273,6 +1275,7 @@ static int snd_fm801_create(struct snd_card *card,
 	err = v4l2_device_register(&pci->dev, &chip->v4l2_dev);
 	if (err < 0) {
 		snd_fm801_free(chip);
+		pci_release_regions(pci);
 		return err;
 	}
 	chip->tea.v4l2_dev = &chip->v4l2_dev;
@@ -1285,6 +1288,7 @@ static int snd_fm801_create(struct snd_card *card,
 		if (snd_tea575x_init(&chip->tea, THIS_MODULE)) {
 			dev_err(card->dev, "TEA575x radio not found\n");
 			snd_fm801_free(chip);
+			pci_release_regions(pci);
 			return -ENODEV;
 		}
 	} else if ((chip->tea575x_tuner & TUNER_TYPE_MASK) == 0) {
-- 
2.25.1

