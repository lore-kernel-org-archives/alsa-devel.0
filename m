Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA49CD4F21
	for <alsa-devel@archiver.kernel.org>; Sun, 17 May 2026 14:34:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F2B8B601FE;
	Sun, 17 May 2026 16:34:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F2B8B601FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1779028463;
	bh=pyzDA1spdtkDsnUqb1pzd4IA1kD84PLcswbD58Ir/TI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=GwUudmiKS2pKBr/CibVNGxRCBflVEONwEGfZMuV9i+r1oivNEztQIfXZK4JsOaS3m
	 TSPBfb2lVCpqNrI1EdNTJaUHprmg0Blvm4Aeb2BfBiMrbv1Z+9saa3SylxtmJdDCVW
	 H3xNZdSFfyhJCvNLsX+TIm+7FDyLQGnllP9ewjwY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 28719F805EE; Sun, 17 May 2026 16:33:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A7600F805EA;
	Sun, 17 May 2026 16:33:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id F4135F80217; Sat, 16 May 2026 15:17:06 +0200 (CEST)
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com
 [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id A59B9F800D0
	for <alsa-devel@alsa-project.org>; Sat, 16 May 2026 15:17:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A59B9F800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=mD3vjKE2
Received: by mail-qt1-f174.google.com with SMTP id
 d75a77b69052e-50fbd79350dso11546561cf.3
        for <alsa-devel@alsa-project.org>;
 Sat, 16 May 2026 06:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778937423; x=1779542223;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w1iiLMTnXZ3HRKof5m2IvmmuWm9G3cxep98kuAE+4wA=;
        b=mD3vjKE2dC4zPnQS9ypeDVW9TR/FrdnsLZ7GreWhA2cVD8xjtCFD89P5XhgmrRhzUl
         AniPUqker8UEPvxVF0+XmGq/Ald9a8+llUdPmpAfcHJGgi998cUrFHi3oiZlvetzgkHX
         V2xKkFnyFYyqeYZ4ieuoK2dBwWPVnpjpv0foF/i2XvZfqzeiFdkFYKMMa/dG0krdEp7r
         v8eipMr9M9QZAd0H2tPRFTIV0MDq52RmrYdhthnJQU5Pf10h0qxb1hSbkZW/u/vcpDcs
         7BW1F2kGYbPeXx8SLtDovzIHc1yiTm0SLfSJjKTvjdE1KS53ZcnpZzwxtdrG6kghEWbB
         RcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778937423; x=1779542223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w1iiLMTnXZ3HRKof5m2IvmmuWm9G3cxep98kuAE+4wA=;
        b=WvM6S0y2WrbPEDFOKvH4Wt4oQjv9V1keJBDcZFTDqhAuEhxC48wsFY2MBrIq0XKpbV
         4oaiZnkT0sQhi0FU75p8d8jZ79X52JXsyTsP5zCGNOI3Ll9UVS0GGJxt+LqnwQKs0Cmq
         nDgQbxFAsqlxqPJ2Fbsu4hiK2zWBEvXWUeU51WQQKcl0JNkapahwHm8mlyGUvR7vZqNR
         sLvnJG+ViAcHO+irxNbonHbKdG1bsQ8KzUtSQ9LL0DqyqO6AbAZK4RAZ+PGMOVjpsxHQ
         GR+2RmDs9wiGmkdeecW/TkjL76Fn+RwrXQc5HSj/4GIP6kiPHiqsipszGn7/z+mlSa8J
         dLdw==
X-Gm-Message-State: AOJu0YybgYhZkAd6NGkrKDbAJOrQDVNSiVtTEB4hCdYwD6KupKkRerqr
	zdpfydxXHn2zRdwHyxB82l6os6FsuTGS9Y7D46TE/JVMW/HvhiyBhMj1
X-Gm-Gg: Acq92OEgHVO3aF2lPXXfPFuxBiQN9njnvkyH43koOUTHAgT1D6ZvQGbtJtyGAYsmbY1
	CdlBh1JLc79iREr1A2xpF/Ces+hA6P+vLeOrZCbtoDR6FXpFIaqgFzgaViSEweCYsown2Gwojpa
	e5+Y6Q48vo484ld7iDYVnq3vUU4ZFWlx9a7wnyhEKIN4YipS7pIUqlJkEoqXTRcpFGFLTvdsqnA
	V7diAioMOBM0xI6/B3MPCyUbsPmm2SJvDsKAW33B5+PupqWCZKgSu321Kch5b6q78xwrf/wYRWL
	L4pzeZcn5dcXSok416eMIzwUWvkrIBSKPND8p5WQFMqhSjXjZJN3+iGz18jQTwpkPBdeBMMcALk
	6MIoDiUIPTe+UzDnTxSyT0RuwxHvAFjtEYg24vUJ2/DM8fB29z6kQBdBPTgnMqIsM77fdQsUTJY
	ojnE8QLbsnhQypFdDNh7ftWvhm7ZySFQHNw8cqwnG/GTbBbgU22f7j7dyfkQe8Rfo9DJd8zEhOZ
	STyZmZF6MLVe6viLNhihUuxXOq9AOdnnggzwZqv5uI+n5KOMklCgMV4
X-Received: by 2002:ac8:7d94:0:b0:50d:abc3:eed5 with SMTP id
 d75a77b69052e-5165a1db10amr108120681cf.29.1778937422824;
        Sat, 16 May 2026 06:17:02 -0700 (PDT)
Received: from sergio-HP-250-15-6-inch-G10-Notebook-PC..
 ([2803:9800:988c:831c:3ae9:178e:aa0e:2efb])
        by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51645856d10sm71755171cf.26.2026.05.16.06.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 May 2026 06:17:02 -0700 (PDT)
From: Sergio Boglione <sboglione@gmail.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	Sergio Boglione <sboglione@gmail.com>
Subject: [PATCH v2] ALSA: hda/realtek: Add quirk for HP 250 G10 (103c:8b34)
Date: Sat, 16 May 2026 10:16:50 -0300
Message-ID: <20260516131651.143109-1-sboglione@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: sboglione@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: K6ZWIAMGFIVJG22CE2MKU3KZL6TFLCAG
X-Message-ID-Hash: K6ZWIAMGFIVJG22CE2MKU3KZL6TFLCAG
X-Mailman-Approved-At: Sun, 17 May 2026 14:33:37 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K6ZWIAMGFIVJG22CE2MKU3KZL6TFLCAG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

HP 250 15.6 inch G10 Notebook PC uses the same ALC236 codec
as the HP 255 15.6 inch G10 (103c:8b2f) and requires the same
fixup to enable the internal speaker EAPD and microphone routing.

Signed-off-by: Sergio Boglione <sboglione@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index a9cd03bb7..11bcc2ef8 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7050,6 +7050,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8ad8, "HP 800 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b0f, "HP Elite mt645 G7 Mobile Thin Client U81", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8b2f, "HP 255 15.6 inch G10 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
+	SND_PCI_QUIRK(0x103c, 0x8b34, "HP 250 15.6 inch G10 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8b3a, "HP Envy 15", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8b3f, "HP mt440 Mobile Thin Client U91", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b42, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
-- 
2.43.0
