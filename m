Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E18EC4829A
	for <alsa-devel@archiver.kernel.org>; Wed,  7 Feb 2024 21:23:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 51A8A84A;
	Wed,  7 Feb 2024 22:22:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 51A8A84A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1707340982;
	bh=lMIHaODZjwFLt53I0Ipnm70RQWp0dIWSiREstu+346A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Y+j9VeOSV5bWHN9elbkWdP8NEW+aT5im6SKLgJVm6kUKI2CzZg1LvtX7poFzQa9hY
	 NPZ0COax6czGTnRdjwxGduRHY03ptJUW7zsrlZm/QPp0evQtonCzux6MT9CIh98luy
	 tDHGBAqU9NkUIlAp40eKRsPhAwtPv5ymeQ7HAyvU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 365F6F805C3; Wed,  7 Feb 2024 22:22:26 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DAD5F805C9;
	Wed,  7 Feb 2024 22:22:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2CE98F80580; Wed,  7 Feb 2024 22:22:22 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E37E0F800E3
	for <alsa-devel@alsa-project.org>; Wed,  7 Feb 2024 22:22:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E37E0F800E3
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ZHulLat9
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C9F0561A30;
	Wed,  7 Feb 2024 21:22:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA907C433F1;
	Wed,  7 Feb 2024 21:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340937;
	bh=lMIHaODZjwFLt53I0Ipnm70RQWp0dIWSiREstu+346A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZHulLat9mSw6SWUE0aUL6JbghORS6saQGD+2qA+10p445pJQXNfQX8dvKyiPxeyEW
	 xvSqk3jVtD2sDhEVoz1T3P+64jltd/B6PAThCwXdnugkhonW+sJb4M+b/QWJqD0Grb
	 4On444rDvcyNqQZAYvRPWkZdcUOilsQoQNRhN/45p6t0EodO8NCZWFN9kugb7Owusn
	 iupmwhsAHBeE7PcwjYxuvBkWR+G6q82HkANyllJQpR4QtN+Qv1j0E98Xo834FJZ/rK
	 5ygH7vmklY+J1XyHQaMKilFFi2ytEBmtVITx+d6OCeNIovjUFZEPZtz8LWFvbSX9DR
	 NMRpXy2bk52zg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kenzo Gomez <kenzo.sgomez@gmail.com>,
	Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 17/44] ALSA: hda: cs35l41: Support additional ASUS
 Zenbook UX3402VA
Date: Wed,  7 Feb 2024 16:20:44 -0500
Message-ID: <20240207212142.1399-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KZAEVVJF54KSULWLW6ODJNZULSBGXAQA
X-Message-ID-Hash: KZAEVVJF54KSULWLW6ODJNZULSBGXAQA
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KZAEVVJF54KSULWLW6ODJNZULSBGXAQA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Kenzo Gomez <kenzo.sgomez@gmail.com>

[ Upstream commit c16dfab33f99fc3ff43d48253bc2784ccb84c1de ]

Add new model entry into configuration table.

Signed-off-by: Kenzo Gomez <kenzo.sgomez@gmail.com>
Link: https://lore.kernel.org/r/20240127164621.26431-1-kenzo.sgomez@gmail.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/pci/hda/cs35l41_hda_property.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/cs35l41_hda_property.c b/sound/pci/hda/cs35l41_hda_property.c
index 35277ce890a4..59504852adc6 100644
--- a/sound/pci/hda/cs35l41_hda_property.c
+++ b/sound/pci/hda/cs35l41_hda_property.c
@@ -76,6 +76,7 @@ static const struct cs35l41_config cs35l41_config_table[] = {
 	{ "10431533", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
 	{ "10431573", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 1000, 4500, 24 },
 	{ "10431663", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, -1, 0, 1000, 4500, 24 },
+	{ "104316A3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104316D3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104316F3", 2, EXTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 1, 2, 0, 0, 0, 0 },
 	{ "104317F3", 2, INTERNAL, { CS35L41_LEFT, CS35L41_RIGHT, 0, 0 }, 0, 1, -1, 1000, 4500, 24 },
@@ -410,6 +411,7 @@ static const struct cs35l41_prop_model cs35l41_prop_model_table[] = {
 	{ "CSC3551", "10431533", generic_dsd_config },
 	{ "CSC3551", "10431573", generic_dsd_config },
 	{ "CSC3551", "10431663", generic_dsd_config },
+	{ "CSC3551", "104316A3", generic_dsd_config },
 	{ "CSC3551", "104316D3", generic_dsd_config },
 	{ "CSC3551", "104316F3", generic_dsd_config },
 	{ "CSC3551", "104317F3", generic_dsd_config },
-- 
2.43.0

