Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F595C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  8 Apr 2022 11:32:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0BDE1A5E;
	Fri,  8 Apr 2022 13:31:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0BDE1A5E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1649417519;
	bh=jhFQUaenNu9zLwekgA7WJUOzJwzSxTj+ototL4sevCA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=eh0YHpZj05PgbmcW4OUr63u4f+1GBv7RGpFCX+der2BnKZzZdFVBFR8UhPTfVUvhf
	 xl+a3NVEnHsO6bmUouCAbZBWHAtinL3eJlKBoW+1QSxPwqMVvCUJnc3bb0biZJbjTV
	 9M5hmh0P1PwrAbXmn1uEZd/JjuvTULAXUwSEWMx8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4A55BF80537;
	Fri,  8 Apr 2022 13:29:58 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 74A46F804B0; Fri,  8 Apr 2022 13:29:53 +0200 (CEST)
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A0B2F804CC
 for <alsa-devel@alsa-project.org>; Fri,  8 Apr 2022 13:29:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A0B2F804CC
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
 by metis.ext.pengutronix.de with esmtps
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <sha@pengutronix.de>)
 id 1ncmo7-0004vY-Kh; Fri, 08 Apr 2022 13:29:39 +0200
Received: from [2a0a:edc0:0:1101:1d::28] (helo=dude02.red.stw.pengutronix.de)
 by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
 (envelope-from <sha@pengutronix.de>)
 id 1ncmo8-001n6j-35; Fri, 08 Apr 2022 13:29:38 +0200
Received: from sha by dude02.red.stw.pengutronix.de with local (Exim 4.94.2)
 (envelope-from <sha@pengutronix.de>)
 id 1ncmo2-005ZAo-Os; Fri, 08 Apr 2022 13:29:34 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: alsa-devel@alsa-project.org
Subject: [PATCH v5 03/21] ASoC: fsl_micfil: drop fsl_micfil_set_mclk_rate()
Date: Fri,  8 Apr 2022 13:29:10 +0200
Message-Id: <20220408112928.1326755-4-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220408112928.1326755-1-s.hauer@pengutronix.de>
References: <20220408112928.1326755-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: alsa-devel@alsa-project.org
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>,
 Sascha Hauer <s.hauer@pengutronix.de>, Vinod Koul <vkoul@kernel.org>,
 NXP Linux Team <linux-imx@nxp.com>, kernel@pengutronix.de,
 dmaengine@vger.kernel.org, Shengjiu Wang <shengjiu.wang@gmail.com>
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

All that the .set_sysclk hook in the micfil driver does is to pass
the sysclk frequency to fsl_micfil_set_mclk_rate(). This function
expects the sample rate as argument though, not any kind of sysclk
frequency. The resulting rate setting of the clock is overwritten
in hw_params anyway, so drop this altogether.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>
---
 sound/soc/fsl/fsl_micfil.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index cf10c212d770d..5353474d0ff2b 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -358,30 +358,10 @@ static int fsl_micfil_hw_params(struct snd_pcm_substream *substream,
 	return 0;
 }
 
-static int fsl_micfil_set_dai_sysclk(struct snd_soc_dai *dai, int clk_id,
-				     unsigned int freq, int dir)
-{
-	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
-	struct device *dev = &micfil->pdev->dev;
-
-	int ret;
-
-	if (!freq)
-		return 0;
-
-	ret = fsl_micfil_set_mclk_rate(micfil, freq);
-	if (ret < 0)
-		dev_err(dev, "failed to set mclk[%lu] to rate %u\n",
-			clk_get_rate(micfil->mclk), freq);
-
-	return ret;
-}
-
 static const struct snd_soc_dai_ops fsl_micfil_dai_ops = {
 	.startup = fsl_micfil_startup,
 	.trigger = fsl_micfil_trigger,
 	.hw_params = fsl_micfil_hw_params,
-	.set_sysclk = fsl_micfil_set_dai_sysclk,
 };
 
 static int fsl_micfil_dai_probe(struct snd_soc_dai *cpu_dai)
-- 
2.30.2

