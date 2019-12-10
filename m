Return-Path: <SRS0=DqDL=2A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426F5C2D0CC
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:16:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4CC520828
	for <alsa-devel@archiver.kernel.org>; Tue, 10 Dec 2019 07:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ngm4WcGx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CC520828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A42F176C;
	Tue, 10 Dec 2019 08:09:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A42F176C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575961849;
	bh=bBw7YwWABINHOMcmRrP5t4orjHJy/KLc26LXpl16+iw=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Ngm4WcGxLf1W79XtF9ykebCjaLQPXFRRQZYkbrchxgkrJrx46391RhOKxTMtw9EFZ
	 Wne16/BDcueZ+llvT+m5rWk6LUD1roZDwCJhCt07yrVU+Ra1bqD4xz1DMShb2x6usw
	 RJGOAdeOll9XMQiY0ksjG/YWJ9tWWGcX2E5uGJ6c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A0A9EF804E4;
	Tue, 10 Dec 2019 07:37:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CF2E3F802A1; Tue, 10 Dec 2019 07:36:54 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FC1AF802A2
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 07:35:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FC1AF802A2
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id E7470B31F
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2019 06:35:01 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Tue, 10 Dec 2019 07:34:53 +0100
Message-Id: <20191210063454.31603-55-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191210063454.31603-1-tiwai@suse.de>
References: <20191210063454.31603-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 54/55] ALSA: vxpocket: Support PCM sync_stop
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

The driver invokes snd_pcm_period_elapsed() simply from the threaded
interrupt handler.  Set card->sync_irq for enabling the missing
sync_stop PCM operation.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pcmcia/vx/vxpocket.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pcmcia/vx/vxpocket.c b/sound/pcmcia/vx/vxpocket.c
index 4e08863c3045..f924d8819f9d 100644
--- a/sound/pcmcia/vx/vxpocket.c
+++ b/sound/pcmcia/vx/vxpocket.c
@@ -185,6 +185,7 @@ static int snd_vxpocket_assign_resources(struct vx_core *chip, int port, int irq
 		card->shortname, port, irq);
 
 	chip->irq = irq;
+	card->sync_irq = chip->irq;
 
 	if ((err = snd_vx_setup_firmware(chip)) < 0)
 		return err;
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
