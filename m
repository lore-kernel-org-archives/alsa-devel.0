Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D58C7EE22
	for <alsa-devel@archiver.kernel.org>; Sun,  7 May 2023 00:36:11 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB261182D;
	Sun,  7 May 2023 02:35:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB261182D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683419769;
	bh=ZhqomB73I32kP61xKVm31O65xmH95OhFb7cvG67S7Q4=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=vhLR/EaGhkP2R77t4nXfRV8zYln1nMXLTfaMtXkJdYUzyj8lsR9JIgMzM7jlNl8Gy
	 0DTUjrq6g1VSQL30wdevP7JiNbxdFUkrkcJzfwB7LcuMJnxBRi8MLAgF3iI4z3GPjt
	 gqJMAtAsG8SuSt/mVByDqjydv0trrrWTcNhAXfbw=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 15220F8053D;
	Sun,  7 May 2023 02:34:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D630EF80551; Sun,  7 May 2023 02:34:46 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 21255F80217
	for <alsa-devel@alsa-project.org>; Sun,  7 May 2023 02:34:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21255F80217
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dOzzndI7
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 13088611B6;
	Sun,  7 May 2023 00:34:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCC8C433EF;
	Sun,  7 May 2023 00:34:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683419683;
	bh=ZhqomB73I32kP61xKVm31O65xmH95OhFb7cvG67S7Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dOzzndI74/G7I6PBNJyh9gLszkz0cu/zjmaxq5nibyt5hrpaaemvi/GhyoxlvPiFz
	 Gm1gR+8HaFN1Mm18KDCf8oG9WBdt3anCzRBjgGF9DoPqolijrYLX0xe9bRl42cyIQe
	 enI7WUDfa/SkYg1gXcJRpWlOq+qZIamOC+p7C5cyciSESKYqXgozlpW+29u/YqUFTd
	 Xkkfx5EnRt6jTbsw3Y0l5xLoTJzTO1/9QQUJSAGeqs6yDiMaOeAKtXJ/M2w60Z6ijU
	 dtfKD93pi/U7Ovw1GAn5GBuFQRcVe81Kbe0/BMNTHAy6GC8AuFToIGHLjJlKLjj/xi
	 mPCgEDmArue0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 06/19] ASoC: amd: yc: Add DMI entries to support
 HP OMEN 16-n0xxx (8A42)
Date: Sat,  6 May 2023 20:34:04 -0400
Message-Id: <20230507003417.4077259-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230507003417.4077259-1-sashal@kernel.org>
References: <20230507003417.4077259-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Message-ID-Hash: OJJ7YJVWEBKQOXRQV5FC7MAT6BGCMNEP
X-Message-ID-Hash: OJJ7YJVWEBKQOXRQV5FC7MAT6BGCMNEP
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: Prajna Sariputra <putr4.s@gmail.com>, Mark Brown <broonie@kernel.org>,
 Sasha Levin <sashal@kernel.org>, lgirdwood@gmail.com, tiwai@suse.com,
 mario.limonciello@amd.com, Syed.SabaKareem@amd.com, aniol@aniolmarti.cat,
 jhunkeler@gmail.com, lub.the.studio@gmail.com, gbrohammer@outlook.com,
 leohearts@leohearts.com, xazrael@hotmail.com, alsa-devel@alsa-project.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/OJJ7YJVWEBKQOXRQV5FC7MAT6BGCMNEP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Prajna Sariputra <putr4.s@gmail.com>

[ Upstream commit ee4281de4d60288b9c802bb0906061ec355ecef2 ]

This model requires an additional detection quirk to enable the internal microphone.

Signed-off-by: Prajna Sariputra <putr4.s@gmail.com>
Link: https://lore.kernel.org/r/2283110.ElGaqSPkdT@n0067ax-linux62
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 4a69ce702360c..ce6630318858e 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -262,6 +262,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "OMEN by HP Gaming Laptop 16z-n000"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8A42"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.39.2

