Return-Path: <SRS0=5Ozn=7Q=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07801C433DF
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Jun 2020 03:52:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8712F20674
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Jun 2020 03:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="szOh5Ncd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8712F20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1C55F1674;
	Wed,  3 Jun 2020 05:52:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1C55F1674
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591156375;
	bh=agchG9ZZCtRgqhvGpkOlb/CpMcgsMYvpYcfPvL8w+w8=;
	h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
	 References:Cc:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From;
	b=szOh5Ncdm5XnD98uQZCUtmSXK/IEcHLGSo8OLJLhSQu7xS7S0d6iYYaPigB2cRSGk
	 VOKnRQSarGi7zP7mnN/B/Hu83WuCd8HEuu/FV2FHexunRK/T7Fg2FhEEE66fZJkPVU
	 9ok3adDBUaPPqSLGbcxvT9bpqT8EFIkP/Bntci4o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B4DACF8028F;
	Wed,  3 Jun 2020 05:50:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 821FBF8028A; Wed,  3 Jun 2020 05:50:26 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EAD2F801ED
 for <alsa-devel@alsa-project.org>; Wed,  3 Jun 2020 05:50:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EAD2F801ED
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1B73D200CD6;
 Wed,  3 Jun 2020 05:50:16 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8F6FD200CC3;
 Wed,  3 Jun 2020 05:50:11 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 81F9C402DF;
 Wed,  3 Jun 2020 11:50:05 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH 2/3] ASoC: fsl_easrc: Fix -Wunused-but-set-variable
Date: Wed,  3 Jun 2020 11:39:40 +0800
Message-Id: <91ceb59e3bce31c9e93abba06f5156692ff5c71e.1591155860.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1591155860.git.shengjiu.wang@nxp.com>
References: <cover.1591155860.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1591155860.git.shengjiu.wang@nxp.com>
References: <cover.1591155860.git.shengjiu.wang@nxp.com>
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

Obtained with:
$ make W=1

sound/soc/fsl/fsl_easrc.c: In function 'fsl_easrc_set_rs_ratio':
sound/soc/fsl/fsl_easrc.c:182:15: warning: variable 'int_bits' set but not used [-Wunused-but-set-variable]
  unsigned int int_bits;
               ^
sound/soc/fsl/fsl_easrc.c: In function 'fsl_easrc_set_ctx_organziation':
sound/soc/fsl/fsl_easrc.c:1204:17: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
  struct device *dev;
                 ^
sound/soc/fsl/fsl_easrc.c: In function 'fsl_easrc_release_context':
sound/soc/fsl/fsl_easrc.c:1294:17: warning: variable 'dev' set but not used [-Wunused-but-set-variable]
  struct device *dev;
                 ^
Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 sound/soc/fsl/fsl_easrc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index f227308a50e2..7d8bf9d47842 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -179,22 +179,21 @@ static int fsl_easrc_set_rs_ratio(struct fsl_asrc_pair *ctx)
 	struct fsl_easrc_ctx_priv *ctx_priv = ctx->private;
 	unsigned int in_rate = ctx_priv->in_params.norm_rate;
 	unsigned int out_rate = ctx_priv->out_params.norm_rate;
-	unsigned int int_bits;
 	unsigned int frac_bits;
 	u64 val;
 	u32 *r;
 
 	switch (easrc_priv->rs_num_taps) {
 	case EASRC_RS_32_TAPS:
-		int_bits = 5;
+		/* integer bits = 5; */
 		frac_bits = 39;
 		break;
 	case EASRC_RS_64_TAPS:
-		int_bits = 6;
+		/* integer bits = 6; */
 		frac_bits = 38;
 		break;
 	case EASRC_RS_128_TAPS:
-		int_bits = 7;
+		/* integer bits = 7; */
 		frac_bits = 37;
 		break;
 	default:
@@ -1201,7 +1200,6 @@ static int fsl_easrc_set_ctx_format(struct fsl_asrc_pair *ctx,
 static int fsl_easrc_set_ctx_organziation(struct fsl_asrc_pair *ctx)
 {
 	struct fsl_easrc_ctx_priv *ctx_priv;
-	struct device *dev;
 	struct fsl_asrc *easrc;
 
 	if (!ctx)
@@ -1209,7 +1207,6 @@ static int fsl_easrc_set_ctx_organziation(struct fsl_asrc_pair *ctx)
 
 	easrc = ctx->asrc;
 	ctx_priv = ctx->private;
-	dev = &easrc->pdev->dev;
 
 	/* input interleaving parameters */
 	regmap_update_bits(easrc->regmap, REG_EASRC_CIA(ctx->index),
@@ -1291,13 +1288,11 @@ static void fsl_easrc_release_context(struct fsl_asrc_pair *ctx)
 {
 	unsigned long lock_flags;
 	struct fsl_asrc *easrc;
-	struct device *dev;
 
 	if (!ctx)
 		return;
 
 	easrc = ctx->asrc;
-	dev = &easrc->pdev->dev;
 
 	spin_lock_irqsave(&easrc->lock, lock_flags);
 
-- 
2.21.0

