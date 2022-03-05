Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C76CC433F5
	for <alsa-devel@archiver.kernel.org>; Sat,  5 Mar 2022 12:38:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B1FEB1A26;
	Sat,  5 Mar 2022 13:37:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B1FEB1A26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646483908;
	bh=VN/BTyQ6YXxryzTpn7h9zkxZdPSJO1L/iFj4E1CtgGw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vJS4INqXS2ak6sZz+YDbh8pST8iXf8/JJ7E35aV+7fDn624Ewa8DdQ8gfvHeI9t1j
	 pJs0Hxuy2u1vIILqIX5C2BTspFL34aDb5ZNuk52idZq9s9tf3ecGdc7d6TAn1a4uL4
	 xXniRD+ukOiza2rYnamAdkfqKWw1O9Z794j4ykEY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6005AF80237;
	Sat,  5 Mar 2022 13:37:38 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9404EF8025D; Sat,  5 Mar 2022 13:37:37 +0100 (CET)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C19CF800E4
 for <alsa-devel@alsa-project.org>; Sat,  5 Mar 2022 13:37:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C19CF800E4
Received: from canpemm500007.china.huawei.com (unknown [172.30.72.53])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4K9khp0bZJzBs4F;
 Sat,  5 Mar 2022 20:35:38 +0800 (CST)
Received: from localhost (10.174.179.215) by canpemm500007.china.huawei.com
 (7.192.104.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 5 Mar
 2022 20:37:29 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <Vijendar.Mukunda@amd.com>,
 <pierre-louis.bossart@linux.intel.com>, <tangmeng@uniontech.com>
Subject: [PATCH -next] ASoC: amd: acp5x-pcm-dma: Fix signedness bug
Date: Sat, 5 Mar 2022 20:37:05 +0800
Message-ID: <20220305123705.3708-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.215]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500007.china.huawei.com (7.192.104.62)
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

In acp5x_audio_probe() platform_get_irq() may return error, but i2s_irq now
is unsigned int so the error handling is never triggered.

Fixes: 87d71a128771 ("ASoC: amd: pcm-dma: Use platform_get_irq() to get the interrupt")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/amd/vangogh/acp5x.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/vangogh/acp5x.h b/sound/soc/amd/vangogh/acp5x.h
index b85d3ee369a3..bd9f1c5684d1 100644
--- a/sound/soc/amd/vangogh/acp5x.h
+++ b/sound/soc/amd/vangogh/acp5x.h
@@ -85,7 +85,7 @@
 struct i2s_dev_data {
 	bool tdm_mode;
 	bool master_mode;
-	unsigned int i2s_irq;
+	int i2s_irq;
 	u16 i2s_instance;
 	u32 tdm_fmt;
 	void __iomem *acp5x_base;
-- 
2.17.1

