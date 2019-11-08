Return-Path: <SRS0=0Fuw=ZA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D74CC5DF60
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:47:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9829B218AE
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Nov 2019 16:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="CP8/bwF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9829B218AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 625F31665;
	Fri,  8 Nov 2019 17:46:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 625F31665
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573231655;
	bh=u4m8GtxGrjcpWdNB1sWbtWgRuCGcXaiq5nPslOBIwOY=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CP8/bwF+kEgL7tyXJCd1KtcByRYBrpzYWc5C89a40TGCGEL+1gNnf3FTCvceuuwuH
	 YQljzM4pvbMq8MIJW2DSsQVQVQXUlLWTuuGY1Yl/VUoW9ajPJwHw67nTpy3RIHoeUq
	 48MF7CYDvBpYHxZroXo9Xq3OUHJd9hpIDNQ3aiBE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C57B0F80321;
	Fri,  8 Nov 2019 17:46:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 00261F803D0; Fri,  8 Nov 2019 17:46:43 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70345F80111
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2019 17:46:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70345F80111
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 6960DAC67
 for <alsa-devel@alsa-project.org>; Fri,  8 Nov 2019 16:46:39 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri,  8 Nov 2019 17:46:37 +0100
Message-Id: <20191108164637.1110-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: memalloc: Drop snd_dma_pci_data() macro
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Now that all users have been converted, we can drop snd_dma_pci_data()
macro definition.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/memalloc.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/sound/memalloc.h b/include/sound/memalloc.h
index 6ada3b8ede4e..3b47832b1c1f 100644
--- a/include/sound/memalloc.h
+++ b/include/sound/memalloc.h
@@ -21,7 +21,6 @@ struct snd_dma_device {
 	struct device *dev;		/* generic device */
 };
 
-#define snd_dma_pci_data(pci)	(&(pci)->dev)
 #define snd_dma_continuous_data(x)	((struct device *)(__force unsigned long)(x))
 
 
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
