Return-Path: <SRS0=LWy3=O5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68B60C433EF
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Oct 2021 06:52:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 782EF60F55
	for <alsa-devel@archiver.kernel.org>; Sat,  9 Oct 2021 06:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 782EF60F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1449B167A;
	Sat,  9 Oct 2021 08:51:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1449B167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633762321;
	bh=IoS6e9GXXlCEPRerNAAAfhIHIL1hPZEuhU6yEXFN3cc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=psFR2GtLckm0UfmvDJVJUHMUKLEQUkY2XiwSASEHw9BFcIpPpC/AhtrPKU65v7UC2
	 SxRQE0UzdTNwmwX6987Doz0tvrvNgsmAAbG40Hbpmr63hnMejFBXgVl2VYw9OCEgMm
	 ZMhMNTqrV3BvX3DNaSgYjPGRSxQslnq8P5VLTLUE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 68B28F80259;
	Sat,  9 Oct 2021 08:51:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1D669F8027D; Sat,  9 Oct 2021 08:51:09 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 08BEFF800F0
 for <alsa-devel@alsa-project.org>; Sat,  9 Oct 2021 08:51:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 08BEFF800F0
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HRFzh5J9pzQj3X;
 Sat,  9 Oct 2021 14:49:52 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 9 Oct 2021 14:50:55 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 9 Oct 2021
 14:50:54 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH] ASoC: soc-core: fix null-ptr-deref in
 snd_soc_del_component_unlocked()
Date: Sat, 9 Oct 2021 14:58:40 +0800
Message-ID: <20211009065840.3196239-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Cc: lgirdwood@gmail.com, broonie@kernel.org, tiwai@suse.com
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

'component' is allocated in snd_soc_register_component(), but component->list
is not initalized, this may cause snd_soc_del_component_unlocked() deref null
ptr in the error handing case.

KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
RIP: 0010:__list_del_entry_valid+0x81/0xf0
Call Trace:
 snd_soc_del_component_unlocked+0x69/0x1b0 [snd_soc_core]
 snd_soc_add_component.cold+0x54/0x6c [snd_soc_core]
 snd_soc_register_component+0x70/0x90 [snd_soc_core]
 devm_snd_soc_register_component+0x5e/0xd0 [snd_soc_core]
 tas2552_probe+0x265/0x320 [snd_soc_tas2552]
 ? tas2552_component_probe+0x1e0/0x1e0 [snd_soc_tas2552]
 i2c_device_probe+0xa31/0xbe0

Fix by adding INIT_LIST_HEAD() to snd_soc_component_initialize().

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/soc-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c830e96afba2..80ca260595fd 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2599,6 +2599,7 @@ int snd_soc_component_initialize(struct snd_soc_component *component,
 	INIT_LIST_HEAD(&component->dai_list);
 	INIT_LIST_HEAD(&component->dobj_list);
 	INIT_LIST_HEAD(&component->card_list);
+	INIT_LIST_HEAD(&component->list);
 	mutex_init(&component->io_mutex);
 
 	component->name = fmt_single_name(dev, &component->id);
-- 
2.25.1

