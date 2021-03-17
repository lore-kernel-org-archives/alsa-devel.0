Return-Path: <SRS0=sQP2=IP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43CEC433E6
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Mar 2021 06:24:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D36664F6B
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Mar 2021 06:24:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D36664F6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 30EDB18DE;
	Wed, 17 Mar 2021 07:23:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 30EDB18DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1615962267;
	bh=MMRHrnup1LjJBnr3vq282X1FqTTUZ4ZSy8rj4DkUe44=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IA6/hWAdOMJ829ggGM8rtsh7xm6E0vtTBmaSg67BQ5edqAOFGr/MV+BSg6QTIXwxx
	 gTbXbKkFhgU9IjqJy3lqM36AeyEZjREP+YFy4rdNYFOTt2/t/KO7XW9nhTe5yaDpwW
	 oi3mi9N8SrYMBBYLLeeOSThH5h4VyRE5Ap3I/Wwg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5DD43F801F7;
	Wed, 17 Mar 2021 07:23:36 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7B2B3F8021C; Wed, 17 Mar 2021 07:23:33 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0836DF80124
 for <alsa-devel@alsa-project.org>; Wed, 17 Mar 2021 07:23:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0836DF80124
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 12H6NFewC011917,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmbs01.realtek.com.tw[172.21.6.94])
 by rtits2.realtek.com.tw (8.15.2/2.70/5.88) with ESMTPS id 12H6NFewC011917
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 17 Mar 2021 14:23:15 +0800
Received: from localhost.localdomain (172.22.102.1) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Wed, 17 Mar 2021 14:23:15 +0800
From: Jack Yu <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: rt1015p: add new acpi id and comapatible id
Date: Wed, 17 Mar 2021 14:23:09 +0800
Message-ID: <20210317062309.14051-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.102.1]
X-ClientProxiedBy: RTEXMBS01.realtek.com.tw (172.21.6.94) To
 RTEXMBS01.realtek.com.tw (172.21.6.94)
Cc: oder_chiou@realtek.com, Jack Yu <jack.yu@realtek.com>,
 alsa-devel@alsa-project.org, lars@metafoo.de, kent_chen@realtek.com,
 kenny_chen@realtek.com, tzungbi@google.com, derek.fang@realtek.com,
 shumingf@realtek.com, flove@realtek.com
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

Add new acpi id and compatible id for rt1015p.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml | 4 +++-
 sound/soc/codecs/rt1015p.c                                   | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml b/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
index 644b68edf3e1..b898dfa4eb83 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt1015p.yaml
@@ -15,7 +15,9 @@ description: |
 
 properties:
   compatible:
-    const: realtek,rt1015p
+    oneOf:
+      - const: realtek,rt1015p
+      - const: realtek,rt1019p
 
   sdb-gpios:
     description:
diff --git a/sound/soc/codecs/rt1015p.c b/sound/soc/codecs/rt1015p.c
index 39f4c4ed2ab8..085a7b3c7bb4 100644
--- a/sound/soc/codecs/rt1015p.c
+++ b/sound/soc/codecs/rt1015p.c
@@ -126,6 +126,7 @@ static int rt1015p_platform_probe(struct platform_device *pdev)
 #ifdef CONFIG_OF
 static const struct of_device_id rt1015p_device_id[] = {
 	{ .compatible = "realtek,rt1015p" },
+	{ .compatible = "realtek,rt1019p" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, rt1015p_device_id);
@@ -134,6 +135,7 @@ MODULE_DEVICE_TABLE(of, rt1015p_device_id);
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rt1015p_acpi_match[] = {
 	{ "RTL1015", 0},
+	{ "RTL1019", 0},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, rt1015p_acpi_match);
-- 
2.29.0

