Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DF6FC433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Apr 2022 06:42:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2996D1DAD;
	Thu, 21 Apr 2022 08:41:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2996D1DAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650523352;
	bh=IT0fiiMCVA4zNY2NXQdCzHh58vXnemNfHb+/rET3V4k=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=QPucYCkHYQnjTlmnzWm6I0YHyA78eu3hQt8fP0cprqIteMsx4lAqz9aSKzQ6urkQy
	 Fkx8DpDpmRPLMlvqiBDrSIPUA8E66HoeRQKTZVNjlhPEyuZKzglm4uc4ZZv4wLkkMn
	 c38szRrgsMASZGd+Mi3FfYETEsrL4QT3pXAn78pw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 84CE7F800C1;
	Thu, 21 Apr 2022 08:41:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 87E57F804DA; Thu, 21 Apr 2022 08:41:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5E21AF80279
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 08:41:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5E21AF80279
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.b="U1hdjNAL"; 
 dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de
 header.b="pzNzFZAh"
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id EBD5F21115
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 06:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1650523263; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4D1dV2/PINllCHZtEbA0cj9sPTWEHuHI84o1DijXb04=;
 b=U1hdjNALgo+Q3lTaffhWBpYHBmHTuUkslQedbDB4EyFiHy8iHf9GIrc01q4KKja+kd8M8u
 JeLq4kSlWP73Zf5+0xtjTcsN6zZH32a+Nbh1XB5yI9ZjXrtw5MmiBv14POoCbtRbcVOV0g
 TG8VqD4sKM3bP7PVhucdzNPntvMiG34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1650523263;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4D1dV2/PINllCHZtEbA0cj9sPTWEHuHI84o1DijXb04=;
 b=pzNzFZAhdupS5EhBhZyabnAEl2gqIUcN2NQ+IxIi6i0JwOAwYpMuN8ZhDsp6C0C3HNqIjn
 Gw8UIY32zc/s6ADw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
 by relay2.suse.de (Postfix) with ESMTP id E69902C149;
 Thu, 21 Apr 2022 06:41:03 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ALSA: usb-audio: Move generic implicit fb quirk entries
 into quirks.c
Date: Thu, 21 Apr 2022 08:41:01 +0200
Message-Id: <20220421064101.12456-2-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220421064101.12456-1-tiwai@suse.de>
References: <20220421064101.12456-1-tiwai@suse.de>
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

Use the new quirk bits to manage the generic implicit fb quirk
entries.  This makes easier to compare with other devices.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/implicit.c | 5 -----
 sound/usb/quirks.c   | 6 ++++++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/sound/usb/implicit.c b/sound/usb/implicit.c
index 1fd087128538..e1bf1b5da423 100644
--- a/sound/usb/implicit.c
+++ b/sound/usb/implicit.c
@@ -45,11 +45,6 @@ struct snd_usb_implicit_fb_match {
 
 /* Implicit feedback quirk table for playback */
 static const struct snd_usb_implicit_fb_match playback_implicit_fb_quirks[] = {
-	/* Generic matching */
-	IMPLICIT_FB_GENERIC_DEV(0x0499, 0x1509), /* Steinberg UR22 */
-	IMPLICIT_FB_GENERIC_DEV(0x0763, 0x2030), /* M-Audio Fast Track C400 */
-	IMPLICIT_FB_GENERIC_DEV(0x0763, 0x2031), /* M-Audio Fast Track C600 */
-
 	/* Fixed EP */
 	/* FIXME: check the availability of generic matching */
 	IMPLICIT_FB_FIXED_DEV(0x0763, 0x2080, 0x81, 2), /* M-Audio FastTrack Ultra */
diff --git a/sound/usb/quirks.c b/sound/usb/quirks.c
index ab9f3da49941..5461cdf907e2 100644
--- a/sound/usb/quirks.c
+++ b/sound/usb/quirks.c
@@ -1793,6 +1793,8 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x046d, 0x09a4, /* Logitech QuickCam E 3500 */
 		   QUIRK_FLAG_CTL_MSG_DELAY_1M | QUIRK_FLAG_IGNORE_CTL_ERROR),
+	DEVICE_FLG(0x0499, 0x1509, /* Steinberg UR22 */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x04d8, 0xfeea, /* Benchmark DAC1 Pre */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
 	DEVICE_FLG(0x04e8, 0xa051, /* Samsung USBC Headset (AKG) */
@@ -1824,6 +1826,10 @@ static const struct usb_audio_quirk_flags_table quirk_flags_table[] = {
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x074d, 0x3553, /* Outlaw RR2150 (Micronas UAC3553B) */
 		   QUIRK_FLAG_GET_SAMPLE_RATE),
+	DEVICE_FLG(0x0763, 0x2030, /* M-Audio Fast Track C400 */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
+	DEVICE_FLG(0x0763, 0x2031, /* M-Audio Fast Track C600 */
+		   QUIRK_FLAG_GENERIC_IMPLICIT_FB),
 	DEVICE_FLG(0x08bb, 0x2702, /* LineX FM Transmitter */
 		   QUIRK_FLAG_IGNORE_CTL_ERROR),
 	DEVICE_FLG(0x0951, 0x16ad, /* Kingston HyperX */
-- 
2.31.1

