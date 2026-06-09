Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2A11CD8CAD
	for <alsa-devel@archiver.kernel.org>; Tue,  9 Jun 2026 20:18:23 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9D30601DC;
	Tue,  9 Jun 2026 22:18:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9D30601DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1781036301;
	bh=0Hg4tPCMfrugvni1af4f972jkXP4g2mgFqjoxlPaLRM=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=VEg7c2S1rYbDnKWScNYntb6SJJdwBmAt7LcPS/190NaGQPPIwfrN+mC2VS/o3E+RE
	 VjlkkMXaiPyCQYKNjmO+MmOXNLkgSarAKcy6e9NPGo6CwIVGCF/C8pULWajleaancA
	 olfAi/z7xT3H/mN4prqO04T/jwRiR7Fm0SbJ03fc=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 48ECCF805FB; Tue,  9 Jun 2026 22:17:48 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C7FDCF805F5;
	Tue,  9 Jun 2026 22:17:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7112FF80496; Tue,  9 Jun 2026 22:17:41 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=194.164.54.141
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1781036257;
	b=D1krGGFKrqp8GN6JdMBn6PRJzT7Q0Q7o3KmD7JnS0m1Ib9oeIUoE0OudhLYRLF7ZZkwD
	 WgACngSIZlncoQj28u3tBOj0L+mk8iNOZxwNiMbVdx71QKnHpnVO/RI55t0GNZ/b/9DJe
	 Jvrj4J+3O8bVEIuS6UygNpVKl/UprR9lnpueEQSMAiB13m8AkOJsB+Z821++h6C7cl5Cv
	 EZPdFGiVeKapyb+9bbCmEol+T/0HJGMcYTMoEswHi9QbIat0ud7pH1w4HdTOPwlSH2eyn
	 uRTYGUKOuY9/eOo5ev3ag/CU/zbR04DyLTj6dEaJHQEAX008o3bZV4qaFvIQfvhOFcw==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1781036257;
	h=From:DKIM-Signature:DKIM-Signature:To:Subject:Date:Message-ID:
	 MIME-Version;
	bh=0Hg4tPCMfrugvni1af4f972jkXP4g2mgFqjoxlPaLRM=;
	b=D33X5FG14tllpv5Ar/wL01B5E8pWQje7kzWya2TlcjRmBC4M9qjQV1a32Gs6jBsZzn1t
	 N8ilEyOJcnQOtlhAR6loIOSY3F0nr472wN5vNdmc0ue6HZRXxWsRmT1d4Ot2zt1nOdU8H
	 g8c0DTrogD9NX/p2mn+svIkNp5Bx6fs/cwl7P+exY9Qm8cg5W+OkpujvaF7oZHq6Sov4l
	 j+zPI73nPAFWh5VkIj4frRa6n1SU14OFh9KyGA26Jel6QSauZOXdRl3JsbWuJdJaLLrwr
	 nDLp6FEopVarGCKpDac/XhHhMo1pInKETlJUqt9NSosAW675nDlZoaSm0Zg5Qu4kHiw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=furst.blue header.i=@furst.blue header.a=ed25519-sha256
 header.s=dkim-ed25519 header.b=2QLO3d1Y;
	dkim=pass header.d=furst.blue header.i=@furst.blue header.a=rsa-sha256
 header.s=dkim-rsa header.b=iroyzRgJ;
	arc=none smtp.remote-ip=194.164.54.141
Received: from mail.furst.blue (mail.furst.blue [194.164.54.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0D9B6F8001F
	for <alsa-devel@alsa-project.org>; Tue,  9 Jun 2026 22:17:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D9B6F8001F
Authentication-Results: alsa1.perex.cz;
	dkim=pass header.d=furst.blue header.i=@furst.blue header.a=ed25519-sha256
 header.s=dkim-ed25519 header.b=2QLO3d1Y;
	dkim=pass (2048-bit key,
 unprotected) header.d=furst.blue header.i=@furst.blue header.a=rsa-sha256
 header.s=dkim-rsa header.b=iroyzRgJ
Received: from k8s-mail.magi.furst.blue (unknown [192.168.208.120])
	by mail.furst.blue (Postfix) with ESMTPS id AA43340100;
	Tue,  9 Jun 2026 20:17:34 +0000 (UTC)
From: furstblumier <seal@furst.blue>
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=furst.blue;
	s=dkim-ed25519; t=1781036254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sMIcxGQxFH2zTRQLBBx52uh5KCOcwTjhjoGXdk5q/1s=;
	b=2QLO3d1YMI9XA2zd+7VMhAOpyUcG4TdCnuuo0fxGFwO+HUVRix7G5F7AjOHQV9xDn06vu5
	kFicZSMi4lKd/3Dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=furst.blue;
 s=dkim-rsa;
	t=1781036254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sMIcxGQxFH2zTRQLBBx52uh5KCOcwTjhjoGXdk5q/1s=;
	b=iroyzRgJPLeD+wtmrqL8WPon1/vc4dbcT/ArOw+LD8xPyVeI65lQ9bhhu5GhSUuwgPyY0V
	mKFVBibYMatoobHAiYiyGBCyDkDglcHOld+EeIqJX9aC8XSOw0CEKK2nw/ucc+ZwLs4Pt3
	fSncDH560LJw1/jqJHbgqizsN7AuxZLI+yZycoYUCp4HVFLMDZokLEK/fSMPNDGCLO0p0I
	LC5IWP90e3POtxSlLnzDjLlhPRCb9KwTyey/F+j3dizUWqP43TJiKDIlr/YzTx/hL0hyna
	kMTcReT+wf9jvmEfMAuHQJfb2j3XbrMzFnHL06BjlD6M3MGOfnBVdkbo8kuCYA==
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	furstblumier <seal@furst.blue>
Subject: [PATCH RESEND] ALSA: hda/realtek: Add quirk for HP 255 15.6 inch G9
 Notebook PC
Date: Tue,  9 Jun 2026 22:17:06 +0200
Message-ID: <20260609201706.502075-1-seal@furst.blue>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: T4J2YJOY325YEB5CIAVBW234VL37T36I
X-Message-ID-Hash: T4J2YJOY325YEB5CIAVBW234VL37T36I
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/T4J2YJOY325YEB5CIAVBW234VL37T36I/>
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

