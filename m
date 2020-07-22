Return-Path: <SRS0=/CfY=BB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0784C433E1
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:49:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77E65206F5
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Jul 2020 15:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KvcpfRMq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c7zvVHqa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E65206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 05B62852;
	Wed, 22 Jul 2020 17:48:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 05B62852
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595432951;
	bh=uSSMfFd7Hm/b0WvCEUGnsvRn1l+2IFBvzRTO1IvTj3s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KvcpfRMqFKoat4CDj/vFZVZi/6Oluw5tTttIdqE30Rgm5AmGilB9HNx0QLOwtBOwV
	 6A/sx7Ca1MI+C7vlAY0fDJ79FWvQB4c30WIIwhIjWH+4bypBta2n0RD8W5V0SKTdZB
	 I4GSjw6bf3nk6fs/yxiVw4ShuVjFAaBc1fZJy7IY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECA7DF8015A;
	Wed, 22 Jul 2020 17:47:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EA643F8015A; Wed, 22 Jul 2020 17:47:30 +0200 (CEST)
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B744DF80139
 for <alsa-devel@alsa-project.org>; Wed, 22 Jul 2020 17:47:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B744DF80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="c7zvVHqa"
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06MFlIF8110020;
 Wed, 22 Jul 2020 10:47:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1595432838;
 bh=XJ+ytuhtkKd7PxGGLQoO++jTzbDtr8cHVrzy6/eyodU=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=c7zvVHqazamxkG/ApE8+1P25eW3S2f2pqRoCasN3ZDxa50JlDEbRyN+KC43VmhI6F
 spFMVxwOAUS3eZPPjFMa51sU5UAKMTSBH7UwZ7k3Owh5sQet+4iufLXiwrAR1ihJRC
 LakTLixG1MOQaPwykB7/fwnUtG0ugS9Gy0LWbwKM=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06MFlIWJ083089;
 Wed, 22 Jul 2020 10:47:18 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 22
 Jul 2020 10:47:17 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 22 Jul 2020 10:47:17 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06MFlHsk009607;
 Wed, 22 Jul 2020 10:47:17 -0500
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <robh@kernel.org>
Subject: [PATCH v2 2/2] ASoC: tas2562: Update shutdown GPIO property
Date: Wed, 22 Jul 2020 10:47:06 -0500
Message-ID: <20200722154706.9657-2-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200722154706.9657-1-dmurphy@ti.com>
References: <20200722154706.9657-1-dmurphy@ti.com>
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

v2 - Set sdz_gpio to NULL if gpio property not present.

 sound/soc/codecs/tas2562.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index e74628061040..8a53633a3853 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -680,12 +680,25 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 	struct device *dev = tas2562->dev;
 	int ret = 0;
 
-	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down",
-						    GPIOD_OUT_HIGH);
+	tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shutdown",
+						      GPIOD_OUT_HIGH);
 	if (IS_ERR(tas2562->sdz_gpio)) {
-		if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER) {
-			tas2562->sdz_gpio = NULL;
+		tas2562->sdz_gpio = NULL;
+		if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
+	}
+
+	/*
+	 * The shut-down property is deprecated but needs to be checked for
+	 * backwards compatibility.
+	 */
+	if (tas2562->sdz_gpio == NULL) {
+		tas2562->sdz_gpio = devm_gpiod_get_optional(dev, "shut-down",
+							      GPIOD_OUT_HIGH);
+		if (IS_ERR(tas2562->sdz_gpio)) {
+			tas2562->sdz_gpio = NULL;
+			if (PTR_ERR(tas2562->sdz_gpio) == -EPROBE_DEFER)
+				return -EPROBE_DEFER;
 		}
 	}
 
-- 
2.27.0

