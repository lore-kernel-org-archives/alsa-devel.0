Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3F1EB64DA
	for <alsa-devel@archiver.kernel.org>; Fri, 16 Jun 2023 10:29:35 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6FCFF826;
	Fri, 16 Jun 2023 12:28:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6FCFF826
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1686911373;
	bh=UL51JaNgCJ359LQ05V71AD9hkKjINQqHj4mLIucZ88o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=BOYpXjztiCIEXd2cvMhm40DEnXqcYF226pjepwR5ttNidGZfnzcB5eE8/r8IH0N2s
	 H2S35sVCrLQHlCczXHbaZQQdAPEEc9lFRcc0fC/PFJHFUe1pRWxup93hMPubw+upys
	 vwv+BZnUTH0yrEROhC4P2v3jiHxSNcGHBPLlGhXU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 861CAF80149; Fri, 16 Jun 2023 12:26:47 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 2048EF805D9;
	Fri, 16 Jun 2023 12:26:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 376FAF80149; Fri, 16 Jun 2023 12:26:44 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F03F6F80132
	for <alsa-devel@alsa-project.org>; Fri, 16 Jun 2023 12:26:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F03F6F80132
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=JZmm7nG5
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8FAA66356C;
	Fri, 16 Jun 2023 10:26:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E19AC433C0;
	Fri, 16 Jun 2023 10:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686911199;
	bh=UL51JaNgCJ359LQ05V71AD9hkKjINQqHj4mLIucZ88o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JZmm7nG5K3kqRuX9FBr3Hu1TnXdK6lvYKt1b9MASGSgA0t5eKa9v7aM1HuGPJzswU
	 gLiCzO3EL62WQNnIQowKWak0xFMu2edsRHDBK5jbdxtSbA3+OtVG5eP0cGJm7V4JMw
	 nk0Q35ChIcMUOHavl62zkRaFyMMu+10T+O+4k9kvhaoke3sI/Zg5MAw8eL1pn0HIyz
	 C9XfBEB9JaEQ+Hf1JcxM9t9kPXdea3m/NABXKiobc2zm8KMXmLQ1LI1Rj3XorVVWv5
	 Aw56itYLC7mh30oi4xohhEV83Zy4pAmKKILyXsHHiqeQeDMVn3Tboem38tdAyGUiYt
	 5bs0Mw4i2GrjA==
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
Subject: [PATCH AUTOSEL 6.1 07/26] ASoC: simple-card: Add missing
 of_node_put() in case of error
Date: Fri, 16 Jun 2023 06:26:04 -0400
Message-Id: <20230616102625.673454-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230616102625.673454-1-sashal@kernel.org>
References: <20230616102625.673454-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.34
Content-Transfer-Encoding: 8bit
Message-ID-Hash: DM5WWF6FUZGDGYZVWP6MNFH6B34REYWU
X-Message-ID-Hash: DM5WWF6FUZGDGYZVWP6MNFH6B34REYWU
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/DM5WWF6FUZGDGYZVWP6MNFH6B34REYWU/>
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
index feb55b66239b8..fbb682747f598 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -416,6 +416,7 @@ static int __simple_for_each_link(struct asoc_simple_priv *priv,
 
 			if (ret < 0) {
 				of_node_put(codec);
+				of_node_put(plat);
 				of_node_put(np);
 				goto error;
 			}
-- 
2.39.2

