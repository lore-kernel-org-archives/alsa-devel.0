Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C1D4CC6B33
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:15:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4B1926022B;
	Thu, 15 Oct 2026 15:15:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4B1926022B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792070145;
	bh=xs+kZ42rmYwiivpmB0ENnaXo2VwKvylSKcyYYvnzXq4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rCoZhzxYY5rGsmMVjXwhNZc4cLNhqzBn2GQrhhF1lNn7K+lHzFQ9QnDlqmCSD3JLS
	 Wgl1mKxoSwq/X1NNxxyYGleio3ziZqLZj3LSqQiVhsSRNR2Px0F/oob38KScOxz5I0
	 4F1NXd/fUcPnOXK36cLnqJsrWueTcEYUWz7PUnFs=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 210A0F80602; Thu, 15 Oct 2026 15:15:12 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 27300F805F5;
	Thu, 15 Oct 2026 15:15:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 46E74F804CF; Thu, 15 Oct 2026 15:15:05 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.221.50
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792070103;
	b=UL1Q0kInDDkouRo3vxodvr+Htu+8wFnw3SR3/pwNttyvSMzjlKk5ZxEHbI242xur7XX8
	 6QuLugb24fssypikBp83JZcCxpvBKK7yZpYQgccY0ep7Gc9u2Io1729x9cKbrT8Txdjxd
	 YMKZWamcunxi6kjRyCWeNEhdKJmSnu6cIfBzoaV6VGyp9U5bPw1aJtsNFX2tviZpVJvDl
	 nAcqxrzAgJ/dEBwlCAoxLyd2BucRud5TJakaxs2R2SMsEsT10j11XwUZf153Inb94Ks4o
	 +xtDSXnhYIbTQpzpxynevkKeBVU1snGPGh/KReBZkvj0O3fnJfZc/exrclAMFLpDcKQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792070103;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xs+kZ42rmYwiivpmB0ENnaXo2VwKvylSKcyYYvnzXq4=;
	b=TIxzyFtp6CdY2U+7xsKL45np6wb5OM4vy9fcqby6zkDdjSqeEk7Ny8gBKQyajtXnSFuB
	 c0bckDRRZLmgCJ1I4jnJsnLzl1XgcCetA0U2/S784b0pAB7cb2HUyqXzceABiV6dC2yAY
	 NskPfzZe2rvcSIHXm4PjRTV/537JvGs4CvPlarhgiCbjVytUGJjvb9HxfzKBw5cP2IIov
	 8tSZOfTMKh4nI0J5V4uJQ2sXci8+pRHq0amJqAWdW6pAm9XRH/7fdVUM4r/pyWKfjRouk
	 2gJ9CwWBHfTNLz2WezwqPSkLDeGDydbidX9RA31YITqUB715iZY89A9mPC8OkKeWyCg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iTT2EO05;
	arc=none smtp.remote-ip=209.85.221.50
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A93B7F800BD
	for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2026 15:15:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A93B7F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iTT2EO05
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-48c14a06c95so4327707f8f.1
        for <alsa-devel@alsa-project.org>;
 Thu, 15 Oct 2026 06:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792070101; x=1792674901;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v0koWxN7u1SSkvKU8TByxzhlloNtbbSXphmEUfbqlfE=;
        b=iTT2EO05XC/sskr5kWGVgQfoSDNaOp8tKdOjrEn2Vcucp7Hh+PWR/QDUoPL0ytFGEU
         C2G7YthUr/FlmLB30tbpPxI/VJu9teOIzx3flZ85ygvsLko9KZOsEG7/sqdCR11T8wpN
         QF7XhmEJqcEnpjM4p87RqiQNDO3j4WhEccWDE0cl/LBopL4sle2VYB9A8UHfFx3ecox6
         nHQr15aK94ePklc9VPI+LlG7Isd8mq2wvWRSI4V3Tc9G2E68bUOWA0VQg/I3zCkdpPKm
         y0w4YPwVtTNGd+wzq4IKJbbcngNEo+OFIK4XOe5+OHr5qT7wzOiDkoLhmHnLhLEwsfI9
         PZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792070101; x=1792674901;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v0koWxN7u1SSkvKU8TByxzhlloNtbbSXphmEUfbqlfE=;
        b=W2455vgv/eJnY/YkukgncH70YlH3uEomUg5H+Towk/ZXInnAfqGS2XWD1cUHb/u3UY
         3xU2A9f+vJzdjl38qZRf05B70UwxabhsIYTlEfFj0H62YstYxeIO4qJGxwdulrCcH41f
         HwZtFgY69EuF5rbRokORumzHivGF8bf5ckSJMKtAZUXYebkgUeMQGPGMQDsfhC9713+q
         lzcDeSkPh6rjL/esrBVCHgT9kH2oI5CC3hy99dWM/7yMkyD7gVv1bbAuJ8l10nn85dRG
         bbVen6xh40J9wYmesUbzhDXNc+n6gN8i1qJzY/00SoEf7B0aJs5ppkwVvC40/Y88kXaX
         w0aQ==
