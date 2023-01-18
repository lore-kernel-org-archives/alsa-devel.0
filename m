Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC91C32793
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Jan 2023 17:00:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6294F7A40;
	Wed, 18 Jan 2023 17:59:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6294F7A40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674061246;
	bh=jpkSNHDMKdFyySCHH7D1lLgmz2gAWGPZsd7Uxm0zdtk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=UYP9Gg1ISWoyD417b2Fn6wSVE9wiErq8dGOEQalCJ2fpnbpnpi/pAvg1wg1ksJkGE
	 RDji0EmB5gxcM6gPpsfBiIRxG58rLridYNmRdEuqjlF5ZMoHcO3we0WRWjhMT9umt5
	 CGgb28FENXcwVaq24jVIOvAfaCVIpYGQ6NvACqtQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 01D73F8024C;
	Wed, 18 Jan 2023 17:59:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83CFBF8024C; Wed, 18 Jan 2023 17:59:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8561F8021D
 for <alsa-devel@alsa-project.org>; Wed, 18 Jan 2023 17:59:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8561F8021D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=woTfoymb; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=N5G8M5j8
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D60B43F75D;
 Wed, 18 Jan 2023 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1674061190; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fL9qo32prQEkmz6bUxUHQD6+LjuusfyOQT45/XgHyME=;
 b=woTfoymbmieYD40giQpseumnY8i6pVuEkDe0nj8CQTRUf4XuwbC+HdU2AtEh7pkg2OM+sI
 KZoPxSktVpNsNB8JVVV+300KDcf5r9aL9KCFr/lKU0kf+D6OAe7n/JebopTmaveh9DMnNs
 FNVxeCDrXSFb1m7ISvRGyiYR8oHt6Zw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1674061190;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=fL9qo32prQEkmz6bUxUHQD6+LjuusfyOQT45/XgHyME=;
 b=N5G8M5j8QsxXw5SH8+Qh+cJCZAdfxy3hQqMDkXkIUVjMVkL9BsU5vWRghfJj4Pf/3+nemU
 eOaOGJO1gE4mslDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B3E42138FE;
 Wed, 18 Jan 2023 16:59:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id nLPEKIYlyGMDOgAAMHmgww
 (envelope-from <tiwai@suse.de>); Wed, 18 Jan 2023 16:59:50 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Add FIXED_RATE quirk for JBL Quantum610
 Wireless
Date: Wed, 18 Jan 2023 17:59:47 +0100
Message-Id: <20230118165947.22317-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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

JBL Quantum610 Wireless (0ecb:205c) requires the same workaround that
was used for JBL Quantum810 for limiting the sample rate.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216798
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 3d13fdf7590c..3ecd1ba7fd4b 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -2152,6 +2152,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x0525, 0xa4ad, /* Hamedal C20 usb camero */
 		   QUIRK_FLAG_IFACE_SKIP_CLOSE),
+	DEVICE_FLG(0x0ecb, 0x205c, /* JBL Quantum610 Wireless */
+		   QUIRK_FLAG_FIXED_RATE),
 	DEVICE_FLG(0x0ecb, 0x2069, /* JBL Quantum810 Wireless */
 		   QUIRK_FLAG_FIXED_RATE),
 
-- 
2.35.3

