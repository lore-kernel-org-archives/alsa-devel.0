Return-Path: <SRS0=r+qN=77=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30501C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:10:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A816A206D7
	for <alsa-devel@archiver.kernel.org>; Thu, 18 Jun 2020 11:10:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="a17qTctK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A816A206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40DB7176B;
	Thu, 18 Jun 2020 13:09:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40DB7176B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592478613;
	bh=zKzj65w/qs2nuUjY2WJmWegnQMDKvzmXAEg7xGFiWcQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=a17qTctKk8+0WknpdhPRgRiwFi6u04U3tXqOoyKTzYUD8OBnj6NUwopwt1ZFWheOa
	 AE3/Rde7T2i2WkM/2G5wMO9HWC7DDI2vElJxAgobUstosBPe9FcyVMlsHEIBcc+wYj
	 s394iJ87GUP5fI9BdDj1VzR1RuuUH0Ny95kvkwvc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 728E9F802A2;
	Thu, 18 Jun 2020 13:09:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ACC03F8029B; Thu, 18 Jun 2020 13:08:57 +0200 (CEST)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21AD6F80162
 for <alsa-devel@alsa-project.org>; Thu, 18 Jun 2020 13:08:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21AD6F80162
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 71299AD41;
 Thu, 18 Jun 2020 11:08:49 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 01/13] ALSA: hda: generic: Always call led-trigger for mic
 mute LED
Date: Thu, 18 Jun 2020 13:08:30 +0200
Message-Id: <20200618110842.27238-2-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200618110842.27238-1-tiwai@suse.de>
References: <20200618110842.27238-1-tiwai@suse.de>
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

Instead of adding a special hook to trigger the mic-mute LED device,
call it always from the common callback function.  It won't hurt even
if no corresponding led cdev is present.

This is basically a preliminary change for the later patches to
convert the all mic-mute LED handling to LED class cdev.

Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_generic.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index f4e9d9445e18..c95ccffbd0cf 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3923,6 +3923,10 @@ static void call_micmute_led_update(struct hda_codec *codec)
 	spec->micmute_led.led_value = val;
 	if (spec->micmute_led.update)
 		spec->micmute_led.update(codec);
+#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
+	ledtrig_audio_set(LED_AUDIO_MICMUTE,
+			  spec->micmute_led.led_value ? LED_ON : LED_OFF);
+#endif
 }
 
 static void update_micmute_led(struct hda_codec *codec,
@@ -4023,16 +4027,6 @@ int snd_hda_gen_add_micmute_led(struct hda_codec *codec,
 }
 EXPORT_SYMBOL_GPL(snd_hda_gen_add_micmute_led);
 
-#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
-static void call_ledtrig_micmute(struct hda_codec *codec)
-{
-	struct hda_gen_spec *spec = codec->spec;
-
-	ledtrig_audio_set(LED_AUDIO_MICMUTE,
-			  spec->micmute_led.led_value ? LED_ON : LED_OFF);
-}
-#endif
-
 /**
  * snd_hda_gen_fixup_micmute_led - A fixup for mic-mute LED trigger
  *
@@ -4051,10 +4045,8 @@ static void call_ledtrig_micmute(struct hda_codec *codec)
 void snd_hda_gen_fixup_micmute_led(struct hda_codec *codec,
 				   const struct hda_fixup *fix, int action)
 {
-#if IS_REACHABLE(CONFIG_LEDS_TRIGGER_AUDIO)
 	if (action == HDA_FIXUP_ACT_PROBE)
-		snd_hda_gen_add_micmute_led(codec, call_ledtrig_micmute);
-#endif
+		snd_hda_gen_add_micmute_led(codec, NULL);
 }
 EXPORT_SYMBOL_GPL(snd_hda_gen_fixup_micmute_led);
 
-- 
2.16.4

