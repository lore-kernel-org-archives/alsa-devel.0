Return-Path: <SRS0=SJ4a=XT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA47C432C1
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 10:56:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AA3214AF
	for <alsa-devel@archiver.kernel.org>; Tue, 24 Sep 2019 10:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IekbL9Ho"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AA3214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8F1FE1676;
	Tue, 24 Sep 2019 12:55:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8F1FE1676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569322571;
	bh=hdrurDyGthe/wf40wKe2m0Q48vUI3U+Fy/0n1ogJVQY=;
	h=From:To:Date:In-Reply-To:References:In-Reply-To:References:
	 Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:From;
	b=IekbL9Hoc7OmcSJhUw6Y2BHQd2/k1lSDYyZ1YDw3fzmNxv14gcD4iatqA+wH1lvNz
	 KuR2EmQxm1ZRcunTANcJX/Jfpa2T4JmgGrf6NQQ75/9Y5xxfix43DyIFAPCpiG8xa8
	 XfGgDaZwsHu9JuF806xJ+jXLvWIJOlz1mrZp6ahY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D0495F800B4;
	Tue, 24 Sep 2019 12:54:26 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C8C9FF80534; Tue, 24 Sep 2019 12:54:23 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 60125F80213
 for <alsa-devel@alsa-project.org>; Tue, 24 Sep 2019 12:54:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 60125F80213
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 710091A03C3;
 Tue, 24 Sep 2019 12:54:19 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id DA4D21A00E7;
 Tue, 24 Sep 2019 12:54:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9AB2C40324;
 Tue, 24 Sep 2019 18:54:04 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org,
 lars@metafoo.de
Date: Tue, 24 Sep 2019 18:52:33 +0800
Message-Id: <45a7c383f43cc1dd9d0934846447aee653278c03.1569296075.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1569296075.git.shengjiu.wang@nxp.com>
References: <cover.1569296075.git.shengjiu.wang@nxp.com>
In-Reply-To: <cover.1569296075.git.shengjiu.wang@nxp.com>
References: <cover.1569296075.git.shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Subject: [alsa-devel] [PATCH V4 2/4] ASoC: fsl_asrc: update supported sample
	format
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The ASRC support 24bit/16bit/8bit input width, which is
data width, not slot width.

For the S20_3LE format, the data with is 20bit, slot width
is 24bit, if we set ASRMCR1n.IWD to be 24bits, the result
is the volume is lower than expected, it likes 24bit data
right shift 4 bits

So replace S20_3LE with S24_3LE in supported list and add S8
format in TX supported list

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_asrc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 4d3804a1ea55..584badf956d2 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -624,7 +624,7 @@ static int fsl_asrc_dai_probe(struct snd_soc_dai *dai)
 
 #define FSL_ASRC_FORMATS	(SNDRV_PCM_FMTBIT_S24_LE | \
 				 SNDRV_PCM_FMTBIT_S16_LE | \
-				 SNDRV_PCM_FMTBIT_S20_3LE)
+				 SNDRV_PCM_FMTBIT_S24_3LE)
 
 static struct snd_soc_dai_driver fsl_asrc_dai = {
 	.probe = fsl_asrc_dai_probe,
@@ -635,7 +635,8 @@ static struct snd_soc_dai_driver fsl_asrc_dai = {
 		.rate_min = 5512,
 		.rate_max = 192000,
 		.rates = SNDRV_PCM_RATE_KNOT,
-		.formats = FSL_ASRC_FORMATS,
+		.formats = FSL_ASRC_FORMATS |
+			   SNDRV_PCM_FMTBIT_S8,
 	},
 	.capture = {
 		.stream_name = "ASRC-Capture",
-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
