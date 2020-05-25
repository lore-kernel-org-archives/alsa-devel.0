Return-Path: <SRS0=YV0t=7H=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6E5C433E0
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2020 09:14:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF4DD20787
	for <alsa-devel@archiver.kernel.org>; Mon, 25 May 2020 09:14:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XloEU3by"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF4DD20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DC48B16F7;
	Mon, 25 May 2020 11:13:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DC48B16F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590398084;
	bh=nwRTtvAKbdSUCYLn+6YBZIr+ABj/qFl8PwSR/xbPq6o=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XloEU3by1nyDfjqn/c+PTGz246KJjSh5GfHQNeQmMRE95p6Yo3GTizHXw45CiOF6s
	 4GzLGbduMEMyhlg5M+aDDLVzLQY2u+wx0yOzHAMo+0I3WcW/NoD3BGvgRQRRZ0nG03
	 6P8k/yHUSS1qQs99kmY2tsjfpprpavbWU/3kv6bw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5AE6EF8016F;
	Mon, 25 May 2020 11:13:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3F7FBF8014A; Mon, 25 May 2020 11:13:50 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F267CF8014A
 for <alsa-devel@alsa-project.org>; Mon, 25 May 2020 11:13:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F267CF8014A
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0527B1A0222;
 Mon, 25 May 2020 11:13:38 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 7655A1A0214;
 Mon, 25 May 2020 11:13:33 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3768F402BB;
 Mon, 25 May 2020 17:13:27 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com
Subject: [PATCH] ASoC: fsl_asrc: Fix -Wmissing-prototypes warning
Date: Mon, 25 May 2020 17:03:32 +0800
Message-Id: <1590397412-12966-1-git-send-email-shengjiu.wang@nxp.com>
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

From: shengjiu wang <shengjiu.wang@nxp.com>

COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64

sound/soc/fsl/fsl_asrc.c:557:18: warning: no previous prototype for function 'fsl_asrc_get_dma_channel' [-Wmissing-prototypes]
struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair, bool dir)
                 ^
sound/soc/fsl/fsl_asrc.c:557:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair, bool dir)
^
static

Fixes: be7bd03f0201 ("ASoC: fsl_asrc: Move common definition to fsl_asrc_common")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: shengjiu wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_asrc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 7e2d598ffb81..d79d2c7f8d36 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -554,7 +554,8 @@ static void fsl_asrc_stop_pair(struct fsl_asrc_pair *pair)
 /**
  * Get DMA channel according to the pair and direction.
  */
-struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair, bool dir)
+static struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair,
+						 bool dir)
 {
 	struct fsl_asrc *asrc = pair->asrc;
 	enum asrc_pair_index index = pair->index;
@@ -564,7 +565,6 @@ struct dma_chan *fsl_asrc_get_dma_channel(struct fsl_asrc_pair *pair, bool dir)
 
 	return dma_request_slave_channel(&asrc->pdev->dev, name);
 }
-EXPORT_SYMBOL_GPL(fsl_asrc_get_dma_channel);
 
 static int fsl_asrc_dai_startup(struct snd_pcm_substream *substream,
 				struct snd_soc_dai *dai)
-- 
2.21.0

