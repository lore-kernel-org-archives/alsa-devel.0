Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A410C5DF94
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:46:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A08E360279;
	Mon, 24 Aug 2026 13:45:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A08E360279
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787571961;
	bh=j2tRYJFNt8KENcj9zWM8AfvTA6H5fHi3uhQAXY2/ZWo=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=BqYgRrdFtbj/h2ZdP/qs00v9PKaG82rzEdIQnv+P9+2R/KZMl5OTN98tVSMDFWOEE
	 CxEAqlFjJSsk0vSqi9MEh046A7OLWOI+WdxFQ+4+v1gscoTnoaZW+OnVPfVGrK+xEO
	 CUimm9EfMFZDB+In1pNSoLe16A5myvWWEbPmTqXk=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9EBA1F80601; Mon, 24 Aug 2026 13:45:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2A20FF80600;
	Mon, 24 Aug 2026 13:45:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 50A46F8051D; Fri, 21 Aug 2026 22:57:33 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787345851;
	b=kzTmaLX0u2nfc2seMZTtpRe5n5AJH2wcYEp8T4noVKGAgROsJmgGb/r7/87Bu1A0t0JW
	 Xg18PCUCzaSolKUHQdTAVuQ/GSAh+Wd3BpbyyiRaBFwQepYg8k99tPwufHD6We6cbQTFI
	 P9/Jza3zM7vx+wgetMducVZ4F3W0UbJtw0tnMXTC8jBlCdnMCzlZwDsPF8ydubgzYunmx
	 Qt0CBBc8mw+0XGqiVBKATikmwwyvml5Gz2GKuyv0xrG3Hvqt+SFI5GuoeaNv/LG78jx9A
	 fdrqbR2w5/LVLzAnzDyf8ldge4g0iTNmeoPs68tjkOEuFwScze5dodplQpkl4j4/Kmg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787345851;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=j2tRYJFNt8KENcj9zWM8AfvTA6H5fHi3uhQAXY2/ZWo=;
	b=VRktrpewx+jiSA1O9X9dZJLo5wBjG1VAnfeAspQq8PTu6Q8EJ10aQPNFkozJLaFmbuyS
	 5TEux/JykQ3aQusgXCwjFh+NHRtWqIzUc77KP6jbUGlYP7ey9JrbIipspXlWjkF5Nk3vT
	 rYYwyWKwB4+XWDP+tAIYVbsHiWP7Vr/QwjhZDWHRF4J7YbRZMDrCyAdncN0Y1G+qyaNrl
	 2HeMHaaUwAOXDV3QeIzVSnf8QiKdm9CSRKzDVMHTUtU9nNOZQrfks5k050ULhpxEekzQZ
	 W+VQ81Jpr4w7zU6KiFN44SA8KJM6PyCYSPwPQBxSNeCjc/bApBUPXMwkuiHXPldghpg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jZXt1s8B;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A82D7F800BA
	for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2026 22:57:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A82D7F800BA
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=jZXt1s8B
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so238497166b.1
        for <alsa-devel@alsa-project.org>;
 Fri, 21 Aug 2026 13:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787345849; x=1787950649;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O0r0GmHxCfTRKvUuN/ynVPBuwVgWoS2Jnuin21tATSk=;
        b=jZXt1s8BMIDZx6AUYdBxd00P091K/ilvD0zWeVWGL0g8uxZuO8us2QSrWwI2tsmbd8
         6VtpCMraFE1iS2+7ehFVITt/IfP1M7AtHSi62i7BuRCT0uws93tsVYMhC2B4/yzYKdai
         oy9rbpJ/57NL/6aJVceZwR3kgBgJq1hXvbmlgRLAAyazYOi3zQ3sxmML+VxeL918e9Wy
         l4g7tdhs5S90CoPHwrkgD27bCg8tZmOQg91pXUo48RY36hUXxtjGoSfQCliUL90i0KF/
         Ey4Ccr2iSXYWuI6Die6U+JpudWsDvZ0py38MPd7ejbX6dobcP6GmQwyzlKMIX0vDa+xp
         lgRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787345849; x=1787950649;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=O0r0GmHxCfTRKvUuN/ynVPBuwVgWoS2Jnuin21tATSk=;
        b=H98TX1CXtImE20AF3P89waCmaxk/3Qpj31Yf4YO0AOzqhAIxhw6mW2sES1Je0Lm0my
         PcPogpUEKRv1pwBaoTU0BbJjZAQNu24l61dMCpyECzBrgadYwO4eUT/8H6Uxqagco69v
         rdIdRyQVT1JUV6dJxmQbbqJZauyIdfnZlqMgdJZemAWm8SZWU9g7RocuuAkAgOjvVNYH
         nwlJCw/vqowjRJUyghAMZQ90jKKF2hCLH2RiTxw1h8yFXdzdo/b4clieKKAfhR/qUBP2
         AZuJtLiZ9KNDkIfioZ8AldrSAtgNeuEDwLusNMKs7ljSOVWJcP1zhy8zKD/M4D0uqcq8
         5KMQ==
X-Gm-Message-State: AFuF++kFyFskzJSprbDM7FdL3DGqQjXAqPkGxLFZzuyE6gTjxv9QwHES
	Im27NgkhxRd7GJ9PvLC9J7S7JCa+e+zxx63F6oIyyjc+MvVvNY7TyKw=
