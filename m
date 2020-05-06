Return-Path: <SRS0=eFJe=6V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC53C38A24
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 07:17:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA51820753
	for <alsa-devel@archiver.kernel.org>; Thu,  7 May 2020 07:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="j4QT55sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA51820753
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22FA817E9;
	Thu,  7 May 2020 09:17:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22FA817E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588835873;
	bh=2tGRWJJ2L7qTVN2IhXlOQRZ9Yz5PL1HYIYLYfY7F8B4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=j4QT55smhu38KEnHaf0lO9r6wuKL+Uwr64s7Iy3g5bX82cqWYEUOQdnpAUS9H5YoB
	 hP+Q+6TOzRv840W5MN9q1zsCKFSQtQJoTLqWsCbH6J8fkCsvbK8QEHYFTj3yAsGgXj
	 EF0v6qwrLxQK4p+muRxMJtrxlwXfDOv60OXP/z7Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5B33AF80162;
	Thu,  7 May 2020 09:16:11 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF275F80249; Wed,  6 May 2020 10:09:31 +0200 (CEST)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17F52F800DF
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2020 10:09:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17F52F800DF
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 2A4DF91E451E0C16612A;
 Wed,  6 May 2020 16:09:14 +0800 (CST)
Received: from linux-lmwb.huawei.com (10.175.103.112) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Wed, 6 May 2020 16:09:07 +0800
From: Samuel Zou <zou_wei@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <mripard@kernel.org>, <wens@csie.org>
Subject: [PATCH -next] ASoC: sun4i-i2s: Use PTR_ERR_OR_ZERO() to simplify code
Date: Wed, 6 May 2020 16:15:12 +0800
Message-ID: <1588752912-37596-1-git-send-email-zou_wei@huawei.com>
X-Mailer: git-send-email 2.6.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.103.112]
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Thu, 07 May 2020 09:16:08 +0200
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Samuel Zou <zou_wei@huawei.com>
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

Fixes coccicheck warning:

sound/soc/sunxi/sun4i-i2s.c:1177:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Samuel Zou <zou_wei@huawei.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index d0a8d58..72012a6 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -1174,10 +1174,8 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
 	i2s->field_fmt_sr =
 			devm_regmap_field_alloc(dev, i2s->regmap,
 						i2s->variant->field_fmt_sr);
-	if (IS_ERR(i2s->field_fmt_sr))
-		return PTR_ERR(i2s->field_fmt_sr);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(i2s->field_fmt_sr);
 }
 
 static int sun4i_i2s_probe(struct platform_device *pdev)
-- 
2.6.2

