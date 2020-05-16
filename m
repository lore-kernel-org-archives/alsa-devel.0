Return-Path: <SRS0=yPb/=66=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E52CFC433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 16 May 2020 06:27:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C38620709
	for <alsa-devel@archiver.kernel.org>; Sat, 16 May 2020 06:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Tlb8K4Gh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C38620709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 89F251658;
	Sat, 16 May 2020 08:26:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 89F251658
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589610420;
	bh=BP0KmP6gu5cNCsV3+1e9mFG9i8XlgN7sHseImi+M930=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Tlb8K4GhLv97GJpglfxWyLwHwOs7ECvWZDGfPGfwfG46FPgObLCYDoVMOtmWD48qQ
	 BohtCNVI27j4lhydTY7eorqBa2OIBFU/74cOAtr3nXhbv43GJqX/ZIMrMRkKum6uha
	 Y7aYetHZojv0n2GwbzcsO/GJcITXCCNlf4wzr/lo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED67DF800FE;
	Sat, 16 May 2020 08:26:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C185BF80158; Sat, 16 May 2020 08:26:06 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 83791F800FE
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2020 08:25:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 83791F800FE
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 758A8ABEC
 for <alsa-devel@alsa-project.org>; Sat, 16 May 2020 06:26:00 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda: Fix potential race in unsol event handler
Date: Sat, 16 May 2020 08:25:56 +0200
Message-Id: <20200516062556.30951-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
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

The unsol event handling code has a loop retrieving the read/write
indices and the arrays without locking while the append to the array
may happen concurrently.  This may lead to some inconsistency.
Although there hasn't been any proof of this bad results, it's still
safer to protect the racy accesses.

This patch adds the spinlock protection around the unsol handling loop
for addressing it.  Here we take bus->reg_lock as the writer side
snd_hdac_bus_queue_event() is also protected by that lock.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
index 26b391be3656..09ddab5f5cae 100644
--- a/sound/hda/hdac_bus.c
+++ b/sound/hda/hdac_bus.c
@@ -160,6 +160,7 @@ static void snd_hdac_bus_process_unsol_events(struct work_struct *work)
 	struct hdac_driver *drv;
 	unsigned int rp, caddr, res;
 
+	spin_lock_irq(&bus->reg_lock);
 	while (bus->unsol_rp != bus->unsol_wp) {
 		rp = (bus->unsol_rp + 1) % HDA_UNSOL_QUEUE_SIZE;
 		bus->unsol_rp = rp;
@@ -171,10 +172,13 @@ static void snd_hdac_bus_process_unsol_events(struct work_struct *work)
 		codec = bus->caddr_tbl[caddr & 0x0f];
 		if (!codec || !codec->dev.driver)
 			continue;
+		spin_unlock_irq(&bus->reg_lock);
 		drv = drv_to_hdac_driver(codec->dev.driver);
 		if (drv->unsol_event)
 			drv->unsol_event(codec, res);
+		spin_lock_irq(&bus->reg_lock);
 	}
+	spin_unlock_irq(&bus->reg_lock);
 }
 
 /**
-- 
2.25.0

