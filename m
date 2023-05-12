Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09D97C77B7F
	for <alsa-devel@archiver.kernel.org>; Fri, 12 May 2023 08:36:43 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8144C1E0;
	Fri, 12 May 2023 10:35:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8144C1E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683880600;
	bh=GmuHJUkNGNN5xpj8W6Y/DwZ9aMocAotrRCrDsbxHGvw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rPPw/8ZrX4kzpHr7sSdctm+xDuF008IaXwx6ruSuSEo5rCiL7jag13K9LtndLeGmz
	 1d7t3f1SW9NV/NIz/iohNlu3t0Cat9CESuCttBC4xn6pwnKk7AiJIriLuvRaiSt+Ek
	 LDYVme84b/GSWgn9hwCsjtZheITAydhFEKlsRoGA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B04A2F80544; Fri, 12 May 2023 10:35:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 203FFF80087;
	Fri, 12 May 2023 10:35:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D73B3F8032D; Fri, 12 May 2023 10:35:17 +0200 (CEST)
Received: from smtp-relay-canonical-0.canonical.com
 (smtp-relay-canonical-0.canonical.com [185.125.188.120])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8C71BF80087
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2023 10:35:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C71BF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20210705 header.b=XgmKbCfr
Received: from localhost.localdomain (unknown [10.101.196.174])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest
 SHA256)
	(No client certificate requested)
	by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 28FE34124F;
	Fri, 12 May 2023 08:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1683880506;
	bh=lJQxGTCChL8jXShZ1mLzmFjS0MxpED2G4Ao6MmnOj4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
	b=XgmKbCfrdg2x996gWCGMTKLi7oFMHqO/IriX8Uu7tHjmguH8DYiE7/Tir9ahaAcmp
	 SoJJtDcWSlNInp8EOhf+q6Hp1hMcV90/Dz+8k04/koSmKLsjomcUfjAOXZPqUZ6+lo
	 dfCKN7DSLzlO8oF4aVMuAmni1QwgQzQOpFqHF+zTiq7M9ILbkZatrPuWJbzuNF46qN
	 /mB+yodvsQVAmr0yOqvaIJkCZLYCU6ZxvIowCgRK0zBxUgOcfcri5aNVoZ+yZj1xx/
	 /1rQ6uyRYK2qh3NBAZDGiCsvkAE5qw7Cvr2mKcXef4GX7QcQZpyw2Wa0Kh03lfrA7S
	 h7tGBoLxQIaDg==
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: tiwai@suse.com
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Stefan Binding <sbinding@opensource.cirrus.com>,
	Andy Chi <andy.chi@canonical.com>,
	Tim Crawford <tcrawford@system76.com>,
	Meng Tang <tangmeng@uniontech.com>,
	"Luke D. Jones" <luke@ljones.dev>,
	Philipp Jungkamp <p.jungkamp@gmx.net>,
	=?UTF-8?q?Kacper=20Michaj=C5=82ow?= <kasper93@gmail.com>,
	Yuchi Yang <yangyuchi66@gmail.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda/realtek: Fix mute and micmute LEDs for yet another
 HP laptop
Date: Fri, 12 May 2023 16:34:16 +0800
Message-Id: <20230512083417.157127-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: S3X4FDIXXKZEBRZGBRPSFH6AJ7X73VUA
X-Message-ID-Hash: S3X4FDIXXKZEBRZGBRPSFH6AJ7X73VUA
X-MailFrom: kai.heng.feng@canonical.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/S3X4FDIXXKZEBRZGBRPSFH6AJ7X73VUA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

There's yet another laptop that needs the fixup to enable mute and
micmute LEDs. So do it accordingly.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 sound/pci/hda/patch_realtek.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 172ffc2c332b..2e3f87e9b4ee 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9480,6 +9480,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8b8f, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b92, "HP", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8b96, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
+	SND_PCI_QUIRK(0x103c, 0x8b97, "HP", ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF),
 	SND_PCI_QUIRK(0x103c, 0x8bf0, "HP", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x1043, 0x103e, "ASUS X540SA", ALC256_FIXUP_ASUS_MIC),
 	SND_PCI_QUIRK(0x1043, 0x103f, "ASUS TX300", ALC282_FIXUP_ASUS_TX300),
-- 
2.34.1

