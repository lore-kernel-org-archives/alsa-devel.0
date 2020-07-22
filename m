Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927C9C433E0
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:40:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177712065E
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 10:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kq+G/BHJ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="s3lB4PdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177712065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A5961667;
	Wed, 22 Jul 2020 12:39:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A5961667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595414427;
	bh=Oi7h3ngMFYYzk+sizlTxEwcDVp2pwFjpWU4+6qtiZp0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kq+G/BHJOx+bqn+fyZez88d/Zm6ucMHkVGWTtbOL6vuWwEx8R32W/NM3jZYq1y2Vc
	 8byg4TTqVGMetxjx9Zj0e5w26ycJe3Ozo25eFRLZ5/SfhzjxtMoKjjUmhOdO1TQFZJ
	 EF0CYtrY3lIrbA4FM+IjZOfPO7FHHvfeFnni2zWM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D6ADF80335;
	Wed, 22 Jul 2020 12:34:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CEA86F80161; Wed, 22 Jul 2020 12:34:54 +0200 (CEST)
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AF8D3F80161
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 12:34:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AF8D3F80161
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=mg.codeaurora.org
 header.i=@mg.codeaurora.org header.b="s3lB4PdG"
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1595414092; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=q5WENp3kjcHbBxRcJZBOwyNNWkqciF+ASgb0ZS4e2Sc=;
 b=s3lB4PdGVUbaFqzxLdFSQFm01QpyTOdljF4SoYMvE4djcxzoQqymD9bZlna7ol0wVqk2oCzZ
 zOJosXJud4axxxg1J0gyXqubgHOeQG7OxhVYsvR6RA0zIYJ1jP05cWDb2sAJNhIjHXTd4g9t
 VyJlli4ezF58ViX5bMcwAquk6M0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI4ZmE2ZSIsICJhbHNhLWRldmVsQGFsc2EtcHJvamVjdC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f1816448e9b2c49c6ac890c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 22 Jul 2020 10:34:44
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id 8553CC43391; Wed, 22 Jul 2020 10:34:44 +0000 (UTC)
Received: from rohkumar-linux.qualcomm.com (unknown [202.46.22.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: rohitkr)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id E9FDBC433C6;
 Wed, 22 Jul 2020 10:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E9FDBC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=rohitkr@codeaurora.org
From: Rohit kumar <rohitkr@codeaurora.org>
To: agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
 broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
 bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/12] ASoC: qcom: lpass-platform: Use platform_get_irq
Date: Wed, 22 Jul 2020 16:01:54 +0530
Message-Id: <1595413915-17867-12-git-send-email-rohitkr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
References: <1595413915-17867-1-git-send-email-rohitkr@codeaurora.org>
Cc: Rohit kumar <rohitkr@codeaurora.org>
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

platform_get_irq_byname() is used when there is list
of interrupts in the device node. As lpass-platform
has only one interrupt entry, use platform_get_irq()
instead.

Signed-off-by: Rohit kumar <rohitkr@codeaurora.org>
---
 sound/soc/qcom/lpass-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/lpass-platform.c b/sound/soc/qcom/lpass-platform.c
index 249c7e6..45da06b 100644
--- a/sound/soc/qcom/lpass-platform.c
+++ b/sound/soc/qcom/lpass-platform.c
@@ -638,7 +638,7 @@ int asoc_qcom_lpass_platform_register(struct platform_device *pdev)
 	struct lpass_variant *v = drvdata->variant;
 	int ret;
 
-	drvdata->lpaif_irq = platform_get_irq_byname(pdev, "lpass-irq-lpaif");
+	drvdata->lpaif_irq = platform_get_irq(pdev, 0);
 	if (drvdata->lpaif_irq < 0)
 		return -ENODEV;
 
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.,
is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.

