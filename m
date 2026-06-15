Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A70CDB46B
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:43:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 22BE0601E1;
	Mon, 22 Jun 2026 09:43:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 22BE0601E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782114231;
	bh=9T5TXJjJT/W0S+9iEkwNGDuS1oeznvsFaTswzHNnstg=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rP03wIi8iWFQGpaYxwbUdUriIQ2SDLWSVGHAlCFPTcDmRbUJxfiYZ7zyoi3cQixov
	 3M5fxhw+GKceh+frFEWQ8Q1wRa1PXGnlPevKcWrmd0InNCpob4NMQ47gNUFvOjoGbK
	 1PrcuCLTR5q2yisUWAiqTNsUAPAp1gkMSRRch+l8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C5488F80635; Mon, 22 Jun 2026 09:43:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 592E8F8064F;
	Mon, 22 Jun 2026 09:43:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 69328F80495; Tue, 16 Jun 2026 01:34:04 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781566443;
	b=jSLWOoZ+e5MY4eDdyU7cZ20WvfdLajpQw6S8YwZm7562e+tDnvM/iGQmu3EO5KAW7z9i
	 xGx+WsJDXDfBiCig1ERNhMBNnjdalfKbGNnWkMewNmm7bsScLQn6jLovgSzuZC0IFRgbL
	 FPiHibkbE1fC834Ionqp5lUrKqDsagopropPvv/g4+OUSSbVFqHuZ8SO+xuLzYvjvxsAZ
	 kKaJRKaCqo6AeAqLGKBVLifTCnu0fD9oBB5huvy7fQxhHsDDs2aXrwbhI5UICNiM7eolv
	 Q+8voa+6dyL42Cc118obkF7J7XOc2BcaM117Gc/FMZ8PihZQlVriIpsEMg9ajwN4EGQ==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781566443;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=9T5TXJjJT/W0S+9iEkwNGDuS1oeznvsFaTswzHNnstg=;
	b=pqCP3PwI5Zs+BUDknYz5EQ4X6A5QREfC8PMoUEFIc4GUoVH+hHABe6Na0CLcF9RHIBk2
	 AVlozFIwLPR2YfqvmV6QKLOq6a+8uA6Kc+z6Up+KCuzRZBw73Ddk5GaNK9jf5tQOFNvBv
	 j0Rk/4Hn8KjqY8UuWZBvpT8tPNClqSMOUzJX0GPQGmFwzWdioxyE2xRLvHBqNU9qJlPx/
	 zC9s96/2XGFa9mlTyYXY7UYLRWhxdh38VvVSL1L9KBcBEBqJPR+PO7eXc/NOLcRvlTRd5
	 up9cuizw1alXXJX3xp5zxCzLlOgYnl1Q+IQmgnjpoJnHUCLDm3bXg8+m/qtc6jEzE1g==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iwSbpcBa;
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 68334F80038
	for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2026 01:34:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 68334F80038
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=iwSbpcBa
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-36d8b644473so3398284a91.3
        for <alsa-devel@alsa-project.org>;
 Mon, 15 Jun 2026 16:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781566440; x=1782171240;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p8FuvkiARpXIOFd5JwFqJggn0SYUMBb/rFOpyqvH+ZM=;
        b=iwSbpcBaBdaa4GEpYZxGSRBngHesRKzVoFLoEQrvAnN+eNSSod9pInGc8WN4hEDz6m
         NY8ORBHyfo08aYjv+KcF/llYoTXyHTNj/irPHFMR4IGsB4s5zl5tURSOp8FKCcTyhqwj
         2LzB1dQIsbcHveYWJGUbUqlCdLvUqk1UlWTEPITwaYw/GlTXGBqfIUHP/H91SgkFOCeu
         qj8rorGfS3bhg0rKyDD46ttKEzaF5s9/3R9Z1h89QdNjP9BKdWn9cLTYuctbWqUMKoSN
         PNYbesZyNLz0PKc83BtU7v6lN2zh5W+f9zsPH1y0D9OknMTN3pm/bWxzW4ODDL5ORsCK
         uxCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781566440; x=1782171240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8FuvkiARpXIOFd5JwFqJggn0SYUMBb/rFOpyqvH+ZM=;
        b=KGZQ726GFcFqTL3Q/k9fLGlmH/a5NE2romRfqCyXwWFFRNDhiuxnynquLCw3LdQlVb
         BUGsnRDRGAvKf3u+yuRPi/VNFfIlJbl4wejBx6PF0ccOZbq2ozagkPwkEKBs6IZtenqw
         4YmMh9Kh/Pj8DczMa+TXoogZG48EQpOoEA3C+Kh4ShWD+zMElzcte0lCEFCu5oCxsgDV
         UFNW759LZkBf0PQ9EBNspzSvpPNhla2NW5+knn4s8qWm3KKqVVnRm23TkJfeWN5aVVpH
         EY1ZAUyI0vPBQ97whMQ60KIqihEtFMPC+UrEdAhb9Tb4r+TSLcut/lWTTNfAUNc2ax+W
         0tRg==
X-Gm-Message-State: AOJu0YxcEiPN54KeUIktBD1XufnJtcizXQZDmsNFLWb8d3JHCKWqlGDI
	SOvI1k/Lm6y0YlIKpLftF0qFzYt+o0jQi0rTp6pj9EzpokqsqArXgh4n
