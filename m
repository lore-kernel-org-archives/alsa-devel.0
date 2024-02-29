Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70522C54E41
	for <alsa-devel@archiver.kernel.org>; Thu, 29 Feb 2024 15:50:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6A53DF9;
	Thu, 29 Feb 2024 16:50:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6A53DF9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1709221836;
	bh=seMaBnzxWwvV+xWVKAtZ7vvq6fEuoCY+K3+gKI3+l9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AZetpaXkR4CHSugawwRJLTYn08c+wCHln3uicKlLP+JN+7OaIuRA+5J+WV0byH6EK
	 guCQef5MACSH7iDGwl450uSYovNE2jjxH89n8nPDzYdzdh2Rh/mdjjofXAdM84zpxl
	 jX0ZVsZhM4It9FqDZXparl74W9Y/3acWb97zBIkY=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E8CEBF805A1; Thu, 29 Feb 2024 16:50:17 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 43C5DF805A9;
	Thu, 29 Feb 2024 16:50:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 810F0F8013D; Thu, 29 Feb 2024 16:50:13 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest
 SHA256)
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 060DFF80570
	for <alsa-devel@alsa-project.org>; Thu, 29 Feb 2024 16:49:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 060DFF80570
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=A5OpD6tw
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C3A7DCE1B21;
	Thu, 29 Feb 2024 15:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B3EC433A6;
	Thu, 29 Feb 2024 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221794;
	bh=seMaBnzxWwvV+xWVKAtZ7vvq6fEuoCY+K3+gKI3+l9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A5OpD6twN9JSzSjqldqkIJpFGBE04NuElU1yptiu1sL3FHXdTogsGFta2LsZlrWO4
	 SfpxhkhUbYKi39yNRhiTEg8bg0Yi9MmTzLQkOlwCd8NOjb5IRqNK3alYqW0Vowj6q2
	 itkybDeMjlQa9Y7L1mxX4KFqpuqhQ+cknyKzcEIeLno6Hs9dZI9hBl9upNe49rdoXL
	 GMEHLUYSFUK6aIblShFf/ezVazTW5kCIacwHe58ads7mtm88DNO9cJgUMBIcIxIkuM
	 iYyZV97yL0pg/KhMb4CzAKQmKGDVlqmCkpGuvffLd9m9z8k4nEsbqjuXnJwrGQGAfF
	 k7/M82p5kJhkA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.schulman@cirrus.com,
	david.rhodes@cirrus.com,
	rf@opensource.cirrus.com,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 04/21] ASoC: cs42l43: Handle error from
 devm_pm_runtime_enable
Date: Thu, 29 Feb 2024 10:49:24 -0500
Message-ID: <20240229154946.2850012-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
Content-Transfer-Encoding: 8bit
Message-ID-Hash: LRXCLZR6AGQ4AFDMNOCY5XC54VXAQ72F
X-Message-ID-Hash: LRXCLZR6AGQ4AFDMNOCY5XC54VXAQ72F
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LRXCLZR6AGQ4AFDMNOCY5XC54VXAQ72F/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit d1722057477a3786b8c0d60c28fc281f6ecf1cc3 ]

As devm_pm_runtime_enable can fail due to memory allocations, it is
best to handle the error.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20240206113850.719888-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs42l43.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index 5643c666d7d04..8015f4b7a5b32 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -2175,7 +2175,10 @@ static int cs42l43_codec_probe(struct platform_device *pdev)
 	pm_runtime_use_autosuspend(priv->dev);
 	pm_runtime_set_active(priv->dev);
 	pm_runtime_get_noresume(priv->dev);
-	devm_pm_runtime_enable(priv->dev);
+
+	ret = devm_pm_runtime_enable(priv->dev);
+	if (ret)
+		goto err_pm;
 
 	for (i = 0; i < ARRAY_SIZE(cs42l43_irqs); i++) {
 		ret = cs42l43_request_irq(priv, dom, cs42l43_irqs[i].name,
-- 
2.43.0

