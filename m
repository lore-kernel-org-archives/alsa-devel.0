Return-Path: <SRS0=1nsM=42=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4468C10F27
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:00:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6414120674
	for <alsa-devel@archiver.kernel.org>; Mon,  9 Mar 2020 10:00:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TGAPzJk2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6414120674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C29E51666;
	Mon,  9 Mar 2020 10:59:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C29E51666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583748020;
	bh=gW/dFvCjl7GrukTeAhgAIhKeG4AKN3+0I7DzHQgi328=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TGAPzJk28OFKcZZ3W3pDh7nYdKxpUju4FzDTS3oxNGM4zoVHTQIc2Xc2vOaMBpClH
	 tD8QdyUXeTlQhKX+KewdSjKI3lPJZDZJd74AGMLWf/9kRVaDqjM3ibvJbzcvT2ZZuB
	 12SAuXLRLbc5zrAazvpqIQLv/7R2AmqauoVLJ20g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51A7EF801EB;
	Mon,  9 Mar 2020 10:59:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A6CAF801F8; Mon,  9 Mar 2020 10:59:29 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 03CB0F801A3
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 10:59:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 03CB0F801A3
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 48712AE46
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2020 09:59:23 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: line6: Fix endless MIDI read loop
Date: Mon,  9 Mar 2020 10:59:22 +0100
Message-Id: <20200309095922.30269-1-tiwai@suse.de>
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

The MIDI input event parser of the LINE6 driver may enter into an
endless loop when the unexpected data sequence is given, as it tries
to continue the secondary bytes without termination.  Also, when the
input data is too short, the parser returns a negative error, while
the caller doesn't handle it properly.  This would lead to the
unexpected behavior as well.

This patch addresses those issues by checking the return value
correctly and handling the one-byte event in the parser properly.

The bug was reported by syzkaller.

Reported-by: syzbot+cce32521ee0a824c21f7@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/000000000000033087059f8f8fa3@google.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/driver.c  | 2 +-
 sound/usb/line6/midibuf.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/usb/line6/driver.c b/sound/usb/line6/driver.c
index b5a3f754a4f1..4f096685ed65 100644
--- a/sound/usb/line6/driver.c
+++ b/sound/usb/line6/driver.c
@@ -305,7 +305,7 @@ static void line6_data_received(struct urb *urb)
 				line6_midibuf_read(mb, line6->buffer_message,
 						LINE6_MIDI_MESSAGE_MAXLEN);
 
-			if (done == 0)
+			if (done <= 0)
 				break;
 
 			line6->message_length = done;
diff --git a/sound/usb/line6/midibuf.c b/sound/usb/line6/midibuf.c
index 8d6eefa0d936..6a70463f82c4 100644
--- a/sound/usb/line6/midibuf.c
+++ b/sound/usb/line6/midibuf.c
@@ -159,7 +159,7 @@ int line6_midibuf_read(struct midi_buffer *this, unsigned char *data,
 			int midi_length_prev =
 			    midibuf_message_length(this->command_prev);
 
-			if (midi_length_prev > 0) {
+			if (midi_length_prev > 1) {
 				midi_length = midi_length_prev - 1;
 				repeat = 1;
 			} else
-- 
2.16.4

