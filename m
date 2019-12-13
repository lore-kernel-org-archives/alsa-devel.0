Return-Path: <SRS0=T7nt=2D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D4AC43603
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:16:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4130320706
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Dec 2019 21:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oNaMaZId"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4130320706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0C1DD1768;
	Fri, 13 Dec 2019 17:30:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0C1DD1768
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576254665;
	bh=hB3hjxT6BYPjYK774MGVV5QxfkznDF/5wWloTkrJN50=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=oNaMaZIdqtQVTN7E0C7/6/PNQ1w64Q/x5M22j4mqdUWscgvMgK16zCXNYCGxFNRe3
	 O6NkWwL0B+CowHSMH+boj+U6cVdrVjaaSPXbxED6GJbhuruDcLzkk3wgi6BrMA9blH
	 vtyozbtlxf2EP51aKCSFFGsezuf3UfNxAPv7Gln4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 75764F8019B;
	Fri, 13 Dec 2019 17:30:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 112A4F801F4; Fri, 13 Dec 2019 17:30:12 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3ACD7F8014F
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2019 17:30:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3ACD7F8014F
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 0D89AAE78
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2019 16:30:07 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Fri, 13 Dec 2019 17:30:05 +0100
Message-Id: <20191213163005.19116-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Subject: [alsa-devel] [PATCH] ALSA: hda: Comment about
	snd_hdac_bus_update_rirb() and spinlock
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

The call of snd_hdac_bus_update_rirb() needs the bus->reg_lock
spinlock protection for concurrency.  Comment about it more
explicitly.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/hda/hdac_controller.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/hdac_controller.c b/sound/hda/hdac_controller.c
index 01787081552d..b856184af37f 100644
--- a/sound/hda/hdac_controller.c
+++ b/sound/hda/hdac_controller.c
@@ -181,6 +181,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_bus_send_cmd);
  * @bus: HD-audio core bus
  *
  * Usually called from interrupt handler.
+ * The caller needs bus->reg_lock spinlock before calling this.
  */
 void snd_hdac_bus_update_rirb(struct hdac_bus *bus)
 {
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
