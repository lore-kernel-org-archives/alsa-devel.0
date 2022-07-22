Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B3AC43334
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jul 2022 14:40:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 74E1218A5;
	Fri, 22 Jul 2022 16:40:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 74E1218A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1658500850;
	bh=/ClPMJ/mLgaKOEzI4Zxm74m6VeEUiwLSxrs8jSjG7Hk=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R4MPtz1SudTxDZRz9oshJd95lfoVDafWH723uIcrpp6aC3Ln1v+5KqcOt8YGlK9Hb
	 WGEsAyrsOX8DdpRrnRrO7pq/bxydWE4/LqoHW1zF+JFwmQb3ZDd4IEkm+oqoagzOn8
	 Rq9SsLasVnTtyIGglMiBZdw3qOPE6YJreABdO1oE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 04317F8023B;
	Fri, 22 Jul 2022 16:39:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3867AF80246; Fri, 22 Jul 2022 16:39:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12F58F8012A
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2022 16:39:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12F58F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="tE2P2iML"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="nWJuz/6P"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 995DF205DF;
 Fri, 22 Jul 2022 14:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1658500789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=syt4R1iyBW3vfVKgztQqjll5NjHStZ2Ha40+mzXKF3g=;
 b=tE2P2iML1moRKs/59JgiR5pyiDIdacjmb69W3xr21SqXJKLnWevqpW4KMvhVj1JxIKdogH
 fFdVGUGkT6aTN4BN5RxYVj9/16pu5BaLgpURA4Eeo4ZEL/FQv3+Z5+60Rlu4AXxVdHa2r/
 jCrHyZKFD9DHqhS9LChjTl9WhGI8zwg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1658500789;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=syt4R1iyBW3vfVKgztQqjll5NjHStZ2Ha40+mzXKF3g=;
 b=nWJuz/6P2+8wdExbaA8tuNU4JgdeRCb7QKbIlQoHqqz1PrhlMeq/oibgLVtIocv8EDQtYb
 UCezTcqWHX6LRKCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7BD6113AB3;
 Fri, 22 Jul 2022 14:39:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7EisHLW22mIOdAAAMHmgww
 (envelope-from <tiwai@suse.de>); Fri, 22 Jul 2022 14:39:49 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Add quirk for Behringer UMC202HD
Date: Fri, 22 Jul 2022 16:39:48 +0200
Message-Id: <20220722143948.29804-1-tiwai@suse.de>
X-Mailer: git-send-email 2.35.3
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

Just like other Behringer models, UMC202HD (USB ID 1397:0507) requires
the quirk for the stable streaming, too.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215934
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index 968d90caeefa..168fd802d70b 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1843,6 +1843,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_SHARE_MEDIA_DEVICE | QUIRK_FLAG_ALIGN_TRANSFER),
 	DEVICE_FLG(0x1395, 0x740a, /* Sennheiser DECT */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x1397, 0x0507, /* Behringer UMC202HD */
+		   QUIRK_FLAG_PLAYBACK_FIRST | QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x1397, 0x0508, /* Behringer UMC204HD */
 		   QUIRK_FLAG_PLAYBACK_FIRST | QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x1397, 0x0509, /* Behringer UMC404HD */
-- 
2.35.3

