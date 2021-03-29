Return-Path: <SRS0=ZkCr=I3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FBE1C433C1
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 15:06:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB96C6157F
	for <alsa-devel@archiver.kernel.org>; Mon, 29 Mar 2021 15:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB96C6157F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4A3C2167A;
	Mon, 29 Mar 2021 17:05:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4A3C2167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1617030403;
	bh=n8LDgV5aTKIZ48XAw7rlW5PwyoJJjDJKiD1337xnQlA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=c/QVVfWhA3ZnBGdAb6pIjI/YU2LuRDhC3ypmxA4eSpixq988v2pvyB+Po2gH3Wm+l
	 BP0n7ZS9ExIHt+4A4CO0ogxYQjsgyIaxDfktnBzyLEt1UOOwWkta6/2mEHvjp8iq1F
	 pcOhzdy4pWbozZD+YK5LjwTdFKMxqzdFpNQmo0ig=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BD81EF80157;
	Mon, 29 Mar 2021 17:05:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B766AF8015A; Mon, 29 Mar 2021 17:05:51 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2DBAFF80141
 for <alsa-devel@alsa-project.org>; Mon, 29 Mar 2021 17:05:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2DBAFF80141
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F8G692hljzPm24;
 Mon, 29 Mar 2021 23:02:57 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.498.0; Mon, 29 Mar 2021
 23:05:26 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: dwc: Fix -Wmissing-prototypes warnings
Date: Mon, 29 Mar 2021 23:05:24 +0800
Message-ID: <20210329150524.18184-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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

while CONFIG_SND_DESIGNWARE_PCM is not set, building with W=1 shows this:

sound/soc/dwc/local.h:127:6: warning: no previous prototype for ‘dw_pcm_push_tx’ [-Wmissing-prototypes]
 void dw_pcm_push_tx(struct dw_i2s_dev *dev) { }
      ^~~~~~~~~~~~~~
sound/soc/dwc/local.h:128:6: warning: no previous prototype for ‘dw_pcm_pop_rx’ [-Wmissing-prototypes]
 void dw_pcm_pop_rx(struct dw_i2s_dev *dev) { }
      ^~~~~~~~~~~~~
sound/soc/dwc/local.h:129:5: warning: no previous prototype for ‘dw_pcm_register’ [-Wmissing-prototypes]
 int dw_pcm_register(struct platform_device *pdev)
     ^~~~~~~~~~~~~~~

Change these to inline functions to fix the warnings.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/dwc/local.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/dwc/local.h b/sound/soc/dwc/local.h
index 91dc70a826f8..1c361eb6127e 100644
--- a/sound/soc/dwc/local.h
+++ b/sound/soc/dwc/local.h
@@ -124,9 +124,9 @@ void dw_pcm_push_tx(struct dw_i2s_dev *dev);
 void dw_pcm_pop_rx(struct dw_i2s_dev *dev);
 int dw_pcm_register(struct platform_device *pdev);
 #else
-void dw_pcm_push_tx(struct dw_i2s_dev *dev) { }
-void dw_pcm_pop_rx(struct dw_i2s_dev *dev) { }
-int dw_pcm_register(struct platform_device *pdev)
+static inline void dw_pcm_push_tx(struct dw_i2s_dev *dev) { }
+static inline void dw_pcm_pop_rx(struct dw_i2s_dev *dev) { }
+static inline int dw_pcm_register(struct platform_device *pdev)
 {
 	return -EINVAL;
 }
-- 
2.17.1

