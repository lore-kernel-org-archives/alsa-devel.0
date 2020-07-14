Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76479C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:30:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED13822203
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 11:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="I+REcuIT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED13822203
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5FD3F15F2;
	Tue, 14 Jul 2020 13:29:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5FD3F15F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594726244;
	bh=zN7sGvMSUp5KHimfTWZeFqj4glJJX4Zg2k6gtzZtHPo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I+REcuITvzAzr4SS6fsREkfUIdO+46Ig2tm+ZTeId/pCHFRjjQ5iR/ieV5puHGWXi
	 CJxbfCnnhR0DqNqIhAYN/sAtrYSkS4JdThKTT1KWGfRPm/QY4hHExwEW5+3Q9QEpJ+
	 u8a/3A6AoPsuNkvN4nF/otUQVVLEYWYXuL6hjhYo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DE92DF800E5;
	Tue, 14 Jul 2020 13:29:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C5F8DF801F2; Tue, 14 Jul 2020 13:29:49 +0200 (CEST)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com
 [221.176.66.80])
 by alsa1.perex.cz (Postfix) with ESMTP id AAD56F800E5
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 13:29:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AAD56F800E5
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by
 rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee65f0d9709a24-eb8a8;
 Tue, 14 Jul 2020 19:29:16 +0800 (CST)
X-RM-TRANSID: 2ee65f0d9709a24-eb8a8
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35f0d970911e-7570e;
 Tue, 14 Jul 2020 19:29:16 +0800 (CST)
X-RM-TRANSID: 2ee35f0d970911e-7570e
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: broonie@kernel.org, tiwai@suse.com, plai@codeaurora.org,
 bgoswami@codeaurora.org, perex@perex.cz, lgirdwood@gmail.com
Subject: [PATCH] ASoC: qcom: qdsp6: Use the defined variable to clean code
Date: Tue, 14 Jul 2020 19:29:23 +0800
Message-Id: <20200714112923.14944-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org,
 Zhang Shengju <zhangshengju@cmss.chinamobile.com>,
 linux-kernel@vger.kernel.org, Tang Bin <tangbin@cmss.chinamobile.com>
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

Use the defined variable "dev" to make the code cleaner.

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/qcom/qdsp6/q6adm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index da242515e..2ec868b2d 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -588,12 +588,12 @@ static int q6adm_probe(struct apr_device *adev)
 	struct device *dev = &adev->dev;
 	struct q6adm *adm;
 
-	adm = devm_kzalloc(&adev->dev, sizeof(*adm), GFP_KERNEL);
+	adm = devm_kzalloc(dev, sizeof(*adm), GFP_KERNEL);
 	if (!adm)
 		return -ENOMEM;
 
 	adm->apr = adev;
-	dev_set_drvdata(&adev->dev, adm);
+	dev_set_drvdata(dev, adm);
 	adm->dev = dev;
 	q6core_get_svc_api_info(adev->svc_id, &adm->ainfo);
 	mutex_init(&adm->lock);
-- 
2.20.1.windows.1



