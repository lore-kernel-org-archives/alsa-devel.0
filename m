Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7B9C54F54
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2026 07:27:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 73D386021C;
	Fri, 31 Jul 2026 09:27:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 73D386021C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1785482849;
	bh=k+d4i9pRDlK17XALsLYuMMij5elx4Vzh4xdHOoVjquw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=nKLZwYtMnLyS5sZJem3oH1efnddyrpirwjYrrR5frFOZX963U/feUYLjqJ9uQoqLn
	 C+HyrMNMbKnS0f14bP7ZPx/9oSxz9+0pm9OYKMoZORlYeAQ8+OOCSGW92aMuA0VMKB
	 khdohqQUsbiqcws46L1srVB6uTEZv0kYvMxMQ0bM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3F89AF80639; Fri, 31 Jul 2026 09:26:26 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9C260F80656;
	Fri, 31 Jul 2026 09:26:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F433F80496; Thu, 30 Jul 2026 09:15:28 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1785395727;
	b=WbQtZ5FfnAA6jlPNS/AYmj3gyDxndxAmVoJm1ZyobGENYzIvgwpi2pwoe6WcZMczjaMX
	 //QjPoXIZTbcxLKd4tRA3RX8GQ7G8kwExXJShBp9kBVYjijOAG9bzyEDhJmvIojz8hrn4
	 zFLSzZ5ku1CbgwJTOFXUdZ94FKtLbdTciZp8tLNRStSQT42sovDBjop5Lhs1hP7G7ALLa
	 IgJkvz+rv5Et1Vksmk0vRjWAeIo7z8fQaQbgkmmmKJ9HWFmwPSt4nbCvpvbxJm8RTPUm3
	 45RuTwFOeT2UedZx/Zm7h1HZkEdlSc+toBYD0ob2qNtMtwIQqg9J0hCJJnJGoMIYZTA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1785395727;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=k+d4i9pRDlK17XALsLYuMMij5elx4Vzh4xdHOoVjquw=;
	b=RccDDXFxZJTqSgZoxqvdU/EAAdF5nwU2HRZP5V5xRBiq52egMK5rBxOWaeQw9Ra9i7Hz
	 p1lgXQuEXF+VDb0e8wnVi91kjDM2gDaFRDzzkHrJhi0dskOPVhlhrfB6RqrCDkhEjplvX
	 4Ep6XmhjIpL3DjLrd257ksSTo0Vi++QWrt/+4Vxvh7vJerVx8TijFrX7Bm16EN7IlRIaM
	 O1YwYT4iv8iEt1BlzN4UsORM6zsxnxc6xEggfRukx0leXs1gBNz1N7lOJ2O+hat4eUawJ
	 v9HFUvSXML2Zd0tixDAalQrSu53FRX351JxeU5lAuVSwGPW2lhX5JR/wKv11GPYeh9Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qRfFbWL2;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com
 [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F1B99F800FE
	for <alsa-devel@alsa-project.org>; Thu, 30 Jul 2026 09:15:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F1B99F800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=qRfFbWL2
Received: by mail-pl1-f175.google.com with SMTP id
 d9443c01a7336-2cab973140bso24711565ad.3
        for <alsa-devel@alsa-project.org>;
 Thu, 30 Jul 2026 00:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785395723; x=1786000523;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FljL6vPaykXZDvXxyzLURv+gVYAZ6DOFtR4WS2DRuXM=;
        b=qRfFbWL2lH0nUM66rUM8wvjZlhzjKuT78UUYMKdXlx7eP9fjfgCK5l158d6zvadJf3
         gR5IZG5SpZtpc4Zcyaw8mpuIGraN4J4INXcV333y/ZmL3vFWiot94LzjpCSWWYSg/f22
         DayKurrtu2pHGcuDprqCaeiSRI390fYhQCOGrgOIjz2mkhasnAiLsXLIDdRWDCZT+4iQ
         AchHBl6qFiGBX8alyiVhih+y0Ws2Aos+FUQ+AiiL9JjicTWm+XtgJ5pFYqPs6sq/FfhG
         EtTrLADLil9mTdtMfLoVNmsM11CTkqYNlJY4gAWQhb+kQ7QXfeTy3CEIE3qfaOmKGerp
         kStQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785395723; x=1786000523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FljL6vPaykXZDvXxyzLURv+gVYAZ6DOFtR4WS2DRuXM=;
        b=j6OApr0ecrTb15J3a1M9ZdG+KUFspFaVFgoInfA1MZ0+wlcP59ESjI/xZNftE7qWg7
         h6vXk9FL7omP3dh9+jeIrVN9LqjiAaHInvAqLl/7tPU9zbArA2IGpCEJZv0JhKJBPjYH
         vbCZzvsMoW+0QL5Dw1+pm5iyNAi6YV8gn2VguNirOyq9NvHxs9rMXOhyxhDKTvtR0Sf9
         j/Pb0rkMbvCKZ1Bb8vK//91MD8kwYdQa1NAxtCXaeNekcnhC8I/fy8keMkpK/itgfVOF
         1YRc7BUyNCTYvbCvWzasxnWBXRnA552WsELEjeRh9uTPCSrM+1c14MaxSKqhfVFfwJQo
         9slQ==
X-Gm-Message-State: AOJu0YxiColeRBN/SGqDQsU0d1USqeJqmGyqV1MMOL9bfKPPqa4/FIXv
	OID7Bx7Im9PnlVMmwqhXiYDdNIeUVdsiGVqf8Keb7RIZzUMzxoL20lX0mEjJx+NNrwU=
X-Gm-Gg: AR+sD10U4zyZ5s471s63VHAINjz4YB9RdZ5hB+ativGxqL9JyfCyfVsOp3NHZohYWDO
	p6Gf0QU4eyIOg3JHId45o/OWdZxA4rltxbHqvstAAxwxFtnP10AurYpvg/NAEtYOYwr03sZMeB7
	tmWrTZOgz3RnqYDFcW6fdkFPgbWST8KUYW/NQOzaK1L76XI+/gdcR4GgNii5j/etixkTwPDvg0d
	E03m5RXkBmZ60puzKrjl02zCKOt/XrA2B4zmUcwC9hwyRoM1rltarQo5FpvSLeumfc5lyYEol55
	2njgzQ0WdHHkDMwFEc4bAAOxFH3RgKY3kg6bCyjmJok/3PBRuXWgekqEwOLLfxzWNQ508Azarap
	cI0JaJbWcCMYss1tUmTFBI8ymlqSAONZXJ5ZL9/ueL07y1OyOL3Ms5DC2zT5TKkJxmVjiotu5uH
	FdTvlc6jrfwju9MRsGX43D7yiJ3/9O2TfVlLxkapRZ+eYImOiSelUiGrkbjxEUeWudqA==
X-Received: by 2002:a17:903:4b48:b0:2cc:f4d4:299f with SMTP id
 d9443c01a7336-2d035c8676fmr15611855ad.27.1785395722887;
        Thu, 30 Jul 2026 00:15:22 -0700 (PDT)
Received: from archlinux-21vg ([202.201.11.13])
        by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bc9fe9sm21490945ad.51.2026.07.30.00.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:15:21 -0700 (PDT)
From: Padhia Luo <lcj20010426@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.com,
	linux-kernel@vger.kernel.org,
	Padhia Luo <lcj20010426@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Fix speaker mute LED on Lenovo ThinkBook
 14 G8+ IPH
Date: Thu, 30 Jul 2026 15:14:53 +0800
Message-ID: <20260730071453.19636-1-lcj20010426@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: lcj20010426@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: W5CJFDCH656TPZUAIED2VKY4YKHQYXIC
X-Message-ID-Hash: W5CJFDCH656TPZUAIED2VKY4YKHQYXIC
X-Mailman-Approved-At: Fri, 31 Jul 2026 07:26:19 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/W5CJFDCH656TPZUAIED2VKY4YKHQYXIC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

On the ThinkBook 14 G8+ IPH (SSID 17aa:393e, ALC287) the F1 speaker mute
LED never lights up, while the F4 mic mute LED works.

Both LEDs are platform LEDs registered by lenovo-wmi-hotkey-utilities and
default to the audio-mute / audio-micmute triggers, so the speaker LED only
follows a control carrying SNDRV_CTL_ELEM_ACCESS_SPK_LED. No control on
this machine has that flag set, so snd_ctl_led never attaches anything and
/sys/class/sound/ctl-led/speaker/card0/list stays empty. The mic LED is
unaffected because MIC_LED is set from the SOF topology on the DMIC
control, which does not go through the codec fixups at all.

The pin configuration of this machine matches the ThinkPad pin quirk that
selects ALC285_FIXUP_THINKPAD_HEADSET_JACK - pin_config_match() masks out
the sequence/association nibbles, so 0x14=0x90170120 still matches the
0x90170110 in the table. That fixup chains into ALC269_FIXUP_THINKPAD_ACPI,
but hda_fixup_thinkpad_acpi() returns early because is_thinkpad() is false:
a ThinkBook exposes neither LEN0068/LEN0268 nor IBM0068. Therefore
snd_hda_gen_add_mute_led_cdev() is never called and spec->vmaster_mute_led
stays 0.

The vendor fallback SND_PCI_QUIRK_VENDOR(0x17aa, "Lenovo XPAD",
ALC269_FIXUP_LENOVO_XPAD_ACPI) would have handled this correctly - the
machine does expose LHK2019 and VPC2004, so is_ideapad() is true - but it
never runs: the pin quirk has already set codec->fixup_id, and
snd_hda_pick_fixup() returns immediately in that case.

Add an SSID quirk selecting a fixup that keeps everything the machine
currently gets (headset jack handling plus the X1 Gen7 DAC routing) and
additionally runs the ideapad ACPI setup. It chains into
ALC287_FIXUP_LENOVO_YOGA_PRO7, which already combines
alc285_fixup_thinkpad_x1_gen7 with ALC269_FIXUP_LENOVO_XPAD_ACPI, so the
resulting chain differs from the current one only by the added ideapad step
and cannot regress the analog output or the headset jack.

Tested on 7.1.5 on the affected machine: the speaker LED group is now
populated at probe time without any userspace help, and the F1 LED
follows the mute state.  Compared against a boot with the previous fixup
selection, the mixer control list (names and numids) and the registered
jack input devices are identical.

Note that the underlying mismatch is not specific to this SSID. Any Lenovo
non-ThinkPad whose pins collide with a ThinkPad pin quirk loses its mute
LED the same way. Letting hda_fixup_thinkpad_acpi() fall back to the
ideapad check would cover the whole class at once, but that touches a
helper shared with every ThinkPad, so this patch only fixes the machine
that was actually tested.

Signed-off-by: Padhia Luo <lcj20010426@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -4077,6 +4077,7 @@
 	ALC298_FIXUP_LENOVO_C940_DUET7,
 	ALC287_FIXUP_LENOVO_YOGA_BOOK_9I,
 	ALC287_FIXUP_LENOVO_YOGA_PRO7,
+	ALC287_FIXUP_LENOVO_XPAD_HEADSET_JACK,
 	ALC287_FIXUP_13S_GEN2_SPEAKERS,
 	ALC256_FIXUP_SET_COEF_DEFAULTS,
 	ALC256_FIXUP_SYSTEM76_MIC_NO_PRESENCE,
@@ -6109,6 +6110,16 @@
 		.chained = true,
 		.chain_id = ALC269_FIXUP_LENOVO_XPAD_ACPI,
 	},
