Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA7A4C5475B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Mar 2024 18:43:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B691E94;
	Mon, 11 Mar 2024 19:43:18 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B691E94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1710182608;
	bh=/13Qo09rKfsJMout/fQ36Ue7hQdaUBOKwc5wkddezjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=uqAVVRKZ7kDLP4RO8gXbVBGmjRIqdcNKxWq7rX6i3RPPssz/jYKuqLxKy5I2ZEYq4
	 2ZfYxq5VCr/spYs5zn5HT6RNXm1qwSLtXOV4J4KgyNh6ckFpEcn75x5RP/wOG74t6t
	 DIOBdhkMFiULtaPjjJRM5ACaHjRmT2s9DPIWFm0I=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BBC63F80C0D; Mon, 11 Mar 2024 19:39:37 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B461F808C4;
	Mon, 11 Mar 2024 19:39:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 37CF4F80634; Mon, 11 Mar 2024 19:39:30 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C1F31F8062D
	for <alsa-devel@alsa-project.org>; Mon, 11 Mar 2024 19:39:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C1F31F8062D
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=qTXHmUai
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id A580560BCB;
	Mon, 11 Mar 2024 18:39:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3030FC433F1;
	Mon, 11 Mar 2024 18:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710182362;
	bh=/13Qo09rKfsJMout/fQ36Ue7hQdaUBOKwc5wkddezjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTXHmUaigIlkKK2eLP2GU9gQF9xJcdz0jVEAhsiLt5aLDnSU/0e00I0D3x2Qnbbho
	 baJa00yavtyCxoH6vnua9XJcIxzAxTorotNzqKlTT+A4EM7ictWnyhx+JmVfW6aQZc
	 pJPKyplAOikOYT8qy9UvJrsZ0ypULTRi2ko2dNyYCSRVUnc/FbXZ/IR4s+dQzRHPll
	 ZFqylER9W/WPiZNKlmSAelRo188DJCWotPr28jKDRdzZ16ALA5IJcoCqutb0Tjp+pX
	 kpdEpDod5YTY7Tw30PTdYgprHIVkaDcoKmyQPpyoRznrmo9sgnzWekAEnnP0w4Wwwo
	 GMGidm5/YNb/A==
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
Subject: [PATCH AUTOSEL 5.15 5/5] ASoC: wm8962: Fix up incorrect error message
 in wm8962_set_fll
Date: Mon, 11 Mar 2024 14:39:01 -0400
Message-ID: <20240311183901.328749-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311183901.328749-1-sashal@kernel.org>
References: <20240311183901.328749-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.151
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZUERJMHLCMTS46QPTM6TNKNYVK2QSKAD
X-Message-ID-Hash: ZUERJMHLCMTS46QPTM6TNKNYVK2QSKAD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZUERJMHLCMTS46QPTM6TNKNYVK2QSKAD/>
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
index 897f38758a230..b5a35999d8dfa 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2920,7 +2920,7 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 				    WM8962_FLL_FRC_NCO, WM8962_FLL_FRC_NCO);
 		break;
 	default:
-		dev_err(component->dev, "Unknown FLL source %d\n", ret);
+		dev_err(component->dev, "Unknown FLL source %d\n", source);
 		return -EINVAL;
 	}
 
-- 
2.43.0

