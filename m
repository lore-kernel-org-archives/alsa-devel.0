Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3AECC6B34
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Oct 2026 13:23:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6E0B560233;
	Thu, 15 Oct 2026 15:22:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6E0B560233
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1792070578;
	bh=xs+kZ42rmYwiivpmB0ENnaXo2VwKvylSKcyYYvnzXq4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=bi3YsCb3KTmNR2xkIAbMP+a1EDNidmw8zkkTm3DrrTduLebLfDcSrGOqChdtYT8H5
	 47o/8Gd/g7vataMCtQ8DGItYWpXzkLrZWgvK7DB58LKstaBTF7vmrN/dQ+I9ENSOJO
	 MzP+6g/yyUUiRsAFvKcR/bKUsTO+68xxjEc7ABJg=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B1D4FF805EE; Thu, 15 Oct 2026 15:22:24 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 10665F80553;
	Thu, 15 Oct 2026 15:22:24 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1667FF804CF; Thu, 15 Oct 2026 15:22:19 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1792070537;
	b=eEKUGnKmtCvokhABTHiplOcTfNZRhxzStyoRTUxRnaMcxdwRgHmoVqx7YYOazD/mhebS
	 oFxzbL1F5zQY5n6RqXWAumpcx4c9qh/dr5+JhqtWuQnVH3FH2RpO5ntrenYTZ4sZWFQN1
	 fgYO88gaQBSrCyRbtcY5rr3xzJz5OlRFX8pJGOaHcgzb68XnFjekcrplgnGX/1PYcxji8
	 L/wbGOUaK4GfPBZIIiRC2wzVSrMHbEIbWj2/JVa1fIl9vMmfWfk5r1DvBekg5Mca6Pjzt
	 eVKK5dFicLye2xK0C9y0J6tUQbsD+ik1sNb0fuYr+CBpMFP6FKbM5j3VrGGw5uFv/Rw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1792070537;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xs+kZ42rmYwiivpmB0ENnaXo2VwKvylSKcyYYvnzXq4=;
	b=dvOzaej6Q6FhCcwNX5kFx6G7i37w0Cy76T3mYaVQtJPj7FnRaYU3iifiny3WJ5vCPQVv
	 FNuuirhE/XaTIV3pXluC9UVwXydcfS/FZJ79N5Nb9jyFyni+X2EAU7vKR5eJPF6L/8EL2
	 p2WYGN092PyUL+mGxsfDK5pZnpbQGJljLbFDpKWTgm2dRmV22GD0ChP8EkI7X3eKxc+/b
	 OXoNyNz1YSR81a7xOuMIUROQ7X/WAxPL/ds2ik6+am62wGPQjz/tXPVD9QKpkID7lQzuq
	 0BBPHcl7EU3gch5UF2krJDoMixeth5IFvHn/CEGr7QW/9yeluQ6nNFOjHXRw3QnDD2Q==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eI7YRz9H;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DB700F800BD
	for <alsa-devel@alsa-project.org>; Thu, 15 Oct 2026 15:22:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DB700F800BD
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=eI7YRz9H
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso18816275e9.1
        for <alsa-devel@alsa-project.org>;
 Thu, 15 Oct 2026 06:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792070536; x=1792675336;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v0koWxN7u1SSkvKU8TByxzhlloNtbbSXphmEUfbqlfE=;
        b=eI7YRz9HXTqeYdM46NS4WDxJNWyuzV2x9GHWTe6DnR/bG/Wsq86yb3BG3rZvPPh36W
         dEnSshYsmKrxvKfbgRcBKLatXEgHzexiU0xu5RV6SePpauqx5FFiFbALadbn/hBDgO5J
         vXDkhfgXzL4BwJwSoOCruxksHzSSoMJcYpayHdiZ3P+PhgfnW//SC0rWeGkHeG4a0Zkc
         uPTHFgwpnopmd3pjPWEs4/rRN5NYHNsvGZr+bqf4evPBLunc761rK8iOTwloUx2YoZP7
         IEdbs8XQL3q5OQDacnYUDiM0Iiey2a0BLPHBuc5wP1ndD3DBrTQdXcmSEI2dGZhYGPJQ
         kbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792070536; x=1792675336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v0koWxN7u1SSkvKU8TByxzhlloNtbbSXphmEUfbqlfE=;
        b=LRIl2A5REg1AqE63/X0UFaInpyp9HvewVGvVwNdZ3dVdfdVKe7K0/5PlTzvLr2XUX0
         GgqJq590ZrFOqg9wLINZdIt9CfcDvdcGfh+rVU0GxQPVrDrDa+SptS94cyEGDKvU63Yi
         UYqipFyo3RBK73CcsBUlVSGYDBvQWEhnj/UKxASqVaqLGx5D/6ptzfJPgo9hn17SZK36
         1ATjtUOQLli8CSMrMwlbBH1cI/PJRXx+CqM5A6F8Rbb7DAzEKxQ8JYgs1vLW4Z+IxX2G
         rCP7YJhhSAPLarKRkoY5UbzujETZt1HeyOFtlT9GD8A1a8DYyhXfg6QDD2twHHwikyHl
         GlgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBywfz7q1R1f4f+11q8UTHDdhvsqPkotiFxJ57pevhxmwJVrAS/GvrMQxKn/5c4EyrD4IDha0OQvEFJX@alsa-project.org
