Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 168F8CA5FB1
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:16:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E4986025D;
	Wed, 30 Sep 2026 09:16:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E4986025D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1790752591;
	bh=uyOfTAk02QIOXjWu/5aFDewOPExwJC2z9PD9LYVmPdI=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=nalCuUT5LFHu6jfOVen5oRGcPY1qIepLp/N4eieIwOIs4d23/z3d5CnJhkDPT1Uyu
	 L6RhQwe1qtMfqhQRAGOQWe2+SWo10jgfdxyIO5H3C1dno7RVNQFGckrvfw75+j1CYg
	 03vJnVnvyM9sOlXw+7ljQO8tYs5ktLfk8hUbAUoA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E708EF80618; Wed, 30 Sep 2026 09:15:40 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id B9C6CF80618;
	Wed, 30 Sep 2026 09:15:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9BC84F80542; Wed, 30 Sep 2026 08:55:14 +0200 (CEST)
Authentication-Results: alsa1.perex.cz; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=alsa-project.org; s=arc; a=rsa-sha256; cv=none; t=1790751313;
	b=FQUkZ9ltC1LWqtpJwQ7wO/z9TK8b0ZnpZbZJlKVOs5rlsxf0XP31inbb47u3WfsfbVAn
	 hmAh6ijGxHPqngCb1SFa6gd3ANX8Onw5cSb4TVBWZtCrZZRgd7VNAFokF/Dw7mI7+Ljte
	 DVUQJIxAnUUiGvOMeOe25pxFz42aoiGb51zE3vB2haCmN8BDjUYRzT8RID8aWxU4u/M8e
	 cjGrjamHSlwdHwqu/ENwZJi30Zk6m3MHqLb6+1M/FtBTKu+0HecU1LexzjD23zxR8BDdd
	 yfrbiZ3oIadbkEKsOgl2KzP2aSPZaIwlx6ORN10yKbYApToAmcawJTsjDEBAwBFRBzA==
ARC-Message-Signature: i=1; d=alsa-project.org; s=arc; a=rsa-sha256;
	c=relaxed/simple; t=1790751313;
	h=DKIM-Signature:From:To:Subject:Date:Message-ID:MIME-Version;
	bh=uyOfTAk02QIOXjWu/5aFDewOPExwJC2z9PD9LYVmPdI=;
	b=cOk/8gxPdYgkQocZ9v66CoGJGzCIAQD/sA1HFEvouB2CesSY//SfLCvP4nfOWStyTQxd
	 y6sDEflj1YUBu3PgCm1j+buABzGmyETKoO15iceKyiiKQecnqJcRqbfNLHLivcyu8pnTc
	 BsnK1Ad/inscGxFTMRfo0pigcmVIGd6P7RUjg1CD3wxo8c56mNV8dffOO0fR12DPaUkzf
	 nmtsMPgjvPgfJlHJz8nwBbjhGJqbDoEcmSOfN235LDzFT2MTlbWTIqg1aRr7tMmxQ2oif
	 4i+rZQ1SGnpcMOjxzFiMO9hPtFM+8ekjADua6OxMmjP+SJ1sG+qI12M8WwJi9ANjHRw==
ARC-Authentication-Results: i=1; alsa1.perex.cz;
 dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=RwKkQh+c;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2BB89F800D0
	for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2026 08:55:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2BB89F800D0
Authentication-Results: alsa1.perex.cz;
	dkim=pass (1024-bit key,
 unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256
 header.s=s110527 header.b=RwKkQh+c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=e2
	8iCUdzTCIXmJO0+kxY85695yfYq1EWE0mmUTBSb+E=; b=RwKkQh+cBcUUAqYYn1
	LYjD3qg7I93VaQUL2Eyt1fGucekPc78PA+BexyUewfVR/RHFDF1iqiIgVTA7lJhx
	iT9fHJihEZJGPQXaGLA4nKeuDS0UzvW7UDraMwH1+JsSo40ceFB35AZLRyewNcMe
	J048TsGH/QnRNe2rYVQcdgMpQ=
Received: from pan-u.. (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wD3PwhKsrxq7NlhBg--.27857S2;
	Wed, 30 Sep 2026 14:55:06 +0800 (CST)
From: Ren Panpan <rppxj178543@163.com>
To: tiwai@suse.de
Cc: perex@perex.cz,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	renpanpan <renpanpan@kylinos.cn>
Subject: [PATCH] ALSA: hda/realtek: Add mute LED quirk for HP Pavilion
 14-dv1001TU
Date: Wed, 30 Sep 2026 14:55:04 +0800
Message-ID: <20260930065504.24151-1-rppxj178543@163.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3PwhKsrxq7NlhBg--.27857S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrW3CFWDKF4xKF4UZrWDJwb_yoW8AFykpr
	4rXr95WF97XF92yr4fGF4UCry8Ga12ga1rKayavr4Sqa429r4vga10vrWqvF4kAryvgF13
	Xr98AFy5uw4jqaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UAGYXUUUUU=
X-CM-SenderInfo: huss5yirxykkqt6rljoofrz/xtbC6QuIh2q8sksFnQAA3a
X-MailFrom: rppxj178543@163.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; loop;
 banned-address; header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; emergency; member-moderation
Message-ID-Hash: BK3ODGQDEBPI2WMFVDLRA5QPRYZLXH3R
X-Message-ID-Hash: BK3ODGQDEBPI2WMFVDLRA5QPRYZLXH3R
X-Mailman-Approved-At: Wed, 30 Sep 2026 07:15:27 +0000
X-Mailman-Version: 3.3.10
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BK3ODGQDEBPI2WMFVDLRA5QPRYZLXH3R/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: renpanpan <renpanpan@kylinos.cn>

The HP Pavilion 14-dv1001TU (subsystem ID 103c:8987) uses a Realtek
ALC287 codec. The mute LED on this machine is controlled by GPIO bit
0x10, which was verified via hda-verb, but the subsystem ID is missing
from the quirk table. As a result, the ALC287_FIXUP_HP_GPIO_LED fixup
that drives GPIO 0x10 is never applied and the mute LED stays off even
though the associated LED class device toggles correctly.

Add the missing SND_PCI_QUIRK entry to map this subsystem ID to
ALC287_FIXUP_HP_GPIO_LED so the mute LED works as expected.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221810
Signed-off-by: renpanpan <renpanpan@kylinos.cn>
---
 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 5127a111c59c..de31eb6a1627 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7483,6 +7483,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x103c, 0x8975, "HP EliteBook x360 840 Aero G9", ALC245_FIXUP_CS35L41_SPI_2_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x897d, "HP mt440 Mobile Thin Client U74", ALC236_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x8981, "HP Elite Dragonfly G3", ALC245_FIXUP_CS35L41_SPI_4),
+	SND_PCI_QUIRK(0x103c, 0x8987, "HP Pavilion 14-dv1001TU", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x898a, "HP Pavilion 15-eg100", ALC287_FIXUP_HP_GPIO_LED),
 	SND_PCI_QUIRK(0x103c, 0x898e, "HP EliteBook 835 G9", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x103c, 0x898f, "HP EliteBook 835 G9", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.43.0