X-Gm-Gg: AR+sD11MGdTHSTe3p565qMWXdWME7ke8fwQgR4BjHHlp1+FEDXDSTHQ0RWCLV0ni0gC
	XOehMHJLv9uu0PgOG7jW38qNcwWNzw8NGnJuktnVEDjmFyCjDyZL1885NqHdZ3QLYvjJXeAFsnf
	9tO3FnZuQ8ACA15Ppe3/m8zc+7anbNSSyjUR2I9rd3s7ug0+/4wNd8A+SzHvR93gYBq7C3HGLAZ
	KK3diCt9hHxqA5p6R6XdIWk++jzP/gYWk2xK0ejGsEE4piqba8vO5pYyLd09U9/vuEeZpiJ6gpm
	kEX8LCP5aJk2dqV9Wa/HalkJVkVLoPjRO/TaJOwh8Xb+RboBtdZ3HlXdfdc2WxyLSY9KfAwk5QH
	K2SyF+vbNUvIvi9F1dqa+CKWTKVO0V3w22lGQYPBNpQFhCM/mFu0DslfjJZjOv2ODGQBrFMrrgm
	o8uJQN6rsQcM6t2RvtB/aPZsmUli3HzUx0ClErWMTdvEys8djgGFjKx7qH+AL9F9MaW8TDYxoE5
	WH1GIZHew==
X-Received: by 2002:a17:907:3e9a:b0:c15:e118:9b99 with SMTP id
 a640c23a62f3a-c246a6a3e6cmr934111166b.23.1787345849337;
        Fri, 21 Aug 2026 13:57:29 -0700 (PDT)
Received: from localhost.localdomain ([31.223.84.205])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2495ee5295sm2393366b.0.2026.08.21.13.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 13:57:28 -0700 (PDT)
From: "=?UTF-8?q?Habil=20Eren=20T=C3=BCrker?=" <habilerenturker@gmail.com>
X-Google-Original-From: =?UTF-8?q?Habil=20Eren=20T=C3=BCrker?=
 <habilerenturker@hotmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	=?UTF-8?q?Habil=20Eren=20T=C3=BCrker?= <habilerenturker@hotmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP Laptop 15-fd0039nt
 speaker mute LED
Date: Fri, 21 Aug 2026 23:57:06 +0300
Message-ID: <20260821205717.3219-1-habilerenturker@hotmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: habilerenturker@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: 65KHM77X6UZQSCB64EVV4VAKGFHQLGLP
X-Message-ID-Hash: 65KHM77X6UZQSCB64EVV4VAKGFHQLGLP
X-Mailman-Approved-At: Mon, 24 Aug 2026 11:45:21 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/65KHM77X6UZQSCB64EVV4VAKGFHQLGLP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

HP Laptop 15-fd0039nt (SSID 103c:8bb6) has a speaker mute LED that is
controlled via VREF100 on NID 0x1a. Unlike standard implementations, this
device requires PIN_VREF100 (0x24) to turn the LED on and PIN_IN (0x20)
to turn it off, with active-high polarity.

The existing ALC236_FIXUP_HP_MICMUTE_LED_ONLY quirk only handles the
microphone mute LED, so this patch adds a new fixup
ALC236_FIXUP_HP_15_FD0XXX that covers both:
- Mic mute LED via GPIO0 (active-low)
- Speaker mute LED via NID 0x1a VREF100

The patch also adds a custom power_filter to ensure the pin remains
powered during suspend, and a shutdown hook to restore the pin state.

Tested-by: Habil Eren Türker <habilerenturker@hotmail.com>
Signed-off-by: Habil Eren Türker <habilerenturker@hotmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 59 ++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 9 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 01b87267f..d19935be3 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -1364,16 +1364,57 @@ static void alc269_fixup_hp_gpio_led(struct hda_codec *codec,
 	alc_fixup_hp_gpio_led(codec, action, 0x08, 0x10);
 }
 
-static void alc236_fixup_hp_micmute_led_only(struct hda_codec *codec,
-				const struct hda_fixup *fix, int action)
+/* Patch for HP 15-fd0xxx (8BB6) Speaker Mute LED & Mic-Mute LED */
+
+static void hp_8bb6_shutup(struct hda_codec *codec)
+{
+	snd_hda_shutup_pins(codec);
+	snd_hda_set_pin_ctl(codec, 0x1a,
+			   snd_hda_codec_get_pin_target(codec, 0x1a));
+}
+
+static unsigned int hp_8bb6_power_filter(struct hda_codec *codec,
+					  hda_nid_t nid,
+					  unsigned int power_state)
+{
+	if (nid == 0x1a)
+		return AC_PWRST_D0;
+	return snd_hda_gen_path_power_filter(codec, nid, power_state);
+}
+
+static int hp_8bb6_speaker_mute_led_set(struct led_classdev *led_cdev,
+					 enum led_brightness brightness)
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
-}
+		alc_fixup_hp_gpio_led(codec, action, 0x00, 0x01);
+		spec->mute_led_polarity = 0;
+		snd_hda_gen_add_mute_led_cdev(codec, hp_8bb6_speaker_mute_led_set);
+		codec->power_filter = hp_8bb6_power_filter;
+		codec->power_save_node = 0;
+		spec->shutup = hp_8bb6_shutup;
+		break;
 
+	case HDA_FIXUP_ACT_INIT:
+		if (spec->gen.vmaster_mute.hook)
+			snd_hda_sync_vmaster_hook(&spec->gen.vmaster_mute);
+		break;
+	}
+}
 static void alc285_fixup_hp_gpio_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -4096,7 +4137,7 @@ enum {
 	ALC236_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
-	ALC236_FIXUP_HP_MICMUTE_LED_ONLY,
+	ALC236_FIXUP_HP_15_FD0XXX,
 	ALC236_FIXUP_LENOVO_INV_DMIC,
 	ALC298_FIXUP_SAMSUNG_AMP,
 	ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS,
@@ -5839,9 +5880,9 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -7345,7 +7386,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
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

