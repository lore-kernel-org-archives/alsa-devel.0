Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D8BC5DF81
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:47:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6443960259;
	Mon, 24 Aug 2026 13:46:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6443960259
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1787572028;
	bh=lCHOKf1he7vKZlNXyEz99WnPXMGujAfkVEfOmKv5yW4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=XRlSceSbGXH8PICEKhhzIKQ8n4TzP0YKl2/vtreXBjIcBVejvAPSAtPAj+F5kNlCu
	 DE8GQuvaZEomYRNTtuRe5wMxVov0U8L1MxBSMLsj7fK2BpKqOj2F5/dT35M/vQ4q5k
	 TwFWBNr14A6Zo7Q0QvG19kYxnPawOo4M6q0/h7H0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3B19AF80698; Mon, 24 Aug 2026 13:45:52 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B96C5F806A4;
	Mon, 24 Aug 2026 13:45:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 29D8CF8007E; Mon, 24 Aug 2026 11:43:34 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1787564612;
	b=EfUKI4F+RojvP/oBYpdJ0umnn5yHtdYElNAfTFJ19TuI8vSrIslOPIdhWU5oNQqUPF3C
	 sPqKSc094gIU8V9Wp0JFoW1/Z/zavUkZ0bD4eiZ/C1KPVXZ8tcNjrdgssC2qjX5Jhl/JZ
	 prmGWZT2sK5aSE4ipMhEpF6KdFNSSRgdG3P3GWeV8wwFZS8nWg98dwrWcBgX25eaO1y2P
	 r/KNFNXgkKtkvMRn0ypphICUU5W88oRKQrAuTVo82c4T1dG8M/6CN/a6osV9ETHdidI74
	 SRM9a+oP6jTgu2vDpom/0227NcJeDJfUnN5nVrZyAWydoyqjgzkbSf4xgsTIDCg9GeA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1787564612;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=lCHOKf1he7vKZlNXyEz99WnPXMGujAfkVEfOmKv5yW4=;
	b=Qaqym6iVrjIKESBgCnYKY9tUaxvDIbtOD6ArbQVU3TjLy5Z/BtXLD1PSpAgmIO2QcuFH
	 8eT7aWrw8i45iYcRbao+NLv0/VKPcYWcnH6oByzLAa+25ufJHG5VRlyqsf29upLrCBanr
	 +nM+xTB9yCESK7jUXRiC95/LtU6NQctuo7OwJOd+uy78TtSe8qB9BGpBmf1J4Q+HLIeaZ
	 TOwR+AhWNacb0QXBkWJopZzx9JgoOjr+TKlUgZs/v/Xrfma7jW/xNPKGr6ylcq3SsgvCW
	 oPqoZdsVj0pMUp329YWZaY8jl5l9dScdc11MdJT0qkRLkIlBNHG/SLYw5IOa3IRC0Bw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SpiqgpoC;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com
 [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0CBBAF8007E
	for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2026 11:43:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CBBAF8007E
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=SpiqgpoC
Received: by mail-ej1-f53.google.com with SMTP id
 a640c23a62f3a-c20e70a0962so485616866b.2
        for <alsa-devel@alsa-project.org>;
 Mon, 24 Aug 2026 02:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787564610; x=1788169410;
 darn=alsa-project.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tt+TQsCLx2V8Yk8sD/vVtXtNe1G9NCu1SZAx+dsGT3Q=;
        b=SpiqgpoCnQkbL1WKaXLOo/aYLxNGGiyUg4c2IKkrQ4oWfIAmEoNDc+Eba3/H931mVp
         4cVMsAHSmqOxUc/q2IPH2IoPv1Nk8xGFKVDJjpZOerHsizyzEwt00le9+nPogeGZ6sFd
         mYIGGAng7K09Tt8+PUWRa1VGZbYfpYMuY0R61Glzj0Yy02eH63hvWimSRKhf7UAU2Dnz
         hjXS59U1UGQSMub0mPYqo6VpwyIm4Rskajnay9lTURRDP/7qcNY7rXW1LQ9XZ8C7nZP1
         QqvuxoUvczvxG7VG7ElsO4fzQ7yBSjRQjFR/1BQ6oy9ILbKtJlNBgnXoYPifSJBE/fNT
         euCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787564610; x=1788169410;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tt+TQsCLx2V8Yk8sD/vVtXtNe1G9NCu1SZAx+dsGT3Q=;
        b=tD0xeKuvtXpdiF1Zr2jy0FFagnSUo8z+beZ83J5tC/TM4v0c+mas7xbLatUE5UTZfb
         qt9qguT+7ePfFhWY8pWdrapbhWRlsHswFFwpJQIX0yJOHw3axSYmPP+Wr8r7xFsHQ5dd
         6ORaQ1lxoAstrfvvx6DUYhtqH6L5fNvEXJxtgC5p5b80igAxds5ov0Ecg36D8FdFyPrv
         qzV1UxUYQ6ZeEN5RWhx9hi1OxlcbY0wrV8KhQG3tHcXxwj6MsAg5uZFbkGF1L8AhXxdn
         uebeuhqUO0GbchMZKbZgm7ViLDglsWTjwBBy3UXCcYhWoQoWYyHSfRAhzBZ/nXILTyzA
         Bgow==
X-Gm-Message-State: AFuF++kBDaeZBeIL/r1j54Qx17Z6WNTqn6UEQwt2PqbXdI5Dwczd9T+z
	77axKkLptb+09gaPUx6tn5lyBwi/Vmg3YCIMxdwGz1wwUqGUDjfTkaw=
X-Gm-Gg: AR+sD10jRX87K2w625wnzsd9v7n9ExLteCt7snLq2s26Exj1Yf+fMfDn0XAb2dQ8HyE
	4kBlcFtDkIX+iGxzaM4YgVsSmdO0cuxuobRwmsXkSYfnDNr7bw5auDmtbaVUiCDCMEDnhI8wrsa
	94P2y1GTjhRM7FW+v8/OXbL71PizUSGkxwx4lNs/M7cECvnRcC5bSoxogDHIHt3BLfIDfgNzqj1
	q2q89L4/bJIjumyc7O88yrxkONTfSnKu9hp4NNchpjNMse2euzcX/p56ZscYPqCRs3phGV0ILnH
	DquPWWXtbgxzP6SB0IOhdYb+J3d9pE8NLb0BchhHjbLY3k7rVWSOKXy+aBPOTyeEyhgwdmZ1MJo
	ygScxVIWFx3tYjl1dw/WUCZUMf+DahaWsJli3P0FRCo8ht3Cw6NrdGQNd3LV6uBcwhb42jHh9Im
	PCYNMgeWm3UpP78cSiVYAUcuZnzZ7/hfMl7IbmMBofMSTk8LUI+krTTUYPN9D/6F5QMkaiq3R79
	AM0rJa9jyKzaQQ=
X-Received: by 2002:a17:907:3d0a:b0:c20:74db:50c7 with SMTP id
 a640c23a62f3a-c246a697ac4mr2957361066b.13.1787564609890;
        Mon, 24 Aug 2026 02:43:29 -0700 (PDT)
Received: from localhost.localdomain ([31.223.84.133])
        by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24966f8f08sm1140963166b.35.2026.08.24.02.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 02:43:29 -0700 (PDT)
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
Date: Mon, 24 Aug 2026 12:42:28 +0300
Message-ID: <20260824094256.3758-1-habilerenturker@hotmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MailFrom: habilerenturker@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: HVMHUUGHDLI3NNE2XLV7HMSAIF2QEVZ7
X-Message-ID-Hash: HVMHUUGHDLI3NNE2XLV7HMSAIF2QEVZ7
X-Mailman-Approved-At: Mon, 24 Aug 2026 11:45:45 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HVMHUUGHDLI3NNE2XLV7HMSAIF2QEVZ7/>
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
 sound/hda/codecs/realtek/alc269.c | 51 ++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 8 deletions(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 01b87267f..a2a3341c3 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -1364,14 +1364,49 @@ static void alc269_fixup_hp_gpio_led(struct hda_codec *codec,
 	alc_fixup_hp_gpio_led(codec, action, 0x08, 0x10);
 }
 
-static void alc236_fixup_hp_micmute_led_only(struct hda_codec *codec,
-				const struct hda_fixup *fix, int action)
+/* Patch for HP 15-fd0xxx (8BB6) Speaker Mute LED & Mic-Mute LED */
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
@@ -4096,7 +4131,7 @@ enum {
 	ALC236_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
-	ALC236_FIXUP_HP_MICMUTE_LED_ONLY,
+	ALC236_FIXUP_HP_15_FD0XXX,
 	ALC236_FIXUP_LENOVO_INV_DMIC,
 	ALC298_FIXUP_SAMSUNG_AMP,
 	ALC298_FIXUP_SAMSUNG_AMP_V2_2_AMPS,
@@ -5839,9 +5874,9 @@ static const struct hda_fixup alc269_fixups[] = {
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
@@ -7345,7 +7380,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
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

