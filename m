Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF80AC43334
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jun 2022 16:17:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DACEB16C1;
	Mon, 13 Jun 2022 18:16:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DACEB16C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655137046;
	bh=sjtJervTZ6yZDBRnrd/C1P0OUfxohUo/Bykqdjnc5/o=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dogOvQwzGSNv2o/0O+Z+Vy0/fYOGwGtnq/zkfyZQBh8tQGxCuE6MEOUE18QB33ECe
	 5Vrd2xJRttkSHR3MfHmqwmsueo2j8MGz9xJWg1YCs9kLcb3JgFiRPqNMVCdRWFmcSO
	 8AFrb0vlA9orjy4MXIESvkcpnfra934sYGd9zpUw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0C98BF804D1;
	Mon, 13 Jun 2022 18:16:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A5D5F804C1; Mon, 13 Jun 2022 18:16:04 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E16FCF80139
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2022 18:15:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E16FCF80139
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="NFFik29o"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25DBuxUi006945;
 Mon, 13 Jun 2022 11:15:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=4R4Ym4XA5bDdt/zDB7Y35xb6VBHh26DwvdrgZzMm1m4=;
 b=NFFik29o2NvZUx2AhujDPn+6BjLnktd3Bb8eKXXHUnu7rvyrxakwxjWipe1RFpIAn8UJ
 SrDUBCvzuuXVhrjqZNNhyRRAXV3pagYvMHitgSfIzZMkpX6cyt+UyfxmOhtJ70ZwrCns
 1n3nFFMXiy9W/vln0kIIwBEyVKjItaSvwe/fLuZzzM0aKZajzPNjkPOX7iC1RRB35sMz
 E/YOADb3ImA7phkeOaBqHYWO6/mR3ZJCOrXZvNmU43iD+0QKhhnwUkA+iX9fTvNvqQjj
 5/cG1DBMeVyFHbrSEZZ+CHPS6qFXLKpKs3xF5t2ESAvtRBMfofhVXNY0evryromRK/dm qg== 
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3gmqfq24mu-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 13 Jun 2022 11:15:55 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 13 Jun
 2022 17:15:52 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Mon, 13 Jun 2022 17:15:52 +0100
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id C607546C;
 Mon, 13 Jun 2022 16:15:52 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>, <samuel@sholland.org>
Subject: [PATCH 1/2] ASoC: sun8i-codec: Partial revert to fix clock specifiers
Date: Mon, 13 Jun 2022 17:15:51 +0100
Message-ID: <20220613161552.481337-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ufAMjQSTEEIdy2v7qIN3Z_ZuR-cxb2fr
X-Proofpoint-GUID: ufAMjQSTEEIdy2v7qIN3Z_ZuR-cxb2fr
X-Proofpoint-Spam-Reason: safe
Cc: alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
 lgirdwood@gmail.com, jernej.skrabec@gmail.com, linux-kernel@vger.kernel.org,
 wens@csie.org, linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 linux-sunxi@lists.linux.dev
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

Recent updates accidentally updated the clock producer/consumer
specifiers on this device as part of refactoring the CPU side of the DAI
links. However, this device sits on the CODEC side and shouldn't have
been updated. Partially revert the changes keeping the switch to the new
clock terminology but going back to the CODEC defines.

Fixes: 7cc3965fde74 ("ASoC: sunxi: Update to use set_fmt_new callback")
Reported-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/sunxi/sun8i-codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sunxi/sun8i-codec.c b/sound/soc/sunxi/sun8i-codec.c
index 90d74a2d53f38..f797c535f2983 100644
--- a/sound/soc/sunxi/sun8i-codec.c
+++ b/sound/soc/sunxi/sun8i-codec.c
@@ -287,10 +287,10 @@ static int sun8i_codec_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 
 	/* clock masters */
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
-	case SND_SOC_DAIFMT_BP_FP: /* Codec slave, DAI master */
+	case SND_SOC_DAIFMT_CBC_CFC: /* Codec slave, DAI master */
 		value = 0x1;
 		break;
-	case SND_SOC_DAIFMT_BC_FC: /* Codec Master, DAI slave */
+	case SND_SOC_DAIFMT_CBP_CFP: /* Codec Master, DAI slave */
 		value = 0x0;
 		break;
 	default:
-- 
2.30.2

