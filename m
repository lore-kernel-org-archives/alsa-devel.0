Return-Path: <SRS0=vWr5=BC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068B0C433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:09:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8277720714
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 16:09:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="ik7HzOqn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="euR4/39W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8277720714
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 110B4167E;
	Thu, 23 Jul 2020 18:08:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 110B4167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595520588;
	bh=+i2sOnpVY0VqRNXiqsxxrVqbbNga2Bv0f9I3RhWqSkY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ik7HzOqn7BGCdxgZd5mCZmV3PWfNBqFIzw8oQgCUfJ2fm1xPhJJVrmOpubbH+rhuc
	 6MA+62gpys2Bs2xdItynpPu3vwKcuHjENWi9eQRfRC9pqqnkx68pV/Js2/tSpq97Mm
	 I/7ChmWsa8RAlTB0aVTADjdd9dvak4nCkbs23T/A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 91CDAF80090;
	Thu, 23 Jul 2020 18:08:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A2D9F8011F; Thu, 23 Jul 2020 18:08:54 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8CDAF8020D
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2020 18:08:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8CDAF8020D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="euR4/39W"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06NG8iCf021775;
 Thu, 23 Jul 2020 11:08:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1595520524;
 bh=nA7a4nlfdC+eYe8JsjKg4KWcz0j3ZopXtCp88J/O3P0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=euR4/39WbozRW1r7GbT2HDVPCvSUH2yFYWfHGy27Yn9014B1wnkPsaA2PwrreS21s
 yNJAFQlXGWMmV+WP6b4qE7gQMwsWCjOTNiBxTjMAy0GV8161hQZ3OIydo2US0I9yUR
 hZKYLzo++yIX0kp9WZCI2fMOL5UjOkOMXLjsE0a8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06NG8iu8000716
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 23 Jul 2020 11:08:44 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Jul 2020 11:08:44 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Jul 2020 11:08:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06NG8iVg049221;
 Thu, 23 Jul 2020 11:08:44 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <robh@kernel.org>
Subject: [PATCH v3 2/2] ASoC: tas2562: Update shutdown GPIO property
Date: Thu, 23 Jul 2020 11:08:38 -0500
Message-ID: <20200723160838.9738-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723160838.9738-1-dmurphy@ti.com>
References: <20200723160838.9738-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Dan Murphy <dmurphy@ti.com>
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

Update the shutdown GPIO property to be shutdown from shut-down.

Fixes: c173dba44c2d2 ("ASoC: tas2562: Introduce the TAS2562 amplifier")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2562.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index e74628061040..99920c691d28 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -680,13 +680,26 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 	struct device *dev = tas2562->dev;
 	int ret = 0;
 
-	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down",
-						    GPIOD_OUT_HIGH);
+	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shutdown", GPIOD_OUT_HIGH);
 	if (IS_ERR(tas2562->sdz_gpio)) {
-		if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER) {
-			tas2562->sdz_gpio = NULL;
+		if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
-		}
+
+		tas2562->sdz_gpio = NULL;
+	}
+
+	/*
+	 * The shut-down property is deprecated but needs to be checked for
+	 * backwards compatibility.
+	 */
+	if (tas2562->sdz_gpio == NULL) {
+		tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down",
+							      GPIOD_OUT_HIGH);
+		if (IS_ERR(tas2562->sdz_gpio))
+			if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
+
+		tas2562->sdz_gpio = NULL;
 	}
 
 	ret = fwnode_property_read_u32(dev->fwnode, "ti,imon-slot-no",
-- 
2.27.0

