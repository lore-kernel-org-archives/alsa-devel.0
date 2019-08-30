Return-Path: <SRS0=nNdU=W2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399A3C3A59B
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 22:00:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6722343B
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Aug 2019 22:00:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f0PONPf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6722343B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CE3EC86E;
	Fri, 30 Aug 2019 23:59:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CE3EC86E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567202410;
	bh=ryLzlCOlrn2Rv5WYsb9zv4uuacZcnDjOoR1NOm4/Xm0=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=f0PONPf6Pa9xzfZWWwmNHf/UhL0ODrVhRdVBZuN9C+BN107aDoyrQ853RrGjc1b9j
	 dCnQFwCDzfpVFWgGy7RQRf2/fn7QdyehmRZWEnL8A7/EJFERaL9Xt0DmAEmc4wwUGf
	 dQWWqP7Bya22lrJTJw8isltN6swi0XhTznFU8Z9s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DA737F80362;
	Fri, 30 Aug 2019 23:59:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB446F80369; Fri, 30 Aug 2019 23:59:17 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 38A8CF800E7
 for <alsa-devel@alsa-project.org>; Fri, 30 Aug 2019 23:59:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 38A8CF800E7
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id F0D4420079F;
 Fri, 30 Aug 2019 23:59:12 +0200 (CEST)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com
 [134.27.226.22])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E48EC20043B;
 Fri, 30 Aug 2019 23:59:12 +0200 (CEST)
Received: from fsr-ub1864-103.ea.freescale.net
 (fsr-ub1864-103.ea.freescale.net [10.171.82.17])
 by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 3FC0F2061E;
 Fri, 30 Aug 2019 23:59:12 +0200 (CEST)
From: Daniel Baluta <daniel.baluta@nxp.com>
To: broonie@kernel.org
Date: Sat, 31 Aug 2019 00:59:10 +0300
Message-Id: <20190830215910.31590-1-daniel.baluta@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: alsa-devel@alsa-project.org, timur@kernel.org, Xiubo.Lee@gmail.com,
 Daniel Baluta <daniel.baluta@nxp.com>, shengjiu.wang@nxp.com,
 linux-kernel@vger.kernel.org, nicoleotsuka@gmail.com,
 NXP Linux Team <linux-imx@nxp.com>, Viorel Suman <viorel.suman@nxp.com>,
 festevam@gmail.com
Subject: [alsa-devel] [PATCH] ASoC: fsl_sai: Implement set_bclk_ratio
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
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
Message-ID: <20190830215910.SRf5Y-7SVbY8ui5doceFYjYteNo63Nk2y8CQrAmcWSs@z>

From: Viorel Suman <viorel.suman@nxp.com>

This is to allow machine drivers to set a certain bitclk rate
which might not be exactly rate * frame size.

Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 21 +++++++++++++++++++--
 sound/soc/fsl/fsl_sai.h |  1 +
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index fe126029f4e3..e896b577b1f7 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -137,6 +137,16 @@ static int fsl_sai_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai, u32 tx_mask,
 	return 0;
 }
 
+static int fsl_sai_set_dai_bclk_ratio(struct snd_soc_dai *dai,
+				      unsigned int ratio)
+{
+	struct fsl_sai *sai = snd_soc_dai_get_drvdata(dai);
+
+	sai->bclk_ratio = ratio;
+
+	return 0;
+}
+
 static int fsl_sai_set_dai_sysclk_tr(struct snd_soc_dai *cpu_dai,
 		int clk_id, unsigned int freq, int fsl_dir)
 {
@@ -423,8 +433,14 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 		slot_width = sai->slot_width;
 
 	if (!sai->is_slave_mode) {
-		ret = fsl_sai_set_bclk(cpu_dai, tx,
-				slots * slot_width * params_rate(params));
+		if (sai->bclk_ratio)
+			ret = fsl_sai_set_bclk(cpu_dai, tx,
+					       sai->bclk_ratio *
+					       params_rate(params));
+		else
+			ret = fsl_sai_set_bclk(cpu_dai, tx,
+					       slots * slot_width *
+					       params_rate(params));
 		if (ret)
 			return ret;
 
@@ -640,6 +656,7 @@ static void fsl_sai_shutdown(struct snd_pcm_substream *substream,
 }
 
 static const struct snd_soc_dai_ops fsl_sai_pcm_dai_ops = {
+	.set_bclk_ratio	= fsl_sai_set_dai_bclk_ratio,
 	.set_sysclk	= fsl_sai_set_dai_sysclk,
 	.set_fmt	= fsl_sai_set_dai_fmt,
 	.set_tdm_slot	= fsl_sai_set_dai_tdm_slot,
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 3a3f6f8e5595..f96f8d97489d 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -177,6 +177,7 @@ struct fsl_sai {
 	unsigned int mclk_streams;
 	unsigned int slots;
 	unsigned int slot_width;
+	unsigned int bclk_ratio;
 
 	const struct fsl_sai_soc_data *soc_data;
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
-- 
2.17.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
