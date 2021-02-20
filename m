Return-Path: <SRS0=SdgV=HW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2420EC433E0
	for <alsa-devel@archiver.kernel.org>; Sat, 20 Feb 2021 12:45:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7546864EDE
	for <alsa-devel@archiver.kernel.org>; Sat, 20 Feb 2021 12:45:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7546864EDE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 32CEB1664;
	Sat, 20 Feb 2021 13:44:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 32CEB1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613825123;
	bh=5+2pw62hQACiqK42pB6ovgTDColB6bOq0QhejsYMJco=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lrnmuC1gZV8MMbb6+EPcnYdxhnHARHJuyj7777rYelHN3baU6LI40ZKmah4t/tQEf
	 v3QCLUJ9vy0wj4vBtMbeQyDWX8mCLNXO451MlFuSqOgtAIn3jIPt/IXjlJ2eJ/4yni
	 18Tgj6per0Cb9+vfFNEKjkw7SonP5EgbHS2U6FAo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A4AA4F80157;
	Sat, 20 Feb 2021 13:44:32 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F0561F8015A; Sat, 20 Feb 2021 13:44:30 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BDE0FF80152
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2021 13:44:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BDE0FF80152
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.b="OJmKx/oV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613825062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=NGCoXmLsNypwd4eOy8IYMqT34aEwVcCuKoDWcemQv1E=;
 b=OJmKx/oVB29IihJ3uj8B8sjMStJdURqVCEkXRrBxGAWc+BfGyqCsMrop0FhaCVSIs2Nvbc
 nha90UyMTfhJWvZXf2NwhyPwxk7UrSpxYQ7/bCP4PM474fiF2cFM0Fsn3jzyMRhiTF1Zuj
 CDYgOSX8WUMFqp+tEd3dA9jwTXbpgkk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-525-M68dyUHHMomh3oUFMMHYaw-1; Sat, 20 Feb 2021 07:44:18 -0500
X-MC-Unique: M68dyUHHMomh3oUFMMHYaw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8357880364B;
 Sat, 20 Feb 2021 12:44:16 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-29.ams2.redhat.com [10.36.112.29])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BB35319709;
 Sat, 20 Feb 2021 12:44:14 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: Pavel Machek <pavel@ucw.cz>,
	Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] leds: trigger: audio: Add an activate callback to ensure the
 initial brightness is set
Date: Sat, 20 Feb 2021 13:44:13 +0100
Message-Id: <20210220124413.23460-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Takashi Iwai <tiwai@suse.de>, Hans de Goede <hdegoede@redhat.com>,
 alsa-devel@alsa-project.org, linux-leds@vger.kernel.org
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

Some 2-in-1s with a detachable (USB) keyboard(dock) have mute-LEDs in
the speaker- and/or mic-mute keys on the keyboard.

Examples of this are the Lenovo Thinkpad10 tablet (with its USB kbd-dock)
and the HP x2 10 series.

The detachable nature of these keyboards means that the keyboard and
thus the mute LEDs may show up after the user (or userspace restoring
old mixer settings) has muted the speaker and/or mic.

Current LED-class devices with a default_trigger of "audio-mute" or
"audio-micmute" initialize the brightness member of led_classdev with
ledtrig_audio_get() before registering the LED.

This makes the software state after attaching the keyboard match the
actual audio mute state, e.g. cat /sys/class/leds/foo/brightness will
show the right value.

But before this commit nothing was actually calling the led_classdev's
brightness_set[_blocking] callback so the value returned by
ledtrig_audio_get() was never actually being send to the hw, leading
to the mute LEDs staying in their default power-on state, after
attaching the keyboard, even if ledtrig_audio_get() returns a different
state.

This could be fixed by having the individual LED drivers call
brightness_set[_blocking] themselves after registering the LED,
but this really is something which should be done by a led-trigger
activate callback.

Add an activate callback for this, fixing the issue of the
mute LEDs being out of sync after (re)attaching the keyboard.

Cc: Takashi Iwai <tiwai@suse.de>
Fixes: faa2541f5b1a ("leds: trigger: Introduce audio mute LED trigger")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/leds/trigger/ledtrig-audio.c | 37 ++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/leds/trigger/ledtrig-audio.c b/drivers/leds/trigger/ledtrig-audio.c
index f76621e88482..c6b437e6369b 100644
--- a/drivers/leds/trigger/ledtrig-audio.c
+++ b/drivers/leds/trigger/ledtrig-audio.c
@@ -6,10 +6,33 @@
 #include <linux/kernel.h>
 #include <linux/leds.h>
 #include <linux/module.h>
+#include "../leds.h"
 
-static struct led_trigger *ledtrig_audio[NUM_AUDIO_LEDS];
 static enum led_brightness audio_state[NUM_AUDIO_LEDS];
 
+static int ledtrig_audio_mute_activate(struct led_classdev *led_cdev)
+{
+	led_set_brightness_nosleep(led_cdev, audio_state[LED_AUDIO_MUTE]);
+	return 0;
+}
+
+static int ledtrig_audio_micmute_activate(struct led_classdev *led_cdev)
+{
+	led_set_brightness_nosleep(led_cdev, audio_state[LED_AUDIO_MICMUTE]);
+	return 0;
+}
+
+static struct led_trigger ledtrig_audio[NUM_AUDIO_LEDS] = {
+	[LED_AUDIO_MUTE] = {
+		.name     = "audio-mute",
+		.activate = ledtrig_audio_mute_activate,
+	},
+	[LED_AUDIO_MICMUTE] = {
+		.name     = "audio-micmute",
+		.activate = ledtrig_audio_micmute_activate,
+	},
+};
+
 enum led_brightness ledtrig_audio_get(enum led_audio type)
 {
 	return audio_state[type];
@@ -19,24 +42,22 @@ EXPORT_SYMBOL_GPL(ledtrig_audio_get);
 void ledtrig_audio_set(enum led_audio type, enum led_brightness state)
 {
 	audio_state[type] = state;
-	led_trigger_event(ledtrig_audio[type], state);
+	led_trigger_event(&ledtrig_audio[type], state);
 }
 EXPORT_SYMBOL_GPL(ledtrig_audio_set);
 
 static int __init ledtrig_audio_init(void)
 {
-	led_trigger_register_simple("audio-mute",
-				    &ledtrig_audio[LED_AUDIO_MUTE]);
-	led_trigger_register_simple("audio-micmute",
-				    &ledtrig_audio[LED_AUDIO_MICMUTE]);
+	led_trigger_register(&ledtrig_audio[LED_AUDIO_MUTE]);
+	led_trigger_register(&ledtrig_audio[LED_AUDIO_MICMUTE]);
 	return 0;
 }
 module_init(ledtrig_audio_init);
 
 static void __exit ledtrig_audio_exit(void)
 {
-	led_trigger_unregister_simple(ledtrig_audio[LED_AUDIO_MUTE]);
-	led_trigger_unregister_simple(ledtrig_audio[LED_AUDIO_MICMUTE]);
+	led_trigger_unregister(&ledtrig_audio[LED_AUDIO_MUTE]);
+	led_trigger_unregister(&ledtrig_audio[LED_AUDIO_MICMUTE]);
 }
 module_exit(ledtrig_audio_exit);
 
-- 
2.30.1

