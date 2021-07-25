Return-Path: <SRS0=9Ww9=MR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74592C4338F
	for <alsa-devel@archiver.kernel.org>; Sun, 25 Jul 2021 10:24:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A35F060F13
	for <alsa-devel@archiver.kernel.org>; Sun, 25 Jul 2021 10:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A35F060F13
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 69D831738;
	Sun, 25 Jul 2021 12:23:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 69D831738
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627208653;
	bh=3CBNphdmSsMlkg/du5dYfr9FXMdT9lx9GDCP52agSbQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jdIrkG6QLoNPSuccyb71ve/rCyTtoetyQ7hEg31vNH9sx/4ML3lxV352hUyDpHsDQ
	 McJ9Qpyu/+us2BxxYsVVxZgf3kYZopdMjeLaAQNOA6AkUtlMMAPiPZ9Cc8Fs8HOuek
	 GKK9lR6Ce/4TPDMU/ihhz21tXEtUYDlsMPIzSGBo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F017BF80258;
	Sun, 25 Jul 2021 12:23:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 81E16F8026C; Sun, 25 Jul 2021 12:23:20 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9DF26F800C0
 for <alsa-devel@alsa-project.org>; Sun, 25 Jul 2021 12:23:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9DF26F800C0
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="etyzjX9p"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="hge6b/ZE"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 775B521F57;
 Sun, 25 Jul 2021 10:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627208591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qpPPDLdi8RDjDNmJHofqo9ot+sqS32SUhTgutcLpiH8=;
 b=etyzjX9pgYY/9FeISbh/+2AHZKiadrm921jHnZx7cJms6ndsXWp78kPA8B8pt5IDWOAUNs
 aIEM0FhnMKoBuKA4dHQTPQVy/6vAyD3SKGVIwnHmCzItvfUiMfAdYjz/hMBoO5r67wXSIf
 rkqbzcIIofOwACCDQBzSaiOvSLRrwnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627208591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=qpPPDLdi8RDjDNmJHofqo9ot+sqS32SUhTgutcLpiH8=;
 b=hge6b/ZESMvkv1JNhOF1uiUldSc4l1eOBJ44lQquju1YwaGLfJIqPh57ccR4e3fBnOx63j
 s/0i+G+L4EsHaLDw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id 5C21DA3B88;
 Sun, 25 Jul 2021 10:23:11 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Fix superfluous autosuspend recovery
Date: Sun, 25 Jul 2021 12:23:09 +0200
Message-Id: <20210725102309.19607-1-tiwai@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
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

The change to restore the autosuspend from the disabled state uses a
wrong check: namely, it should have been the exact comparison of the
quirk_type instead of the logical and (&&).  Otherwise it matches
wrongly with the other quirk types.

Although re-enabling the autosuspend for the already enabled device
shouldn't matter much, it's better to fix the unbalanced call.

Fixes: 9799110825db ("ALSA: usb-audio: Disable USB autosuspend properly in setup_disable_autosuspend()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index 2f6a62416c05..a1f8c3a026f5 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -907,7 +907,7 @@ static void usb_audio_disconnect(struct usb_interface *intf)
 		}
 	}
 
-	if (chip->quirk_type & QUIRK_SETUP_DISABLE_AUTOSUSPEND)
+	if (chip->quirk_type == QUIRK_SETUP_DISABLE_AUTOSUSPEND)
 		usb_enable_autosuspend(interface_to_usbdev(intf));
 
 	chip->num_interfaces--;
-- 
2.26.2

