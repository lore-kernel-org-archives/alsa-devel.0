Return-Path: <SRS0=4V3b=E2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240D6C2D0E4
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:23:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E2BA22269
	for <alsa-devel@archiver.kernel.org>; Fri, 20 Nov 2020 16:23:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AvIELhZv";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xuKRxDVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E2BA22269
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C02151715;
	Fri, 20 Nov 2020 17:22:43 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C02151715
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605889413;
	bh=vBYEDxeWGr2WVDsaU9JoHxXG3Ni9B9eteSqn4Twg9jo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AvIELhZvPyQSGm1pbQC6WObWTB/PaI21mmCDpGsaBzwhpB9vUlsNrn1bLysOU61Zs
	 PvnIxZDUyoc63f9NM2VMCwGrGDTcHOUXLIUiXzgniL4ZRnqykCM2aFI2Fr/mw9ZITL
	 Mi6LU/MD5uCHN08O0eKN7eXOb7dxwP8QksVNaWo8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3B71FF8051E;
	Fri, 20 Nov 2020 17:18:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A7C3EF8051F; Fri, 20 Nov 2020 17:18:32 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1DDEBF8051D
 for <alsa-devel@alsa-project.org>; Fri, 20 Nov 2020 17:18:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1DDEBF8051D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="xuKRxDVH"
Received: from localhost.localdomain (adsl-84-226-167-205.adslplus.ch
 [84.226.167.205])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9E096223BE;
 Fri, 20 Nov 2020 16:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1605889108;
 bh=vBYEDxeWGr2WVDsaU9JoHxXG3Ni9B9eteSqn4Twg9jo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=xuKRxDVHHqiDSgK3K+Q8DYu5DLZ23VYVwsKqijAZV4F0MQPBYnPWMKLvy/qbQxSWb
 MhwdfJAmbIh0wj5AraHRC0GcSEVUC68KnzKd+m2/9S2rWQDion/q/Y1jvDelQW7hqT
 UvzffEYzltPZ4R64ly17nm/PIMP2nPh5tw1WNJtw=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Subject: [PATCH 12/38] ASoC: uniphier: drop of_match_ptr from of_device_id
 table
Date: Fri, 20 Nov 2020 17:16:26 +0100
Message-Id: <20201120161653.445521-12-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201120161653.445521-1-krzk@kernel.org>
References: <20201120161653.445521-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: linux-arm-kernel@lists.infradead.org,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Takashi Iwai <tiwai@suse.com>, Krzysztof Kozlowski <krzk@kernel.org>
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

  sound/soc/uniphier/aio-ld11.c:375:34: warning: ‘uniphier_aio_of_match’ defined but not used [-Wunused-const-variable=]
  sound/soc/uniphier/evea.c:554:34: warning: ‘evea_of_match’ defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 sound/soc/uniphier/aio-ld11.c | 2 +-
 sound/soc/uniphier/aio-pxs2.c | 2 +-
 sound/soc/uniphier/evea.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/uniphier/aio-ld11.c b/sound/soc/uniphier/aio-ld11.c
index 8b44f8dc4970..107dd8c15a0a 100644
--- a/sound/soc/uniphier/aio-ld11.c
+++ b/sound/soc/uniphier/aio-ld11.c
@@ -388,7 +388,7 @@ MODULE_DEVICE_TABLE(of, uniphier_aio_of_match);
 static struct platform_driver uniphier_aio_driver = {
 	.driver = {
 		.name = "snd-uniphier-aio-ld11",
-		.of_match_table = of_match_ptr(uniphier_aio_of_match),
+		.of_match_table = uniphier_aio_of_match,
 	},
 	.probe    = uniphier_aio_probe,
 	.remove   = uniphier_aio_remove,
diff --git a/sound/soc/uniphier/aio-pxs2.c b/sound/soc/uniphier/aio-pxs2.c
index a1d05fe9d3c2..66e983d80c5e 100644
--- a/sound/soc/uniphier/aio-pxs2.c
+++ b/sound/soc/uniphier/aio-pxs2.c
@@ -294,7 +294,7 @@ MODULE_DEVICE_TABLE(of, uniphier_aio_of_match);
 static struct platform_driver uniphier_aio_driver = {
 	.driver = {
 		.name = "snd-uniphier-aio-pxs2",
-		.of_match_table = of_match_ptr(uniphier_aio_of_match),
+		.of_match_table = uniphier_aio_of_match,
 	},
 	.probe    = uniphier_aio_probe,
 	.remove   = uniphier_aio_remove,
diff --git a/sound/soc/uniphier/evea.c b/sound/soc/uniphier/evea.c
index d27e9ca07856..b14d52052439 100644
--- a/sound/soc/uniphier/evea.c
+++ b/sound/soc/uniphier/evea.c
@@ -560,7 +560,7 @@ MODULE_DEVICE_TABLE(of, evea_of_match);
 static struct platform_driver evea_codec_driver = {
 	.driver = {
 		.name = DRV_NAME,
-		.of_match_table = of_match_ptr(evea_of_match),
+		.of_match_table = evea_of_match,
 	},
 	.probe  = evea_probe,
 	.remove = evea_remove,
-- 
2.25.1

