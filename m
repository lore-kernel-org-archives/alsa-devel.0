Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11654EB64D7
	for <alsa-devel@archiver.kernel.org>; Wed, 28 Jun 2023 09:45:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8A7E583A;
	Wed, 28 Jun 2023 11:44:15 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8A7E583A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687945505;
	bh=g+ifChkKIq9jd2hJQAclk/y7Y/UN6oIsxAu456FPZE4=;
	h=From:To:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=HnNfTeCFpOxKXYX+fPYRIwF9C1UkXLr960sGKhFKRkd1uLUHr+RjKtuEZcalFmDJ3
	 9CANkBtPp38yjoTudO3m6yCEsgIV1iBfLUclQqezwmvI+w/r9a2Cs5X1w96xNH4yei
	 jXAQV4vGh2g7lUN8G+dKoy3DHWR3XFKSxhhxewVE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id ED559F80544; Wed, 28 Jun 2023 11:44:03 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 43B6CF80093;
	Wed, 28 Jun 2023 11:44:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 48C66F8053B; Wed, 28 Jun 2023 11:43:59 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 39740F80093
	for <alsa-devel@alsa-project.org>; Wed, 28 Jun 2023 11:43:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39740F80093
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256
 header.s=susede2_rsa header.b=kDsw4FJp;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=pdpRgd/S
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B73CD2187A;
	Wed, 28 Jun 2023 09:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_rsa;
	t=1687945434; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=TCsLSIdzurNkVOt98iJvAYNDDLk6PoUym46E6J7YgrU=;
	b=kDsw4FJp+ARP8GW+dTKQgbY+ZFAJnHfds8cbycjfSypC/smLKRjeHkP93dLxUD5Y+KoGfz
	gggCg3QwUju9KlFROk6wqFK31AKFSTlcX9SEJaeJeirZ28d+75RGHqznDiO0c3/QnIVhN2
	B921eNyCUZGgabrlVhLLz74uuj5HQF4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1687945434;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
  content-transfer-encoding:content-transfer-encoding;
	bh=TCsLSIdzurNkVOt98iJvAYNDDLk6PoUym46E6J7YgrU=;
	b=pdpRgd/SiQ+0RdUXyjP0pPlvwrYZzGFD49GHbEyF4VWDe8/UFcRZWMxUFbymtATUYPxMhu
	5qRtetIWHcTfr0DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de
 [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9BD98138EF;
	Wed, 28 Jun 2023 09:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id QUEVJdoAnGTHAgAAMHmgww
	(envelope-from <tiwai@suse.de>); Wed, 28 Jun 2023 09:43:54 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: ump: Correct wrong byte size at converting a UMP System
 message
Date: Wed, 28 Jun 2023 11:43:52 +0200
Message-Id: <20230628094352.15754-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GQ4F6WZ56YCEDBIUBY54OCOAALNFP2ZF
X-Message-ID-Hash: GQ4F6WZ56YCEDBIUBY54OCOAALNFP2ZF
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/GQ4F6WZ56YCEDBIUBY54OCOAALNFP2ZF/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

A wrong size for UMP_SYSTEM_STATUS_MIDI_TIME_CODE and case
UMP_SYSTEM_STATUS_SONG_SELECT was reported at converting to the legacy
MIDI 1.0 stream.  This patch corrects the value.

Fixes: 0b5288f5fe63 ("ALSA: ump: Add legacy raw MIDI support")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/ump_convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/ump_convert.c b/sound/core/ump_convert.c
index fb61df424a87..de04799fdb69 100644
--- a/sound/core/ump_convert.c
+++ b/sound/core/ump_convert.c
@@ -73,7 +73,7 @@ static int cvt_ump_system_to_legacy(u32 data, unsigned char *buf)
 	case UMP_SYSTEM_STATUS_MIDI_TIME_CODE:
 	case UMP_SYSTEM_STATUS_SONG_SELECT:
 		buf[1] = (data >> 8) & 0x7f;
-		return 1;
+		return 2;
 	case UMP_SYSTEM_STATUS_SONG_POSITION:
 		buf[1] = (data >> 8) & 0x7f;
 		buf[2] = data & 0x7f;
-- 
2.35.3