X-Gm-Message-State: AFq9FYIAIgRQ8YMevxCYO+IHk85KcosSznKfSgSokH+xLz3eSGCFe3EZ
	rRaqui+tVBToom/PzQWG3ScvPQqyn2Se2wjjpk6gEzVN+7hn6ZMsFNCS+FVfVV4FlSs=
X-Gm-Gg: AYBFou0LBJYGhQ3Alr9KvQ/UGfsS5GdVrKoO2kvtb4kDmoVCB5et33wcqNHAyUzWa0o
	g5dMOYqWb2//4FDo1lFxBsB1vQZ5hRbVML53evG6yn6QcPSk2bS7MeffkaLqjhJEeAPjiaPI8Mp
	mpN8lOVG/2Dzskhx59Z+Q/eTjMQSG7C5sNorLYqTKyEPMlPG7MbWrNl3ZvO8G/nygzgfN4/AAP+
	BKD1/vC0GeiPoK7G4bjBFRYh7sQiql6mRxo/dr4B0aqnarFtRZ3+dnQXFo1JziR130mD5mAVGCa
	JLpwZxluHkfFOvPKmWJVf8YA6JF+xc5mhKtg+kduKRAAyQSn6uZMpFvIu/YwvXzJ2B7z5awa6Es
	EiUjSp7im5ye2vjyyTYQdzL/qvAu/lUQbkDWdENZzCbdATa+OY5J0P1PXKPHP7nVZuyOVyD/ybu
	T4z/mYI+Ub4/KsDaMs3exQ9l8MlLuvZCzL8bW3mvCsBnMYZ+zzVocTJxouy8MphEjmc2hFdE3wH
	AMad6ipTSE=
X-Received: by 2002:a05:6000:4b05:b0:48b:60d:2b28 with SMTP id
 ffacd0b85a97d-48dbacdd339mr34075195f8f.39.1792070101004;
        Thu, 15 Oct 2026 06:15:01 -0700 (PDT)
Received: from archlinux.lan ([188.75.207.119])
        by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab5b03sm19935364f8f.30.2026.10.15.06.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:15:00 -0700 (PDT)
From: Viktor Menshin <ripeeerr@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	Viktor Menshin <ripeeerr@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Fix hiss/crackle on Lenovo Xiaoxin 14 GT
 (17aa:3912)
Date: Thu, 15 Oct 2026 22:13:02 +0900
Message-ID: <20261015131302.54503-1-ripeeerr@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KSUTKWUDZWOYNHF53ML3PD2V6HIA3YIP
X-Message-ID-Hash: KSUTKWUDZWOYNHF53ML3PD2V6HIA3YIP
X-MailFrom: ripeeerr@gmail.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation;
 nonmember-moderation; administrivia; implicit-dest; max-recipients; max-size;
 news-moderation; no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KSUTKWUDZWOYNHF53ML3PD2V6HIA3YIP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Commit 3a3e810e9108 ("ALSA: hda/realtek: Add quirk for Lenovo Xiaoxin
14 GT") added a quirk mapping SSID 17aa:3912 to
ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN, chosen by analogy with
neighboring SSIDs (0x390d, 0x3911, 0x391a) without being verified on
hardware, as noted in that commit's own message.

I have since tested it on the actual hardware (Lenovo Xiaoxin Pro 14
ASP10, same 17aa:3912 SSID) and confirmed it does not fix the reported
issue. ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN only repoints pin 0x17
and the preferred DAC pairs for the bass speaker; it does not touch
the codec's vendor processing coefficients. The actual symptom -
constant electrical hiss/crackle on both the headphone jack and the
internal speakers, independent of volume - is unrelated to pin/DAC
routing and is also present on stock Windows before the Realtek
driver is installed, which points at those coefficients being left
at their power-on default.

To find the correct values, I passed the physical HD Audio controller
through to a Windows 10 VM (VFIO, with QEMU patched to log CORB verb
traffic) and captured the coefficient writes the vendor Realtek driver
performs at init. Replaying a single one of them on Linux via hda-verb
reproducibly eliminates the headphone jack noise:

    hda-verb /dev/snd/hwC#D0 0x20 SET_COEF_INDEX 0x36
    hda-verb /dev/snd/hwC#D0 0x20 SET_PROC_COEF  0x77d7

This has held up across reboots and kernel updates for several weeks
(applied via a small systemd oneshot unit while testing).

Add a dedicated fixup that performs this coefficient write and chains
it with the existing ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN (which may
still be relevant for the bass speaker pin wiring on this board), and
point the 17aa:3912 quirk entry at it instead.

Honesty note: this fixes the headphone jack. The internal speakers
still have noise under certain conditions (notably worse on AC power)
that I have not been able to isolate via coefficient-table replay;
that part remains open. Sending what is verified to work rather than
holding this back.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221203
Fixes: 3a3e810e9108 ("ALSA: hda/realtek: Add quirk for Lenovo Xiaoxin 14 GT")
Signed-off-by: Viktor Menshin <ripeeerr@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 1623cf926..b72e04dc9 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -3661,6 +3661,28 @@ static void alc287_fixup_yoga9_14iap7_bass_spk_pin(struct hda_codec *codec,
 	}
 }
 
