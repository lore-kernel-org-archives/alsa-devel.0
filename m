Return-Path: <SRS0=mEIa=AU=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C075C433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:23:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18EFF20720
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Jul 2020 14:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oXwHPIxc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18EFF20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zte.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7F620950;
	Thu,  9 Jul 2020 16:22:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7F620950
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594304597;
	bh=t/22JcxJNUFMFODqJBSezaZ6qN9Phxzm7crjUgSjxiw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oXwHPIxcqU8rjpYn93XQOLMt45s7ZDoL+hQTtkW3/Z7OddjEgNlLLWH58uKsjgbSQ
	 tqW68vcpz3mDpMU8GtcPjTNrBqMJEXageLq+upYfBTjHYLZLPep/5BGkjk8vAvnf1+
	 yR8Ner1I+ApVvLpXpIAOOKwNwusbgSv/sCB1CIqg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06ADFF800AE;
	Thu,  9 Jul 2020 16:22:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D289AF80216; Tue,  7 Jul 2020 13:45:17 +0200 (CEST)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [63.217.80.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23CDEF800DF
 for <alsa-devel@alsa-project.org>; Tue,  7 Jul 2020 13:45:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23CDEF800DF
Received: from mse-fl1.zte.com.cn (unknown [10.30.14.238])
 by Forcepoint Email with ESMTPS id 15C503D8B48ABFE1F3AD;
 Tue,  7 Jul 2020 19:44:59 +0800 (CST)
Received: from notes_smtp.zte.com.cn (notes_smtp.zte.com.cn [10.30.1.239])
 by mse-fl1.zte.com.cn with ESMTP id 067Bimif058681;
 Tue, 7 Jul 2020 19:44:48 +0800 (GMT-8)
 (envelope-from wang.yi59@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
 by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
 with ESMTP id 2020070719450240-4209657 ;
 Tue, 7 Jul 2020 19:45:02 +0800 
From: Yi Wang <wang.yi59@zte.com.cn>
To: timur@kernel.org
Subject: [PATCH] ASoC: fsl: mpc8610_hpcd: Add missing of_node_put()
Date: Tue, 7 Jul 2020 19:47:47 +0800
Message-Id: <1594122467-11615-1-git-send-email-wang.yi59@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release
 8.5.3FP6|November 21, 2013) at 2020-07-07 19:45:02,
 Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2020-07-07 19:44:51, Serialize complete at 2020-07-07 19:44:51
X-MAIL: mse-fl1.zte.com.cn 067Bimif058681
X-Mailman-Approved-At: Thu, 09 Jul 2020 16:22:25 +0200
Cc: wang.yi59@zte.com.cn, alsa-devel@alsa-project.org, wang.liang82@zte.com.cn,
 Xiubo.Lee@gmail.com, linuxppc-dev@lists.ozlabs.org, tiwai@suse.com,
 lgirdwood@gmail.com, nicoleotsuka@gmail.com, broonie@kernel.org,
 Liao Pingfang <liao.pingfang@zte.com.cn>, xue.zhihong@zte.com.cn,
 festevam@gmail.com, linux-kernel@vger.kernel.org
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

From: Liao Pingfang <liao.pingfang@zte.com.cn>

After finishing using device node got from of_find_compatible_node(),
of_node_put() needs to be called.

Signed-off-by: Liao Pingfang <liao.pingfang@zte.com.cn>
---
 sound/soc/fsl/mpc8610_hpcd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index f7bd900..b3090fe 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -426,9 +426,11 @@ static int __init mpc8610_hpcd_init(void)
 	guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
 	if (of_address_to_resource(guts_np, 0, &res)) {
 		pr_err("mpc8610-hpcd: missing/invalid global utilities node\n");
+		of_node_put(guts_np);
 		return -EINVAL;
 	}
 	guts_phys = res.start;
+	of_node_put(guts_np);
 
 	return platform_driver_register(&mpc8610_hpcd_driver);
 }
-- 
2.9.5

