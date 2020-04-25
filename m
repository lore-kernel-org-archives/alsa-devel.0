Return-Path: <SRS0=c9Fs=6J=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540BEC55185
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Apr 2020 07:29:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D01372071C
	for <alsa-devel@archiver.kernel.org>; Sat, 25 Apr 2020 07:29:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qEPqRq0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D01372071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 028711691;
	Sat, 25 Apr 2020 09:28:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 028711691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587799762;
	bh=UOd6Vzbs1TXAidhomAzYjnOiJuur3k2N6Eq/Dun8Dag=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qEPqRq0PrJfbeNDShsphoiBFEGWQDHQDHE5GENyBblNecv6ajkAKM/yvKVBoloykm
	 EX4xgsNleteKJbhOVZz3ddzN6nU0nrQHFrOlFSigdRsU99cJZIK0Mad90hTewZwJgQ
	 EMuxzvME3QI2abFbjNhQevGz4nPmPZObTNPZtV/Q=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BBA56F80159;
	Sat, 25 Apr 2020 09:28:30 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1EF8F801EC; Sat, 25 Apr 2020 09:28:22 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 475D7F800BE
 for <alsa-devel@alsa-project.org>; Sat, 25 Apr 2020 09:28:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 475D7F800BE
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A6E9C1A06DF;
 Sat, 25 Apr 2020 09:28:10 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 23C031A06D6;
 Sat, 25 Apr 2020 09:28:06 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 43266402D5;
 Sat, 25 Apr 2020 15:28:00 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH v2] ASoC: fsl_easrc: Check for null pointer before
 dereferencing "ctx" in fsl_easrc_hw_free()
Date: Sat, 25 Apr 2020 15:19:29 +0800
Message-Id: <d23c939f1c9eeb3fce34b6c34d44e2d6156f663a.1587799355.git.shengjiu.wang@nxp.com>
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

The patch 955ac624058f: "ASoC: fsl_easrc: Add EASRC ASoC CPU DAI
drivers" from Apr 16, 2020, leads to the following Smatch complaint:

sound/soc/fsl/fsl_easrc.c:1529 fsl_easrc_hw_free()
warn: variable dereferenced before check 'ctx' (see line 1527)

sound/soc/fsl/fsl_easrc.c
  1526          struct fsl_asrc_pair *ctx = runtime->private_data;
  1527          struct fsl_easrc_ctx_priv *ctx_priv = ctx->private;
                                                      ^^^^^
Dereference

  1528
  1529          if (ctx && (ctx_priv->ctx_streams & BIT(substream->stream))) {
                    ^^^
This check is too late, to prevent a NULL dereference.

  1530                  ctx_priv->ctx_streams &= ~BIT(substream->stream);
  1531                  fsl_easrc_release_context(ctx);

Fixes: 955ac624058f ("ASoC: fsl_easrc: Add EASRC ASoC CPU DAI drivers")
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_easrc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index 97658e1f4989..20326bffab64 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1524,9 +1524,14 @@ static int fsl_easrc_hw_free(struct snd_pcm_substream *substream,
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_asrc_pair *ctx = runtime->private_data;
-	struct fsl_easrc_ctx_priv *ctx_priv = ctx->private;
+	struct fsl_easrc_ctx_priv *ctx_priv;
 
-	if (ctx && (ctx_priv->ctx_streams & BIT(substream->stream))) {
+	if (!ctx)
+		return -EINVAL;
+
+	ctx_priv = ctx->private;
+
+	if (ctx_priv->ctx_streams & BIT(substream->stream)) {
 		ctx_priv->ctx_streams &= ~BIT(substream->stream);
 		fsl_easrc_release_context(ctx);
 	}
-- 
2.21.0

