Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD792EB64D7
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jun 2023 10:32:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CF406846;
	Fri, 16 Jun 2023 12:31:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CF406846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686911538;
	bh=vixycZa0jXtagiMlhPDBWtOLoaPdv3OMpN1lDdPe7/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=qPv2eSDMWvjSiJrhfCt/isPSph5VnyH3ZvGZ8ayneQSscNKkJ9Xk1mTbF4+BJC7lZ
	 PZQpjRvhoGuYFL52Ln4R2uFuO4qFFloSz0RS1Xn7qOe4GDeej7PxUY+T13ne0yLmHw
	 ceEBspOp6FqWTNzOUo8avU/6hOJ1VjDu2lfmVLRQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5AAFAF805A8; Fri, 16 Jun 2023 12:28:19 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 1EFC8F805BE;
	Fri, 16 Jun 2023 12:28:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B4147F805BF; Fri, 16 Jun 2023 12:28:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 87CC4F805A9
	for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2023 12:28:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 87CC4F805A9
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=YXzr9E8S
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 636FC636E9;
	Fri, 16 Jun 2023 10:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B306C433C0;
	Fri, 16 Jun 2023 10:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686911281;
	bh=vixycZa0jXtagiMlhPDBWtOLoaPdv3OMpN1lDdPe7/U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YXzr9E8SXQf5anqREkgTajbzQkb1NHXDzW06YQA9nl+qjHLJ1+hnkPvYYgPcnFnP2
	 UStgnjo/8J6Xw7GQpr0UL/5ptK7TOK9siiISXkORVVDXCBVMFVkeRaAI7Yc8MaOeHD
	 bs++5A0vGDilOO+3b6ShFFEv7eye8eMoKx4BNyYpEWroZ4NmrsQBUb9GyWlFOjRu8r
	 rJ9kLsCOkcy6ZIk8Qq00Vn8OMsGtNQD2DNg0dP7ib9nXo9Zr/dv8gPZtHlKWNIwuos
	 1N5TeCCUnezHvnpNejuznDdyLBVn5BUxUuvF2RPZDYddhJu9t/S1KeKzQXdgn5vyni
	 s9vA4w1W5tzyg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Herve Codina <herve.codina@bootlin.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	spujar@nvidia.com,
	aidanmacdonald.0x0@gmail.com,
	astrid.rost@axis.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.10 04/14] ASoC: simple-card: Add missing
 of_node_put() in case of error
Date: Fri, 16 Jun 2023 06:27:41 -0400
Message-Id: <20230616102753.673975-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102753.673975-1-sashal@kernel.org>
References: <20230616102753.673975-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.184
Content-Transfer-Encoding: 8bit
Message-ID-Hash: BGKSLRRINO3NP7UK6XLSCHXAD45XBIBI
X-Message-ID-Hash: BGKSLRRINO3NP7UK6XLSCHXAD45XBIBI
X-MailFrom: sashal@kernel.org
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/BGKSLRRINO3NP7UK6XLSCHXAD45XBIBI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Herve Codina <herve.codina@bootlin.com>

[ Upstream commit 8938f75a5e35c597a647c28984a0304da7a33d63 ]

In the error path, a of_node_put() for platform is missing.
Just add it.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20230523151223.109551-9-herve.codina@bootlin.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/generic/simple-card.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index d916ec69c24ff..ac97e8b7978c7 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -410,6 +410,7 @@ static int simple_for_each_link(struct asoc_simple_priv *priv,
 
 			if (ret < 0) {
 				of_node_put(codec);
+				of_node_put(plat);
 				of_node_put(np);
 				goto error;
 			}
-- 
2.39.2