X-Gm-Message-State: AFq9FYJUjspBxyr6k+JKIThjWbC/wGGAe6V+kqaT9e/lPHyQZiRpMfx9
	9wm6JnSRnb60KRysHFWZ7Gw0qR+Ho7wOJ6wXGzomcTGNsGGy+mRYUWP4ve+8hEE5Xoo=
X-Gm-Gg: AYBFou0yRpX4IEGZX4EQRgiQnxO/JcjAhvVb6qNDJjB03HZPxboAdpfMegTmXOqtuRM
	Fh5YRynylq3QjdvNL05XWDJLPyLecL3PVY2/NJfcrPh2F6uqmU9ZhTJvEGBKvO7cdCeGdTKroBk
	XEKAH/OPUZNSfz+AFbuCLzPMdprxu0QQff48dZk5decv6DWa6KJUejBKLV3I+GlRH9QD5lCoHbQ
	Qo2jNvo+QHStxzvg6acOWxuk60XkhUtx9920HP7x/YtIr2Yhj2kRMN50mNlZWi6JNF9CMtRI+DA
	mkc6Iq7JYzoX6FHai20Dm4Nkqf4HJvZRHcbbTUyfCjGjCm2u571J4ZlSK3ZYZxQouFGkBQ+IOya
	h4xlNXAp8+G+B7s0Gu9VJeXvVW5XKfidlzwDa1VT67vct/4nS92lwFbHq8CJq+jDQ7h2W1/5MQR
	XyRSZRonwqDMLMOsc7lS/4RQe7YKwsiln3GcUQ8VD33Ipm6QfWRTKutcoUOWNrL6+TioZsMRMe
X-Received: by 2002:a05:600c:8216:b0:49d:34:420d with SMTP id
 5b1f17b1804b1-4a18e4b0465mr392350895e9.20.1792070535541;
        Thu, 15 Oct 2026 06:22:15 -0700 (PDT)
Received: from archlinux.lan ([188.75.207.119])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd91c55bsm64398865e9.0.2026.10.15.06.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 06:22:14 -0700 (PDT)
From: Viktor Menshin <ripeeerr@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.de,
	alsa-devel@alsa-project.org,
	Viktor Menshin <ripeeerr@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Fix hiss/crackle on Lenovo Xiaoxin 14 GT
 (17aa:3912)
Date: Thu, 15 Oct 2026 22:21:57 +0900
Message-ID: <20261015132157.57198-1-ripeeerr@gmail.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 466PTN4L2TVA6Y3E7POAQEQGA3CLINZV
X-Message-ID-Hash: 466PTN4L2TVA6Y3E7POAQEQGA3CLINZV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/466PTN4L2TVA6Y3E7POAQEQGA3CLINZV/>
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

