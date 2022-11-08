Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2336C433FE
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Nov 2022 06:59:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D76D0852;
	Tue,  8 Nov 2022 07:59:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D76D0852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667890792;
	bh=UbyN0QjaUxFmLiXbQPgwuBzAzJMu3o6DQUjLmqyOk7E=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dKlLtIi2kekAqpt60XM0W9FP+T1slXH2DPPB9bY6HQC2MSlmvOLXJiavs551nHqde
	 cththB3ZAwU0meeTvaIbXchOUgYSnL2cOnhgRSMmOU/LuY7IweKuxxHObFGGdsPXw9
	 oxpERJBmNdxewJnu6FO9JVxhkLcK+NG13XXX8tVw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9EF23F8020D;
	Tue,  8 Nov 2022 07:58:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E900F8016A; Tue,  8 Nov 2022 07:58:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E489F800EC
 for <alsa-devel@alsa-project.org>; Tue,  8 Nov 2022 07:58:28 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E489F800EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="vTSTOFcN"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="OBlTUTd4"
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 081661F899;
 Tue,  8 Nov 2022 06:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667890708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=d96Kojy34GU314t0nzFPf3W0N3ywvoPEB++yr4V4yBM=;
 b=vTSTOFcN6R8ol7JjFEFOCSDuTXcqiygTtia5ynADMfCCXKYUP9GSX/E+jGeJFELQ6cUqJN
 /bY+LTAVeYRlbOQJzIwoT07y/+Y+GNf8cU8wY05YL1zb2ixtIydHA15TRbPnjJobee+NNI
 vd5x2L7GscoQPumA/aGjFrKXxcv+DZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667890708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=d96Kojy34GU314t0nzFPf3W0N3ywvoPEB++yr4V4yBM=;
 b=OBlTUTd4zs82/nmVGsQ3UUPBT/Ezn5iPgOfPMilrhhYljOlCmGr5jl4FrqjCEnSxZiylZG
 sPL2FKgsOQ+9VfBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D550C139F1;
 Tue,  8 Nov 2022 06:58:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tv8UMxP+aWO0IQAAMHmgww
 (envelope-from <tiwai@suse.de>); Tue, 08 Nov 2022 06:58:27 +0000
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ALSA: usb-audio: Yet more regression for for the delayed
 card registration
Date: Tue,  8 Nov 2022 07:58:23 +0100
Message-Id: <20221108065824.14418-1-tiwai@suse.de>
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

Although we tried to fix the regression for the recent changes with
the delayed card registration, it doesn't seem covering the all
cases; e.g. on Roland EDIROL M-100FX, where the generic quirk for
Roland devices is applied, it misses the card registration because the
detection of the last interface (apparently for MIDI) fails.

This patch is an attempt to recover from those failures by calling the
card register also at the error path for the secondary interfaces.
The card register condition is also extended to match with the old
check in the previous patch, too (i.e. the simple check of the
interface number) for catching the probe with errors.

Fixes: 39efc9c8a973 ("ALSA: usb-audio: Fix last interface check for registration")
Cc: <stable@vger.kernel.org>
Link: https://bugzilla.suse.com/show_bug.cgi?id=1205111
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/card.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/sound/usb/card.c b/sound/usb/card.c
index a5ed11ea1145..26268ffb8274 100644
--- a/sound/usb/card.c
+++ b/sound/usb/card.c
@@ -742,6 +742,18 @@ get_alias_quirk(struct usb_device *dev, unsigned int id)
 	return NULL;
 }
 
+/* register card if we reach to the last interface or to the specified
+ * one given via option
+ */
+static int try_to_register_card(struct snd_usb_audio *chip, int ifnum)
+{
+	if (check_delayed_register_option(chip) == ifnum ||
+	    chip->last_iface == ifnum ||
+	    usb_interface_claimed(usb_ifnum_to_if(chip->dev, chip->last_iface)))
+		return snd_card_register(chip->card);
+	return 0;
+}
+
 /*
  * probe the active usb device
  *
@@ -880,15 +892,9 @@ static int usb_audio_probe(struct usb_interface *intf,
 		chip->need_delayed_register = false; /* clear again */
 	}
 
-	/* register card if we reach to the last interface or to the specified
-	 * one given via option
-	 */
-	if (check_delayed_register_option(chip) == ifnum ||
-	    usb_interface_claimed(usb_ifnum_to_if(dev, chip->last_iface))) {
-		err = snd_card_register(chip->card);
-		if (err < 0)
-			goto __error;
-	}
+	err = try_to_register_card(chip, ifnum);
+	if (err < 0)
+		goto __error_no_register;
 
 	if (chip->quirk_flags & QUIRK_FLAG_SHARE_MEDIA_DEVICE) {
 		/* don't want to fail when snd_media_device_create() fails */
@@ -907,6 +913,11 @@ static int usb_audio_probe(struct usb_interface *intf,
 	return 0;
 
  __error:
+	/* in the case of error in secondary interface, still try to register */
+	if (chip)
+		try_to_register_card(chip, ifnum);
+
+ __error_no_register:
 	if (chip) {
 		/* chip->active is inside the chip->card object,
 		 * decrement before memory is possibly returned.
-- 
2.35.3

