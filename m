Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5CF4C001DB
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Aug 2023 16:16:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 47FBEE76;
	Sun, 13 Aug 2023 18:15:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 47FBEE76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691943377;
	bh=jRDE0jWXws9jMExLZ0ak8vIhAFZa1jKUZhP1XXiU/4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=g1f2PSGnvCI7WnOoGhdPqFm+rCUTYAGkBPjE3O7e6w0EdwowsNqlkgeMG3QZg8CVL
	 1oDa/gWoc6CT4EXVc6TOioIEsZwNWKj0XZwpHmXNgFHcLXYxCbxnaxV+uPEd+eiu7d
	 shCpIRX4mipre97S04IeKnLXC/NCR/EnKaoWAmr4=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 19E76F8025F; Sun, 13 Aug 2023 18:15:27 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id DE946F80272;
	Sun, 13 Aug 2023 18:15:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 514D3F80272; Sun, 13 Aug 2023 18:15:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 7678DF80016
	for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2023 18:15:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7678DF80016
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=G7wyR1NO
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 661DF62601;
	Sun, 13 Aug 2023 16:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFDEC433CA;
	Sun, 13 Aug 2023 16:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691943319;
	bh=jRDE0jWXws9jMExLZ0ak8vIhAFZa1jKUZhP1XXiU/4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G7wyR1NOfWe6sZwrlK3ZtGpXXaKOWZrAhAQM+I/93iX9B+E85VAqYN5Rk0tU3f78O
	 clU2Soz23ywpW+MR8w9hBkcB5rlLzcGSOUuPfMB7bAH4GQmin73Hg9PbMWkQdrfaRl
	 uQWZGKNvm2BYaHYmymnq2Ag1ABAcKsiA+QfGL4yRX9F/9e8U6X5Ifirx2fKJf/Dx4P
	 q7nf7ooapUzs3yVrWKZ4u9ClJ2B+eQNGPUPFsXFgX+U1UZT0VMiUj09jXIC+tJnlRU
	 fz9ZueY4MfWBThK8E5wUfz5idtqZDiEskZDpV0u0ppzkqfIyd5LUpsmq96zMrRXKOG
	 jkFh3555L5clw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Edgar <ljijcj@163.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	lgirdwood@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	cristian.ciocaltea@collabora.com,
	pierre-louis.bossart@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	u.kleine-koenig@pengutronix.de,
	zhuning0077@gmail.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.14 8/9] ASoc: codecs: ES8316: Fix DMIC config
Date: Sun, 13 Aug 2023 12:14:26 -0400
Message-Id: <20230813161427.1089101-8-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813161427.1089101-1-sashal@kernel.org>
References: <20230813161427.1089101-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.322
Content-Transfer-Encoding: 8bit
Message-ID-Hash: JBE3B4NO2LLOY6FNO2BTI4LQLSH2YZDB
X-Message-ID-Hash: JBE3B4NO2LLOY6FNO2BTI4LQLSH2YZDB
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/JBE3B4NO2LLOY6FNO2BTI4LQLSH2YZDB/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Edgar <ljijcj@163.com>

[ Upstream commit d20d35d1ad62c6cca36368c1e8f29335a068659e ]

According to the datasheet, the DMIC config should
be changed to { 0, 2 ,3 }

Signed-off-by: Edgar <ljijcj@163.com>
Link: https://lore.kernel.org/r/20230719054722.401954-1-ljijcj@163.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/es8316.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 0410f2e5183c3..d35a157bad57f 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -140,7 +140,7 @@ static const char * const es8316_dmic_txt[] = {
 		"dmic data at high level",
 		"dmic data at low level",
 };
-static const unsigned int es8316_dmic_values[] = { 0, 1, 2 };
+static const unsigned int es8316_dmic_values[] = { 0, 2, 3 };
 static const struct soc_enum es8316_dmic_src_enum =
 	SOC_VALUE_ENUM_SINGLE(ES8316_ADC_DMIC, 0, 3,
 			      ARRAY_SIZE(es8316_dmic_txt),
-- 
2.40.1