X-Gm-Gg: Acq92OFDoWQZjK9k0pWm7IQlw1oLyXznugUcZXmMJsKZwColpsWvdJ4M+NydRfXyqsV
	g5I5J6v7+Lwboo5DgnD8XCKia3QcYjyWj+TgHOQtQa+xkn1lMt4amsUforJqGhgVWBcudotH5zL
	Whg2htx4VMF5UCBkzqe79UG1nz/w8UUfHrMnD7bDsKyEaXF9Nu0yswNGRuPWJQNT8OFAoBUrUYY
	G1k8ey4hE4rRpM8EbJ/z9y/kr1x3o3FTg17x0ddmH9nhiE6v+L1juNdFVScdqnFlZkXa//b6A0i
	oX/9EtVC33hN5gArtAHimf0TfKzrf6XQhEcY4XTTy+80jaeOF9FzYrJNp7YvrNnX874m7BXW9HT
	f/VfzlyKCh3+CM5+9lPOxmpVw/LjCWrtX2uNpCiwzDnZ1RmnPuPK9Lc4QhvBN5WoCSQg1YYZumA
	BANM5MH+2B0q7MY5kuuTZeq+sGV+StufmxoA==
X-Received: by 2002:a17:90b:5109:b0:36d:70c8:3a3 with SMTP id
 98e67ed59e1d1-37c528e0f2bmr1211166a91.15.1781566439872;
        Mon, 15 Jun 2026 16:33:59 -0700 (PDT)
Received: from tall-manderson.lan ([2607:fb90:9c20:d8f0:780f:3697:cc13:5d3a])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-379e88d546dsm7118845a91.2.2026.06.15.16.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 16:33:59 -0700 (PDT)
From: Galen <rwekyes@gmail.com>
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	Galen <rwekyes@gmail.com>
Subject: [PATCH] ALSA: hda/conexant: Add pin config quirk for Lenovo IdeaPad
 Slim 5 16AKP10
Date: Mon, 15 Jun 2026 16:33:53 -0700
Message-ID: <20260615233353.19913-1-rwekyes@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: rwekyes@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: H7SJODYQV6ZRHAKFIQCPDJJDXRI2DC2G
X-Message-ID-Hash: H7SJODYQV6ZRHAKFIQCPDJJDXRI2DC2G
X-Mailman-Approved-At: Mon, 22 Jun 2026 07:42:56 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/H7SJODYQV6ZRHAKFIQCPDJJDXRI2DC2G/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The Lenovo IdeaPad Slim 5 16AKP10 (PCI SSID 17aa:38b6) uses the
Conexant SN6140 codec. The internal microphone is on pin 0x1a but
the BIOS configures it with pin default 0x95a60120, which includes
a jack detection bit that causes the kernel to treat it as an
unplugged external mic rather than a fixed internal mic.

Add a pin config quirk that overrides pin 0x1a to 0x95a60130,
setting the connectivity bits to indicate a fixed/always-connected
device. This allows the internal microphone to be correctly
identified and used.

Signed-off-by: Galen Hassen <rwekyes@gmail.com>
---
 sound/hda/codecs/conexant.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
index e3b6aaabe..40d4591f9 100644
--- a/sound/hda/codecs/conexant.c
+++ b/sound/hda/codecs/conexant.c
@@ -291,6 +291,7 @@ enum {
 	CXT_FIXUP_HEADSET_MIC,
 	CXT_FIXUP_HP_MIC_NO_PRESENCE,
 	CXT_PINCFG_SWS_JS201D,
+	CXT_PINCFG_LENOVO_IDEAPAD_SLIM5_16AKP10,
 	CXT_PINCFG_TOP_SPEAKER,
 	CXT_FIXUP_HP_A_U,
 	CXT_FIXUP_ACER_SWIFT_HP,
@@ -826,6 +827,12 @@ static const struct hda_pintbl cxt_pincfg_lemote[] = {
 	{}
 };
 
+/* Lenovo IdeaPad Slim 5 16AKP10 with SN6140 */
+static const struct hda_pintbl cxt_pincfg_lenovo_ideapad_slim5_16akp10[] = {
+	{ 0x1a, 0x95a60130 }, /* Internal mic, fixed/always-connected */
+	{}
+};
+
 /* SuoWoSi/South-holding JS201D with sn6140 */
 static const struct hda_pintbl cxt_pincfg_sws_js201d[] = {
 	{ 0x16, 0x03211040 }, /* hp out */
@@ -1006,6 +1013,10 @@ static const struct hda_fixup cxt_fixups[] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = cxt_pincfg_sws_js201d,
 	},
+	[CXT_PINCFG_LENOVO_IDEAPAD_SLIM5_16AKP10] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = cxt_pincfg_lenovo_ideapad_slim5_16akp10,
+	},
 	[CXT_PINCFG_TOP_SPEAKER] = {
 		.type = HDA_FIXUP_PINS,
 		.v.pins = (const struct hda_pintbl[]) {
@@ -1116,6 +1127,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo IdeaPad Z560", CXT_FIXUP_MUTE_LED_EAPD),
 	SND_PCI_QUIRK(0x17aa, 0x3905, "Lenovo G50-30", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x390b, "Lenovo G50-80", CXT_FIXUP_STEREO_DMIC),
+	SND_PCI_QUIRK(0x17aa, 0x38b6, "Lenovo IdeaPad Slim 5 16AKP10", CXT_PINCFG_LENOVO_IDEAPAD_SLIM5_16AKP10),
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
 	/* NOTE: we'd need to extend the quirk for 17aa:3977 as the same
 	 * PCI SSID is used on multiple Lenovo models
-- 
2.53.0

