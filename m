Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA41C433DB
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 12:13:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A212F64F38
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 12:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A212F64F38
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 318E516CC;
	Tue,  2 Mar 2021 13:12:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 318E516CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614687200;
	bh=YKvMeXdJW74s4YYvMjxTEeZq82f5vJi7f7QjwlogSHE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=KvHhATDltVByJQrWpyA3u6k0VRRGHVFWLzvDR90SBsY2Y8jPaovRHuhAYAu/SFyfX
	 r1XY/5I23JhP/fKrRa74Fm9lgmCKx6IqyH4hg7BT36zJe76S/2aXwpt4XsA11XJ0i1
	 ZP0MNKRzSXGJbikBcfHMGA+iLcddLBHn+T1RzduM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75F2BF8012D;
	Tue,  2 Mar 2021 13:12:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 34DDBF80269; Tue,  2 Mar 2021 13:12:27 +0100 (CET)
Received: from cmccmta1.chinamobile.com (cmccmta1.chinamobile.com
 [221.176.66.79])
 by alsa1.perex.cz (Postfix) with ESMTP id 182EBF8012D
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 13:12:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 182EBF8012D
Received: from spf.mail.chinamobile.com (unknown[172.16.121.13]) by
 rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee2603e2b8b1b9-8dc5a;
 Tue, 02 Mar 2021 20:11:56 +0800 (CST)
X-RM-TRANSID: 2ee2603e2b8b1b9-8dc5a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.112.105.130])
 by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7603e2b87525-1c240;
 Tue, 02 Mar 2021 20:11:55 +0800 (CST)
X-RM-TRANSID: 2ee7603e2b87525-1c240
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: broonie@kernel.org, paul@crapouillou.net, lgirdwood@gmail.com,
 perex@perex.cz, tiwai@suse.com
Subject: [PATCH] ASoC: codec: Omit superfluous error message in
 jz4760_codec_probe()
Date: Tue,  2 Mar 2021 20:11:48 +0800
Message-Id: <20210302121148.28328-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Tang Bin <tangbin@cmss.chinamobile.com>
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

The function devm_platform_ioremap_resource has already contained error
message, so remove the redundant dev_err here.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/codecs/jz4760.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/jz4760.c b/sound/soc/codecs/jz4760.c
index e8f28ccc145a..c2d8a107f159 100644
--- a/sound/soc/codecs/jz4760.c
+++ b/sound/soc/codecs/jz4760.c
@@ -843,7 +843,6 @@ static int jz4760_codec_probe(struct platform_device *pdev)
 	codec->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(codec->base)) {
 		ret = PTR_ERR(codec->base);
-		dev_err(dev, "Failed to ioremap mmio memory: %d\n", ret);
 		return ret;
 	}
 
-- 
2.18.2



