Return-Path: <SRS0=Qkbk=MV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8710DC4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 18:52:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D130C60F5C
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Jul 2021 18:52:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D130C60F5C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8DA9A1EEB;
	Thu, 29 Jul 2021 20:51:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8DA9A1EEB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627584748;
	bh=TcYl0DMo36iAlXDGcki9u0tWiAzBKv5wz0fC59DK3jE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=d2hcBq3/XpuP1QKOmx7L7YEK8tb3/UT6mq0NiNVWxtraRzFKP7HJ8l5RCT/LPOpfq
	 nipbrVBCm5+tscdFI5NxzRZ9ziGmpQcFs3Qp0Gny3+z3Z0BRgysbERufKL+sqG78GT
	 /njblXJ/60l1C0MUVS/FIwnxu5ns08e8EHC7fkyE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 24145F800EB;
	Thu, 29 Jul 2021 20:51:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 310C0F8026C; Thu, 29 Jul 2021 20:51:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DF9A8F800EB
 for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2021 20:51:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DF9A8F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="iasBF/Sg"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="/armjIBj"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0D87C1FD72;
 Thu, 29 Jul 2021 18:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1627584690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DKMHjcq6Cq6IJ5G3Dk/V0m0uE+MZCzSkbbhgY7UU0wI=;
 b=iasBF/Sg6411/BIasIwIK5HbWxjHsniEJJXhh6N4xViFJvIbTYWIhrvcFVyQiFCBZDf3l9
 JzGVZCHgncT5DfKlJ4IgqTYCm0yTc0kJJ5KUhMbARJcngaqXdhTxzeQHWpwCVC63RoEPnh
 r9oUqnhiMDCQmLdfb1fXvx3Md++nd6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1627584690;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DKMHjcq6Cq6IJ5G3Dk/V0m0uE+MZCzSkbbhgY7UU0wI=;
 b=/armjIBjp03seuqvRRnJ0GnnxsJ1tfKDSQha2m7eSgYz5w+roE3Za5JqTePsulx4DvKZNw
 hielHstNs2ScoSAQ==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id EF8C4A3B83;
 Thu, 29 Jul 2021 18:51:29 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: usb-audio: Avoid unnecessary or invalid connector
 selection at resume
Date: Thu, 29 Jul 2021 20:51:26 +0200
Message-Id: <20210729185126.24432-1-tiwai@suse.de>
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

The recent fix for the resume on Lenovo machines seems causing a
regression on others.  It's because the change always triggers the
connector selection no matter which widget node type is.

This patch addresses the regression by setting the resume callback
selectively only for the connector widget.

Fixes: 44609fc01f28 ("ALSA: usb-audio: Check connector value on resume")
Cc: <stable@vger.kernel.org>
BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=213897
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/mixer.c | 35 ++++++++++++++++++++---------------
 1 file changed, 20 insertions(+), 15 deletions(-)

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index f4cdaf1ba44a..9b713b4a5ec4 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -1816,6 +1816,15 @@ static void get_connector_control_name(struct usb_mixer_interface *mixer,
 		strlcat(name, " - Output Jack", name_size);
 }
 
+/* get connector value to "wake up" the USB audio */
+static int connector_mixer_resume(struct usb_mixer_elem_list *list)
+{
+	struct usb_mixer_elem_info *cval = mixer_elem_list_to_info(list);
+
+	get_connector_value(cval, NULL, NULL);
+	return 0;
+}
+
 /* Build a mixer control for a UAC connector control (jack-detect) */
 static void build_connector_control(struct usb_mixer_interface *mixer,
 				    const struct usbmix_name_map *imap,
@@ -1833,6 +1842,10 @@ static void build_connector_control(struct usb_mixer_interface *mixer,
 	if (!cval)
 		return;
 	snd_usb_mixer_elem_init_std(&cval->head, mixer, term->id);
+
+	/* set up a specific resume callback */
+	cval->head.resume = connector_mixer_resume;
+
 	/*
 	 * UAC2: The first byte from reading the UAC2_TE_CONNECTOR control returns the
 	 * number of channels connected.
@@ -3642,23 +3655,15 @@ static int restore_mixer_value(struct usb_mixer_elem_list *list)
 	return 0;
 }
 
-static int default_mixer_resume(struct usb_mixer_elem_list *list)
-{
-	struct usb_mixer_elem_info *cval = mixer_elem_list_to_info(list);
-
-	/* get connector value to "wake up" the USB audio */
-	if (cval->val_type == USB_MIXER_BOOLEAN && cval->channels == 1)
-		get_connector_value(cval, NULL, NULL);
-
-	return 0;
-}
-
 static int default_mixer_reset_resume(struct usb_mixer_elem_list *list)
 {
-	int err = default_mixer_resume(list);
+	int err;
 
-	if (err < 0)
-		return err;
+	if (list->resume) {
+		err = list->resume(list);
+		if (err < 0)
+			return err;
+	}
 	return restore_mixer_value(list);
 }
 
@@ -3697,7 +3702,7 @@ void snd_usb_mixer_elem_init_std(struct usb_mixer_elem_list *list,
 	list->id = unitid;
 	list->dump = snd_usb_mixer_dump_cval;
 #ifdef CONFIG_PM
-	list->resume = default_mixer_resume;
+	list->resume = NULL;
 	list->reset_resume = default_mixer_reset_resume;
 #endif
 }
-- 
2.26.2

