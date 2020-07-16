Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6CDC433E3
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:55:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D37EB20739
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 14:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kFlC0pAJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D37EB20739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 70AB91672;
	Thu, 16 Jul 2020 16:54:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 70AB91672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594911320;
	bh=R+Vh84uzvHLs5lnVeeKfzy7IKC9XldUOSPgQ/2wh+rY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kFlC0pAJo2cQ58lbrKL79dd6r9EywHUnqvD+dIX+VpIEFdhZEVhVbK6v83YePQCLx
	 UEhU0/+5epklRZgb/m9ZYY7xXhXCbGfcBUushDYMdRb3ZFZA6zhjE2KWqVECJdJQ6M
	 h8q0aa5NOOEWMXiHS/z+Bw2K3s0SXYnvVKiTrDUI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F30E4F8028A;
	Thu, 16 Jul 2020 16:52:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7C6BFF8028A; Thu, 16 Jul 2020 16:52:53 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A00B9F801EC
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 16:52:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A00B9F801EC
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:95f7:ce7f:fb76:c54a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: aferraris)
 by bhuna.collabora.co.uk (Postfix) with ESMTPSA id E5D742A50D8;
 Thu, 16 Jul 2020 15:52:37 +0100 (BST)
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/2] ASoC: fsl_asrc: make sure the input and output clocks are
 different
Date: Thu, 16 Jul 2020 16:52:00 +0200
Message-Id: <20200716145201.186270-2-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716145201.186270-1-arnaud.ferraris@collabora.com>
References: <20200716145201.186270-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Arnaud Ferraris <arnaud.ferraris@collabora.com>,
 Timur Tabi <timur@kernel.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Nicolin Chen <nicoleotsuka@gmail.com>,
 Mark Brown <broonie@kernel.org>, kernel@collabora.com,
 Shengjiu Wang <shengjiu.wang@gmail.com>
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

The current clock selection algorithm might select the same clock for
both input and output. This can happen when, for instance, the output
sample rate is a multiple of the input rate.

This patch makes sure it always selects distinct input and output
clocks.

Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 sound/soc/fsl/fsl_asrc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 02c81d2e34ad..bfd35b9c0781 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -622,7 +622,8 @@ static void fsl_asrc_select_clk(struct fsl_asrc_priv *asrc_priv,
 			clk_rate = clk_get_rate(asrc_priv->asrck_clk[clk_index]);
 			/* Only match a perfect clock source with no remainder */
 			if (clk_rate != 0 && (clk_rate / rate[j]) <= 1024 &&
-			    (clk_rate % rate[j]) == 0)
+			    (clk_rate % rate[j]) == 0 &&
+			    (j == 0 || i != select_clk[j-1]))
 				break;
 		}
 
-- 
2.27.0

