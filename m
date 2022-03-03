Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31367C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Mar 2022 17:37:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 408241E7C;
	Thu,  3 Mar 2022 18:36:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 408241E7C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646329066;
	bh=a8JgCZuGwYM14iM9kpLEwlnzTZpkOqL1zBp445/q0Yk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IKY9T9ro7DFwDrTx12+VcRZPBQ8rVNw69p6LpyV4vt/w5f27D7Teep3OF5Ss+x2VT
	 BKOpW+3VQrkwm0npg2iGVQkxPRqEKa/f0q5+d9GqN1sM4jof6eYk94d0jjMVYBX4Wc
	 TKBvnRwAU64kuYUo6h1TdKmyX5eTKHFGtTNZLHmM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B2DF1F805BE;
	Thu,  3 Mar 2022 18:31:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5D8E4F8055C; Thu,  3 Mar 2022 18:31:32 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B6D01F8051F
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2022 18:31:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B6D01F8051F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="nHLyAwYT"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2234AADt028599;
 Thu, 3 Mar 2022 11:31:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=7OagKgdEVfE1W5ke5mHVLC61Cbl1a7WdHXMCUL9/MWk=;
 b=nHLyAwYT2/7JAZ/Svl7g2y6nQiY6PH+p54kLyeJwUUrx0AMo1nnVXP/Vgp+mvVSkDVxn
 AznMn0Ooz0Tv2RysvdOT2O3CWCMecLjCMvxFrzoO3ceMjTkIDdmkLDpqMNo7xYxEiPMJ
 bRJuJa7VIrmYPwgQdHa00CZ+cioMkBKefxQKne1eA9121OcC24TEcEjkZcBmOcWTBrYQ
 74JWZpkGDFfJi06v+BoojdS5dBN1rB/mL9KX7n48oLc3hGxzOqKXrcJnlP3WDflaVfjp
 eP9Bof+4ab4Gfc8idiV91x92Eikbew2jZl2AdGaIRuY718kRPPFwnTjTn7bT3mMEu/ce jg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ejncq8ybk-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 03 Mar 2022 11:31:06 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 3 Mar
 2022 17:31:03 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.18 via
 Frontend Transport; Thu, 3 Mar 2022 17:31:03 +0000
Received: from aryzen.ad.cirrus.com (unknown [198.61.65.198])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 5F26D11D1;
 Thu,  3 Mar 2022 17:31:03 +0000 (UTC)
From: Lucas Tanure <tanureal@opensource.cirrus.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob
 Herring <robh+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Subject: [PATCH 03/20] ASoC: cs35l41: Fix DSP mbox start command and global
 enable order
Date: Thu, 3 Mar 2022 17:30:42 +0000
Message-ID: <20220303173059.269657-4-tanureal@opensource.cirrus.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
References: <20220303173059.269657-1-tanureal@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: UPtZl0vb1q5uuNiLxv-MDp1EGMa6Q5tk
X-Proofpoint-GUID: UPtZl0vb1q5uuNiLxv-MDp1EGMa6Q5tk
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org, Lucas Tanure <tanureal@opensource.cirrus.com>,
 devicetree@vger.kernel.org
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

Global enable must happen before CSPL_MBOX_CMD_RESUME command
is sent. Move it to PRE_PMU as both events use
SND_SOC_DAPM_OUT_DRV_E macro.

Signed-off-by: Lucas Tanure <tanureal@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l41.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index f3787d77f892..05de94fd2e55 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -573,7 +573,7 @@ static int cs35l41_main_amp_event(struct snd_soc_dapm_widget *w,
 	int ret = 0;
 
 	switch (event) {
-	case SND_SOC_DAPM_POST_PMU:
+	case SND_SOC_DAPM_PRE_PMU:
 		regmap_multi_reg_write_bypassed(cs35l41->regmap,
 						cs35l41_pup_patch,
 						ARRAY_SIZE(cs35l41_pup_patch));
@@ -649,7 +649,7 @@ static const struct snd_soc_dapm_widget cs35l41_dapm_widgets[] = {
 
 	SND_SOC_DAPM_OUT_DRV_E("Main AMP", CS35L41_PWR_CTRL2, 0, 0, NULL, 0,
 			       cs35l41_main_amp_event,
-			       SND_SOC_DAPM_POST_PMD |	SND_SOC_DAPM_POST_PMU),
+			       SND_SOC_DAPM_POST_PMD |	SND_SOC_DAPM_PRE_PMU),
 
 	SND_SOC_DAPM_MUX("ASP TX1 Source", SND_SOC_NOPM, 0, 0, &asp_tx1_mux),
 	SND_SOC_DAPM_MUX("ASP TX2 Source", SND_SOC_NOPM, 0, 0, &asp_tx2_mux),
-- 
2.35.1

