Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AE6C5320E
	for <alsa-devel@archiver.kernel.org>; Tue, 20 Aug 2024 07:47:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 43810BC0;
	Tue, 20 Aug 2024 09:46:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 43810BC0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1724140028;
	bh=rXWE6JT9sWMyR1WlzQj9C1Q40JeJwGKh6MI5I0VgzJ8=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=IOv+CvkjveE9u3APeWE5ARfSCjUaxEe3BmS2G4U7z189DXCg1EqCAfXB1yw12EWgY
	 soUVJDJg3GzflWRMOOumAD2jlDy8U43Jpv5a1mQYeLvJyQh1i7N+u8LjB7Y9sNYSna
	 LoY6YWPvWWkX95SFAmqkynrCk0BNJKDsgb0bW+n0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D22DF805BA; Tue, 20 Aug 2024 09:46:36 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AAEF3F80589;
	Tue, 20 Aug 2024 09:46:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2ACCF80494; Tue, 20 Aug 2024 09:45:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E1D13F800F0
	for <alsa-devel@alsa-project.org>; Tue, 20 Aug 2024 09:45:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1D13F800F0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=hgpIQJeq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=92co+hLB;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=MpAKsk5I;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=qvdsZhtP
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD9751FFAA;
	Tue, 20 Aug 2024 07:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1724139931; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=t6cJp10j8rOTWkrZ/d+deOifl3EAADS0qODgZUN76HA=;
	b=hgpIQJeqWRXUpT7XOmmwFmSnKXi+IZV0LLSDYuROvUwFyzL1QUpngIlP7fGtHnZr6B+nye
	t2lJqnTGOJQbVT84AKfqoXRjGRNIpbmraUl6BN5RrLtq9ADXPnL6vcZ9OYJl97wp+VhRps
	/8lMtS/kYzkV9omlKaa7x/vSCzW3jV8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724139931;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=t6cJp10j8rOTWkrZ/d+deOifl3EAADS0qODgZUN76HA=;
	b=92co+hLB2KYMIvN4GJDGoeX3UktTSilzefTSzXQ/JY2AwFR3+Wgph5dpnGPtFRkZVmjoc5
	+s/I+p7BFefLsmCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MpAKsk5I;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qvdsZhtP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1724139930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=t6cJp10j8rOTWkrZ/d+deOifl3EAADS0qODgZUN76HA=;
	b=MpAKsk5IUlLfNdFot5X4PxKGyIRdgxYKYPU1/JTxVFdkjQ9Mzxo2uXnE9SbcidAhUr36me
	dAa5656RTuGbjVotDTkkzcRN6vD3WdCOlQoE3j8LfTQi/1rLd1dlvBjLz9USVVk/SuGEuP
	0V57GOmjuFisW7j0/iHz0cufZQ3y4h8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1724139930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=t6cJp10j8rOTWkrZ/d+deOifl3EAADS0qODgZUN76HA=;
	b=qvdsZhtPAeL+X537iN6RASlNadD7UcBgckxBuoerBwLniaYtrG3UgAbgxSPi9vWo/KuntH
	sVMRV8vsNcJw96Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C5A4313770;
	Tue, 20 Aug 2024 07:45:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ko4dL5pJxGY2IAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 20 Aug 2024 07:45:30 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH alsa-utils] aseqdump: Add missing dump of UMP Set Key
 Signature Message
Date: Tue, 20 Aug 2024 09:46:09 +0200
Message-ID: <20240820074611.15173-1-tiwai@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DD9751FFAA
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Message-ID-Hash: XWBI3QBOYRBXBFUDLBXX3YJXN3VQ6YXF
X-Message-ID-Hash: XWBI3QBOYRBXBFUDLBXX3YJXN3VQ6YXF
X-MailFrom: tiwai@suse.de
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XWBI3QBOYRBXBFUDLBXX3YJXN3VQ6YXF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The handling of Set Key Signature message of the Flex Data type was
missing by some reason.  Now the definition was added in alsa-lib
ump_msg.h, so let's show the contents.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 seq/aseqdump/aseqdump.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/seq/aseqdump/aseqdump.c b/seq/aseqdump/aseqdump.c
index 1d9c01e01dd3..e37c87b45fc1 100644
--- a/seq/aseqdump/aseqdump.c
+++ b/seq/aseqdump/aseqdump.c
@@ -964,6 +964,14 @@ static void dump_ump_flex_data_event(const unsigned int *ump)
 		return;
 	}
 
+	if (fh->meta.status_bank == SND_UMP_FLEX_DATA_MSG_BANK_SETUP &&
+	    fh->meta.status == SND_UMP_FLEX_DATA_MSG_STATUS_SET_KEY_SIGNATURE) {
+		printf("UMP Set Key Signature     sharps/flats %d, tonic %d\n",
+		       fh->set_key_sig.sharps_flats,
+		       fh->set_key_sig.tonic_note);
+		return;
+	}
+
 	if (fh->meta.status_bank == SND_UMP_FLEX_DATA_MSG_BANK_SETUP &&
 	    fh->meta.status == SND_UMP_FLEX_DATA_MSG_STATUS_SET_CHORD_NAME) {
 		printf("UMP Set Chord Name     tonic %d %d %d, alt1 %d/%d, alt2 %d/%d, alt3 %d/%d, alt4 %d/%d, bass %d %d %d, alt1 %d/%d alt2 %d/%d\n",
-- 
2.43.0

