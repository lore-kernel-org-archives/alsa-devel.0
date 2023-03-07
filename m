Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 362EEC6FD1A
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Mar 2023 13:55:32 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C109146D;
	Tue,  7 Mar 2023 14:54:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C109146D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1678197329;
	bh=fV0mCdGJ3NUHgsaHGj5qtLsd3XNCGbk2LlkQhmrzPQc=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=Z5R1XJBZF6SD+n+2HeoG20rINAmYiHNF/NPkgkc/6ImqY2Bd1cJydX4SPm1VVR1oJ
	 pXI0nmZGXKsR0AWMRd/NsZFcBVUHKWXAg9w3I5hAeuKUZsC76QWcGlLJjvfJfT+fWy
	 WbgtbfUYLO3z3WiYseTbjl/M/3eM19th75qUPTVw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E8B37F8042F;
	Tue,  7 Mar 2023 14:54:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8C504F8042F; Tue,  7 Mar 2023 14:54:13 +0100 (CET)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B02C5F800C9
	for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2023 14:54:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B02C5F800C9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20210705 header.b=sxPyZqxY
Received: from localhost (36-226-179-130.dynamic-ip.hinet.net
 [36.226.179.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits)
 server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id DCFDF3F0E1;
	Tue,  7 Mar 2023 13:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1678197249;
	bh=xPBz9N8CBbExdFLBr+cIY26Ubw3p0nhKguR8fCGx6Bo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=sxPyZqxYpvT5V/SvqJs4re/xSBdUyBZjgTlqgWOX+6X3VjN7EUHd3OI4AuJGcAel8
	 yzoxJdYCcnW+QyCJtr2ekZr0NNc33/vq1WtGHTdNvcJaSqjJBxYQsgUy4kvPmSt9uz
	 RMxYOikwxBm1oyVUUcpGz+oUnDemv2dq7cD1i749VKUr6FlfHmIIP/wQfqEhd4Utoa
	 flJwo8L3PACFbYZwaOV3Lnv4CtWTg6bXWve17VCc9l6ElotDfNAWS8rprTR55DPDtc
	 LEVXqkW57kpE/2V21BJnd+eSKOWG7Be2MuZzr4XNr184cE6xywcM9In5vAXjvusogD
	 7HCqhyWxg7oZQ==
From: Jeremy Szu <jeremy.szu@canonical.com>
To: tiwai@suse.com
Subject: [PATCH] ALSA: hda/realtek: fix speaker,
 mute/micmute LEDs not work on a HP platform
Date: Tue,  7 Mar 2023 21:53:16 +0800
Message-Id: <20230307135317.37621-1-jeremy.szu@canonical.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: CK3YORV6GQ55MQGRC6WP3NNKBI7ZAUHH
X-Message-ID-Hash: CK3YORV6GQ55MQGRC6WP3NNKBI7ZAUHH
X-MailFrom: jeremy.szu@canonical.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Jeremy Szu <jeremy.szu@canonical.com>,
 Stefan Binding <sbinding@opensource.cirrus.com>,
 Tim Crawford <tcrawford@system76.com>, Andy Chi <andy.chi@canonical.com>,
 Meng Tang <tangmeng@uniontech.com>, Philipp Jungkamp <p.jungkamp@gmx.net>,
 =?UTF-8?q?Kacper=20Michaj=C5=82ow?= <kasper93@gmail.com>,
 Gabriele Mazzotta <gabriele.mzt@gmail.com>,
 Yuchi Yang <yangyuchi66@gmail.com>,
 "moderated list:SOUND" <alsa-devel@alsa-project.org>,
 open list <linux-kernel@vger.kernel.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/CK3YORV6GQ55MQGRC6WP3NNKBI7ZAUHH/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

There is a HP platform needs ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED quirk to
make mic-mute/audio-mute/speaker working.

Signed-off-by: Jeremy Szu <jeremy.szu@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3c629f4ae080..5d530b489c48 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9447,6 +9447,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b8a, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b8b, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b8d, "HP", ALC236_FIXUP_HP_GPIO_LED),
+	SND_PCI_QUIRK(0x103c, 0x8b8f, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b92, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8bf0, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
-- 
2.38.1

