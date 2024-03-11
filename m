Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23B5EC5475B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:38:51 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EF0FCE94;
	Mon, 11 Mar 2024 19:38:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EF0FCE94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710182329;
	bh=IA2auWJWODwH5z1b1RuFSmAMwQl9MlpFfPqkOuWvdOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=kQp5Ja75XuBGQbox6ebzCiCoCHd7OQicF7y2Odu/qi815i9bfrDL9IhwEi8tqgg9H
	 XNrJU2H3gc3JYTRl56AY3krB6W0zRooNMHP4HB4xUQ2T4qOMQhG9IjCZufwdDtrm+s
	 bNMB5oIPhC12geekowJnANxbAb5Vgcjk6qlmHa4w=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0ACB2F80612; Mon, 11 Mar 2024 19:37:47 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EAC74F805F8;
	Mon, 11 Mar 2024 19:37:45 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 16C19F804B0; Mon, 11 Mar 2024 19:37:01 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 2B614F800E4
	for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2024 19:36:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2B614F800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=rpOqJdYq
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CBCC760EB9;
	Mon, 11 Mar 2024 18:36:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54796C43390;
	Mon, 11 Mar 2024 18:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182214;
	bh=IA2auWJWODwH5z1b1RuFSmAMwQl9MlpFfPqkOuWvdOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rpOqJdYqvFyWmjgHhSacPme38u+RKS6kXpQiyy0mnkqcK+ARSTV3FLb675wxuyMvs
	 cHGDULO/Ozy/Fjed1vU80CUgG/03/acODeiWCvTuhM1RLX87voTJ9G/Rc6H8KrKaYb
	 f5SyvkBpL2jTD8kUzdYzX9uPypux3FyoboxmtY/CoIdjCfSYXC91r44w4vH4mfpk80
	 Zn8uIxSZReXTIm47XxENX8ojejLdF1E2InJqWYF/InkJ2Hok80In09QpEealKqpa7+
	 PG5wvZn0dygQZOym516LOJs3si1rFzR9FpE0CNkyxWWgaktNUDSLEOAanja5Y1F2Nl
	 OgYULTjfNYWAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Binding <sbinding@opensource.cirrus.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	gregkh@linuxfoundation.org,
	kailang@realtek.com,
	jian-hong@endlessm.com,
	bin.li@canonical.com,
	jeremy.szu@canonical.com,
	jin@mediatomb.cc,
	hui.wang@canonical.com,
	edward@edward-p.xyz,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.7 06/14] ALSA: hda/realtek: Add quirks for Lenovo
 Thinkbook 16P laptops
Date: Mon, 11 Mar 2024 14:36:09 -0400
Message-ID: <20240311183618.327694-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183618.327694-1-sashal@kernel.org>
References: <20240311183618.327694-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BGBGOR32MFX5JYM6MZI7IXVN2IZ3DK64
X-Message-ID-Hash: BGBGOR32MFX5JYM6MZI7IXVN2IZ3DK64
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BGBGOR32MFX5JYM6MZI7IXVN2IZ3DK64/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Stefan Binding <sbinding@opensource.cirrus.com>

[ Upstream commit 6214e24cae9b10a7c1572f99552610a24614fffe ]

These models use 2 CS35L41 amps with HDA using I2C.
Both models have _DSD support inside cs35l41_hda_property.c.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218437

Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20240301160154.158398-3-sbinding@opensource.cirrus.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/patch_realtek.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index eb45e5c3db8c6..9590fd31441bc 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -10288,6 +10288,8 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x3886, "Y780 VECO DUAL", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a7, "Y780P AMD YG dual", ALC287_FIXUP_TAS2781_I2C),
 	SND_PCI_QUIRK(0x17aa, 0x38a8, "Y780P AMD VECO dual", ALC287_FIXUP_TAS2781_I2C),
+	SND_PCI_QUIRK(0x17aa, 0x38a9, "Thinkbook 16P", ALC287_FIXUP_CS35L41_I2C_2),
+	SND_PCI_QUIRK(0x17aa, 0x38ab, "Thinkbook 16P", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b4, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b5, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b6, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.43.0

