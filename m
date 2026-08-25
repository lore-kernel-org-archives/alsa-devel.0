Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D599EC61DBD
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:18:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5EB03602C3;
	Tue, 25 Aug 2026 13:18:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5EB03602C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787656699;
	bh=1rGcIZc6xyJ10BN4yD1jgVoi+DZUD/QP5PKu48fGIKA=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=sZVMtAzVJiLgUxNHt7U2bi1H4gyeBJUe5dMOgZtbVcSnqSAhDPvyTx445dYwzBIDW
	 aeHGf3IjQyWt8tRZWlDdg/Lfroh66drkA4X/ljAYMejqIkorawijpGFvBj3urV1LJB
	 7JCZI3Mqm4Q1rsMEiYPVlIILzdh/EJhnWBzCEvaE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 09029F8060C; Tue, 25 Aug 2026 13:17:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 74EECF8060C;
	Tue, 25 Aug 2026 13:17:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12179F8027B; Tue, 25 Aug 2026 10:41:39 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.208.49
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787647297;
	b=mPcz1Fm9jdo5yt18nfbeJ6slYKWRGhCfGPoJfE80m2ncmvM+PlAVOcsN6YP0UT6jwL3o
	 EPXLekFe6buBh3ISqV6zZsJbv7Z1Ea9+bAIfF3twCmOJjSEGBk2J79N9QnqF+LNdFYE5T
	 cIu2MSQ36DlRJzpL17QBiBXw5kBajWy0lNgMc92ieE3sWcE1Ji2Meti6g2QfT/x+ezM40
	 AmIKy3RnS5q2TvYkLuOv/9xAvNECiQ1W3cGEPap0sO5uICz1q5GBmhmhhh5BFSUTXj0ro
	 LiyG874f8z5Tv3FX+dI8naTbBz+SYreyuIVtVnoJ6vd0NJ5gmc3yWeHPOABNFMfOVNQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787647297;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=1rGcIZc6xyJ10BN4yD1jgVoi+DZUD/QP5PKu48fGIKA=;
	b=a+qy/RcTH5xA3CMLh6udDh3OjRXAWSWSmkAKJNw/7/DP7eIQguTLNs+0Qkralu7FUJPu
	 EsCLC7NEidAwUK+k+M+kzQZ/KmZqwjAWXrtukmJIxUYRq5yNBQmL5YQJCDkO678v9ZWzD
	 CvmTyWX3S3dzcFZyCbRvnuOGYbGcMiWXXZqDvRYnCgpzrtJYYikgR+IfFQCqbWS3B3awU
	 o3D0fEpE7X+u7U0x3L0phQ5pv+njr0l5MNZv9h9b9u1O8+DM6UMkVge8ZvkjmopsMRnBv
	 LCJ4UiO3gdLZjPeEkpkoS+HZo2c5yjh9vMhZzuLxtryBgXrMr4PX8YY0BrpOTgrnUng==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=caZx8fTs;
	arc=none smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9C2CAF80027
	for <alsa-devel@alsa-project.org>; Tue, 25 Aug 2026 10:41:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9C2CAF80027
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=caZx8fTs
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-6a1542cdb53so5443161a12.2
        for <alsa-devel@alsa-project.org>;
 Tue, 25 Aug 2026 01:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787647295; x=1788252095;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/rqGdLhMu9krZRKREk51+4+n08MuVi1R0FDvTEzZocw=;
        b=caZx8fTsVpsTJFc7oth6EzdmFPLSX+B2ai0Uz0H6hHgWvUYI3+QkBWDZmQUERaXxgJ
         WVIrG2pa1BQojhbZTh2zw0uEywnNC6ds6eeL3rqDmB9s6bVJQsoSKUGy+x/riHvpJMtD
         RXteuioJFcxQX1q9pRJGv8n3HZuhwNXsMFxNO8y4H8vSrqoXKLflWqQYtZiYlKQj3YgJ
         aIuwMhcNNRYLNFRI/Fl5dsSyaDNlOnGqF2akbUB0J9QMBw8riMCAhCpKaaZcu1GGWGUw
         8mysvV28Ljku/ESpXXcBs3Yte9FEsGRZiao/2VwHlaO+3NdBw9A04NCyVQam+Z7N6brA
         JSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787647295; x=1788252095;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/rqGdLhMu9krZRKREk51+4+n08MuVi1R0FDvTEzZocw=;
        b=p/Bxo0ZLNvblYC+wB4u3e/Jlz3dFMaAp4D2uQusNgWCnwRy/lqdiw5rhCWPEAdOfe8
         zuwCTqDE/vui7SRDMu/LU6vZnrno01FJ1IXiDBi5OSv3BxoV68NU/PcG5A1eKvLPT5f4
         uVJbRRXfGtpFGWGzfBzN4jHP2p/OEVCJCQ5/A+a3JhrKUKeMi63MDbEEOzgAtMjAvng9
         9C3OrXCfTFg5eeCPKLmixe2uSRlEgh1FlLYEQJHegafyeufn9Ad6Cxvk8pwQXBS0B5Qz
         6r9rbBcy79REEe1sVMBHBmwa22yhoA4RQwjVQYj1KlG7lrWE1fzMX0MnVO8/Sr8ELfaG
         oCkg==
