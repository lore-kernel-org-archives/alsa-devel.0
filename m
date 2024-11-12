Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C670D32D8B
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2024 10:37:40 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E069B210B;
	Tue, 12 Nov 2024 11:37:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E069B210B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1731407857;
	bh=4rsZ7XKzD7PO2tZLFTEdw8ukKSap/AdkY01vjvFPy7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=t27MWJ2f+bzA/KPHRPR9C2JXP6wd9AxvDrlI9SE0lt22cxsDgikSWBW1rGWs4kl/c
	 TXflfkW3QDZG9EW7tMooKK3TiLw5nELTs7LwHzmJfgCT8ZiOVFWy2bypRPLMMflO2C
	 XkLmamVYVjEN5N0e/suChFDEHOj0Xxhc/DcKYo7o=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B0170F805F2; Tue, 12 Nov 2024 11:36:39 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 309ADF805EE;
	Tue, 12 Nov 2024 11:36:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D2185F8059F; Tue, 12 Nov 2024 11:36:33 +0100 (CET)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0EB39F8059F
	for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2024 11:36:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0EB39F8059F
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=MRGOKg2N
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 66FD3A41943;
	Tue, 12 Nov 2024 10:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A30D6C4CED6;
	Tue, 12 Nov 2024 10:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731407790;
	bh=4rsZ7XKzD7PO2tZLFTEdw8ukKSap/AdkY01vjvFPy7g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MRGOKg2NDA6ciN67AJOduf2CqZFn2EKLiZ9mxmpiV8H5Z7Zq4kdVbP2F8bUArTBXw
	 D7fHssYX5pC2UcFIvgge/qF4TiEs9e77RKc1eNfv7LfuQwx6WJOAKwEZ8HnUW1iWXK
	 qkp3NtbR+tFy5/BSJltbSN/CUiShABmN2AsCEXBu/eQ1LpxyFQEBWRB8rxbMb+Hgpg
	 wa6jJ+YEhnE3LyuBbwIlmjHrHrDTGXY0gCFpBlKIws8osa+PgGBOiQC46AKxQzdqdm
	 yvoOrzxw9G8PJNUE1/d22kodEEOe+VbKicwInS3IyaLZhX7fTXl07cQs+kR5o9tzkG
	 smyxmqqDbu0CQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luo Yifan <luoyifan@cmss.chinamobile.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	olivier.moysan@foss.st.com,
	arnaud.pouliquen@foss.st.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.11 13/16] ASoC: stm: Prevent potential division by
 zero in stm32_sai_mclk_round_rate()
Date: Tue, 12 Nov 2024 05:35:55 -0500
Message-ID: <20241112103605.1652910-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241112103605.1652910-1-sashal@kernel.org>
References: <20241112103605.1652910-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.7
Content-Transfer-Encoding: 8bit
Message-ID-Hash: KP4XSV6HCB7OTXJCBNGEG7FU2PKCUJBV
X-Message-ID-Hash: KP4XSV6HCB7OTXJCBNGEG7FU2PKCUJBV
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/KP4XSV6HCB7OTXJCBNGEG7FU2PKCUJBV/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Luo Yifan <luoyifan@cmss.chinamobile.com>

[ Upstream commit 63c1c87993e0e5bb11bced3d8224446a2bc62338 ]

This patch checks if div is less than or equal to zero (div <= 0). If
div is zero or negative, the function returns -EINVAL, ensuring the
division operation (*prate / div) is safe to perform.

Signed-off-by: Luo Yifan <luoyifan@cmss.chinamobile.com>
Link: https://patch.msgid.link/20241106014654.206860-1-luoyifan@cmss.chinamobile.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/stm/stm32_sai_sub.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index ad2492efb1cdc..19307812ec765 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -378,8 +378,8 @@ static long stm32_sai_mclk_round_rate(struct clk_hw *hw, unsigned long rate,
 	int div;
 
 	div = stm32_sai_get_clk_div(sai, *prate, rate);
-	if (div < 0)
-		return div;
+	if (div <= 0)
+		return -EINVAL;
 
 	mclk->freq = *prate / div;
 
-- 
2.43.0

