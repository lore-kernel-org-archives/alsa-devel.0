Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E939C04A6A
	for <alsa-devel@archiver.kernel.org>; Sun, 13 Aug 2023 15:52:52 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F8E983B;
	Sun, 13 Aug 2023 17:52:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F8E983B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691941970;
	bh=ODJAzLJrSrARDxgIUkCOj51pj+qq43I1mJ/KPafrinw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=tyeXATLwCCBe5/deprP18xltZDQGL6/b7cKmMBxaju+U83799OY1J93f7cm8mr+JT
	 LVQMy31YLNXEA/OU2SZC5LG9VcQgewcO/YDl2qp2cv8Ja7yRyjcwislbfjkluBGruw
	 oJ8mkAK/h+vOYJ5rpOyKFYHtWq4su7diW8bzoq9M=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 087B1F805A1; Sun, 13 Aug 2023 17:51:22 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 0CE09F80588;
	Sun, 13 Aug 2023 17:51:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E521DF8057B; Sun, 13 Aug 2023 17:51:16 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id DC62FF801EB
	for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2023 17:51:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz DC62FF801EB
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=dfHtPROb
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9568A6308C;
	Sun, 13 Aug 2023 15:51:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75418C433C8;
	Sun, 13 Aug 2023 15:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691941872;
	bh=ODJAzLJrSrARDxgIUkCOj51pj+qq43I1mJ/KPafrinw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dfHtPRObwwm0+TSOWUkAKZQwzZvtM6QgGlghfoQTVLLyz6wJQ+B/73lkZwP3ViTG+
	 Oh5XEjEN0lhSYpMAuGyOfDZnvfXnnMJQLTFZgR6795OEkE27zUAwC/FaOL++f58QtV
	 xhj6SeU50t+AADikfY8cWyO20RJc6H3xldNu4MOja25CBcOZkjVQjmkFKRIysCPSqa
	 CWIdNBdt+w1LCGrVU/49XyttrlVtnwxW4ijF6D3kr2hp5BLXodd4+rLrIarbzee8gV
	 bW70Cy/xIU8MmDqQk40YWCuC+SltbmfUWp+JizRIIvqcELnPJW9ugrMQlticzkdaeY
	 QQPtEX42NBJEg==
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
	zhuning0077@gmail.com,
	hdegoede@redhat.com,
	u.kleine-koenig@pengutronix.de,
	pierre-louis.bossart@linux.intel.com,
	alsa-devel@alsa-project.org
Subject: [PATCH AUTOSEL 6.4 29/54] ASoc: codecs: ES8316: Fix DMIC config
Date: Sun, 13 Aug 2023 11:49:08 -0400
Message-Id: <20230813154934.1067569-29-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
Message-ID-Hash: C5GA6VG2OQVBFPGRAFKXXFSZVQQ7T7OR
X-Message-ID-Hash: C5GA6VG2OQVBFPGRAFKXXFSZVQQ7T7OR
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/C5GA6VG2OQVBFPGRAFKXXFSZVQQ7T7OR/>
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
index ccecfdf700649..9f5522dee501d 100644
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

