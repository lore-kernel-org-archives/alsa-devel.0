Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC1AC56201
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:22:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 051CC22269
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="psOzSD+E";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEKoIH8i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051CC22269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6844B171E;
	Fri, 20 Nov 2020 17:21:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6844B171E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605889360;
	bh=BHZ6nUetqig2aNv0C70O6rfOF+ARiHZiTexSCji7bWY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=psOzSD+Emu3uqgpa2N/eAsKSjlsVU7J1RG+h//uVtE9oZYuRWEaPcJlNQEfZ0BklS
	 id+8xg8WFvP76K78Y+QTMUIb5wREW630KEu9/u3hSbILfbwAUz/kzF/ACinM2EZCHq
	 i6nrq8SsvQGwZN4qFBQK9XzKpTUMskNRlSp99KEY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9691F80506;
	Fri, 20 Nov 2020 17:18:26 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E896FF804FD; Fri, 20 Nov 2020 17:18:23 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A0C3F804FB
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:18:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A0C3F804FB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="qEKoIH8i"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6C0DA22464;
 Fri, 20 Nov 2020 16:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605889099;
 bh=BHZ6nUetqig2aNv0C70O6rfOF+ARiHZiTexSCji7bWY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=qEKoIH8i5FwAd5ly1vMetYZhFMu1kpGGqVE0UUn9liC3Pi2D6HO3lIEMkW8i9iaIP
 sNmP3yJA84yDGQ6X8WBlUdXg32+sjozEnLCoNRgkwkHHoCYqRV7xID/N1XiaadZ4jB
 2FoLPoO6eL220nGxQEDKgQA4xBeZprhpFjIkGsag=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 10/38] ASoC: rockchip: drop of_match_ptr from of_device_id
 table
Date: Fri, 20 Nov 2020 17:16:24 +0100
Message-Id: <20201120161653.445521-10-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Heiko Stuebner <heiko@sntech.de>, Takashi Iwai <tiwai@suse.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>, 
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The driver can match only via the DT table so the table should be always
used and the of_match_ptr does not have any sense (this also allows ACPI
matching via PRP0001, even though it is not relevant here).  This fixes
compile warning (!CONFIG_OF on x86_64):

  sound/soc/rockchip/rockchip_i2s.c:569:34: warning: ‘rockchip_i2s_match’ defined but not used [-Wunused-const-variable=]
  sound/soc/rockchip/rockchip_pdm.c:463:34: warning: ‘rockchip_pdm_match’ defined but not used [-Wunused-const-variable=]
  sound/soc/rockchip/rockchip_spdif.c:44:34: warning: ‘rk_spdif_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/rockchip/rockchip_i2s.c   | 2 +-
 sound/soc/rockchip/rockchip_pdm.c   | 2 +-
 sound/soc/rockchip/rockchip_spdif.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 593299675b8c..39d7ce1f53a7 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -714,7 +714,7 @@ static struct platform_driver rockchip_i2s_driver = {
 	.remove = rockchip_i2s_remove,
 	.driver = {
 		.name = DRV_NAME,
-		.of_match_table = of_match_ptr(rockchip_i2s_match),
+		.of_match_table = rockchip_i2s_match,
 		.pm = &rockchip_i2s_pm_ops,
 	},
 };
diff --git a/sound/soc/rockchip/rockchip_pdm.c b/sound/soc/rockchip/rockchip_pdm.c
index 5adb293d0435..171b55e4010a 100644
--- a/sound/soc/rockchip/rockchip_pdm.c
+++ b/sound/soc/rockchip/rockchip_pdm.c
@@ -614,7 +614,7 @@ static struct platform_driver rockchip_pdm_driver = {
 	.remove = rockchip_pdm_remove,
 	.driver = {
 		.name = "rockchip-pdm",
-		.of_match_table = of_match_ptr(rockchip_pdm_match),
+		.of_match_table = rockchip_pdm_match,
 		.pm = &rockchip_pdm_pm_ops,
 	},
 };
diff --git a/sound/soc/rockchip/rockchip_spdif.c b/sound/soc/rockchip/rockchip_spdif.c
index 674810851fbc..9869da7bccea 100644
--- a/sound/soc/rockchip/rockchip_spdif.c
+++ b/sound/soc/rockchip/rockchip_spdif.c
@@ -381,7 +381,7 @@ static struct platform_driver rk_spdif_driver = {
 	.remove = rk_spdif_remove,
 	.driver = {
 		.name = "rockchip-spdif",
-		.of_match_table = of_match_ptr(rk_spdif_match),
+		.of_match_table = rk_spdif_match,
 		.pm = &rk_spdif_pm_ops,
 	},
 };
-- 
2.25.1

