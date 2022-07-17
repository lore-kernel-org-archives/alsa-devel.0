Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8DFEC433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 17 Jul 2022 07:07:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D68F118DE;
	Sun, 17 Jul 2022 09:06:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D68F118DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658041661;
	bh=hLFkk5BxM0L4Xp982xW3TBQk+PTrRudE1Ap9VQgMTzE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hixMZfZLYxm1L/j0h3rPdMI8MZjHTMl9dPbmSIardlMqaY7FMe+LXNoosRFhN5VSi
	 n7xv3rhun3yyegHNX6t2p597/Cv1bhH89AXcRk+IJOZQSsIGGzO5VgfzajKRDxxGzQ
	 nfNu0vxe6fe4sCNi46I5LBeAnNuDKiZ0HVmdHt0Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 05976F804FB;
	Sun, 17 Jul 2022 09:06:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 028F9F804FB; Sun, 17 Jul 2022 09:06:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C4BB8F8012A
 for <alsa-devel@alsa-project.org>; Sun, 17 Jul 2022 09:05:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C4BB8F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="M9dXj/ri"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="PZJ0nQ0I"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6B2C31F983;
 Sun, 17 Jul 2022 07:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658041556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dt+1QCRZ2XSmqOkJwPq4z4lw5/QFdsDsZDcIDJQkFcE=;
 b=M9dXj/riP4INPSUe1OMZNpqzlN/uyyVE/dPIgodoRNzUPS5RpkzXeNT7qC3ds6hYzddEVS
 Fj+64u9kDO9YG0QMyH0qSYdlmmhjdZLRUk1u0nm6jp2Hj1bpOwh5OycNCrl/ENVr29CEhX
 cM8ZdNNO79zTx2Q/OX3A9MDPfQ+bPpQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658041556;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dt+1QCRZ2XSmqOkJwPq4z4lw5/QFdsDsZDcIDJQkFcE=;
 b=PZJ0nQ0IB9LrPSC9HQyh+KwKGFQV7TY/MKltwyWc/gOdm9a91HwkmpAcijknN84Vd+mW93
 ZYfhc2wWt3vMmVCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 458A513A89;
 Sun, 17 Jul 2022 07:05:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mMkaENS002LDawAAMHmgww
 (envelope-from <tiwai@suse.de>); Sun, 17 Jul 2022 07:05:56 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 5/5] ALSA: doc: Drop stale fasync entry
Date: Sun, 17 Jul 2022 09:05:49 +0200
Message-Id: <20220717070549.5993-6-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220717070549.5993-1-tiwai@suse.de>
References: <20220717070549.5993-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The fasync entry has been dropped recently.  Update the documentation
as well.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 Documentation/sound/kernel-api/writing-an-alsa-driver.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
index 176b73583b7a..84b4ecae1485 100644
--- a/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
+++ b/Documentation/sound/kernel-api/writing-an-alsa-driver.rst
@@ -1597,7 +1597,6 @@ are the contents of this file:
           spinlock_t lock;
           wait_queue_head_t sleep;
           struct timer_list tick_timer;
-          struct fasync_struct *fasync;
 
           /* -- private section -- */
           void *private_data;
-- 
2.35.3

