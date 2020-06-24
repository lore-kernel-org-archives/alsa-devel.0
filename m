Return-Path: <SRS0=wWF8=AF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90A39C433DF
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:16:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A5D820768
	for <alsa-devel@archiver.kernel.org>; Wed, 24 Jun 2020 16:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sKzAWT/P";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OmFiMdq1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A5D820768
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 993C41886;
	Wed, 24 Jun 2020 18:16:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 993C41886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593015417;
	bh=VKJKHZY3g8NfUAogWbLOxR8JsFGuAHEwznKztgZFOmg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sKzAWT/PnCpjiNrmALAfasnGaeZs8ZzI7RRcjat08gMn1h86ms+Pc0my3qayMfEwq
	 G08BHfP/ORYI7DkFjxX70kgu9yA9/ooA3BjhwVBGVdg4RxZDARB3fzQGJgkJX9uQzA
	 xROJCycwizk+19KN6ZgtLxQ+LPEmCYq6hw4cTW9c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52503F802A1;
	Wed, 24 Jun 2020 18:15:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC068F8015A; Wed, 24 Jun 2020 18:15:19 +0200 (CEST)
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 11DD3F8015A
 for <alsa-devel@alsa-project.org>; Wed, 24 Jun 2020 18:15:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 11DD3F8015A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OmFiMdq1"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05OGFBAq021191;
 Wed, 24 Jun 2020 11:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1593015311;
 bh=qUC2mpsw94iRI+GEjoOUWoy0avC1fy2ViW4yz+XKfrY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OmFiMdq1k7PF71aESYBktMROjxFb241w26YG0yns0YdCQW6Qe/Ljz9flti1R9GlQ9
 RDsfsPUjauYZLkaD1MdvaHRVfQKT5OFgu37HUBFLlyXemajs96pHVgDs3fcso8ekvX
 mQ390Pp4WgWBpm/lA/cOoz2v1aJyOp0yqefpLlPs=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05OGFBkQ127545
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 24 Jun 2020 11:15:11 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 11:15:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 24 Jun 2020 11:15:11 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05OGFBE2113793;
 Wed, 24 Jun 2020 11:15:11 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [PATCH v5 2/7] ASoC: tas2562: Update shutdown GPIO property
Date: Wed, 24 Jun 2020 11:14:54 -0500
Message-ID: <20200624161459.19248-3-dmurphy@ti.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200624161459.19248-1-dmurphy@ti.com>
References: <20200624161459.19248-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: robh@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Dan Murphy <dmurphy@ti.com>, devicetree@vger.kernel.org
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
 sound/soc/codecs/tas2562.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 7fae88655a0f..f6495426f562 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -619,8 +619,8 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 	struct device *dev = tas2562->dev;
 	int ret = 0;
 
-	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down-gpio",
-						      GPIOD_OUT_HIGH);
+	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down",
+						    GPIOD_OUT_HIGH);
 	if (IS_ERR(tas2562->sdz_gpio)) {
 		if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER) {
 			tas2562->sdz_gpio = NULL;
-- 
2.26.2