X-Gm-Message-State: AFuF++kKiYn5NY2nZ8t9HXz0uUHQnNAmXh1HwD/1yCpiJmF4OBHxMkvm
	rQ7iB0IHP6fQeZDLmUqyEGCKlOgDYxEpO879YMJSyaXp4NomMpcc9N8=
X-Gm-Gg: AR+sD13BFsulcvXOIwBPymDxGrQMoFV7Ba8Dx1bpJemaxIWnGXdLoBCKBcLS3fENd+u
	4jLDM6Iq+JreSmn7/ael8VfDp5Y8/ml+IaSyj9DObQbHfy10AbF6iV8ISOqtQedDJdWb/beR4PO
	XyaqrmMUNLZMJIAqfrFRUeG8AWCQDmDaERRovtE66xqL7wI8V0xitrWd/q7YwNrllJbyUf+I9H+
	QO6CcW7HN5l11R7vDUkuP633gIS7dDOjpOoK3OIbwUkWfat/HBJQbhymi/WGQG0VTV0W1a3bqNG
	fsCf5WXbHloUVVEePDtkA+q/Ke8kGzis6QWCCPhGtduLrfdCfq2CJ4MLAJJ3hJHhu7jig6+A7TY
	++FwzRR7lJ7QjDb1VgFXvAdhrQbAVL2vg5eo7QHX/C9KtZ9kQmwa8FSw03dXwqZhrdatm2/lKmR
	xQ3OmV1HFHiI3kyxdeN+Wx/q6ADvB8KSFG21pEqppweuNNu3/TRmdpAR4inJGyT0JWELrgKcVO3
	T2lH8PpdA==
X-Received: by 2002:a17:906:f5a8:b0:c21:450d:cd7e with SMTP id
 a640c23a62f3a-c24925dbc76mr2418611366b.9.1787647295025;
        Tue, 25 Aug 2026 01:41:35 -0700 (PDT)
Received: from localhost.localdomain ([31.223.84.133])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24962bbea6sm1567513466b.27.2026.08.25.01.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 01:41:34 -0700 (PDT)
From: "=?UTF-8?q?Habil=20Eren=20T=C3=BCrker?=" <habilerenturker@gmail.com>
X-Google-Original-From: =?UTF-8?q?Habil=20Eren=20T=C3=BCrker?=
 <habilerenturker@hotmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?Habil=20Eren=20T=C3=BCrker?= <habilerenturker@hotmail.com>
Subject: [PATCH] ALSA: hda/realtek: Fix speaker mute LED for HP Laptop
 15-fd0039nt
Date: Tue, 25 Aug 2026 11:40:14 +0300
Message-ID: <20260825084125.4103-1-habilerenturker@hotmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: habilerenturker@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: DGLUID5FQMBB74DR7AOLPZWQBNMJ4KEJ
X-Message-ID-Hash: DGLUID5FQMBB74DR7AOLPZWQBNMJ4KEJ
X-Mailman-Approved-At: Tue, 25 Aug 2026 11:17:22 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DGLUID5FQMBB74DR7AOLPZWQBNMJ4KEJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

HP Laptop 15-fd0039nt (SSID 103c:8bb6) needs a quirk to control the
speaker mute LED via VREF100 on NID 0x1a (active-high).

This patch replaces the previous ALC236_FIXUP_HP_MICMUTE_LED_ONLY
with ALC236_FIXUP_HP_15_FD0XXX, which covers both mic mute (GPIO0)
and speaker mute (NID 0x1a) LEDs.

Use spec->no_shutup_pins instead of a custom shutup hook, as suggested
by Takashi Iwai.

Fixes: e711ebfadc9a ("ALSA: hda/realtek: Add quirk for HP Laptop 15-fd0039nt")
Tested-by: Habil Eren Türker <habilerenturker@hotmail.com>
Signed-off-by: Habil Eren Türker <habilerenturker@hotmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 61 +++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 8 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 01b87267f..ec7b9ee67 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -1364,14 +1364,59 @@ static void alc269_fixup_hp_gpio_led(struct hda_codec *codec,
 	alc_fixup_hp_gpio_led(codec, action, 0x08, 0x10);
 }
 
