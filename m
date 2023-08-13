Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F6D7C41513
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Aug 2023 16:15:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CC93CE7F;
	Sun, 13 Aug 2023 18:14:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CC93CE7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691943314;
	bh=LXLKgo/FuVHwmPKi1Faa2x/jlskZzn0r0tOS1csN5p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=AzPhGn3QB3folK6ZHzd6RRfc8j0OflVdmZLgPlaWMaIZ32ignmerxEo3MW6tvMMzi
	 MZbpPv6u/5Mw/MHMvxquvXohRspZto9MN75/2b9Xs7nLwl4qsND28OXal8Wu7es3uC
	 J9IG7ovlBobklFSWfioEnptzJNegws8YbP+/Rr58=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D7C96F80254; Sun, 13 Aug 2023 18:14:17 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 66CFEF8025F;
	Sun, 13 Aug 2023 18:14:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7BA96F80510; Sun, 13 Aug 2023 18:14:14 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id D1228F80254
	for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2023 18:14:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1228F80254
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bkHAtKIc
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BF42363BB5;
	Sun, 13 Aug 2023 16:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84398C433C9;
	Sun, 13 Aug 2023 16:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691943251;
	bh=LXLKgo/FuVHwmPKi1Faa2x/jlskZzn0r0tOS1csN5p8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bkHAtKIcM+DoTwSUT3WLp/YqlkTZ81lSw7NAh9jjoNs6PkLvZRdQqcRzBYWigwscl
	 qk9ICIkdEOsGzUB8Bhxl2KIgw1kq7qktm0Wpg+NVs54QqDu1T9fQPsDC0sKfXNOqgm
	 Mw/sPh24GT1LRJHV1nQxIloRDGCxGwEmvnD0xBj+Mwwy4jFPt9FmAvNG1gAnHs0nbm
	 9EXEYtT6OeS6t/W+Cme4S+KamA61CovRKpW/dLdE1XQLFTRdtvxYyyoL4x3sVXo3lp
	 887pFkQYsej/dUOdr7nMz+Uqlf1dtxovq09xydKDfRjmT6ciopSqbwVu9KhbbAY8Ja
	 1TbKYv8oE5Naw==
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
	peter.ujfalusi@linux.intel.com,
	zhuning0077@gmail.com,
	pierre-louis.bossart@linux.intel.com,
	u.kleine-koenig@pengutronix.de,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 4.19 10/13] ASoc: codecs: ES8316: Fix DMIC config
Date: Sun, 13 Aug 2023 12:13:14 -0400
Message-Id: <20230813161317.1087606-10-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813161317.1087606-1-sashal@kernel.org>
References: <20230813161317.1087606-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.291
Content-Transfer-Encoding: 8bit
Message-ID-Hash: HS4DXVTSOP6H3AUOAXQYJAT7WTD2YHUC
X-Message-ID-Hash: HS4DXVTSOP6H3AUOAXQYJAT7WTD2YHUC
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/HS4DXVTSOP6H3AUOAXQYJAT7WTD2YHUC/>
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
index 57130edaf3aba..d3a44b21143d4 100644
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

