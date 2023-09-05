Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF1EEC83F3E
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Sep 2023 08:13:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3F436206;
	Tue,  5 Sep 2023 10:12:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3F436206
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1693901622;
	bh=QGJW7HcNFWiE/aj+WJpky27+HGqJAsg4oVCQulSpdHA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=k4n+AzKNxs7Ez2ASwnpBEdlbVhqS4T2N3EsL331s8nKkNqGa9m3qaWSswbg9TZWnq
	 zXq7qsy6ci4wgoZnaYc8ilvS/samAxqePCwLXMHmm8vEpVIoe30TFECmOFKQjw7mG2
	 ylAPTU686p2FSUG/GifMmcHsLhroOnJwDr+RcQCo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DDF2EF80549; Tue,  5 Sep 2023 10:12:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 98650F8047D;
	Tue,  5 Sep 2023 10:12:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DF8EBF8047D; Tue,  5 Sep 2023 10:12:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 98015F80236
	for <alsa-devel@alsa-project.org>; Tue,  5 Sep 2023 10:12:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 98015F80236
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=LXZ14eLR;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=jPhRFkMq
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AF3081F750;
	Tue,  5 Sep 2023 08:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1693901532;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=vXrlT15bVFgndCa2VOvr5NzcUokK5WiCZgecVH73Ikk=;
	b=LXZ14eLRSSsIMbWWSx1WXffqpcNwO5qsZmjE/UW/yMGDMIXaFvWEX1b6xJfQ8YbOPNeLDz
	aiFJ3J12DbdAOjkl7LGHQIA+Hw8a+4jFRG8YGA8emUB/GIeGH+ah6sJCoVS1qwo5NpYZWi
	v1Gda6zKVR0zH2F/4wJII/8yFERnDWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1693901532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=vXrlT15bVFgndCa2VOvr5NzcUokK5WiCZgecVH73Ikk=;
	b=jPhRFkMqj4Ei6uN+mJG7YwNeHDaYt3C4gNPcweSa5zvepAtp9YHh/cvhN4atJGJIRhUkOM
	LSv/U4B1Ym7ntkBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9192013911;
	Tue,  5 Sep 2023 08:12:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jGLGItzi9mRQBgAAMHmgww
	(envelope-from <tiwai@suse.de>); Tue, 05 Sep 2023 08:12:12 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Cc: Ash Holland <ash@sorrel.sh>
Subject: [PATCH v2] ALSA: seq: Fix snd_seq_expand_var_event() call to
 user-space
Date: Tue,  5 Sep 2023 10:12:10 +0200
Message-Id: <20230905081210.6731-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: U2UV53SEEV6P7Z4MYURRASEJE6SHI3KN
X-Message-ID-Hash: U2UV53SEEV6P7Z4MYURRASEJE6SHI3KN
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/U2UV53SEEV6P7Z4MYURRASEJE6SHI3KN/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The recent fix to clear the padding bytes at
snd_seq_expand_var_event() broke the read to user-space with
in_kernel=0 parameter.  For user-space address, it has to use
clear_user() instead of memset().

Fixes: f80e6d60d677 ("ALSA: seq: Clear padded bytes at expanding events")
Reported-and-tested-by: Ash Holland <ash@sorrel.sh>
Closes: https://lore.kernel.org/r/8a555319-9f31-4ea2-878f-adc338bc40d4@sorrel.sh
Link: https://lore.kernel.org/r/20230905052631.18240-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: add clear_user() return check

 sound/core/seq/seq_memory.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_memory.c b/sound/core/seq/seq_memory.c
index 174585bf59d2..b603bb93f896 100644
--- a/sound/core/seq/seq_memory.c
+++ b/sound/core/seq/seq_memory.c
@@ -187,8 +187,13 @@ int snd_seq_expand_var_event(const struct snd_seq_event *event, int count, char
 	err = expand_var_event(event, 0, len, buf, in_kernel);
 	if (err < 0)
 		return err;
-	if (len != newlen)
-		memset(buf + len, 0, newlen - len);
+	if (len != newlen) {
+		if (in_kernel)
+			memset(buf + len, 0, newlen - len);
+		else if (clear_user((__force void __user *)buf + len,
+				    newlen - len))
+			return -EFAULT;
+	}
 	return newlen;
 }
 EXPORT_SYMBOL(snd_seq_expand_var_event);
-- 
2.35.3

