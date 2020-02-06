Return-Path: <SRS0=zIiJ=32=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAC1C33CAC
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:33:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BE521775
	for <alsa-devel@archiver.kernel.org>; Thu,  6 Feb 2020 16:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JTHGOkp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BE521775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 662A916C0;
	Thu,  6 Feb 2020 17:32:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 662A916C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581006819;
	bh=XkW5Rj0g4gHaxy5qDUZRE47TjhDgwKZsswran6hO/gI=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JTHGOkp01FrqjWQ09h7BFgI3hhZAPOyxtCi9gcdwyZP6xcXbonclDAZ4HwL2vNwqc
	 KH85X1kEikaw+5mDhBLQhlgZ0pJm51zVlUD7b6v6WQHeyna1fZ+RWNThndXYruDzU7
	 6qOLe2Bg5c9VyTbW65KGDGOFy8YVL35l5Ne75aNY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DBCF6F80274;
	Thu,  6 Feb 2020 17:32:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06256F80277; Thu,  6 Feb 2020 17:32:01 +0100 (CET)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D01BF80162
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 17:31:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D01BF80162
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 32E13AFAA
 for <alsa-devel@alsa-project.org>; Thu,  6 Feb 2020 16:31:53 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Date: Thu,  6 Feb 2020 17:31:52 +0100
Message-Id: <20200206163152.6073-4-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200206163152.6073-1-tiwai@suse.de>
References: <20200206163152.6073-1-tiwai@suse.de>
Subject: [alsa-devel] [PATCH 3/3] ALSA: emu8000: Fix the cast to __user
	pointer
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

Fixes the sparse warnings.  The cast to __user pointer needs __force:
  sound/isa/sb/emu8000_pcm.c:528:9: warning: cast removes address space '<asn:1>' of expression

No functional changes, just sparse warning fixes.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/isa/sb/emu8000_pcm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/isa/sb/emu8000_pcm.c b/sound/isa/sb/emu8000_pcm.c
index e377ac93f37f..8e8257c574b0 100644
--- a/sound/isa/sb/emu8000_pcm.c
+++ b/sound/isa/sb/emu8000_pcm.c
@@ -435,7 +435,7 @@ enum {
 #define LOOP_WRITE(rec, offset, _buf, count, mode)		\
 	do {							\
 		struct snd_emu8000 *emu = (rec)->emu;		\
-		unsigned short *buf = (unsigned short *)(_buf); \
+		unsigned short *buf = (__force unsigned short *)(_buf); \
 		snd_emu8000_write_wait(emu, 1);			\
 		EMU8000_SMALW_WRITE(emu, offset);		\
 		while (count > 0) {				\
@@ -492,7 +492,7 @@ static int emu8k_pcm_silence(struct snd_pcm_substream *subs,
 #define LOOP_WRITE(rec, pos, _buf, count, mode)				\
 	do {								\
 		struct snd_emu8000 *emu = rec->emu;			\
-		unsigned short *buf = (unsigned short *)(_buf);		\
+		unsigned short *buf = (__force unsigned short *)(_buf);	\
 		snd_emu8000_write_wait(emu, 1);				\
 		EMU8000_SMALW_WRITE(emu, pos + rec->loop_start[0]);	\
 		if (rec->voices > 1)					\
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
