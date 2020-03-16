Return-Path: <SRS0=b36W=5B=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D58FC0044D
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:07:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D884320658
	for <alsa-devel@archiver.kernel.org>; Mon, 16 Mar 2020 09:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FaB/HZrv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D884320658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2D26818A6;
	Mon, 16 Mar 2020 10:06:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2D26818A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584349664;
	bh=fmKJqciuIHLHhI6K56a41nQa/LuN32XuyHJhL/4M7wU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FaB/HZrvOFXgmIbVgCM8jwgwUcv5MFyxEX/G7vfrI+aJohT3knNcF9alk7m8/UbH2
	 nu3v5VZnQ9TBKEaaY/2oGIJZIMuIyiR6LCWFRn1bTsNtd17oOBRG+/aF4YU2cQ9ySM
	 j+Dtc7gC2OboUsGKpS8HGyp4HOov0F2PX/ljMDgo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7D909F8028B;
	Mon, 16 Mar 2020 10:05:14 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1E03F80110; Mon, 16 Mar 2020 10:05:12 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02E42F80110
 for <alsa-devel@alsa-project.org>; Mon, 16 Mar 2020 10:05:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02E42F80110
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 27831AEDE;
 Mon, 16 Mar 2020 09:05:08 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ALSA: seq: oss: Fix running status after receiving sysex
Date: Mon, 16 Mar 2020 10:05:06 +0100
Message-Id: <20200316090506.23966-3-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200316090506.23966-1-tiwai@suse.de>
References: <20200316090506.23966-1-tiwai@suse.de>
Cc: Andreas Steinmetz <ast@domdv.de>
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

This is a similar bug like the previous case for virmidi: the invalid
running status is kept after receiving a sysex message.

Again the fix is to clear the running status after handling the sysex.

Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/3b4a4e0f232b7afbaf0a843f63d0e538e3029bfd.camel@domdv.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/oss/seq_oss_midi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/core/seq/oss/seq_oss_midi.c b/sound/core/seq/oss/seq_oss_midi.c
index a88c235b2ea3..2ddfe2226651 100644
--- a/sound/core/seq/oss/seq_oss_midi.c
+++ b/sound/core/seq/oss/seq_oss_midi.c
@@ -602,6 +602,7 @@ send_midi_event(struct seq_oss_devinfo *dp, struct snd_seq_event *ev, struct seq
 		len = snd_seq_oss_timer_start(dp->timer);
 	if (ev->type == SNDRV_SEQ_EVENT_SYSEX) {
 		snd_seq_oss_readq_sysex(dp->readq, mdev->seq_device, ev);
+		snd_midi_event_reset_decode(mdev->coder);
 	} else {
 		len = snd_midi_event_decode(mdev->coder, msg, sizeof(msg), ev);
 		if (len > 0)
-- 
2.16.4

