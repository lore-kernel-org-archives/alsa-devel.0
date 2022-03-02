Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70285C433EF
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Mar 2022 09:06:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BAD06280A;
	Wed,  2 Mar 2022 10:05:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BAD06280A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646211958;
	bh=AfUKihGzydu1DrGY5HHUcoj/7ebxwbArPJp6J0Y4YBM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=rd9o284EQ5J9vc+cScTqvvpmZ+J00GWAucGIV4/cTOqq6rhOhv2NjuK9/8YOgFK0f
	 FwpOqY7fCCoNEvCwvgULOAnhOYbQmJbCzdn6HxlE7URaRgNA60G7xThb9ktNCh/UD4
	 BTAxOVqid/afdVmci/0s2uyR64nLDZmX5Gs7ro4E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30834F80054;
	Wed,  2 Mar 2022 09:35:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 54997F80508; Wed,  2 Mar 2022 09:35:35 +0100 (CET)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C62FCF80C6D
 for <alsa-devel@alsa-project.org>; Wed,  2 Mar 2022 09:34:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C62FCF80C6D
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1nPKRL-0005uW-9K; Wed, 02 Mar 2022 09:34:31 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.94.2)
 (envelope-from <sha@pengutronix.de>)
 id 1nPKRK-00Fxnd-ES; Wed, 02 Mar 2022 09:34:30 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/7] ASoC: fsl_sai: Use better variable names
Date: Wed,  2 Mar 2022 09:34:26 +0100
Message-Id: <20220302083428.3804687-6-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220302083428.3804687-1-s.hauer@pengutronix.de>
References: <20220302083428.3804687-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Cc: Nicolin Chen <nicoleotsuka@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 kernel@pengutronix.de, Xiubo Li <Xiubo.Lee@gmail.com>
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

"ret" is normally used as a variable name for return values. In
fsl_sai_set_bclk() it stores the difference between the desired rate and
the rate we can archieve, so rename it to "diff". Also rename "savesub"
to "bestdiff" as that stores the best difference we have found.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/fsl/fsl_sai.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 2544fd363e24d..190f6206023fa 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -343,11 +343,10 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 	struct fsl_sai *sai = snd_soc_dai_get_drvdata(dai);
 	unsigned int reg, ofs = sai->soc_data->reg_offset;
 	unsigned long clk_rate;
-	u32 savediv = 0, ratio, savesub = freq;
+	u32 savediv = 0, ratio, bestdiff = freq;
 	int adir = tx ? RX : TX;
 	int dir = tx ? TX : RX;
 	u32 id;
-	int ret = 0;
 
 	/* Don't apply to consumer mode */
 	if (sai->is_consumer_mode)
@@ -361,19 +360,21 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 	id = sai->soc_data->mclk0_is_mclk1 ? 1 : 0;
 
 	for (; id < FSL_SAI_MCLK_MAX; id++) {
+		int diff;
+
 		clk_rate = clk_get_rate(sai->mclk_clk[id]);
 		if (!clk_rate)
 			continue;
 
 		ratio = clk_rate / freq;
 
-		ret = clk_rate - ratio * freq;
+		diff = clk_rate - ratio * freq;
 
 		/*
 		 * Drop the source that can not be
 		 * divided into the required rate.
 		 */
-		if (ret != 0 && clk_rate / ret < 1000)
+		if (diff != 0 && clk_rate / diff < 1000)
 			continue;
 
 		dev_dbg(dai->dev,
@@ -385,13 +386,13 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 		else
 			continue;
 
-		if (ret < savesub) {
+		if (diff < bestdiff) {
 			savediv = ratio;
 			sai->mclk_id[tx] = id;
-			savesub = ret;
+			bestdiff = diff;
 		}
 
-		if (ret == 0)
+		if (diff == 0)
 			break;
 	}
 
@@ -402,7 +403,7 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 	}
 
 	dev_dbg(dai->dev, "best fit: clock id=%d, div=%d, deviation =%d\n",
-			sai->mclk_id[tx], savediv, savesub);
+			sai->mclk_id[tx], savediv, bestdiff);
 
 	/*
 	 * 1) For Asynchronous mode, we must set RCR2 register for capture, and
-- 
2.30.2

