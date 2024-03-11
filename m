Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C166C54E58
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:45:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BAD0514E9;
	Mon, 11 Mar 2024 19:45:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BAD0514E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710182739;
	bh=mmN/SZR6PmFIvbIsDtMtfVjVtr8+wCKe8berH2El920=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=iwwTypX3efhDKYbyB2u8aYmUbuMENUEwizAUEs8kMk+TqvFg6OwPiszYxWbyg4ZVX
	 UaaUWyl+b7kVI+eqimgRoIcFRSqkLpgZGzU6UGeBvFMcIwC04kF3VSMQmaW37eswOL
	 VtlYHHrOiwSqq8zhxjOwaPSheaX06kvHWN9t2IsQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 484B1F806F9; Mon, 11 Mar 2024 19:40:51 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id EF32CF8057A;
	Mon, 11 Mar 2024 19:40:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 9A7CAF8057C; Mon, 11 Mar 2024 19:40:46 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7534CF806A4
	for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2024 19:40:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7534CF806A4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=NchFS/VF
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2DB80601E2;
	Mon, 11 Mar 2024 18:40:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01C48C43390;
	Mon, 11 Mar 2024 18:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182410;
	bh=mmN/SZR6PmFIvbIsDtMtfVjVtr8+wCKe8berH2El920=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NchFS/VFTIs0bFSuWFV75HS5qScCu5rmrXZfTIRJbnA8jsAk7azxwb4b3uQKUlHNw
	 PEOsaSCzivsuy50t7p0dxpeaNygB8emsmtR/xg+MIhWCOBK+If+9Oa5lUq8iZpuvjM
	 y3zXK+Y9MtOdO8TH3KcwyA+Arlqx65DC5vgwfpT24kIfZ+TWxew0zgfZn8PGXIkeKB
	 7KRfnDQXyEMv7M7/YFwbV3Fs9cU0S9RKZHsyrpRftrGGX/xv8uL+7sLIn0cM7Gt5Ga
	 UyojBjlQ0vl+8zRnT17mW6ugCCVquZX5ZWhyiAdzZU1zs4wMJ2vqXsOtO7AB0Ph0U7
	 OkwqMKBFk7VEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	patches@opensource.cirrus.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 5/5] ASoC: wm8962: Fix up incorrect error message
 in wm8962_set_fll
Date: Mon, 11 Mar 2024 14:39:49 -0400
Message-ID: <20240311183950.329120-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183950.329120-1-sashal@kernel.org>
References: <20240311183950.329120-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.271
Content-Transfer-Encoding: 8bit
Message-ID-Hash: AUKHHBUDLH5PC7ZBAUIHTMS73JSJ45QQ
X-Message-ID-Hash: AUKHHBUDLH5PC7ZBAUIHTMS73JSJ45QQ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/AUKHHBUDLH5PC7ZBAUIHTMS73JSJ45QQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 96e202f8c52ac49452f83317cf3b34cd1ad81e18 ]

Use source instead of ret, which seems to be unrelated and will always
be zero.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-5-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 9ccec511352a0..15828ae62f9de 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2908,7 +2908,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0

