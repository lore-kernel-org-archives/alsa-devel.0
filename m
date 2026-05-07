Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79AE5CD37AC
	for <alsa-devel@archiver.kernel.org>; Mon, 11 May 2026 14:46:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BCB776021B;
	Mon, 11 May 2026 16:46:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BCB776021B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1778510776;
	bh=dbGEMJI+e/WMInV5rFJqPoVsmlqkBVZNE8omGFqufu0=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Go0HGIto67byNpTbXKBFsEKGgh3EeCI3GX0id1ldUNqreV/nf8AEUB3JOSMZm4BIV
	 FTx7hTIDGN2/YjAIGuA3N4FOSGKkNKIN1DHR434kGGZDCP7xxXPfPxPvKV8EOJTOkn
	 gzqqBFKgMHZbmWDnlrICf5yF1AXCIUXdvin0zIXw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D63DBF806AC; Mon, 11 May 2026 16:44:46 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E6F2F806A6;
	Mon, 11 May 2026 16:44:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C438FF80518; Thu,  7 May 2026 22:28:08 +0200 (CEST)
Received: from mail.furst.blue (mail.furst.blue [194.164.54.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 1B8B2F800FE
	for <alsa-devel@alsa-project.org>; Thu,  7 May 2026 22:28:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1B8B2F800FE
Authentication-Results: alsa1.perex.cz;
	dkim=pass header.d=furst.blue header.i=@furst.blue header.a=ed25519-sha256
 header.s=dkim-ed25519 header.b=xk9MQU8T;
	dkim=pass (2048-bit key,
 unprotected) header.d=furst.blue header.i=@furst.blue header.a=rsa-sha256
 header.s=dkim-rsa header.b=IagIxNc0
Received: from k8s-mail.magi.furst.blue (unknown [192.168.178.120])
	by mail.furst.blue (Postfix) with ESMTPS id 282D5400FC;
	Thu,  7 May 2026 20:28:06 +0000 (UTC)
From: furstblumier <seal@furst.blue>
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=furst.blue;
	s=dkim-ed25519; t=1778185684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zQtb3czEO6wx6aU0Snza8jd5UNjwCSEYQ9VjV4HQkeg=;
	b=xk9MQU8T8MEsJt3Dd+tN57HUDbGOtIa5kjESoBJwPVTaGZWBTCXXUggAHiNXk2/ZilMi7w
	PH9R+IfoZuqukNBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=furst.blue;
 s=dkim-rsa;
	t=1778185684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zQtb3czEO6wx6aU0Snza8jd5UNjwCSEYQ9VjV4HQkeg=;
	b=IagIxNc0dt35143uVYv7JX+atObONYsW0V//2xeyP3Omy4XrkF9frt1oRkpEqfipLbnK2X
	iP7CcINK9g7uRjyaKZNzDQY53lQm6MfJmy3UswvmBIxqHFqPSspH41mDqtcUx0nAXp3shV
	nKmNt6UW7zDKGkJh3ZwG3uY/tqFzn7KmcGTkv7pHKu/DwP/+HWPs7NRfqrsiDopiNrFKj/
	zxv5kCrmEzO2lAeKpIqhLjKpiE3L23VWl9Z/hEfiyxUEhL5kTs8o79nBbSzXFOS77q1wPY
	XnQJB/70HH25+q830DRHfmxjgelYXIoIk8m05GTk37tEa0/h9wWxuNXiObcEXA==
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	furstblumier <seal@furst.blue>
Subject: [PATCH] ALSA: hda/realtek: Add quirk for HP 255 15.6 inch G9 Notebook
 PC
Date: Thu,  7 May 2026 22:27:54 +0200
Message-ID: <20260507202754.16114-1-seal@furst.blue>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MailFrom: seal@furst.blue
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: S64EO3WBDVVYZZ3BLYAX6J2SKXPCX3NO
X-Message-ID-Hash: S64EO3WBDVVYZZ3BLYAX6J2SKXPCX3NO
X-Mailman-Approved-At: Mon, 11 May 2026 14:44:41 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S64EO3WBDVVYZZ3BLYAX6J2SKXPCX3NO/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Signed-off-by: furstblumier <seal@furst.blue>
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

