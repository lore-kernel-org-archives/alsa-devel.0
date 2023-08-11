Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1AFEB64DD
	for <alsa-devel@archiver.kernel.org>; Fri, 11 Aug 2023 07:41:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17C34AE9;
	Fri, 11 Aug 2023 09:41:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17C34AE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691739714;
	bh=z/spso/e1XMbzRxm5JiK77AG/1MZZD9AVFrAYVOmuTs=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KX0kSa8NKO74yTEARCCDv1a/E1J9GnBdyMMtcxVJmi6EV9yX+qG6FpBXNs4GMzWnv
	 T2iX8eik3NRleOU7lrVlIrRdX/bEhD46xzyqysnzoRWKFhxYDcoRiohJWkyZMMZRq2
	 NGrrh9JggceovqaHe7Y23ay/f0seuCv+WATdS8MQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3A349F805B1; Fri, 11 Aug 2023 09:39:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 63E25F805AE;
	Fri, 11 Aug 2023 09:39:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59EBDF80536; Fri, 11 Aug 2023 09:15:14 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8CB45F800F4
	for <alsa-devel@alsa-project.org>; Fri, 11 Aug 2023 09:15:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8CB45F800F4
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RMZj16s8jzCrkT;
	Fri, 11 Aug 2023 15:11:33 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 11 Aug
 2023 15:15:02 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <perex@perex.cz>, <tiwai@suse.com>, <claudiu.beznea@tuxon.dev>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <peda@axentia.se>, <lars@metafoo.de>,
	<nuno.sa@analog.com>, <povik+lin@cutebit.org>, <wens@csie.org>,
	<jernej.skrabec@gmail.com>, <samuel@sholland.org>, <robh@kernel.org>,
	<u.kleine-koenig@pengutronix.de>, <alsa-devel@alsa-project.org>,
	<linux-arm-kernel@lists.infradead.org>, <asahi@lists.linux.dev>,
	<linux-sunxi@lists.linux.dev>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next 1/5] ASoC: atmel: Remove redundant of_match_ptr()
Date: Fri, 11 Aug 2023 15:14:22 +0800
Message-ID: <20230811071426.2343133-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811071426.2343133-1-ruanjinjie@huawei.com>
References: <20230811071426.2343133-1-ruanjinjie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-MailFrom: ruanjinjie@huawei.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: ALJ6GHMLYYILXYLLBIL34SZSRSEDDTYQ
X-Message-ID-Hash: ALJ6GHMLYYILXYLLBIL34SZSRSEDDTYQ
X-Mailman-Approved-At: Fri, 11 Aug 2023 07:39:15 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ALJ6GHMLYYILXYLLBIL34SZSRSEDDTYQ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The driver depends on CONFIG_OF, it is not necessary to use
of_match_ptr() here.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 sound/soc/atmel/atmel-i2s.c    | 2 +-
 sound/soc/atmel/atmel-pdmic.c  | 2 +-
 sound/soc/atmel/mchp-i2s-mcc.c | 2 +-
 sound/soc/atmel/mchp-spdifrx.c | 2 +-
 sound/soc/atmel/mchp-spdiftx.c | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/atmel/atmel-i2s.c b/sound/soc/atmel/atmel-i2s.c
index 69a88dc65165..4febd4d3d0fa 100644
--- a/sound/soc/atmel/atmel-i2s.c
+++ b/sound/soc/atmel/atmel-i2s.c
@@ -730,7 +730,7 @@ static void atmel_i2s_remove(struct platform_device *pdev)
 static struct platform_driver atmel_i2s_driver = {
 	.driver		= {
 		.name	= "atmel_i2s",
-		.of_match_table	= of_match_ptr(atmel_i2s_dt_ids),
+		.of_match_table	= atmel_i2s_dt_ids,
 	},
 	.probe		= atmel_i2s_probe,
 	.remove_new	= atmel_i2s_remove,
diff --git a/sound/soc/atmel/atmel-pdmic.c b/sound/soc/atmel/atmel-pdmic.c
index efcbdd1a629f..0db7815d230c 100644
--- a/sound/soc/atmel/atmel-pdmic.c
+++ b/sound/soc/atmel/atmel-pdmic.c
@@ -690,7 +690,7 @@ static int atmel_pdmic_probe(struct platform_device *pdev)
 static struct platform_driver atmel_pdmic_driver = {
 	.driver	= {
 		.name		= "atmel-pdmic",
-		.of_match_table	= of_match_ptr(atmel_pdmic_of_match),
+		.of_match_table	= atmel_pdmic_of_match,
 		.pm		= &snd_soc_pm_ops,
 	},
 	.probe	= atmel_pdmic_probe,
diff --git a/sound/soc/atmel/mchp-i2s-mcc.c b/sound/soc/atmel/mchp-i2s-mcc.c
index 7c83d48ca1a0..4b8a63295f89 100644
--- a/sound/soc/atmel/mchp-i2s-mcc.c
+++ b/sound/soc/atmel/mchp-i2s-mcc.c
@@ -1098,7 +1098,7 @@ static void mchp_i2s_mcc_remove(struct platform_device *pdev)
 static struct platform_driver mchp_i2s_mcc_driver = {
 	.driver		= {
 		.name	= "mchp_i2s_mcc",
-		.of_match_table	= of_match_ptr(mchp_i2s_mcc_dt_ids),
+		.of_match_table	= mchp_i2s_mcc_dt_ids,
 	},
 	.probe		= mchp_i2s_mcc_probe,
 	.remove_new	= mchp_i2s_mcc_remove,
diff --git a/sound/soc/atmel/mchp-spdifrx.c b/sound/soc/atmel/mchp-spdifrx.c
index ff6aba143aee..e97cd8f4a728 100644
--- a/sound/soc/atmel/mchp-spdifrx.c
+++ b/sound/soc/atmel/mchp-spdifrx.c
@@ -1197,7 +1197,7 @@ static struct platform_driver mchp_spdifrx_driver = {
 	.remove_new = mchp_spdifrx_remove,
 	.driver	= {
 		.name	= "mchp_spdifrx",
-		.of_match_table = of_match_ptr(mchp_spdifrx_dt_ids),
+		.of_match_table = mchp_spdifrx_dt_ids,
 		.pm	= pm_ptr(&mchp_spdifrx_pm_ops),
 	},
 };
diff --git a/sound/soc/atmel/mchp-spdiftx.c b/sound/soc/atmel/mchp-spdiftx.c
index 1d3e17119888..b1040576f71f 100644
--- a/sound/soc/atmel/mchp-spdiftx.c
+++ b/sound/soc/atmel/mchp-spdiftx.c
@@ -891,7 +891,7 @@ static struct platform_driver mchp_spdiftx_driver = {
 	.remove_new = mchp_spdiftx_remove,
 	.driver	= {
 		.name	= "mchp_spdiftx",
-		.of_match_table = of_match_ptr(mchp_spdiftx_dt_ids),
+		.of_match_table = mchp_spdiftx_dt_ids,
 		.pm = pm_ptr(&mchp_spdiftx_pm_ops)
 	},
 };
-- 
2.34.1

