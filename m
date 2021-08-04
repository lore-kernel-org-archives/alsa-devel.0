Return-Path: <SRS0=vE6Q=M3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFAEC4338F
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Aug 2021 18:56:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1695360E09
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Aug 2021 18:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1695360E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD2981686;
	Wed,  4 Aug 2021 20:55:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD2981686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628103357;
	bh=w/Zgn9S61NoHeIE2vu+DgBcXaivGFRTIAa5FTf/s4MU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=ObkdMriY8VVwZTEsQOj1f0/8mgeSGOOBIgpF0LTsFLQAgGvzHhnT+O6rS5ihgs/L1
	 vuZxiqueNeoFpU0mkNycVyxUX2BLv3fTdvuz8/vq7d7AxGf+CFicmV6KZ1cqtWnCPl
	 44ubmFzMkG3PcPFkGCnH936SojYprSsHz9xZVQHI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39D03F801F7;
	Wed,  4 Aug 2021 20:55:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5C032F8025F; Wed,  4 Aug 2021 20:55:06 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74E16F8010A
 for <alsa-devel@alsa-project.org>; Wed,  4 Aug 2021 20:54:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74E16F8010A
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="277747201"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; d="scan'208";a="277747201"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2021 11:54:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; d="scan'208";a="668191813"
Received: from ccho-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.189.253])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2021 11:54:52 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: pci/korg1212: completely remove 'set but not used'
 warnings
Date: Wed,  4 Aug 2021 13:54:42 -0500
Message-Id: <20210804185442.274057-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

Commit 6cdc01ebdfb0 ("ALSA: pci/korg1212: remove 'set but not used'
warnings") missed one __maybe_unused, add to enable make W=1 sound/
compilation with x86_64 allmodconfig

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/pci/korg1212/korg1212.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/korg1212/korg1212.c b/sound/pci/korg1212/korg1212.c
index 49ed2bfaf11f..5c9e240ff6a9 100644
--- a/sound/pci/korg1212/korg1212.c
+++ b/sound/pci/korg1212/korg1212.c
@@ -2094,7 +2094,7 @@ static int snd_korg1212_create(struct snd_card *card, struct pci_dev *pci)
 {
         int err, rc;
         unsigned int i;
-	unsigned iomem_size;
+	__maybe_unused unsigned iomem_size;
 	__maybe_unused unsigned ioport_size;
 	__maybe_unused unsigned iomem2_size;
 	struct snd_korg1212 *korg1212 = card->private_data;
-- 
2.25.1

