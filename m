Return-Path: <SRS0=cEba=4V=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B39ADC3F2D7
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:40:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A3132166E
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Mar 2020 19:40:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="suh55+Aj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wOMHCfxk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3132166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7EF851616;
	Wed,  4 Mar 2020 20:39:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7EF851616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583350848;
	bh=nMaTL4uhEY7LUUa/7pdAy2L05jJJEjV1u9OaYSg+BZs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=suh55+AjXeVZ6L7glST/YU2EeODR9DbeeFNSV25oXInpc9f8GaCxAc8vfU2edVOMR
	 d/w4js8G6k9Me5Fcy47PjKlsRAV3Jx1UIkpLx/u3DhJ12f0jICeOqVNIBuyuL3haNU
	 iBkPr190xOvmnMXYNAAXqqzuTS8HPsFjqMogtpTo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 14A7EF801ED;
	Wed,  4 Mar 2020 20:39:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21810F801F9; Wed,  4 Mar 2020 20:39:56 +0100 (CET)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1897EF801EC
 for <alsa-devel@alsa-project.org>; Wed,  4 Mar 2020 20:39:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1897EF801EC
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wOMHCfxk"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 024Jdn0B105016;
 Wed, 4 Mar 2020 13:39:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1583350789;
 bh=r2mknFt8cgYulGR03WSMmgUWqx+HkwzAP0Mh0loWYh8=;
 h=From:To:CC:Subject:Date;
 b=wOMHCfxkWmYSQwhY+zBDpZeBvklZ9uobgr8EHGKfjLyHRRdz3kl8bO6QYfavg7nmQ
 Z8UKDjUzUlmChhRCYkYxw+isnMIyJShg2QjJot8VF8MUZn6Yu66oNZ1Zk+fV2u739a
 fTailUwIdRce8oaBW9vYJ+mOBv5yxmUbwPIP1Hws=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 024Jdntj005972
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 4 Mar 2020 13:39:49 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Mar
 2020 13:39:49 -0600
Received: from localhost.localdomain (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Mar 2020 13:39:49 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
 by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 024Jdmnl064182;
 Wed, 4 Mar 2020 13:39:49 -0600
From: Dan Murphy <dmurphy@ti.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [PATCH for-next] ASoC: tlv320adcx140: Fix mic_bias and vref device
 tree verification
Date: Wed, 4 Mar 2020 13:34:27 -0600
Message-ID: <20200304193427.16886-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 Dan Murphy <dmurphy@ti.com>
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

Fix the range verification check for the mic_bias and vref device tree
entries.

Fixes 37bde5acf040 ("ASoC: tlv320adcx140: Add the tlv320adcx140 codec driver family")
Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 sound/soc/codecs/tlv320adcx140.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/sound/soc/codecs/tlv320adcx140.c b/sound/soc/codecs/tlv320adcx140.c
index 93a0cb8e662c..38897568ee96 100644
--- a/sound/soc/codecs/tlv320adcx140.c
+++ b/sound/soc/codecs/tlv320adcx140.c
@@ -748,9 +748,8 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	if (ret)
 		bias_source = ADCX140_MIC_BIAS_VAL_VREF;
 
-	if (bias_source != ADCX140_MIC_BIAS_VAL_VREF &&
-	    bias_source != ADCX140_MIC_BIAS_VAL_VREF_1096 &&
-	    bias_source != ADCX140_MIC_BIAS_VAL_AVDD) {
+	if (bias_source < ADCX140_MIC_BIAS_VAL_VREF ||
+	    bias_source > ADCX140_MIC_BIAS_VAL_AVDD) {
 		dev_err(adcx140->dev, "Mic Bias source value is invalid\n");
 		return -EINVAL;
 	}
@@ -760,9 +759,8 @@ static int adcx140_codec_probe(struct snd_soc_component *component)
 	if (ret)
 		vref_source = ADCX140_MIC_BIAS_VREF_275V;
 
-	if (vref_source != ADCX140_MIC_BIAS_VREF_275V &&
-	    vref_source != ADCX140_MIC_BIAS_VREF_25V &&
-	    vref_source != ADCX140_MIC_BIAS_VREF_1375V) {
+	if (vref_source < ADCX140_MIC_BIAS_VREF_275V ||
+	    vref_source > ADCX140_MIC_BIAS_VREF_1375V) {
 		dev_err(adcx140->dev, "Mic Bias source value is invalid\n");
 		return -EINVAL;
 	}
-- 
2.25.1