+	[ALC287_FIXUP_LENOVO_XPAD_HEADSET_JACK] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc_fixup_headset_jack,
+		.chained = true,
+		/* Same as ALC285_FIXUP_THINKPAD_HEADSET_JACK, except that the
+		 * mute LEDs are driven through ideapad_laptop rather than
+		 * thinkpad_acpi.
+		 */
+		.chain_id = ALC287_FIXUP_LENOVO_YOGA_PRO7,
+	},
 	[ALC623_FIXUP_LENOVO_THINKSTATION_P340] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc_fixup_no_shutup,
@@ -7790,6 +7801,7 @@
 	SND_PCI_QUIRK(0x17aa, 0x3920, "Yoga S990-16 pro Quad VECO Quad", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3929, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x392b, "Thinkbook 13x Gen 5", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
+	SND_PCI_QUIRK(0x17aa, 0x393e, "Lenovo ThinkBook 14 G8+ IPH", ALC287_FIXUP_LENOVO_XPAD_HEADSET_JACK),
 	HDA_CODEC_QUIRK(0x17aa, 0x394c, "Lenovo Yoga Slim 7 14AGP11", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3977, "IdeaPad S210", ALC283_FIXUP_INT_MIC),
 	SND_PCI_QUIRK(0x17aa, 0x3978, "Lenovo B50-70", ALC269_FIXUP_DMIC_THINKPAD_ACPI),
