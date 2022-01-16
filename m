Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EE2AC433EF
	for <alsa-devel@archiver.kernel.org>; Sun, 16 Jan 2022 08:29:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B35917BD;
	Sun, 16 Jan 2022 09:28:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B35917BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642321782;
	bh=NxNCXO1cpO9S+w4Xu5aojSxkBAnFy89JVw8Cz31gHAM=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pB45VAyCJkw+ELDj8M/NTcvs+KuKN5dy+JYYOoAQvWL5oXiAomOWKYLzUSoo1gbZ0
	 eW1hqJL0O+qUCHxGe01FLqizXcUIUFLoKW1tAntJOUREH0eDZLEg42WBaPk1v2H1S0
	 2bKEZbiBI8TuDVSEIw7Y/ht72/UYDooec3b136S4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B19AAF8047D;
	Sun, 16 Jan 2022 09:28:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9934F804CC; Sun, 16 Jan 2022 09:28:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 871C0F800BF
 for <alsa-devel@alsa-project.org>; Sun, 16 Jan 2022 09:28:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 871C0F800BF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="TQGvAmut"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="5s3oYyDY"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 62A4A1F3AF
 for <alsa-devel@alsa-project.org>; Sun, 16 Jan 2022 08:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1642321719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ohDCGoda+5Xylm+IVSC85lgLETenqt+xFUbfJxOI9JA=;
 b=TQGvAmutVlMxFk3skUOzXa8qVr3HljN1rdMDaVO7c70uwubb8g69tX2rt51dyERW2xmxUQ
 dZGJKztxOrzQTZilADFqWR+9U5N0TAlIMKR0aWf+P6FalCAtKyGVj7SiLMVSgfotHPtPE+
 +R8jrPk7WMLmZhximcrMPe/z5xuW7Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1642321719;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ohDCGoda+5Xylm+IVSC85lgLETenqt+xFUbfJxOI9JA=;
 b=5s3oYyDYJobxEoAsM55LyzzCE7ZM6xhiWdfTV7q0a5hCctN83aivBJnKBZf/lJ+jr1f1pf
 JcOC6aumqCwwLiCg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 521A0A3B81;
 Sun, 16 Jan 2022 08:28:39 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ALSA: core: Fix SSID quirk lookup for subvendor=0
Date: Sun, 16 Jan 2022 09:28:38 +0100
Message-Id: <20220116082838.19382-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
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

Some weird devices set the codec SSID vendor ID 0, and
snd_pci_quirk_lookup_id() loop aborts at the point although it should
still try matching with the SSID device ID.  This resulted in a
missing quirk for some old Macs.

Fix the loop termination condition to check both subvendor and
subdevice.

Fixes: 73355ddd8775 ("ALSA: hda: Code refactoring snd_hda_pick_fixup()")
Cc: <stable@vger.kernel.org>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215495
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
v1->v2: Fix a typo of logical OR in the condition

 sound/core/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/core/misc.c b/sound/core/misc.c
index 3579dd7a161f..50e4aaa6270d 100644
--- a/sound/core/misc.c
+++ b/sound/core/misc.c
@@ -112,7 +112,7 @@ snd_pci_quirk_lookup_id(u16 vendor, u16 device,
 {
 	const struct snd_pci_quirk *q;
 
-	for (q = list; q->subvendor; q++) {
+	for (q = list; q->subvendor || q->subdevice; q++) {
 		if (q->subvendor != vendor)
 			continue;
 		if (!q->subdevice ||
-- 
2.31.1

