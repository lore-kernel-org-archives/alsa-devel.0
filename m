Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29842CA5FA5
	for <alsa-devel@archiver.kernel.org>; Tue, 29 Sep 2026 19:10:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 49C9E602EC;
	Tue, 29 Sep 2026 21:10:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 49C9E602EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790709019;
	bh=mqNxGtc2qZj/pB7g0jn0pOCaDg7IRzMAZBIJBCo08OU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=LscHarI2hPc0aAAtGBlmEeJuTnFHCgy9Idkx5NED6sG5CL6MqrDkzPzjrZnqGyiYz
	 KAtJBkRuvxNYw2NWH5IzMIH/kuyhtRjc3X5QI0oi81DWyc+tUDK+5R51c3jgGtGzAm
	 xG6k7OI5v1NfZZafN3PSZIe0Su2Bu/Vk2nxPwKlo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5D0AAF806EC; Tue, 29 Sep 2026 21:07:14 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 80A4EF80C25;
	Tue, 29 Sep 2026 21:07:14 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DCDFCF80525; Mon, 28 Sep 2026 15:43:52 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=74.125.229.205
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790603032;
	b=aH4BZsjJRDYW/9tK9EwVjjmOYvcPruck6gEFMKJWGekFtjMEF4gtRuM5b5PHLgyBsva7
	 PcdkgRY37msw7m/5JlkftfqwtVtaC27pbF4N3yf46eoCHf3UZP7O9mFEBlyTeGWvTRZKQ
	 BMcaxgcqUkwUbCjEN8ubfClKS28mzi+stfGNKOlNSo4i/i0F8NMbTOkC1jl5yhjngfDel
	 xDRsb9zn3HethpdxZpq3TzoAgcdyGu/aWnDfTs2Vy/vWfRZAnH8MxbWV45ramz5RYczMQ
	 kDKqgrpIwUzFg4mxpj+wUN0o9OAdBwVWv4l2hytVwVBwp80uCGMAHdWx/MFEYFQvpzA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790603032;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=mqNxGtc2qZj/pB7g0jn0pOCaDg7IRzMAZBIJBCo08OU=;
	b=jX387/0FxkktQCzDEr+aTxcrWf2jsxccTQhaFo03SrT+OAKT3s4buRvx0GuCjgi7pMrQ
	 TyVZgEcrbFHDXKSGYUfS91ldXawgwGP12qxutuC+/7IysFIZVd3eNtruvW0SUk6nhn1La
	 XLsPKdNSd6hPmrdRAir/lOtLKb0YGbXTfqTTDCs9oyQYePnt7N64RFZRvtdNNCyobEbxg
	 cnR9jrSIxN6n9Q+TzhWd27NFCmQy3NJ9wvo0kVgppIQoZeKcl2T9Yvwtad/VnU6EuPzZz
	 DJSFSHGaJGD6GXMI3pxaCelLjpu84kbT1tIfGlX/d/6pUxQ/Emc2bfk0nqJD0TZOiJg==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b="Lf8h/vrC";
	arc=none smtp.remote-ip=74.125.229.205
Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com
 [74.125.229.205])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 29F1FF80301
	for <alsa-devel@alsa-project.org>; Mon, 28 Sep 2026 15:43:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 29F1FF80301
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Lf8h/vrC
Received: by mail-lf2-f13.google.com with SMTP id
 2adb3069b0e04-5b899413537so4187226e87.1
        for <alsa-devel@alsa-project.org>;
 Mon, 28 Sep 2026 06:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790603030; x=1791207830;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rOxLA1JMar839B+IImDVjERCRoDtVDtOiXPwWspWPbs=;
        b=Lf8h/vrCvAOHhY1DvKp8HCkdn5+YnR4Ib6bpkeY9jzKCaWe+xwFXud4N/IqRqGT0Q+
         rXiFaf1HjJ4OV2eNP6g3GIC4esQGsg8ZRLFBLP1kU+61POwoyOgvbBcbYq0k/JAfbeZa
         qRhYVMASufGHswN/6PNIT+D3giuE8fkVFGEUejHfqVrY7AXlFVgHff2VM9QrOsknfpGF
         aIbIuHRvsNRg3H7qy2vepHtYb/gUId/8ShELIX6U5uDKoeYidiLK+V+zHGlHyzsmlpil
         GgjWEib6xPwxDNyIY0tpQFTtQnfqPe6y2MrMx6sGodd+oge59bOxxOr2DLhyVzLZiOix
         sTSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790603030; x=1791207830;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rOxLA1JMar839B+IImDVjERCRoDtVDtOiXPwWspWPbs=;
        b=1YQWYqEv+h3NZYozoqE8YkH7odXQxPjqRVE6KxGnt1IUrsdtmwLFa8pakspsVApibK
         uTR3rVE/M2WKXL9LKRctW3pOjfDNxqLZc8HpOol589Qy1oHCIScEnT2G0FiaQ2WhB5ET
         c9b6VbdOn9U/AXQnru2th7upa3i5hVT6PLe5G/l5Eewx9ulnRdGdUVXtKg3pyCbJSsYm
         vvbA0u1jz34C2mTfJShXvmqvKzA08RiQif2I0UVCzdgS4A7G2Lw+pVXj137AQgQU5fgS
         1lJTGTn+uyEKUAfMVg9vt/g4ZcyFuOY3Q9RmLZQzWjO365gRxO+mJR94Vl4+yGp6Q4iO
         UvQA==
X-Gm-Message-State: AFq9FYLNdS83j9YE8VFbAjeo/Tko90Bu6LSYWUUzIPi14yKAzWPaImyI
	2TRZpglCAzoyXbHRQqLxTbcubZzyaNsJOtQEh7nURCWu6etAtCW7K5c1
