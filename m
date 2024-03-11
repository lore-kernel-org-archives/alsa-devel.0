Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47592C5475B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:44:17 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 231141909;
	Mon, 11 Mar 2024 19:44:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 231141909
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710182655;
	bh=Gp9IO464KiE0GU2Yx/UvzMNFMfeX7usV3cGwqZ/sgbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=C1PJ74cOuhZz+kAPTcdbRlvV2CoiyfsBcLfXxsRyEZt2IFzFbtpmaiXTLIRriQfnl
	 hQRXYNDsS/a0TOQTFp+9whf7J+bnr5EprS9xhlK2VgXpN0xoHkebYn5QowT5Q2I+Za
	 5PeyOaplyZuqkefCseYCMCsMpJP7wKkU4oiIgBgA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E2ACEF80CB8; Mon, 11 Mar 2024 19:40:00 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4AA21F80C8B;
	Mon, 11 Mar 2024 19:40:00 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id EEC8BF80674; Mon, 11 Mar 2024 19:39:54 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 0863FF80C5A
	for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2024 19:39:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0863FF80C5A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=P0ct7dtQ
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DFEB960F57;
	Mon, 11 Mar 2024 18:39:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F75EC433C7;
	Mon, 11 Mar 2024 18:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182379;
	bh=Gp9IO464KiE0GU2Yx/UvzMNFMfeX7usV3cGwqZ/sgbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P0ct7dtQr+kJ4jbhiBTp67eKHJU9oGS2xo8SvMu5SqeVh/K0sGmIG3ppZMbOmWeYC
	 3B+M9xLhyl3TDxs/XAv+UiTe12anYXsw6ZQQPm7ZKkEJ1frbsl+nRaeYYoJft6N1+l
	 +NxrBatgyHSOFwBcJrR4wx9C/bSSc+mjY+WFoXOJ/puHNWNYwTWxYd7UmF5mFg1Csg
	 dKLz2hjUc7IDv0rr00YZd5D9I6vUj+Og3JeBA+wvaEZARFnvkobxef0w/BrzOH6hdV
	 zP2F0XV2aqI1LzhrMACWdPxnqvlZHyOxTPXtcUGO/BQPD3B4wA/BjuFzbZOmQbRF56
	 F8vmzQB+3miow==
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
Subject: [PATCH AUTOSEL 5.10 3/5] ASoC: wm8962: Enable oscillator if selecting
 WM8962_FLL_OSC
Date: Mon, 11 Mar 2024 14:39:20 -0400
Message-ID: <20240311183923.328881-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183923.328881-1-sashal@kernel.org>
References: <20240311183923.328881-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.212
Content-Transfer-Encoding: 8bit
Message-ID-Hash: XWQGYKG57K2OY757WW6X3AHV2LINATJ6
X-Message-ID-Hash: XWQGYKG57K2OY757WW6X3AHV2LINATJ6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/XWQGYKG57K2OY757WW6X3AHV2LINATJ6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Stuart Henderson <stuarth@opensource.cirrus.com>

[ Upstream commit 03c7874106ca5032a312626b927b1c35f07b1f35 ]

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Link: https://msgid.link/r/20240306161439.1385643-1-stuarth@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/wm8962.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 57aeded978c28..d6efc85f966b0 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2898,8 +2898,12 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 	switch (fll_id) {
 	case WM8962_FLL_MCLK:
 	case WM8962_FLL_BCLK:
+		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		break;
 	case WM8962_FLL_OSC:
 		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		snd_soc_component_update_bits(component, WM8962_PLL2,
+					      WM8962_OSC_ENA, WM8962_OSC_ENA);
 		break;
 	case WM8962_FLL_INT:
 		snd_soc_component_update_bits(component, WM8962_FLL_CONTROL_1,
-- 
2.43.0

