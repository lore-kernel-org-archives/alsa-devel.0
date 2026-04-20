Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 701EAF588C2
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:16:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [45.14.194.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8BE1660204;
	Mon, 20 Apr 2026 15:16:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8BE1660204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1776690990;
	bh=IJRaeUrOT4uxjtqct0t5ecqTdc2mzEjDLrfsy60+b04=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=mwET5uFss+foxbv+aX1w98q5sC7xnmrBOZYuwLiYL33evncJ6+tFG3ToNxjw0uAiH
	 AiQUkdIhi3yg/uli04+ZfPSYFFhBmeNNgcsN0dLMzc7drTUK6CVHDpwW1Cw+mGH5mt
	 P+5hwShrt8+m1ZlaRBmYMC4etPgIp8ABs1o51j/0=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 514CAF805E6; Mon, 20 Apr 2026 15:15:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0AEBEF80524;
	Mon, 20 Apr 2026 15:15:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 30A7CF80524; Mon, 20 Apr 2026 15:15:46 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8B41CF800AE
	for <alsa-devel@alsa-project.org>; Mon, 20 Apr 2026 15:15:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8B41CF800AE
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=A66MNC5u
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3456D6012B;
	Mon, 20 Apr 2026 13:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00F1EC19425;
	Mon, 20 Apr 2026 13:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776690941;
	bh=IJRaeUrOT4uxjtqct0t5ecqTdc2mzEjDLrfsy60+b04=;
	h=From:To:Cc:Subject:Date:From;
	b=A66MNC5uAmJo3ESN/UeRL5KYSrrJpUPBO/M+Op3676M/ng2lvo8t2qFXCla795G2D
	 8HgKXSnWg3CGDnvkb70/8J4XloUsFNTNyFeTuFuTTp8wYKtT7tW2c20O/rngGiqaj+
	 JC91iMAwm9PDGSkytJkyke6ZcEmK74VeUKcY1/PMFWWgH9vvk/5ztztz1WmBMUl3/Z
	 E16Tx3c7epPg1edgsp2CbYrdVSj2+MeUUgYf2oNCuIo+J0NzmjmHxEahGAO/57z8PR
	 ftgmv52tjYom+x2DuiWV2IGQuZbK7vHk8R4Iz/RKYG3JaMyPKs5W8BNWd+OqyYcDEd
	 HUVoDdBgyrUmw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Zhang Heng <zhangheng@kylinos.cn>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] ALSA: hda/realtek: add quirk for Lenovo Yoga 7
 2-in-1 16AKP10
Date: Mon, 20 Apr 2026 09:07:47 -0400
Message-ID: <20260420131539.986432-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
Message-ID-Hash: IKFGPR6OY26EQH5UY2PUTSNQTU3P4JBJ
X-Message-ID-Hash: IKFGPR6OY26EQH5UY2PUTSNQTU3P4JBJ
X-MailFrom: sashal@kernel.org
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/IKFGPR6OY26EQH5UY2PUTSNQTU3P4JBJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Zhang Heng <zhangheng@kylinos.cn>

[ Upstream commit 7bae956cac0433c4d41aac9f1d04e42694e0b706 ]

This machine is equipped with ALC287 and requires the quirk
ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN to fix the issue
where the bass speakers are not configured and the speaker
volume cannot be controlled.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=221210
Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>
Link: https://patch.msgid.link/20260313080624.1395362-1-zhangheng@kylinos.cn
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 sound/hda/codecs/realtek/alc269.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/hda/codecs/realtek/alc269.c b/sound/hda/codecs/realtek/alc269.c
index 1b64292220ac8..4b06cb48252e2 100644
--- a/sound/hda/codecs/realtek/alc269.c
+++ b/sound/hda/codecs/realtek/alc269.c
@@ -7429,6 +7429,7 @@ static const struct hda_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x17aa, 0x38ab, "Thinkbook 16P", ALC287_FIXUP_MG_RTKC_CSAMP_CS35L41_I2C_THINKPAD),
 	SND_PCI_QUIRK(0x17aa, 0x38b4, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	HDA_CODEC_QUIRK(0x17aa, 0x391c, "Lenovo Yoga 7 2-in-1 14AKP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
+	HDA_CODEC_QUIRK(0x17aa, 0x391d, "Lenovo Yoga 7 2-in-1 16AKP10", ALC287_FIXUP_YOGA9_14IAP7_BASS_SPK_PIN),
 	SND_PCI_QUIRK(0x17aa, 0x38b5, "Legion Slim 7 16IRH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b6, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
 	SND_PCI_QUIRK(0x17aa, 0x38b7, "Legion Slim 7 16APH8", ALC287_FIXUP_CS35L41_I2C_2),
-- 
2.53.0

