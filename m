Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091FDCD8CA8
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 19:55:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9088A601DC;
	Tue,  9 Jun 2026 21:55:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9088A601DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781034953;
	bh=0Hg4tPCMfrugvni1af4f972jkXP4g2mgFqjoxlPaLRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bIxpky1lsh8T522bY0qfhhw9sqX4nyAN+6PvsOTOcG4ryMvFR+GZS8UuLo68toxSX
	 S6+EE9O//ZYvgKuJHuq+vp6M6J17LTDUJkEWTDmgurLLBpccAYM2XwN0mVaEK39xib
	 DJUoJtrDWAlArHeAUetnl4VnHoiX4QoeA1HPbGU8=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9F04CF805F2; Tue,  9 Jun 2026 21:55:18 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 617CCF805F7;
	Tue,  9 Jun 2026 21:55:18 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 35D7DF80496; Tue,  9 Jun 2026 21:55:12 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=194.164.54.141
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781034907;
	b=dePQdxBQeYdDgb6vSV2WoJ/TE+AukH5oDvY9bVUgUgtKG8dBST1bhQ2Slnyb8QHxU/o1
	 vWMkZ/NFleTk0sZ+Ak3mw7mBbPyJ4rDbYRUKsoLPOwa/OPLPJyqTRDY5reNrfPYJVBJfm
	 7qsy/KigSX9V0FpBlVOD6MPZBbVOzi2w7VLoHQfVkfM7YnPqQk8l2Lwu+g02DNOv/MV41
	 Ga2Xf2IRMRfN+K0nv6Rw20N3iw0IA722svYZI3XytEG5OJ2guXwoHihWc2CEJSBACBAd7
	 LDQZ9nCS8+c86uNiM8gemb9zzcOd5SUt0tsnIn9C43+8JAYO+sOW9qsd1NXJaG1rp9w==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781034907;
	h=From:DKIM-Signature:DKIM-Signature:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=0Hg4tPCMfrugvni1af4f972jkXP4g2mgFqjoxlPaLRM=;
	b=FkWxv5iK9SjgC2xMe6mACBCAFRX4yU5UlmFQBiXT/6UDnhX4HpjcG0GalC+a8qtqY7WD
	 Z0S7vHxI/wQ6fe/z/MyFMQze3ju7VQXEHW01IxiTS20ywIZVETtYVTaKySX/ZYXDHpsbS
	 LtXasXoAxn7XoacDdhhEo/4QEGjP1gYYYCsfAhKwpIPMoQiRZnfR0z24F0gpw6wem/TCT
	 S8vGQMOdsFiB+bVj8Bf5ad6oSXNMTW4NUze5oPYZxuKpDilHeV0znIIL332cKa+N5rmQd
	 zhTV0s1Z3B3cXyMgUcE/hexsOCsTGfVDFLiaamqugrIKxb87Tdbqww5PNhW35suf7yw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=furst.blue header.i=@furst.blue header.a=ed25519-sha256
 header.s=dkim-ed25519 header.b=xcO99m2B;
	dkim=pass header.d=furst.blue header.i=@furst.blue header.a=rsa-sha256
 header.s=dkim-rsa header.b=l0MA9QZA;
	arc=none smtp.remote-ip=194.164.54.141
Received: from mail.furst.blue (mail.furst.blue [194.164.54.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C30E1F801F5
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 21:55:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C30E1F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass header.d=furst.blue header.i=@furst.blue header.a=ed25519-sha256
 header.s=dkim-ed25519 header.b=xcO99m2B;
	dkim=pass (2048-bit key,
 unprotected) header.d=furst.blue header.i=@furst.blue header.a=rsa-sha256
 header.s=dkim-rsa header.b=l0MA9QZA
Received: from k8s-mail.magi.furst.blue (unknown [192.168.208.120])
	by mail.furst.blue (Postfix) with ESMTPS id 8D28B40100;
	Tue,  9 Jun 2026 19:55:05 +0000 (UTC)
From: furstblumier <seal@furst.blue>
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=furst.blue;
	s=dkim-ed25519; t=1781034905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMIcxGQxFH2zTRQLBBx52uh5KCOcwTjhjoGXdk5q/1s=;
	b=xcO99m2BrzQAmmxU43aR/fb6376GwAnT5bjQ90Q7gupjnzkiYosH+3fD84zweaY7D8v7sg
	tEuqyuOke/3bCWBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=furst.blue;
 s=dkim-rsa;
	t=1781034905;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sMIcxGQxFH2zTRQLBBx52uh5KCOcwTjhjoGXdk5q/1s=;
	b=l0MA9QZAkp5Vot7Q1M4LowoUPssMCrcQH+lwTyuJsqs65wutQX5m7YgCl2NwoU4Ag548/q
	umYf5EQQMLqql1rursR+WlS3Iab/c3q8vCQJkEso5GmosvbvbDv6u46r9xmRPlkOp11Jw8
	sMIHl4XPdEVSWfWNYccnL3T/6hoSwb37yt6LrNiie9Xt4rTDVsV+oXvnIKQkzy9hq/n0sM
	0uKEFUFRILUIg/LTcN5Ax4I8kxvVQI56z48rVQPCdQNZAJTMubYP59PQPMLVA2P2NDmvRv
	LZyz+zZDpUzTxCnbwxnJLeKKjMEC5am3M7ZoToMuFHq28rwD0WG14cmpPypxXQ==
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	furstblumier <seal@furst.blue>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP 255 15.6 inch G9 Notebook
 PC
Date: Tue,  9 Jun 2026 21:54:43 +0200
Message-ID: <20260609195443.498879-1-seal@furst.blue>
In-Reply-To: <20260507202754.16114-1-seal@furst.blue>
References: <20260507202754.16114-1-seal@furst.blue>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4ZNUVXKLYCNEVMZ5SG7RKOO5CGBYLCJT
X-Message-ID-Hash: 4ZNUVXKLYCNEVMZ5SG7RKOO5CGBYLCJT
X-MailFrom: seal@furst.blue
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4ZNUVXKLYCNEVMZ5SG7RKOO5CGBYLCJT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The HP 255 15.6 inch G9 Notebook PC (PCI SSID 103c:8a1b) uses the
ALC236 codec but lacks an entry in the quirk table, causing the kernel
to fall back to a null SSID match (103c:0000) and skip the necessary
fixup. Add a quirk entry using ALC236_FIXUP_HP_MUTE_LED_COEFBIT2,
matching the HP 255 G8 which uses the same codec and fixup. This fixes
the mute-button LED and fixes an issue with unplugging and replugging a
headset jack not being recognized as an audio sink.

Signed-off-by: Furst Blumier <seal@furst.blue>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 11d0ea8ed..08c8b17b7 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7063,6 +7063,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x89da, "HP Spectre x360 14t-ea100", ALC245_FIXUP_HP_SPECTRE_X360_EU0XXX),
 	SND_PCI_QUIRK(0x103c, 0x89e7, "HP Elite x2 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8a0f, "HP Pavilion 14-ec1xxx", ALC287_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8a1b, "HP 255 15.6 inch G9 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8a1f, "HP Laptop 14s-dr5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8a20, "HP Laptop 15s-fq5xxx", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8a25, "HP Victus 16-d1xxx (MB 8A25)", ALC245_FIXUP_HP_MUTE_LED_COEFBIT),
-- 
2.54.0

