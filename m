Return-Path: <SRS0=GrjN=62=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0971CC54E8B
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 10:33:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77BB0206B9
	for <alsa-devel@archiver.kernel.org>; Tue, 12 May 2020 10:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n1k4xG1E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77BB0206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D9A05167C;
	Tue, 12 May 2020 12:32:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D9A05167C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589279616;
	bh=tQV12XdmmxRAYTNYU/a528g3IbaAYoF0XV7RuSDqvfg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=n1k4xG1EA3HMzxobhhpwf6LnVgvX5wBirdPn/pSZsnq3cvte17n4qA94Fc08IKDgN
	 NFi48Qkb4ZlGWTt9lg1/7L6DcDBJrvNL5vsQBaY+obrq8uY2QfksGRbR/J4YrYv+pR
	 oZ3VIy580ESfPjiYROJZc9j7MYQqf7uvwgCkEMwU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 70ADDF80112;
	Tue, 12 May 2020 12:32:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ADAA2F8014C; Tue, 12 May 2020 12:32:45 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA3A7F800E3
 for <alsa-devel@alsa-project.org>; Tue, 12 May 2020 12:32:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA3A7F800E3
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 72DE0200F2E;
 Tue, 12 May 2020 12:32:37 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E6ABC200F8B;
 Tue, 12 May 2020 12:32:32 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 0D4E9402BC;
 Tue, 12 May 2020 18:32:26 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH] ASoC: fsl_asrc: Set ASR76K and ASR56K based on processing
 clock
Date: Tue, 12 May 2020 18:22:59 +0800
Message-Id: <1589278979-31008-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

The processing clock is different for platforms, so it is better
to set ASR76K and ASR56K based on processing clock, rather than
hard coding the value for them.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Signed-off-by: Mihai Serban <mihai.serban@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 067a54ab554f..ca926915068f 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -858,6 +858,8 @@ static const struct regmap_config fsl_asrc_regmap_config = {
  */
 static int fsl_asrc_init(struct fsl_asrc *asrc)
 {
+	unsigned long ipg_rate;
+
 	/* Halt ASRC internal FP when input FIFO needs data for pair A, B, C */
 	regmap_write(asrc->regmap, REG_ASRCTR, ASRCTR_ASRCEN);
 
@@ -875,11 +877,14 @@ static int fsl_asrc_init(struct fsl_asrc *asrc)
 	regmap_update_bits(asrc->regmap, REG_ASRTFR1,
 			   ASRTFR1_TF_BASE_MASK, ASRTFR1_TF_BASE(0xfc));
 
-	/* Set the processing clock for 76KHz to 133M */
-	regmap_write(asrc->regmap, REG_ASR76K, 0x06D6);
-
-	/* Set the processing clock for 56KHz to 133M */
-	return regmap_write(asrc->regmap, REG_ASR56K, 0x0947);
+	/*
+	 * Set the period of the 76KHz and 56KHz sampling clocks based on
+	 * the ASRC processing clock.
+	 * On iMX6, ipg_clk = 133MHz, REG_ASR76K = 0x06D6, REG_ASR56K = 0x0947
+	 */
+	ipg_rate = clk_get_rate(asrc->ipg_clk);
+	regmap_write(asrc->regmap, REG_ASR76K, ipg_rate / 76000);
+	return regmap_write(asrc->regmap, REG_ASR56K, ipg_rate / 56000);
 }
 
 /**
-- 
2.21.0

