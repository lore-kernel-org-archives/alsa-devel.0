Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79E47C001DB
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Aug 2023 16:14:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 34BAC1F2;
	Sun, 13 Aug 2023 18:13:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 34BAC1F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691943254;
	bh=LtyDGKCxc+4Ue+VNONWfq3esVK/GdVSLuzudU5QxtdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=rss95LdjX8ZZ4xfIXeXbcFBTxrolUxKQTCtj9gZCrftNQd22wBAR0/MoIDO0XfrD1
	 8zNtTAjhari34QGEOCCGavtDtip/JR9umZshnrsWLEZCE5qxSeY1Kx0tYUFcet91Yz
	 bs8PJc2zLJBqDaJ11SzLWFjuNLpiyNUXxA26V55M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 126BCF80578; Sun, 13 Aug 2023 18:13:10 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BE2E9F80551;
	Sun, 13 Aug 2023 18:13:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 708C4F80551; Sun, 13 Aug 2023 18:13:06 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 97D71F80254
	for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2023 18:13:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97D71F80254
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=tfnfnWIK
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 2576463BC8;
	Sun, 13 Aug 2023 16:13:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D06C433C8;
	Sun, 13 Aug 2023 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691943182;
	bh=LtyDGKCxc+4Ue+VNONWfq3esVK/GdVSLuzudU5QxtdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tfnfnWIKj3dwrht50jE1GbEyKVX6Mu+IIV44q9jh3AskynkarXkf/XeWURPDEWlU7
	 ZW9mw81bgQNwfiWkivscU6id5NJM5yt2AU/WD6DQdVLyhgSyjtKWKJ6tCGpaPqqJvi
	 HUw/B5Cn9kh9h5/WDJ1HWp/1aUDnh/5QmSXR7ISZPuncCu+jJbfd0TWIxRkOAV1sfZ
	 Bibh/nmtcT235BXwzHm2q06ZsNScYh1BlEcmjab11UQemzj98yWN16PowoIjoQKyzd
	 loqGLf0GzqkheAamF8itVo1XNUnlbEMMn5HIrEb+MfYZ8KMwKriAnRzTzu8/6UPhxs
	 mwSRBnja6Dp3w==
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
	hdegoede@redhat.com,
	fred.oh@linux.intel.com,
	u.kleine-koenig@pengutronix.de,
	zhuning0077@gmail.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 5.4 10/14] ASoc: codecs: ES8316: Fix DMIC config
Date: Sun, 13 Aug 2023 12:11:58 -0400
Message-Id: <20230813161202.1086004-10-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813161202.1086004-1-sashal@kernel.org>
References: <20230813161202.1086004-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.253
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 4XGNEUFTBD4K77PJAUD4XTRJ27VYTCPH
X-Message-ID-Hash: 4XGNEUFTBD4K77PJAUD4XTRJ27VYTCPH
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/4XGNEUFTBD4K77PJAUD4XTRJ27VYTCPH/>
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
index 131f41cccbe65..dd2df9a903e05 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -153,7 +153,7 @@ static const char * const es8316_dmic_txt[] = {
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