+/*
+ * The Lenovo Xiaoxin 14 GT (SSID 17aa:3912) uses the same bass-speaker
+ * pin wiring as its 0x390d/0x3911/0x391a siblings, but on this board the
+ * codec's vendor processing coefficients (node 0x20) are left at their
+ * power-on default instead of being programmed the way the vendor
+ * (Windows) driver programs them. That leaves audible hiss/crackle on
+ * both the headphone jack and the internal speakers, independent of
+ * volume, regardless of which pin/DAC routing is used.
+ *
+ * This single coefficient write was captured from the vendor driver's
+ * own init sequence (via a VFIO pass-through of the physical codec to a
+ * Windows VM) and confirmed to eliminate the headphone jack noise.
+ */
+static void alc287_fixup_lenovo_xiaoxin_14gt_hp_noise(struct hda_codec *codec,
+						       const struct hda_fixup *fix, int action)
+{
+	if (action != HDA_FIXUP_ACT_INIT)
+		return;
+
+	alc_write_coef_idx(codec, 0x36, 0x77d7);
+}
+
 static void alc_fixup_yoga_pro7_audio(struct hda_codec *codec,
 				      const struct hda_fixup *fix, int action)
 {
@@ -4320,6 +4342,7 @@ enum {
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK,
 	ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN,
 	ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN,
+	ALC287_FIXUP_LENOVO_XIAOXIN_14GT_HP_NOISE,
 	ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS,
 	ALC236_FIXUP_DELL_DUAL_CODECS,
 	ALC287_FIXUP_CS35L41_I2C_2_THINKPAD_ACPI,
@@ -6787,6 +6810,12 @@ static const struct hda_fixup alc269_fixups[] = {
 		.chained = true,
 		.chain_id = ALC287_FIXUP_CS35L41_I2C_2,
 	},
+	[ALC287_FIXUP_LENOVO_XIAOXIN_14GT_HP_NOISE] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc287_fixup_lenovo_xiaoxin_14gt_hp_noise,
+		.chained = true,
+		.chain_id = ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN,
+	},
 	[ALC295_FIXUP_DELL_INSPIRON_TOP_SPEAKERS] = {
 		.type = HDA_FIXUP_FUNC,
 		.v.func = alc295_fixup_dell_inspiron_top_speakers,
@@ -8309,7 +8338,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	HDA_CODEC_QUIRK(0x17aa, 0x3907, "Legion Pro 7i 16IAX10H / Y9000P IAX10", ALC287_FIXUP_LENOVO_LEGION_AW88399),
 	SND_PCI_QUIRK(0x17aa, 0x390d, "Lenovo Yoga Pro 7 14ASP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN_HEADSET),
 	SND_PCI_QUIRK(0x17aa, 0x3911, "Lenovo Yoga Pro 7 14IAH10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
-	SND_PCI_QUIRK(0x17aa, 0x3912, "Lenovo Xiaoxin 14 GT", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	SND_PCI_QUIRK(0x17aa, 0x3912, "Lenovo Xiaoxin 14 GT", ALC287_FIXUP_LENOVO_XIAOXIN_14GT_HP_NOISE),
 	SND_PCI_QUIRK(0x17aa, 0x3913, "Lenovo 145", ALC236_FIXUP_LENOVO_INV_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x391f, "Yoga S990-16 pro Quad YC Quad", ALC287_FIXUP_TXNW2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x3920, "Yoga S990-16 pro Quad VECO Quad", ALC287_FIXUP_YOGA9_SPEAKER2_TO_DAC1),
-- 
2.43.0

