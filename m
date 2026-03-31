Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4EA6D3515C
	for <alsa-devel@archiver.kernel.org>; Wed,  1 Apr 2026 09:48:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 794496020B;
	Wed,  1 Apr 2026 11:48:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 794496020B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1775036930;
	bh=2GnK+Nlwm9bg1PaPeyqmBcyqU/7DjutpTZp06XVtIvw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Pc9SjmetMl/9FdvoNEHoE4GkIBYiNbIz3rT3SshreAU2MXwX/IKUF7rNFd8HjAyFo
	 R0NtFf6Pc30JK4iFgZ3nJajewHGJNmqGcWbBkOJ7EvHQnWvUKKKwHyBlhaLOHkjPnY
	 nE/kkcD2QAhXRp/9Qrj5LRK2FrE1rwamIUciNXmE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1F5A3F805FD; Wed,  1 Apr 2026 11:48:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E2772F8060A;
	Wed,  1 Apr 2026 11:48:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 1267FF80549; Tue, 31 Mar 2026 10:30:11 +0200 (CEST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 694AAF80020
	for <alsa-devel@alsa-project.org>; Tue, 31 Mar 2026 10:29:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 694AAF80020
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=MfZQUgQQ
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-486fd27754bso53446555e9.3
        for <alsa-devel@alsa-project.org>;
 Tue, 31 Mar 2026 01:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774945790; x=1775550590;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1kHp9oqEeREnWh2HQ68CB/eH7dqBHF/gYeCZeyUXvUw=;
        b=MfZQUgQQZkkz0QPwpLmCJchggZIzWkNZWLu6bxTC454S5pNjqQEG07/6gnKCSGpg3X
         rwKoAUEVrcxRShRFtmdGIvUMPMIjOEqWCq3ZlLvMUIh/nmvwq2ePAvH2hBKTfQLHBuz1
         P4/NrAELxRPfYm86jpTinX1f7Wyv60TObHY2lJVCL0loE2dLf9ZMZnxN2BSLN324uS1+
         Df9dZ+HmGdv/rx1GxZBCKzXp6fMJba/Q1vxyDNAUsbv5moi587ASdGd2VaCyaEoNW1vN
         TzkD9cf2BdskhvhdiN3wS0KlL7rEDrL+Z0OGBPbSUP3ld8WmtDdj39VEO2BbllGtatFb
         eHHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774945790; x=1775550590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1kHp9oqEeREnWh2HQ68CB/eH7dqBHF/gYeCZeyUXvUw=;
        b=pnv4RjKIYCo9kd753J9hXT5cN3RVdzTXAUA4Uz7aXT+37J7GXVJ26X42yaoqDwtqvm
         UNcbem6wzwF/b0wX42jKBPxDXa7Yhi1x1VLAHFs5lTYNPk4eijFRItAOglYiX8htgQJu
         zXf5Vd7hzdWneYVymUorZ8AO8mgrX0VW/oivJZu2L5vFGlmaPbW/830BmE23i5PJ2aep
         nQBFebv0iY8zMlQDAKbn5CjqIUuq3icgYm9jkyA0zOZqn2NwBqkNLlrP3+/jaoOMlLVF
         NT2fcz6xFBI4fbXyjTeG2TLjg0dS97q+647KaIwo07Yy0mMSBs4IVi9KiBIBUKfz4R4w
         Ftaw==
X-Gm-Message-State: AOJu0Yy03t4u+CAQafFn9tw4GfZjOdNBjzzEH+ptyBY+4Tb3znglfx6f
	xfxl9W1sErv8EFvaKJcE+EkF9FRTdKoG1TzUlsnLT8zXnLgkmgtKmrgy+SeBW6QCu6E=
X-Gm-Gg: ATEYQzzsnuDFlce1BHyffk8W2lrMMi4oxr5mVmB9wKnqxvzbNonE420y2UNRdAoeMMq
	+C2tKj1FzWv11WKtoOCqB6jp1Dewrv8nkU12Tb70Rc7PThzJDM2SEotRspoXHfEyZ0QqUH7Gh71
	iM2AdLd3GYmL4G6Q22iKGXdBEvFw7k5C9Bbaq/phtCa/7iU8ZHriuFdfdZ6o65W16UD8PwMlcgr
	JVwGPZIPPEoQy4BnPavgSQWsw+HdJ4zeAHheeaXREZTmSJRXcVjjswNpdMakjVC559ZXWzgqSDx
	NCcohAIVtfoU9p/1GjbJTnyKnby6a8sGo3jtBPvzHaE2XFktEZh9dsa8t5tDT5O8Z84N/xz+JQ4
	igHLhIpPY8eux9cE5KNVqaspOdwLIloO5fWdmR7j3zsbtJB9IbZaNrimM5C9+GXyhi5RCAWZLU1
	opv4OHFDPVOJdDpObz2Ma4DWVM8ZtE5FR9vdt7h2rtY+hIRmUQuDAkQ8Sbt8QeOrzFykP1BydFl
	EFHhbOVs5bYcuQ=
X-Received: by 2002:a05:600c:528d:b0:488:7f49:eae5 with SMTP id
 5b1f17b1804b1-4887f49ed4bmr13675275e9.16.1774945789742;
        Tue, 31 Mar 2026 01:29:49 -0700 (PDT)
Received: from alex-Yoga-Pro-7-14IMH9.. ([109.185.185.217])
        by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887c884b8asm10256865e9.15.2026.03.31.01.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 01:29:49 -0700 (PDT)
From: Alexander Savenko <alex.sav4387@gmail.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	linux-kernel@vger.kernel.org,
	Alexander Savenko <alex.sav4387@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for Lenovo Yoga Pro 7 14IMH9
Date: Tue, 31 Mar 2026 11:29:28 +0300
Message-ID: <20260331082929.44890-1-alex.sav4387@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: alex.sav4387@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: ZCIAJGJZLZL5PVHXWI2IONBP2TIGVJBC
X-Message-ID-Hash: ZCIAJGJZLZL5PVHXWI2IONBP2TIGVJBC
X-Mailman-Approved-At: Wed, 01 Apr 2026 09:48:01 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZCIAJGJZLZL5PVHXWI2IONBP2TIGVJBC/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The Lenovo Yoga Pro 7 14IMH9 (DMI: 83E2) shares PCI SSID 17aa:3847
with the Legion 7 16ACHG6, but has a different codec subsystem ID
(17aa:38cf). The existing SND_PCI_QUIRK for 17aa:3847 applies
ALC287_FIXUP_LEGION_16ACHG6, which attempts to initialize an external
I2C amplifier (CLSA0100) that is not present on the Yoga Pro 7 14IMH9.

As a result, pin 0x17 (bass speakers) is connected to DAC 0x06 which
has no volume control, making hardware volume adjustment completely
non-functional. Audio is either silent or at maximum volume regardless
of the slider position.

Add a HDA_CODEC_QUIRK entry using the codec subsystem ID (17aa:38cf)
to correctly identify the Yoga Pro 7 14IMH9 and apply
ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN, which redirects pin 0x17 to
DAC 0x02 and restores proper volume control. The existing Legion entry
is preserved unchanged.

This follows the same pattern used for 17aa:386e, where Legion Y9000X
and Yoga Pro 7 14ARP8 share a PCI SSID but are distinguished via
HDA_CODEC_QUIRK.

Link: https://github.com/nomad4tech/lenovo-yoga-pro-7-linux
Tested-by: Alexander Savenko <alex.sav4387@gmail.com>
Signed-off-by: Alexander Savenko <alex.sav4387@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 086c05053..8efb3e363 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7622,6 +7622,10 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3834, "Lenovo IdeaPad Slim 9i 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x383d, "Legion Y9000X 2019", ALC285_FIXUP_LEGION_Y9000X_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3843, "Lenovo Yoga 9i / Yoga Book 9i", ALC287_FIXUP_LENOVO_YOGA_BOOK_9I),
+	/* Yoga Pro 7 14IMH9 shares PCI SSID 17aa:3847 with Legion 7 16ACHG6;
+	 * use codec SSID to distinguish them
+	 */
+	HDA_CODEC_QUIRK(0x17aa, 0x38cf, "Lenovo Yoga Pro 7 14IMH9", ALC287_FIXUP_YOGA9_14IMH9_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x3847, "Legion 7 16ACHG6", ALC287_FIXUP_LEGION_16ACHG6),
 	SND_PCI_QUIRK(0x17aa, 0x384a, "Lenovo Yoga 7 15ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
 	SND_PCI_QUIRK(0x17aa, 0x3852, "Lenovo Yoga 7 14ITL5", ALC287_FIXUP_YOGA7_14ITL_SPEAKERS),
-- 
2.43.0