-static void alc236_fixup_hp_micmute_led_only(struct hda_codec *codec,
-				const struct hda_fixup *fix, int action)
+/*
+ * HP Laptop 15-fd0xxx (SSID 103c:8bb6) Speaker Mute LED fix
+ *
+ * The speaker mute LED is controlled via VREF100 on NID 0x1a.
+ * This pin must remain powered (D0) even during suspend, otherwise
+ * the LED state is lost and the pin defaults to Hi-Z on resume,
+ * causing the LED to stop responding to mute toggles.
+ * Windows keeps this pin powered unconditionally, so matching that
+ * behavior ensures consistent LED operation across suspend/resume.
+ * The mic-mute LED is controlled via GPIO 0 with active-low polarity.
+ */
+static unsigned int hp_8bb6_power_filter(struct hda_codec *codec,
+					 hda_nid_t nid,
+					 unsigned int power_state)
+{
+	if (nid == 0x1a)
+		return AC_PWRST_D0;
+	return snd_hda_gen_path_power_filter(codec, nid, power_state);
+}
+
+static int hp_8bb6_speaker_mute_led_set(struct led_classdev *led_cdev,
+					enum led_brightness brightness)
+{
+	struct hda_codec *codec = dev_to_hda_codec(led_cdev->dev->parent);
+	unsigned int val = (brightness == LED_OFF) ? PIN_IN : PIN_VREF100;
+
+	snd_hda_set_pin_ctl_cache(codec, 0x1a, val);
+	return 0;
+}
+
+static void alc236_fixup_hp_15_fd0xxx(struct hda_codec *codec,
+				      const struct hda_fixup *fix,
+				      int action)
 {
 	struct alc_spec *spec = codec->spec;
 
-	if (action == HDA_FIXUP_ACT_PRE_PROBE)
+	switch (action) {
+	case HDA_FIXUP_ACT_PRE_PROBE:
 		spec->micmute_led_polarity = 1;
-	alc_fixup_hp_gpio_led(codec, action, 0x00, 0x01);
+		alc_fixup_hp_gpio_led(codec, action, 0x00, 0x01);
+
+		spec->mute_led_polarity = 0;
+		snd_hda_gen_add_mute_led_cdev(codec, hp_8bb6_speaker_mute_led_set);
+
+		codec->power_filter = hp_8bb6_power_filter;
+		spec->no_shutup_pins = 1;
+		break;
+
+	case HDA_FIXUP_ACT_INIT:
+		if (spec->gen.vmaster_mute.hook)
+			snd_hda_sync_vmaster_hook(&spec->gen.vmaster_mute);
+		break;
+	}
 }
 
 static void alc285_fixup_hp_gpio_led(struct hda_codec *codec,
@@ -4096,7 +4141,7 @@ enum {
 	ALC236_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
-	ALC236_FIXUP_HP_MICMUTE_LED_ONLY,
+	ALC236_FIXUP_HP_15_FD0XXX,
 	ALC236_FIXUP_LENOVO_INV_DMIC,
 	ALC298_FIXUP_SAMSUNG_AMP,
 	ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS,
@@ -5839,9 +5884,9 @@ static const struct hda_fixup alc269_fixups[] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc236_fixup_hp_mute_led_micmute_gpio,
 	},
-	[ALC236_FIXUP_HP_MICMUTE_LED_ONLY] = {
+	[ALC236_FIXUP_HP_15_FD0XXX] = {
 		.type = HDA_FIXUP_FUNC,
-		.v.func = alc236_fixup_hp_micmute_led_only,
+		.v.func = alc236_fixup_hp_15_fd0xxx,
 	},
 	[ALC236_FIXUP_LENOVO_INV_DMIC] = {
 		.type = HDA_FIXUP_FUNC,
@@ -7345,7 +7390,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8bb3, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bb4, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
-	SND_PCI_QUIRK(0x103c, 0x8bb6, "HP Laptop 15-fd0039nt", ALC236_FIXUP_HP_MICMUTE_LED_ONLY),
+	SND_PCI_QUIRK(0x103c, 0x8bb6, "HP Laptop 15-fd0039nt", ALC236_FIXUP_HP_15_FD0XXX),
 	SND_PCI_QUIRK(0x103c, 0x8bbe, "HP Victus 16-r0xxx (MB 8BBE)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
-- 
2.47.3

