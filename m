Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35C8C2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:29:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6585321BE5
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Bef+xO5d";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CgMMJMnz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6585321BE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CA47C1747;
	Wed, 23 Sep 2020 15:28:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CA47C1747
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600867785;
	bh=YosS7I/MdJpy1nBjd9TO4E30xc5GrKJhW8zazhG2lFE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Bef+xO5dad9tBGVy6+/aiUtVgKEBFY9qtpU1zd6XLrHZG3zsHpsZ5aaW5pBrTjGl/
	 su37Jx/knih88JiS3ngyjfO+UCMpe9rh0TnF4icY5ErpqYfDmTNie+WLYRglXBClCe
	 W3rcIAjOsebLxwuCig6roqS33mVogme1zDSbejp4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2739F802EA;
	Wed, 23 Sep 2020 15:26:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 38C34F802EB; Wed, 23 Sep 2020 15:26:35 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4EC5F802DC
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 15:26:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4EC5F802DC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CgMMJMnz"
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQRSq079517;
 Wed, 23 Sep 2020 08:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1600867587;
 bh=A4bgooINotZr+K0CU0OP7KantsSeOeiJxDKk2TXeaTM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=CgMMJMnzSRXDnwA3NrOftnO0mVOcH1U6+onAuVS2skPwNxLuD+UxouWpqFCQ43NFv
 YRHeK7TjfNMPsobDLpublzpxVubonsReldeZXNcwMt3c74rja6rff/OGnayPok++O9
 qaHDsGcMp1moh/dQfG2FAvAR8ZKUhkCeUpzCZaxA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08NDQRt2101881
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 23 Sep 2020 08:26:27 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 23
 Sep 2020 08:26:27 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 23 Sep 2020 08:26:27 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08NDQRfL007732;
 Wed, 23 Sep 2020 08:26:27 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <tiwai@suse.com>,
 <robh+dt@kernel.org>
Subject: [PATCH 5/6] ASoC: tas2770: Remove ti,asi-format code
Date: Wed, 23 Sep 2020 08:25:59 -0500
Message-ID: <20200923132600.10652-5-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200923132600.10652-1-dmurphy@ti.com>
References: <20200923132600.10652-1-dmurphy@ti.com>
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

Remove the code to support the asi-format binding property. The code
does nothing except read the property and set a variable. No additional
action is taken except to reset the variable. The property is supposed
to set the rising or falling RX edge detection of the SBCLK but this
edge detection is done by checking the DAI_FMT_INV_MASK.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tas2770.c | 11 -----------
 sound/soc/codecs/tas2770.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/sound/soc/codecs/tas2770.c b/sound/soc/codecs/tas2770.c
index c42e653cd653..c7a6f7e8200c 100644
--- a/sound/soc/codecs/tas2770.c
+++ b/sound/soc/codecs/tas2770.c
@@ -391,8 +391,6 @@ static int tas2770_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	if (ret < 0)
 		return ret;
 
-	tas2770->asi_format = fmt;
-
 	return 0;
 }
 
@@ -646,15 +644,6 @@ static int tas2770_parse_dt(struct device *dev, struct tas2770_priv *tas2770)
 {
 	int rc = 0;
 
-	rc = fwnode_property_read_u32(dev->fwnode, "ti,asi-format",
-				      &tas2770->asi_format);
-	if (rc) {
-		dev_info(tas2770->dev, "Property %s is missing setting default slot\n",
-			 "ti,asi-format");
-
-		tas2770->asi_format = 0;
-	}
-
 	rc = fwnode_property_read_u32(dev->fwnode, "ti,imon-slot-no",
 				      &tas2770->i_sense_slot);
 	if (rc) {
diff --git a/sound/soc/codecs/tas2770.h b/sound/soc/codecs/tas2770.h
index b3fc4a487033..856a7c5cff5a 100644
--- a/sound/soc/codecs/tas2770.h
+++ b/sound/soc/codecs/tas2770.h
@@ -132,7 +132,6 @@ struct tas2770_priv {
 	struct regmap *regmap;
 	struct snd_soc_component *component;
 	int power_state;
-	int asi_format;
 	struct gpio_desc *reset_gpio;
 	struct gpio_desc *sdz_gpio;
 	int sampling_rate;
-- 
2.28.0

