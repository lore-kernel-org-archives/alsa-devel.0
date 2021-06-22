Return-Path: <SRS0=bL7i=LQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB73EC2B9F4
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 12:51:09 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC946135A
	for <alsa-devel@archiver.kernel.org>; Tue, 22 Jun 2021 12:51:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC946135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 395D41671;
	Tue, 22 Jun 2021 14:50:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 395D41671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1624366266;
	bh=ECXAJtbalSay+Qd0eaUuhl/WG7f9fngW4KybbUdEXHA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AxjYVJb6ZMO9bcKCDAbn7hS5Vo1hifMhomUj5VcB+dB+LEbUzsvv/E/G6hM5CNzfr
	 9rHGVa3b4Kgs5WuKTmmk37gxfD2X30e1mBRWzICRFsgu2QDs6EulomAYIlKZHi/Njn
	 uQPg/cv3xjdQUlubC/xnE1PDqOlF+Aztx3xn/uoA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A7A14F8025F;
	Tue, 22 Jun 2021 14:50:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 95497F80268; Tue, 22 Jun 2021 14:50:14 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A024BF80161
 for <alsa-devel@alsa-project.org>; Tue, 22 Jun 2021 14:50:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A024BF80161
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C6C21A0E58;
 Tue, 22 Jun 2021 14:50:07 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 65EF81A0E88;
 Tue, 22 Jun 2021 14:50:03 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 199354024D;
 Tue, 22 Jun 2021 20:49:58 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: fsl_spdif: Fix unexpected interrupt after suspend
Date: Tue, 22 Jun 2021 20:31:24 +0800
Message-Id: <1624365084-7934-1-git-send-email-shengjiu.wang@nxp.com>
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

When system enter suspend, the machine driver suspend callback
function will be called, then the cpu driver trigger callback
(SNDRV_PCM_TRIGGER_SUSPEND) be called, it would disable the
interrupt.

But the machine driver suspend and cpu dai driver suspend order
maybe changed, the cpu dai driver's suspend callback is called before
machine driver's suppend callback, then the interrupt is not cleared
successfully in trigger callback.

So need to clear interrupts in cpu dai driver's suspend callback
to avoid such issue.

Fixes: 9cb2b3796e08 ("ASoC: fsl_spdif: Add pm runtime function")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_spdif.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/fsl/fsl_spdif.c b/sound/soc/fsl/fsl_spdif.c
index a9c6b930b04a..8ffb1a6048d6 100644
--- a/sound/soc/fsl/fsl_spdif.c
+++ b/sound/soc/fsl/fsl_spdif.c
@@ -1467,6 +1467,9 @@ static int fsl_spdif_runtime_suspend(struct device *dev)
 	struct fsl_spdif_priv *spdif_priv = dev_get_drvdata(dev);
 	int i;
 
+	/* Disable all the interrupts */
+	regmap_update_bits(spdif_priv->regmap, REG_SPDIF_SIE, 0xffffff, 0);
+
 	regmap_read(spdif_priv->regmap, REG_SPDIF_SRPC,
 			&spdif_priv->regcache_srpc);
 	regcache_cache_only(spdif_priv->regmap, true);
-- 
2.27.0

