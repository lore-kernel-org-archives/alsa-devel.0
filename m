Return-Path: <SRS0=G+7e=EJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD7ACC2D0A3
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:48:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F98F22384
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Nov 2020 07:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="uWA7s0Jk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F98F22384
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A5C841743;
	Tue,  3 Nov 2020 08:47:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A5C841743
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604389718;
	bh=T+165QLrgXu6NY9kDdOJj9CbzRu3iu81XTbfFCT1plk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uWA7s0JkU0DTqiN6nw4oX+quFzKDHuGw3ytzM/B0j3SLiFPI6WZ3LtnSzHK/UqOHJ
	 9fNM5TTc1hTZ7cVTn6D+aR9SRhaBFhsr8VnyzVy32yFnPwRsBx24tW1l7j8yPSxcKj
	 rHmjdQLJbuZ8DluB3efJMFTmjN0VfYrNmE/Zumbc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BABBFF804D6;
	Tue,  3 Nov 2020 08:45:28 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D947AF80232; Mon,  2 Nov 2020 09:44:10 +0100 (CET)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3EB7F80083
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2020 09:44:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3EB7F80083
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4CPmfh5d72zkddh;
 Mon,  2 Nov 2020 16:43:56 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Mon, 2 Nov 2020
 16:43:53 +0800
From: Zhang Qilong <zhangqilong3@huawei.com>
To: <peter.ujfalusi@ti.com>, <perex@perex.cz>, <tiwai@suse.com>
Subject: [PATCH v2] ASoC: ti: davinci-mcasp: fix error handling in
 davinci_mcasp_probe
Date: Mon, 2 Nov 2020 16:54:36 +0800
Message-ID: <20201102085436.14450-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Tue, 03 Nov 2020 08:45:21 +0100
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
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

Forgetting to call pm_runtime_disable if davinci_mcasp_get_dt_params
failed in function davinci_mcasp_probe, and we should go to error
handling branch.

Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
Changelog:
V2
- changed the subject and fixed the description.
---
 sound/soc/ti/davinci-mcasp.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index 4b46dd827f3f..ec90c23c9e20 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2362,8 +2362,10 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		goto err;
 
 	ret = davinci_mcasp_get_dt_params(mcasp);
-	if (ret)
-		return -EINVAL;
+	if (ret) {
+		ret = -EINVAL;
+		goto err;
+	}
 
 	ret = devm_snd_soc_register_component(&pdev->dev,
 					&davinci_mcasp_component,
-- 
2.17.1

