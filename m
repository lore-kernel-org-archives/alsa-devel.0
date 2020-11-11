Return-Path: <SRS0=kIe0=ER=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C0FC388F9
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 13:08:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CCBC5206CA
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Nov 2020 13:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fVZDGoa/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCBC5206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F122B1769;
	Wed, 11 Nov 2020 14:07:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F122B1769
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605100102;
	bh=8wi1WNl+EPQo+TBW6DnItPQZpFg0h0s7c/CD0ovBl6o=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fVZDGoa/FVMShmS679FE1SjzO69rMF7wtRGeu8cLotVreXKis7hcDmF9F2MFkAFlK
	 LcQSufCaHJRxqybyBT8nHbIlddeiCp138cie/P1mG0Syn252e+P34RNANDR05/Uwjs
	 M4wf6nAuW17Rn9Zb5wte+Qu4qxWucTB2VQfIrI64=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABB18F804C1;
	Wed, 11 Nov 2020 14:05:59 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D644BF8027C; Wed, 11 Nov 2020 14:05:55 +0100 (CET)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7E4ABF8022D
 for <alsa-devel@alsa-project.org>; Wed, 11 Nov 2020 14:05:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7E4ABF8022D
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CWQ2S2Vvjzhhpc;
 Wed, 11 Nov 2020 21:05:36 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Nov 2020
 21:05:37 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <rf@opensource.cirrus.com>
Subject: [PATCH v2 2/4] ASoC: arizona: Fix PM disable depth imbalance on error
Date: Wed, 11 Nov 2020 21:09:21 +0800
Message-ID: <20201111130923.220186-3-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20201111130923.220186-1-zhangqilong3@huawei.com>
References: <20201111130923.220186-1-zhangqilong3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org
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
keep it balanced according to context.

Fixes: 85e7dd3f871b9 ("ASoC: arizona: Add support for setting the output volume limits")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
 sound/soc/codecs/wm8997.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8997.c b/sound/soc/codecs/wm8997.c
index 229f2986cd96..014328162262 100644
--- a/sound/soc/codecs/wm8997.c
+++ b/sound/soc/codecs/wm8997.c
@@ -1163,10 +1163,10 @@ static int wm8997_probe(struct platform_device *pdev)
 
 	ret = arizona_init_vol_limit(arizona);
 	if (ret < 0)
-		return ret;
+		goto err_pm_disable;
 	ret = arizona_init_spk_irqs(arizona);
 	if (ret < 0)
-		return ret;
+		goto err_pm_disable;
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					      &soc_component_dev_wm8997,
@@ -1181,6 +1181,8 @@ static int wm8997_probe(struct platform_device *pdev)
 
 err_spk_irqs:
 	arizona_free_spk_irqs(arizona);
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
 
 	return ret;
 }
-- 
2.25.4

