Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A167C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Nov 2023 16:21:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40DFD74C;
	Tue, 14 Nov 2023 17:20:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40DFD74C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1699978907;
	bh=B5PqwQYJNNSgfG3hCtF1MC+hcgZeRJeQfMHx2GLjlPg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Uup6vHHKkuUSN+K3UN2xZ8Pihk5vUY+oRmqxOsIKMeNhDZawCo7/gV/bDv5g31NSb
	 CQHcud3Tln2oJ+eR4N+4L37jcZgY4b3T+HJ3Z3kTb8owCbR22VloZHMTES+rL08Y9C
	 MIhEQGi9UjfWnZppCc301m6vrxFD8ZwaE6Tkdh/0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 720A5F8016E; Tue, 14 Nov 2023 17:20:28 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C7016F80549;
	Tue, 14 Nov 2023 17:20:27 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 76D72F801D5; Tue, 14 Nov 2023 14:38:40 +0100 (CET)
Received: from mail.malych.org (gateway.malych.org [185.150.1.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D049EF80152
	for <alsa-devel@alsa-project.org>; Tue, 14 Nov 2023 14:38:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D049EF80152
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=malych.org header.i=@malych.org header.a=rsa-sha256
 header.s=dkim header.b=Zvk4ID63
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 15682AA8C67;
	Tue, 14 Nov 2023 14:38:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=malych.org; s=dkim;
	t=1699969110; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=M2W/mJKe/9mkt7dXkYSPCn0UkTJjRbISNIwGBXbQaKM=;
	b=Zvk4ID63K95XkuTNq3EqXHqlYuoJDscu0bATZmkk9sTVw0XWCfUSFv2gepdklKwN+pF/vL
	XnvT2jOFSCcejZ/v/TitswpuZFE52HvN9ZnMDqbkDP9UHcKeHOYadGQBoTWalV+APnWoc2
	g7ML7e+Z5ioVxfZY6VjNyOFbfeBLO4E+ScYRfDCs/ckDTZeCkgRO6+MeNXTkNDfeWXZO/w
	nTDIBsU+ajdjap+QzEmmct503FFGNx4X0YDxRGvgHSKrYNGlUabwYy7dlatujApVJ9K2Z0
	0gonxONj4Glg3EwdaABOKuVt0nTsD1co1NfgSTbyF2fXKCvr4szbuSVhdJDTew==
From: Matus Malych <matus@malych.org>
To: tiwai@suse.com
Cc: alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Matus Malych <matus@malych.org>
Subject: [PATCH v2] ALSA: hda/realtek: Enable Mute LED on HP 255 G10
Date: Tue, 14 Nov 2023 14:35:25 +0100
Message-Id: <20231114133524.11340-1-matus@malych.org>
In-Reply-To: <87r0kuoug5.wl-tiwai@suse.de>
References: <87r0kuoug5.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-MailFrom: matus@malych.org
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: DVF66JQHEQWH566OZUF2AUUQTXBZCEAS
X-Message-ID-Hash: DVF66JQHEQWH566OZUF2AUUQTXBZCEAS
X-Mailman-Approved-At: Tue, 14 Nov 2023 16:20:23 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DVF66JQHEQWH566OZUF2AUUQTXBZCEAS/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

HP 255 G10 has a mute LED that can be made to work using quirk
ALC236_FIXUP_HP_MUTE_LED_COEFBIT2.
Enable already existing quirk - at correct line to keep order

Signed-off-by: Matus Malych <matus@malych.org>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index cdd808e02b44..3c85b8247c11 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9868,6 +9868,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8abb, "HP ZBook Firefly 14 G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad1, "HP EliteBook 840 14 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8ad2, "HP EliteBook 860 16 inch G9 Notebook PC", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b2f, "HP 255 15.6 inch G10 Notebook PC", ALC236_FIXUP_HP_MUTE_LED_COEFBIT2),
 	SND_PCI_QUIRK(0x103c, 0x8b42, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b43, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b44, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
-- 
2.34.1

