Return-Path: <SRS0=9dS2=H4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29834C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Feb 2021 02:06:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1031364EF5
	for <alsa-devel@archiver.kernel.org>; Fri, 26 Feb 2021 02:06:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1031364EF5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 76AC215DC;
	Fri, 26 Feb 2021 03:05:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 76AC215DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614305194;
	bh=LpRUuHcAicX4DFA4xO5XYsMIhxuJ+Acr3S65ZcvovxA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GEHshBbjKY2EACQ2ry+fAtr5zyj+MV1tyETR1JYCQokS6fZSAE01I5ctzwX1oErTI
	 cVShZzmaOStliRA0W6YYHGMqfPN/s8Dih5IpRPMSIRfzxghExrBHQSjGXzYh/UxD7Z
	 Uaro+T2+LCkErthh5N0KezzYzH93h0tAhNQ2rPSo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECB1BF80169;
	Fri, 26 Feb 2021 03:05:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E57BF8016A; Fri, 26 Feb 2021 03:05:42 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C673BF800E4
 for <alsa-devel@alsa-project.org>; Fri, 26 Feb 2021 03:05:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C673BF800E4
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 11Q25Q9a8010702,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
 by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 11Q25Q9a8010702
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Fri, 26 Feb 2021 10:05:26 +0800
Received: from localhost.localdomain (172.22.102.1) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 26 Feb 2021 10:05:25 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: rt1015p: add acpi device id for rt1015p
Date: Fri, 26 Feb 2021 10:05:17 +0800
Message-ID: <20210226020517.17124-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.102.1]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
Cc: oder_chiou@realtek.com, Jack Yu <jack.yu@realtek.com>,
 alsa-devel@alsa-project.org, lars@metafoo.de, kent_chen@realtek.com,
 kenny_chen@realtek.com, derek.fang@realtek.com, shumingf@realtek.com,
 flove@realtek.com
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

From: Jack Yu <jack.yu@realtek.com>

Add acpi device id for rt1015p.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt1015p.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/rt1015p.c b/sound/soc/codecs/rt1015p.c
index 671f2a2130fe..61694de080e6 100644
--- a/sound/soc/codecs/rt1015p.c
+++ b/sound/soc/codecs/rt1015p.c
@@ -4,6 +4,7 @@
 //
 // Copyright 2020 The Linux Foundation. All rights reserved.
 
+#include <linux/acpi.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -130,10 +131,19 @@ static const struct of_device_id rt1015p_device_id[] = {
 MODULE_DEVICE_TABLE(of, rt1015p_device_id);
 #endif
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id rt1015p_acpi_match[] = {
+	{ "ALCP1015", 0},
+	{ },
+};
+MODULE_DEVICE_TABLE(acpi, rt1015p_acpi_match);
+#endif
+
 static struct platform_driver rt1015p_platform_driver = {
 	.driver = {
 		.name = "rt1015p",
 		.of_match_table = of_match_ptr(rt1015p_device_id),
+		.acpi_match_table = ACPI_PTR(rt1015p_acpi_match),
 	},
 	.probe = rt1015p_platform_probe,
 };
-- 
2.29.0

