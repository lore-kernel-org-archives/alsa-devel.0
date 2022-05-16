Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1315C433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 16 May 2022 10:32:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 64CC415C2;
	Mon, 16 May 2022 12:31:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 64CC415C2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652697141;
	bh=L+K0egCYuIBHX29UleAWVIvOUogHYX5Ht6OD8dcWIoc=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=QMCqLoRMlz6h4PQfp2RlUmuxCwEwwob3lNQxFw1/cM61GFrfFd5GOtNFwUI+/fCr7
	 NSvpG0PHDheFiC1PXDquc3c8CdSn8Ckjdbr+Z7EcwRAd6jsnZQ8KIGRBTyWiPBGjkf
	 t0fHl00mjiwN3SNVA87vmibTf5WGbYaKJmxub0vI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00377F8012F;
	Mon, 16 May 2022 12:31:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E748EF8014B; Mon, 16 May 2022 12:31:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5621BF800D8
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2022 12:31:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5621BF800D8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="cd9i0ARg"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="91Sq00/C"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BAEC41FAE9
 for <alsa-devel@alsa-project.org>; Mon, 16 May 2022 10:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1652697080; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EcDltIjgqg9WlxoW7VjyCeKLmGeI2LTVCpafPT7p4/g=;
 b=cd9i0ARgzNZsj0ocngjJa9hfAIDapwBq5zNIigno7OGLUkYXgP7GFHeDzalBSIOZWgGqEZ
 bK5A8x1yFGuLwMy8S5pPPgRr1qn2c8YGqihbytrZFS8gsY7+52UUF4jGgERLJIbTk2fAzq
 kLEGUzx1XABEZGnL2SK846qId7fQJKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1652697080;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=EcDltIjgqg9WlxoW7VjyCeKLmGeI2LTVCpafPT7p4/g=;
 b=91Sq00/Ce44+poGs8OB06MzcS5N0e9FKz7b1dJXpJxw3E/N/Gsev4In64TZEj6CPl7uEhE
 dYvVVoDCkZPyNxBw==
Received: from valkyrie.site.de (unknown [10.163.18.242])
 by relay2.suse.de (Postfix) with ESMTP id A19422C141;
 Mon, 16 May 2022 10:31:20 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Restore Rane SL-1 quirk
Date: Mon, 16 May 2022 12:31:12 +0200
Message-Id: <20220516103112.12950-1-tiwai@suse.de>
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

At cleaning up and moving the device rename from the quirk table to
its own table, we removed the entry for Rane SL-1 as we thought it's
only for renaming.  It turned out, however, that the quirk is required
for matching with the device that declares itself as no standard
audio but only as vendor-specific.

Restore the quirk entry for Rane SL-1 to fix the regression.

BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=215887
Fixes: 5436f59bc5bc ("ALSA: usb-audio: Move device rename and profile quirks to an internal table")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/quirks-table.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/usb/quirks-table.h b/sound/usb/quirks-table.h
index 0ea39565e623..40a5e3eb4ef2 100644
--- a/sound/usb/quirks-table.h
+++ b/sound/usb/quirks-table.h
@@ -3235,6 +3235,15 @@ YAMAHA_DEVICE(0x7010, "UB99"),
 	}
 },
 
+/* Rane SL-1 */
+{
+	USB_DEVICE(0x13e5, 0x0001),
+	.driver_info = (unsigned long) & (const struct snd_usb_audio_quirk) {
+		.ifnum = QUIRK_ANY_INTERFACE,
+		.type = QUIRK_AUDIO_STANDARD_INTERFACE
+        }
+},
+
 /* disabled due to regression for other devices;
  * see https://bugzilla.kernel.org/show_bug.cgi?id=199905
  */
-- 
2.35.3

