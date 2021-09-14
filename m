Return-Path: <SRS0=quTn=OE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB204C433F5
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Sep 2021 14:15:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D67960234
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Sep 2021 14:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5D67960234
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 75DBE179F;
	Tue, 14 Sep 2021 16:14:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 75DBE179F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631628944;
	bh=0RIlWaj/6vDgo+1JE+j24MRgsXnwYwMM4Lu6kqqbWPU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kI8ZRkmqkGgDZwM60njJ62LAMRNwFWbrorcMO0aSTGrIHol+1yztJy/nhu4t4oGM7
	 tDydW+hEPYPW1sMe1YvTfW7/1/bSJKqdN3Ilc+FZuLwfQe03cihUQOV37n76aMshUZ
	 /VpRxSsXC2FhhdBITh5d0nwgW70AkrOOn6Okovjg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27246F804E3;
	Tue, 14 Sep 2021 16:14:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8A656F804B3; Tue, 14 Sep 2021 16:14:04 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7B18CF80271
 for <alsa-devel@alsa-project.org>; Tue, 14 Sep 2021 16:13:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7B18CF80271
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="GLkP3UhD"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E6ehYg028588; 
 Tue, 14 Sep 2021 09:13:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=xERiLCVK25ruxS5L5bQkCaKRQyBu1ljWkeam+lZCbGo=;
 b=GLkP3UhDTtFUjVizHoH8LakGPEUctUasbCoNdu0yL4r5BlGqj6AfBTeAU24wO3XjIXFN
 8bWK+WEcNvEaq6v/d0AtWduEWv7bAv5d8UwsqfVmTMolmGTBPWUsUPGcFiGsznPHCOHo
 MMHTmpFOeMbdLKqkmPQodIo6V7qWHL5Gd9aWpWPgqeGPfyyMQtkZfj/yaf/E0TxvAmhp
 3G5IW1+m59xRk06OwhjeXqbXmdpWraY2/wk8QvoCx0IfvHXdk5rIch/FD+8SfflBrOsy
 n7nYe8QdRYqc/8qg+nDTKweg7DKa3fm0bYsAemcb+9I8f9f62tU77lnh/nEehbFUJl9L 4A== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 3b29n3s3s3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 14 Sep 2021 09:13:51 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Tue, 14 Sep
 2021 15:13:49 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Tue, 14 Sep 2021 15:13:49 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 97647B0E;
 Tue, 14 Sep 2021 14:13:49 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 1/6] ASoC: cs35l41: Fix use of an uninitialised variable
Date: Tue, 14 Sep 2021 15:13:44 +0100
Message-ID: <20210914141349.30218-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: Bi41cKGcgvaWWvUioMG9C8tVBrh3Hcsq
X-Proofpoint-ORIG-GUID: Bi41cKGcgvaWWvUioMG9C8tVBrh3Hcsq
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 james.schulman@cirrus.com, lgirdwood@gmail.com, david.rhodes@cirrus.com
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

The loop checking PDN_DONE doesn't check the return value from
regmap_read, nor does it initialise val. This means if regmap_read fails
val will be checked for the PDN_DONE bit whilst being uninitialised.

Fix this up by switching to regmap_read_poll_timeout which tidies up the
code and avoids the uninitialised variable.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index dbec54a28a9e3..d2a11cc336833 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -580,7 +580,6 @@ static int cs35l41_main_amp_event(struct snd_soc_dapm_widget *w,
 	unsigned int val;
 	int ret = 0;
 	bool pdn;
-	int i;
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
@@ -599,19 +598,11 @@ static int cs35l41_main_amp_event(struct snd_soc_dapm_widget *w,
 				CS35L41_GLOBAL_EN_MASK, 0);
 
 		pdn = false;
-		for (i = 0; i < 100; i++) {
-			regmap_read(cs35l41->regmap,
-				CS35L41_IRQ1_STATUS1,
-				&val);
-			if (val & CS35L41_PDN_DONE_MASK) {
-				pdn = true;
-				break;
-			}
-			usleep_range(1000, 1100);
-		}
-
-		if (!pdn)
-			dev_warn(cs35l41->dev, "PDN failed\n");
+		ret = regmap_read_poll_timeout(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
+					       val, val &  CS35L41_PDN_DONE_MASK,
+					       1000, 100000);
+		if (ret)
+			dev_warn(cs35l41->dev, "PDN failed: %d\n", ret);
 
 		regmap_write(cs35l41->regmap, CS35L41_IRQ1_STATUS1,
 				CS35L41_PDN_DONE_MASK);
-- 
2.11.0

