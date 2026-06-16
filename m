Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEACACDB471
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:44:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 08FC16023C;
	Mon, 22 Jun 2026 09:43:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 08FC16023C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1782114246;
	bh=QFUfyWDZ7jBPugSWk6RmS5YMcXyiK8VRmnUoLKuBncw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=q/PSi9rnY0mRw3dZwFNXCPzWDFiJfYB8llq46SY6yOGTeTQ89BUu4ACIQL8Tef9lp
	 BovPNgVmmF7TpH0yiRBeONJoh/wUeLYZrTxGxXSuZiJF4iO8cv3hRNh2YDmgMKh97t
	 okOJjsE3H5KWABJ3BTiX0uhJDoIe+6zSVn7WB5+0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B9E93F8067B; Mon, 22 Jun 2026 09:43:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7B44AF8067A;
	Mon, 22 Jun 2026 09:43:05 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B0B68F80495; Tue, 16 Jun 2026 19:35:12 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=209.85.216.44
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781631311;
	b=d/+1e0KDT6VvohbNst9q5k5AYnenrbKXX71Yjzq1EINnrT9V3c2K59eBZ/zje1ogQtYp
	 Nrvh3LQtpp67M/qlG4Rkq3jn/rnheeupNLJ267/Qd5WSapuhKUzCtbSZMV3fIg/PlDNDd
	 J3Wb1wRUAS6X9WG6kFs7ysTgaHqQwkunDk7c2jR7C+WbO4s3kpv/jIGKk4n6bqtCtW904
	 nfCkygy2fc9WhRLYxt9mmaTNcwBw+9TNR9U5fNbDQ6/nrkvLqlKhjzNZ4XwJQwDF6OczM
	 OGwsnb/7hUq78WOf/5T1BFf6ZAigitT23ZMZYJ5z4QSYIFSHtloUeFbAkO/DzNWuwjg==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781631311;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=QFUfyWDZ7jBPugSWk6RmS5YMcXyiK8VRmnUoLKuBncw=;
	b=ldjTuYCxx7RcMcv1kizrOBaXbQO2LtjAcRWbja1o36TCY6tRROWp+0FY0jZThr0v2ZA8
	 xiCS/pmUTLsmWpGxg27ex53iifb5xIk5FxN+9keXxnlPaWTV/q5A30i5HkqwLCHamf4Cy
	 3U+JURjbv8k8npuajIkvcKKwVl11jx4K6f5CaRomQZLpK/xaxUhh4zI30RfO062OzvNZf
	 7yb+wBvOx1VA7B1ObbBvH2jfnX+4UyIwiNoDGe5cmW4MWNGuqHICYKSW5qnoefrVEUwei
	 gKDd8PLsk8EnuEWUi7FVVild7WDLAnDO0yltu8ewqKI28BPkm3MWMZ3AqJskIcy1gUw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aHfiGkvX;
	arc=none smtp.remote-ip=209.85.216.44
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9B6EFF800C1
	for <alsa-devel@alsa-project.org>; Tue, 16 Jun 2026 19:35:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9B6EFF800C1
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=aHfiGkvX
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-37c5b9d42efso55953a91.1
        for <alsa-devel@alsa-project.org>;
 Tue, 16 Jun 2026 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781631308; x=1782236108;
 darn=alsa-project.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eddoeh+529KrI4UXlEjaC0Bj1TBtvgIqM8rPX6PagYA=;
        b=aHfiGkvXTk4CejUB/hmWP9doijAa/qrLD9mZUgHIsCFPtCh2S3UKywC6DWw2wReFRg
         Alvga0iPuopypg+h0zRCVVYYywHbkqI95lqAKaBAxpmkdJfvYZOIJ22cxeB5LNpGtS3a
         qOmd4bQoriysxktqCaGVK+oO+wRp1uCda9hRhycbZYypxhbtzU3uwv4aBjOYjXFL2WJQ
         ieoPq4oDLl0/BywiwngzDcVLAL3uJhKDkhWWANBnZ+2Lz4QA3dBR6oyLBzZ03O5/fTZ8
         zRzFpBhDTdOVcRgs+PC8Yvdten8sWBvawv2uUWolgOkPitipXffUJzz8RhtzW4A3ONot
         9hEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781631308; x=1782236108;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eddoeh+529KrI4UXlEjaC0Bj1TBtvgIqM8rPX6PagYA=;
        b=isopCRdfVRWYmk0bLErwxah9VCva3F4lBWJ7IlyhKakKJ8D/xU4ZgUr3FxMz+HIdjk
         eneBdNUVrFdQ7FMIPnyIAOzdZUCGbDac4blugM664+5e/76mhAA/QJdBDqJalCtyy3UM
         LxhVH414VGyPpHmUqC1eHfcjYZ4iKVQRVqrbfRVdh9bdZMYImXUQfmSS4Y4UqQl3QXW3
         T7GxLKfnqUgutfW2ZfKAQ4BY8zHMT1X30E2dg7BpLkclhJINw0rugYLRg7CoWIO0SJm3
         FuFz1S5H+AxyfzTJkZjfmlhtnmVjhfzSFoSl0iW6A9f1c3czsHK9mPr8Eyen3Vk/0nj8
         0GpQ==
