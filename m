Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD4AC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:20:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8CBC61216
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 15:20:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E8CBC61216
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 852E418AA;
	Thu, 16 Sep 2021 17:19:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 852E418AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631805618;
	bh=pIKOyBPqOtPQ5tUrjYBDs88YWILSe6sPV4Zg0nRxu24=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lv7bzYm3hYRRj9yfVyudFG7mHUn9cXsgnTGKLubKxYHQq6tYuWrJQp+QLTF8NkDz0
	 lHsKDeomzM647n3ATmo9S4sm/3g96nFCjPz7HiVeypR9J1TNZ3Zhv6nLCZO5R27OXE
	 2W0Q31R/2ISU7ixxR9xTQJv+Udcb5lqBA9TwzGzc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3508F80113;
	Thu, 16 Sep 2021 17:18:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0821CF8025E; Thu, 16 Sep 2021 17:18:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 59690F80113
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 17:18:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 59690F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ojuCOWLL"
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4252261216;
 Thu, 16 Sep 2021 15:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631805530;
 bh=pIKOyBPqOtPQ5tUrjYBDs88YWILSe6sPV4Zg0nRxu24=;
 h=From:To:Cc:Subject:Date:From;
 b=ojuCOWLLeRWUSmnACBx+dHNN7g/j+R4U2IWP30lY9l+dH0vBkgPoYrd2u3oiegiZx
 qReFH+z6EwZoJ7khFFp6psqMqBaE8U8Uviefx/IDVRSydbGdxsPMwfDW5GRLK22ldI
 kKSWHJF4ymYw0/FBRYX+BxQ8jA+f/Gfcxe8DQ73eCedYF1iRbmK4bmBjiQG98Qv59x
 E8rt5B5pFwyIArDkE6vcTC2oEvTkG4CLUxdXzUcWSsjA8vzDvUyfB+hV3nT7/oZoQ5
 2tYSb5O4mXPpGv3OhON653pcsHYBn75FAlGCIsK1auXwW4CyrBdaHzCfRW0iLB1PVV
 h+E9gkKAacFiw==
From: Mark Brown <broonie@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Liam Girdwood <lgirdwood@gmail.com>
Subject: [PATCH 1/6] ASoC: adau1372: Update to modern clocking terminology
Date: Thu, 16 Sep 2021 16:18:01 +0100
Message-Id: <20210916151806.20756-1-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1714; h=from:subject;
 bh=pIKOyBPqOtPQ5tUrjYBDs88YWILSe6sPV4Zg0nRxu24=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhQ1+oxjCjppFXU0FzP4ppgiAoSnqZgLJavH/2l9mZ
 4Bz1WAyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYUNfqAAKCRAk1otyXVSH0B2kB/
 oDQclyTojqJBCbf/8n0eOQJ0UuYgQ9vI3FUQgeO32fHTDZqaSLAsoJ51CeXaUB3ujutDfRLBnBOP48
 ody+7WaL+zH/m3Em0u74Vnj29KkzCBTWvakaV7wBNa3MKFF/ITj7Uh9mxn1P89Wo/w0h7At/GnfsdE
 GFbYAKoKMtv/kQeStS7jMmrpjLNOJyT/09EMv5wVweWpDiTrjv0WZyH77DQDJARDm4L/p4yULG6fV+
 gIIUd3b/GLoRxuc/3+ifNwL52CTpyTqIMXofPpXylTfqdjWvakTLvEcw4sOXNlwG4xck4Z3VrgwhtK
 Tt28Hn99OGmAwQCWvGyFWAPVhCwHiI
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
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

As part of moving to remove the old style defines for the bus clocks update
the adau1372 driver to use more modern terminology for clocking.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/adau1372.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/soc/codecs/adau1372.c b/sound/soc/codecs/adau1372.c
index 6811a8b3866d..1faa4c426365 100644
--- a/sound/soc/codecs/adau1372.c
+++ b/sound/soc/codecs/adau1372.c
@@ -30,7 +30,7 @@ struct adau1372 {
 	void (*switch_mode)(struct device *dev);
 	bool use_pll;
 	bool enabled;
-	bool master;
+	bool clock_provider;
 
 	struct snd_pcm_hw_constraint_list rate_constraints;
 	unsigned int slot_width;
@@ -578,13 +578,13 @@ static int adau1372_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 	unsigned int sai0 = 0, sai1 = 0;
 	bool invert_lrclk = false;
 
-	switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
-	case SND_SOC_DAIFMT_CBM_CFM:
-		adau1372->master = true;
+	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
+	case SND_SOC_DAIFMT_CBP_CFP:
+		adau1372->clock_provider = true;
 		sai1 |= ADAU1372_SAI1_MS;
 		break;
-	case SND_SOC_DAIFMT_CBS_CFS:
-		adau1372->master = false;
+	case SND_SOC_DAIFMT_CBC_CFC:
+		adau1372->clock_provider = false;
 		break;
 	default:
 		return -EINVAL;
@@ -714,7 +714,7 @@ static int adau1372_set_tdm_slot(struct snd_soc_dai *dai, unsigned int tx_mask,
 		break;
 	case 4:
 		sai0 = ADAU1372_SAI0_SAI_TDM4;
-		if (adau1372->master)
+		if (adau1372->clock_provider)
 			adau1372->rate_constraints.mask = ADAU1372_RATE_MASK_TDM4_MASTER;
 		else
 			adau1372->rate_constraints.mask = ADAU1372_RATE_MASK_TDM4;
-- 
2.20.1

