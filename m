Return-Path: <SRS0=/Ps/=6F=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C55BC55182
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:50:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C09CE20B1F
	for <alsa-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="HNORvG+O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C09CE20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0DE3D167F;
	Tue, 21 Apr 2020 10:50:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0DE3D167F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587459051;
	bh=iwrsMyHe4v31a0q4sUi9uUQo2wCY6Bu0URe+um6NLOE=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HNORvG+OtHDXvXjK5dqt95SVI0GPLqfw7cZdPISodvoKl3qyjiW/hfYcb94IyR4OA
	 9oRDfVJgteKVqNSDG9HkGmmz7xzbUI/8HQ0NaKGS/FWG2ap/AgRGUHG6xesZvy3HKQ
	 2j5QC/t6GawPmM24K3srp31C04tT4cJOAXO4Op44=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 95669F80143;
	Tue, 21 Apr 2020 10:50:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 94E38F801EC; Tue, 21 Apr 2020 10:49:59 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3D39F8012F
 for <alsa-devel@alsa-project.org>; Tue, 21 Apr 2020 10:49:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3D39F8012F
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C8DF1A0C15;
 Tue, 21 Apr 2020 10:49:51 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 582C61A0C34;
 Tue, 21 Apr 2020 10:49:46 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 3CA4F4029E;
 Tue, 21 Apr 2020 16:49:40 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
 alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: fsl_esai: Remove expensive print in irq handler
Date: Tue, 21 Apr 2020 16:41:23 +0800
Message-Id: <1587458483-2166-1-git-send-email-shengjiu.wang@nxp.com>
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

Use dev_dbg instead of dev_err in irq handler, the dev_err
is expensive, we don't need the message to be printed everytime,
which is almost a debug option.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_esai.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_esai.c b/sound/soc/fsl/fsl_esai.c
index c7a49d03463a..453392a9cd68 100644
--- a/sound/soc/fsl/fsl_esai.c
+++ b/sound/soc/fsl/fsl_esai.c
@@ -94,10 +94,10 @@ static irqreturn_t esai_isr(int irq, void *devid)
 		dev_dbg(&pdev->dev, "isr: Transmission Initialized\n");
 
 	if (esr & ESAI_ESR_RFF_MASK)
-		dev_warn(&pdev->dev, "isr: Receiving overrun\n");
+		dev_dbg(&pdev->dev, "isr: Receiving overrun\n");
 
 	if (esr & ESAI_ESR_TFE_MASK)
-		dev_warn(&pdev->dev, "isr: Transmission underrun\n");
+		dev_dbg(&pdev->dev, "isr: Transmission underrun\n");
 
 	if (esr & ESAI_ESR_TLS_MASK)
 		dev_dbg(&pdev->dev, "isr: Just transmitted the last slot\n");
-- 
2.21.0

