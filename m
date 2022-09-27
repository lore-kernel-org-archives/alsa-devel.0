Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A498C6FA82
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Sep 2022 14:23:59 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89C3784B;
	Tue, 27 Sep 2022 16:23:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89C3784B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664288637;
	bh=xpO7wjpnoJ0aKhp9nXGI/S6d2w2ru5I3IB83eJ+q1Dc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jNwQ5qSDCYx+5G/4WxNoRCYx+osgJNyrXijWBlD8KA8iTLBFiqR9QCN24EPjT6M2r
	 aJ7KuB5OR6YGic++NTlKNa+PoSYlsAU95luZIZul8dwuw6pehxVmIH+CVtcw/6iRNM
	 RNH+1BLQx8BjX9pLH+9AId5YTTNBUrcCwhAERNTk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4483F804D0;
	Tue, 27 Sep 2022 16:22:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5B02CF8011C; Tue, 27 Sep 2022 16:22:43 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 15F54F8011C
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2022 16:22:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 15F54F8011C
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4McMDN0WwdzWgpj;
 Tue, 27 Sep 2022 22:18:28 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 27 Sep 2022 22:22:32 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 27 Sep
 2022 22:22:32 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <olivier.moysan@foss.st.com>, <arnaud.pouliquen@foss.st.com>,
 <perex@perex.cz>, <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
 <lgirdwood@gmail.com>, <broonie@kernel.org>
Subject: [PATCH v2 -next 2/2] ASoC: stm32: spdifrx: Fix PM disable depth
 imbalance in stm32_spdifrx_probe
Date: Tue, 27 Sep 2022 22:26:01 +0800
Message-ID: <20220927142601.64266-3-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
In-Reply-To: <20220927142601.64266-1-zhangqilong3@huawei.com>
References: <20220927142601.64266-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, linux-stm32@st-md-mailman.stormreply.com
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

The pm_runtime_enable will increase power disable depth. Thus
a pairing decrement is needed on the error handling path to
keep it balanced according to context. We fix it by moving
pm_runtime_enable to the endding of stm32_spdifrx_probe.

Fixes:ac5e3efd55868 ("ASoC: stm32: spdifrx: add pm_runtime support")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
Reviewed-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 sound/soc/stm/stm32_spdifrx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_spdifrx.c b/sound/soc/stm/stm32_spdifrx.c
index 0f7146756717..d399c906bb92 100644
--- a/sound/soc/stm/stm32_spdifrx.c
+++ b/sound/soc/stm/stm32_spdifrx.c
@@ -1002,8 +1002,6 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 	udelay(2);
 	reset_control_deassert(rst);
 
-	pm_runtime_enable(&pdev->dev);
-
 	pcm_config = &stm32_spdifrx_pcm_config;
 	ret = snd_dmaengine_pcm_register(&pdev->dev, pcm_config, 0);
 	if (ret)
@@ -1036,6 +1034,8 @@ static int stm32_spdifrx_probe(struct platform_device *pdev)
 			FIELD_GET(SPDIFRX_VERR_MIN_MASK, ver));
 	}
 
+	pm_runtime_enable(&pdev->dev);
+
 	return ret;
 
 error:
-- 
2.25.1