X-Gm-Message-State: AOJu0YxqhaUD7EPSZ/7Tqj+64yB8AYslZyz4pO1DHc8dTK2a6Gwksi67
	PMuJaN1II8OKlvS3eS7N3NM0ChGbkYoyD+cA0tSdrSipo+EuOCdaPJkZ
X-Gm-Gg: Acq92OFuibdGlfZjvb4jAo3xr8O4fyBPtzeD2jYiuc8d0pcNKSMl1GblFGMxkDMjMJD
	X9dEotPty2L4mwrSy/gRQ/Jtm1HntfeVcOY2L0I71t+Rc/AFfsCLeADZDWEiWM4tnoXwYwstP+1
	mzmvYjKfQsBM6vkWwBFzcX14AUXGfXTrh7zPu3pc2q23mK6era3TFRNhjrHYWNG9oaqvzISm08v
	KEAmDs1Usn3gqbMc2dBf79kK6PEhVjRSdhUR+Jg3iTu8rI9O72eUmwPrjR533TJdbZMgPBsGwni
	vcstgwlgs56uZTtxEvl5j5GuWqMH3UNUkU3iwJlw5kojqmnGGIFEnp8gKkHUoR5ZEotvVdh1ko1
	FhJPSFbUVjpThWSUETuNe/mv2I1SNgjYPjHiYo9N4vUgsIh+76nl24T5YBoPwp+swmPyxT72lco
	sEBBpY5P91dVO5snrWKk0M1/s5hUZk5A0ahQvXokRZFQEO
X-Received: by 2002:a17:90b:38cf:b0:36d:c138:e0a0 with SMTP id
 98e67ed59e1d1-37c8e44c2cdmr538734a91.2.1781631307993;
        Tue, 16 Jun 2026 10:35:07 -0700 (PDT)
Received: from tall-manderson.lan ([2607:fb90:9c20:d8f0:80e2:7be3:c57b:988d])
        by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521e76d1sm3491956a91.8.2026.06.16.10.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 10:35:07 -0700 (PDT)
From: Galen Hassen <rwekyes@gmail.com>
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	Galen Hassen <rwekyes@gmail.com>
Subject: [PATCH v2] ALSA: hda/conexant: Add pin config quirk for Lenovo
 IdeaPad Slim 5 16AKP10
Date: Tue, 16 Jun 2026 10:32:57 -0700
Message-ID: <20260616173257.37373-1-rwekyes@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <87se6mrah4.wl-tiwai@suse.de>
References: <87se6mrah4.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: rwekyes@gmail.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: NEVPDW4YJZMOLAQ6SZJCCZSMZECNGUWT
X-Message-ID-Hash: NEVPDW4YJZMOLAQ6SZJCCZSMZECNGUWT
X-Mailman-Approved-At: Mon, 22 Jun 2026 07:42:56 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/NEVPDW4YJZMOLAQ6SZJCCZSMZECNGUWT/>
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

Changes in v2:
- Move the quirk table entry to the correct position in PCI SSID
  order (between 0x38af and 0x3905), as pointed out by Takashi Iwai.

diff --git a/sound/hda/codecs/conexant.c b/sound/hda/codecs/conexant.c
index e3b6aaabe..3d9226276 100644
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
@@ -1114,6 +1125,7 @@ static const struct hda_quirk cxt5066_fixups[] = {
 	SND_PCI_QUIRK(0x17aa, 0x21da, "Lenovo X220", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x21db, "Lenovo X220-tablet", CXT_PINCFG_LENOVO_TP410),
 	SND_PCI_QUIRK(0x17aa, 0x38af, "Lenovo IdeaPad Z560", CXT_FIXUP_MUTE_LED_EAPD),
+	SND_PCI_QUIRK(0x17aa, 0x38b6, "Lenovo IdeaPad Slim 5 16AKP10", CXT_PINCFG_LENOVO_IDEAPAD_SLIM5_16AKP10),
 	SND_PCI_QUIRK(0x17aa, 0x3905, "Lenovo G50-30", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x390b, "Lenovo G50-80", CXT_FIXUP_STEREO_DMIC),
 	SND_PCI_QUIRK(0x17aa, 0x3975, "Lenovo U300s", CXT_FIXUP_STEREO_DMIC),
-- 
2.53.0

