Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39170C4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Dec 2023 14:05:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 84C99836;
	Mon, 11 Dec 2023 15:05:25 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 84C99836
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1702303535;
	bh=jUihBYeHQbkQW/PvPBbNJ5y9AEV7+IkhX93m4Wyi1qE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=teZcIAKMuhvxy8QNcmsK6FudxSOYCmqcERIN1UdialYZlycj+HwEoy0zpmPzvIMUm
	 p7qFKd1ptOpuwLq1CueruFw/DSWdRHcAboeAKpf7C3XZxkKxIGJcb+/39A5JklwD8i
	 MKpg6WYpl9bVVtEs/dCNXaCHAvgDyfS4dShq/Kyo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 5FF08F806BF; Mon, 11 Dec 2023 15:03:34 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 713E8F806B0;
	Mon, 11 Dec 2023 15:03:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 12E91F80494; Mon, 11 Dec 2023 15:03:26 +0100 (CET)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id F3CD8F80615
	for <alsa-devel@alsa-project.org>; Mon, 11 Dec 2023 15:03:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F3CD8F80615
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=CQDwwr4u
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 1E44ECE1287;
	Mon, 11 Dec 2023 14:03:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ECDDC433C8;
	Mon, 11 Dec 2023 14:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702303395;
	bh=jUihBYeHQbkQW/PvPBbNJ5y9AEV7+IkhX93m4Wyi1qE=;
	h=From:To:Cc:Subject:Date:From;
	b=CQDwwr4ufh1oFIUjmx0CgHlEBqxDadFUyLH0xbVS3QPsJ4SJSQFQeSwaj6UNuanMC
	 k2KjvFLOWa1qrRF/ZK1yWakxRDiX2LGQ4ovCREgnz+BySl2+b+wZBvg/IsnHBaiubn
	 rMNVC+gEKjfQ76gtU5I6ZnxkoQM9ascafeTt0mdzxbHBe7n2TVQKUV/FAcf5uaY2qZ
	 sqWsssmmpHfyI/RClrDBjNYjg+PsnjmYbvb84kgHG4VKxB9cV2C/uwziiJYgM/vt0n
	 F855gC7diWjaGopI5IZwhD/IP0vC4/mn7xrm1Vif0jkOwuJVad7CMnkxcRE3d+LGMa
	 qbwgj/AQwQwuQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Strozek <mstrozek@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
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
Subject: [PATCH AUTOSEL 4.14 1/5] ASoC: cs43130: Fix the position of const
 qualifier
Date: Mon, 11 Dec 2023 09:03:06 -0500
Message-ID: <20231211140311.392827-1-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.14.332
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VW5NXL4BD2K3UIVGFRQB5RDB2YHEBIMY
X-Message-ID-Hash: VW5NXL4BD2K3UIVGFRQB5RDB2YHEBIMY
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VW5NXL4BD2K3UIVGFRQB5RDB2YHEBIMY/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Maciej Strozek <mstrozek@opensource.cirrus.com>

[ Upstream commit e7f289a59e76a5890a57bc27b198f69f175f75d9 ]

Signed-off-by: Maciej Strozek <mstrozek@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20231117141344.64320-2-mstrozek@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/codecs/cs43130.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs43130.c b/sound/soc/codecs/cs43130.c
index 643e37fc218e1..793496e8d262d 100644
--- a/sound/soc/codecs/cs43130.c
+++ b/sound/soc/codecs/cs43130.c
@@ -1675,7 +1675,7 @@ static ssize_t cs43130_show_dc_r(struct device *dev,
 	return cs43130_show_dc(dev, buf, HP_RIGHT);
 }
 
-static u16 const cs43130_ac_freq[CS43130_AC_FREQ] = {
+static const u16 cs43130_ac_freq[CS43130_AC_FREQ] = {
 	24,
 	43,
 	93,
@@ -2351,7 +2351,7 @@ static const struct regmap_config cs43130_regmap = {
 	.use_single_rw		= true, /* needed for regcache_sync */
 };
 
-static u16 const cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
+static const u16 cs43130_dc_threshold[CS43130_DC_THRESHOLD] = {
 	50,
 	120,
 };
-- 
2.42.0

