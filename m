Return-Path: <SRS0=h1r5=K4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0F19C4708F
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 06:22:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FB596121D
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 06:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FB596121D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AB04016E1;
	Wed,  2 Jun 2021 08:21:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AB04016E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622614958;
	bh=RVqEfiPWMOH3/yOtAzCoDAOu7H/uqt75SlO4V7QAB+Y=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a/9V7wfSjOzoEcJhSFT2sKmcWtBrxaDHds0XSNYAY2xs4hhU4NcFRo6Flyf0WyNWj
	 ctOqXgA1C/5Rq7QEeEDUl9OpvIgYf9D20dYrGAld446bOjYBrxfM1Pfux3U9mmeWHA
	 JN/3pLyRCC01N146VLpdcrK0gE3aoGjQF2fVwXN8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5029CF80103;
	Wed,  2 Jun 2021 08:21:48 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4C55EF80273; Wed,  2 Jun 2021 08:21:45 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 25BFEF80273
 for <alsa-devel@alsa-project.org>; Wed,  2 Jun 2021 08:21:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 25BFEF80273
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com
 header.b="mMZQXuL6"
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D506201D24;
 Wed,  2 Jun 2021 08:21:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva021.eu-rdc02.nxp.com 6D506201D24
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
 s=nselector4; t=1622614899;
 bh=I5ZG4i74Bbuci05fKSVfqx2SSFWVySduNNdHnTcrr28=;
 h=From:To:Subject:Date:From;
 b=mMZQXuL66kraGhH3fm3IZw897euPTILI6GWB26xETQbpQkkCyERli+lh8mjpEY2VY
 wACh9rO/praUxBUdYmB5LdTiGb0ZNzkqD76ii5akZrIf5TsEnSgwnNgnmqzEtNlr9X
 BcC2aWIn9LMzFmdqar/2/5Qbi/+0b/01SARXwKHiVL8N44kviq2IRhuF5wgou7R0Gd
 /oYCRe5/05bg6YjMq5TcSdGQkp71tY4paId956ZP+KNiCRUcTYFGdlpBMhO9ukyO89
 RcjDwlw+wTs8+stYhVCIdH7rltzISLff+qHrPAHzAn8C/s3AGnIOY0QlcH6FQRfS++
 /DfNkoTZXAEeQ==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id BA4C5200AF5;
 Wed,  2 Jun 2021 08:21:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva021.eu-rdc02.nxp.com BA4C5200AF5
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7B42C4031E;
 Wed,  2 Jun 2021 14:21:33 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: fsl,
 spdif: Add compatible string for imx8ulp
Date: Wed,  2 Jun 2021 14:04:09 +0800
Message-Id: <1622613849-10271-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
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

Add compatible string for imx8ulp, which supports spdif module

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl,spdif.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
index 4454aca34d56..f226ec13167a 100644
--- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
+++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
@@ -25,6 +25,7 @@ properties:
       - fsl,imx8mq-spdif
       - fsl,imx8mm-spdif
       - fsl,imx8mn-spdif
+      - fsl,imx8ulp-spdif
 
   reg:
     maxItems: 1
-- 
2.27.0

