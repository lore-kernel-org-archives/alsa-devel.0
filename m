Return-Path: <SRS0=r47B=2C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76819C43603
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:12:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF91821556
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 19:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JciyQ/g/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF91821556
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 48B551713;
	Thu, 12 Dec 2019 20:12:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 48B551713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576177972;
	bh=gc1lwKeIgwnt9057JekbWg6kXgZYrTNk0X74gn56UzE=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JciyQ/g/OqK2KAVPgk930tjwplw8r7QG3aJW2wLLxbMBigzKYqKnmAuyjQRucuD5e
	 Q+XxYRj+gYN0kb7111nvFsLqoAJg15FEBAXO/VTqyaBjqptCTWiTVR8UgJpsUToWFY
	 dbyNHmzIrIiwIkIMfgjh34F3li2DkB45+Vy11Aco=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91E87F80232;
	Thu, 12 Dec 2019 20:11:10 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 64B3CF80217; Thu, 12 Dec 2019 20:11:07 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C97FF80139
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2019 20:11:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C97FF80139
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 1FA6BB077;
 Thu, 12 Dec 2019 19:11:03 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu, 12 Dec 2019 20:11:00 +0100
Message-Id: <20191212191101.19517-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191212191101.19517-1-tiwai@suse.de>
References: <20191212191101.19517-1-tiwai@suse.de>
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Subject: [alsa-devel] [PATCH 1/2] ALSA: hda: Use waitqueue for RIRB in
	HDA-core helper, too
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

This patch implements the same logic that was done for the legacy
HD-audio controller driver by the commit 88452da92ba2 ("ALSA: hda: Use
standard waitqueue for RIRB wakeup") to the HDA-core helper code,
too.  This makes snd_hdac_bus_get_response() waiting for the response
with bus->rirb_wq instead of polling when bus->polling is false.
It'll save both CPU time and response latency.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_controller.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index cd1c3b282657..61950b83b8c9 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -241,30 +241,42 @@ int snd_hdac_bus_get_response(struct hdac_bus *bus, unsigned int addr,
 {
 	unsigned long timeout;
 	unsigned long loopcounter;
+	wait_queue_entry_t wait;
 
+	init_wait_entry(&wait, 0);
 	timeout = jiffies + msecs_to_jiffies(1000);
 
 	for (loopcounter = 0;; loopcounter++) {
 		spin_lock_irq(&bus->reg_lock);
+		if (!bus->polling_mode)
+			prepare_to_wait(&bus->rirb_wq, &wait,
+					TASK_UNINTERRUPTIBLE);
 		if (bus->polling_mode)
 			snd_hdac_bus_update_rirb(bus);
 		if (!bus->rirb.cmds[addr]) {
 			if (res)
 				*res = bus->rirb.res[addr]; /* the last value */
+			if (!bus->polling_mode)
+				finish_wait(&bus->rirb_wq, &wait);
 			spin_unlock_irq(&bus->reg_lock);
 			return 0;
 		}
 		spin_unlock_irq(&bus->reg_lock);
 		if (time_after(jiffies, timeout))
 			break;
-		if (loopcounter > 3000)
+		if (!bus->polling_mode) {
+			schedule_timeout(msecs_to_jiffies(2));
+		} else if (loopcounter > 3000) {
 			msleep(2); /* temporary workaround */
-		else {
+		} else {
 			udelay(10);
 			cond_resched();
 		}
 	}
 
+	if (!bus->polling_mode)
+		finish_wait(&bus->rirb_wq, &wait);
+
 	return -EIO;
 }
 EXPORT_SYMBOL_GPL(snd_hdac_bus_get_response);
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
