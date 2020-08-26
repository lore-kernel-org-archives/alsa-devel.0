Return-Path: <SRS0=TbbB=CE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DB4DC433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:50:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06E642224D
	for <alsa-devel@archiver.kernel.org>; Wed, 26 Aug 2020 14:50:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="SCJds82P";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScUGKkM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06E642224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 738151757;
	Wed, 26 Aug 2020 16:49:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 738151757
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598453445;
	bh=4KSU23WtTjItpkpM4PdbL4vEH8O0UC56ECWXv2J/6J0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SCJds82PbQjDb/zbDR4ZMxA5yTEsRvCrP/xYSs5FoAzcldUWDCcRFgJSxZxF3/pgy
	 iewO64ncyOBNUiq/iMrjXvO84lOvfKHqGq/iGEctlVF6v0z4XZkiUzr+WiCSCdvNTE
	 yLAjoiZO6rpyHyXAACkeWD7pcCvK6hjt3BzX8VfA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 13600F80105;
	Wed, 26 Aug 2020 16:49:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F1CA6F801F2; Wed, 26 Aug 2020 16:49:53 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D283F800EB
 for <alsa-devel@alsa-project.org>; Wed, 26 Aug 2020 16:49:43 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D283F800EB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ScUGKkM+"
Received: from localhost.localdomain (unknown [194.230.155.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AFABF2177B;
 Wed, 26 Aug 2020 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598453381;
 bh=4KSU23WtTjItpkpM4PdbL4vEH8O0UC56ECWXv2J/6J0=;
 h=From:To:Cc:Subject:Date:From;
 b=ScUGKkM+UeSzgY8CMhwi8/yLLMbvJ0FnhzjziU28im+JhxuxMHaDVTMN80ixGtMTt
 Am/zzb5mVpN9sx7OSMnAH1h57ECyeO2+QJbuALgfs9vdz5A8/gdyvvQFmJQih4fqtb
 DSRsulWA1dpGg5pD7Fvr08H8nTo55Pl9X4WXKrFY=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>,
 Richard Fitzgerald <rf@opensource.cirrus.com>,
 Lee Jones <lee.jones@linaro.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@st.com>, alsa-devel@alsa-project.org,
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] mfd: madera: Simplify with dev_err_probe()
Date: Wed, 26 Aug 2020 16:49:33 +0200
Message-Id: <20200826144935.10067-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Cc: Krzysztof Kozlowski <krzk@kernel.org>
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

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/mfd/madera-core.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/madera-core.c b/drivers/mfd/madera-core.c
index 8a8d733fdce5..4ed6ad8ce002 100644
--- a/drivers/mfd/madera-core.c
+++ b/drivers/mfd/madera-core.c
@@ -369,19 +369,14 @@ EXPORT_SYMBOL_GPL(madera_of_match);
 static int madera_get_reset_gpio(struct madera *madera)
 {
 	struct gpio_desc *reset;
-	int ret;
 
 	if (madera->pdata.reset)
 		return 0;
 
 	reset = devm_gpiod_get_optional(madera->dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(reset)) {
-		ret = PTR_ERR(reset);
-		if (ret != -EPROBE_DEFER)
-			dev_err(madera->dev, "Failed to request /RESET: %d\n",
-				ret);
-		return ret;
-	}
+	if (IS_ERR(reset))
+		return dev_err_probe(madera->dev, PTR_ERR(reset),
+				"Failed to request /RESET");
 
 	/*
 	 * A hard reset is needed for full reset of the chip. We allow running
-- 
2.17.1