X-Gm-Gg: AYBFou1IBG6R+pzsUZfUZQHfcuIRGW3u3hJnjSJT4ddaSU2oo1BjiRvd2PWlwLSIffU
	sX0J1vQSPe4GH3e46N/eD+rkuWbS7Q74dRgMokIPFFuE4uHW5ai46H3YeT3Emr+RKxVGc5uWQzA
	2g0gaK3ADaRDM84mOg16SgPzld07QHJM6d6BmxMNTV+lWQ7Ucg69zL2jkKt01/uN+gZA0cTGG3D
	gMDUiqluIvK84ackFgE4HkbuIdKIW69JN521ucWAwNdVAxxIFmoDgGkpZS9MWsOK0HWlgv0ac7i
	miK1P8gMLpHVriUJaNlDHCIc7Y3gpRX6J69TWdwEdjIe6tv4PaCRO+WipEyqXzItW4RYtkGjit1
	WEGAdJip/FHsCfpnTQJLI4S8Ymrzkc6aLWm8nrWqn5v0AYQIrxPCD/PelbUXfZBD0045lUnMaEO
	fNtOpJNyzU6tuYxOs5xSOkzrjsu7APMCdtu6bXXbnKJQkgdxg5qPOvVMHRFvPYaQ9bimz66tvKN
	dwqucOL0dmLL/7eR3VGtYHyti8xRSPWGHciTP7ATvQiLQvTngT81O4WGRWG7pWk/hLpX+i9YF6+
	z1ozs3p82xqm3aNBAbF/NY4bdKYtR8+KN2U=
X-Received: by 2002:a05:6512:b28:b0:5b8:f7fc:959f with SMTP id
 2adb3069b0e04-5b8f7fc976fmr1468909e87.60.1790603029893;
        Mon, 28 Sep 2026 06:43:49 -0700 (PDT)
Received: from DESKTOP-P8LEVVU ([2a02:2a40:1afa:d200:255c:8e92:476c:7c40])
        by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b9debb25a9sm570634e87.44.2026.09.28.06.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:43:49 -0700 (PDT)
From: Bartosz Brom <bartosz.brom06@gmail.com>
To: perex@perex.cz,
	tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Brom <bartosz.brom06@gmail.com>
Subject: [PATCH] ALSA: hda/realtek: Add mute LED quirks for HP Pavilion
 15-eh3174nw and HP Laptop 15-dw1xxx
Date: Mon, 28 Sep 2026 15:43:35 +0200
Message-ID: <20260928134335.1875-1-bartosz.brom06@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: bartosz.brom06@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: RB7WUNMXKWIKCN6XARRUMQICRHIL6I2W
X-Message-ID-Hash: RB7WUNMXKWIKCN6XARRUMQICRHIL6I2W
X-Mailman-Approved-At: Tue, 29 Sep 2026 19:07:08 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RB7WUNMXKWIKCN6XARRUMQICRHIL6I2W/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The HP Pavilion 15-eh3174nw with an ALC287 codec requires the
ALC287_FIXUP_HP_GPIO_LED fixup for its mute LED to work correctly.

Add subsystem ID 0x103c:0x8bc7 to the quirk table to apply the
existing fixup.

Tested on an HP Pavilion 15-eh3174nw; the mute LED now follows the
speaker mute state.

The HP Laptop 15-dw1xxx with an ALC236 codec requires the
ALC236_FIXUP_HP_MUTE_LED_MICMUTE_GPIO fixup for its mute LED to work correctly.

Add subsystem ID 0x103c:0x85f1 to the quirk table to apply the existing fixup.

Tested on an HP Laptop 15-dw1xxx; the mute LED now follows the speaker
mute state.

Signed-off-by: Bartosz Brom <bartosz.brom06@gmail.com>
---
 sound/hda/codecs/realtek/alc269.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 5127a111c59c..daca68ece94a 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7388,6 +7388,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x85c6, "HP Pavilion x360 Convertible 14-dy1xxx", ALC295_FIXUP_HP_MUTE_LED_COEFBIT11),
 	SND_PCI_QUIRK(0x103c, 0x85de, "HP Envy x360 13-ar0xxx", ALC285_FIXUP_HP_ENVY_X360),
 	SND_PCI_QUIRK(0x103c, 0x85f0, "HP Laptop 15-dw0xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
+	SND_PCI_QUIRK(0x103c, 0x85f1, "HP Laptop 15-dw1xxx", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_GPIO),
 	SND_PCI_QUIRK(0x103c, 0x85f3, "HP 250 G8 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8603, "HP Omen 17-cb0xxx", ALC285_FIXUP_HP_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x860c, "HP ZBook 17 G6", ALC285_FIXUP_HP_GPIO_AMP_INIT),
@@ -7581,6 +7582,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8bb4, "HP Slim OMEN", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x8bb6, "HP Laptop 15-fd0039nt", ALC236_FIXUP_HP_15_FD0XXX),
 	SND_PCI_QUIRK(0x103c, 0x8bbe, "HP Victus 16-r0xxx (MB 8BBE)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
+	SND_PCI_QUIRK(0x103c, 0x8bc7, "HP Pavilion 15-eh3174nw", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8bc8, "HP Victus 15-fa1xxx", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bcd, "HP Omen 16-xd0xxx", ALC245_FIXUP_HP_MUTE_LED_V1_COEFBIT),
 	SND_PCI_QUIRK(0x103c, 0x8bd4, "HP Victus 16-s0xxx (MB 8BD4)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
-- 
2.55.0.windows.5

