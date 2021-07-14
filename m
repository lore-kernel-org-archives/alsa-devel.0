Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D7B0C07E9A
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 08:49:44 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2FD6610F9
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 08:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2FD6610F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 884841681;
	Wed, 14 Jul 2021 10:48:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 884841681
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626252580;
	bh=oapcqTKXM0wkI4XieWe/oyhhMzcsh9CmFgCUaa7VtHA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FwrCDJTH7nNr+qqkzq+iiemFcUoXxWLk12Wt1pjaaRQR0XFNipn4+VXsh6n1BUwwv
	 HfVaJGyEi7kpkrxvY9zWX3MF4HUJFxNbNJN03qtqjgwern7DYWBLcf6HcQrAW0QZDc
	 WCQIt3j4ajVOUXhvueFmMGnd/SJL8wzDMB82h24w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ED714F80253;
	Wed, 14 Jul 2021 10:48:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC691F80254; Wed, 14 Jul 2021 10:48:47 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E1647F8011C
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 10:48:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E1647F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="NIMenlPR"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="4v4QVEDc"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 6089D227E6;
 Wed, 14 Jul 2021 08:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1626252519; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=axAvMSHptEp4HM1UgZnAqjGGhj9fsxR7DUaEPimz0qk=;
 b=NIMenlPRgk/zWvG5zWkIbWciL9/QBzFTNr2NSarLknsWhavl4ClY8QS2daNonxYOJD4dTg
 z1wCzMuE40j1TYSrZjM0kK3BPf+CHQk6TgV+ncjNbLMKq1rVLml2dTT+VxY7B3HntUcIUk
 lvDaMXe/dvGuZ7nYCKmtrAKDWYhXpL8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1626252519;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=axAvMSHptEp4HM1UgZnAqjGGhj9fsxR7DUaEPimz0qk=;
 b=4v4QVEDc8OY8rlvcz6fKkTExcY1kVhOXJbx+MDuCQjqVPENwy3mTjhhw80cVfi+QldCsyO
 k43UIiD2JYLITUDg==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 56C16A3B8A;
 Wed, 14 Jul 2021 08:48:39 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Add missing proc text entry for BESPOKEN type
Date: Wed, 14 Jul 2021 10:48:36 +0200
Message-Id: <20210714084836.1977-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Pavel Machek <pavel@denx.de>
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

Recently we've added a new usb_mixer element type, USB_MIXER_BESPOKEN,
but it wasn't added in the table in snd_usb_mixer_dump_cval().  This
is no big problem since each bespoken type should have its own dump
method, but it still isn't disallowed to use the standard one, so we
should cover it as well.  Along with it, define the table with the
explicit array initializer for avoiding other pitfalls.

Fixes: 785b6f29a795 ("ALSA: usb-audio: scarlett2: Fix wrong resume call")
Reported-by: Pavel Machek <pavel@denx.de>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 30b3e128e28d..f4cdaf1ba44a 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -3295,7 +3295,15 @@ static void snd_usb_mixer_dump_cval(struct snd_info_buffer *buffer,
 {
 	struct usb_mixer_elem_info *cval = mixer_elem_list_to_info(list);
 	static const char * const val_types[] = {
-		"BOOLEAN", "INV_BOOLEAN", "S8", "U8", "S16", "U16", "S32", "U32",
+		[USB_MIXER_BOOLEAN] = "BOOLEAN",
+		[USB_MIXER_INV_BOOLEAN] = "INV_BOOLEAN",
+		[USB_MIXER_S8] = "S8",
+		[USB_MIXER_U8] = "U8",
+		[USB_MIXER_S16] = "S16",
+		[USB_MIXER_U16] = "U16",
+		[USB_MIXER_S32] = "S32",
+		[USB_MIXER_U32] = "U32",
+		[USB_MIXER_BESPOKEN] = "BESPOKEN",
 	};
 	snd_iprintf(buffer, "    Info: id=%i, control=%i, cmask=0x%x, "
 			    "channels=%i, type=\"%s\"\n", cval->head.id,
-- 
2.26.2

