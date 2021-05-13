Return-Path: <SRS0=EA+P=KI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F502C433ED
	for <alsa-devel@archiver.kernel.org>; Thu, 13 May 2021 11:12:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EADA561443
	for <alsa-devel@archiver.kernel.org>; Thu, 13 May 2021 11:12:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADA561443
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 65F3317CC;
	Thu, 13 May 2021 13:11:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 65F3317CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620904342;
	bh=jFaMfUvmAI3lS9+6yL203abz7s0+BgwOmwD9LdktRxY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=RKja3rECjM2pjod4kOGbsMEpWhY9LKFESOJGPwWasPhtLO42zd40VgYKw56FEusyj
	 2Wl304xm4E0CudXlwzCimDqXIs/GQea7xB6u+LWM9Tymdsh/VLnx5qA1kmowFgvo2M
	 jPMVMD9/XxmPb/A8+uetc9do7pG6SAlHomzTVaeg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB0C1F80156;
	Thu, 13 May 2021 13:11:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94B50F80163; Thu, 13 May 2021 13:11:29 +0200 (CEST)
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 390F3F8012E
 for <alsa-devel@alsa-project.org>; Thu, 13 May 2021 13:11:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 390F3F8012E
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R361e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395;
 MF=jiapeng.chong@linux.alibaba.com; NM=1; PH=DS; RN=5; SR=0;
 TI=SMTPD_---0UYkXXym_1620904272; 
Received: from
 j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com
 fp:SMTPD_---0UYkXXym_1620904272) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 13 May 2021 19:11:17 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: perex@perex.cz
Subject: [PATCH v2] ALSA: hda: generic: Remove redundant assignment to dac
Date: Thu, 13 May 2021 19:11:11 +0800
Message-Id: <1620904271-76027-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 alsa-devel@alsa-project.org, tiwai@suse.com, linux-kernel@vger.kernel.org
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

Variable dac is set to zero, but this value is never read as it is
overwritten or not used later on, hence it is a redundant assignment
and can be removed.

Clean up the following clang-analyzer warning:

sound/pci/hda/hda_generic.c:1436:4: warning: Value stored to 'dac' is
never read [clang-analyzer-deadcode.DeadStores].

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
Changes in v2:
  -For the follow advice: https://lore.kernel.org/patchwork/patch/1423536/

 sound/pci/hda/hda_generic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index b638fc2..fc02957 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1433,7 +1433,7 @@ static int try_assign_dacs(struct hda_codec *codec, int num_outs,
 			path = snd_hda_add_new_path(codec, dac, pin, 0);
 		}
 		if (!path) {
-			dac = dacs[i] = 0;
+			dacs[i] = 0;
 			badness += bad->no_dac;
 		} else {
 			/* print_nid_path(codec, "output", path); */
-- 
1.8.3.1

