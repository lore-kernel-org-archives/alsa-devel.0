Return-Path: <SRS0=h1r5=K4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A97C4708F
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 06:21:28 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D34F661027
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Jun 2021 06:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D34F661027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E4D616D6;
	Wed,  2 Jun 2021 08:20:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E4D616D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1622614883;
	bh=jplEBxDd8R/Ahstr6hCMu67LDfVJZuf3OLfQ1OxV04M=;
	h=From:To:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=nYVNCalOrnKdkld/jYOQWTrgTb1JTdFkGod+XvRiIQlYh4r5TIbyJ+2pnb5FZIxxP
	 n8msWY2uzXaR2klxEAGU6AbWV0eIFQ5s2cMpmwgwq0GB0YTGdsbFZl4jxDUOycs+Nf
	 XQeB2gwYEgkaFC9QzBpO9g5HpoKi4RiC3ffiit+4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06193F80273;
	Wed,  2 Jun 2021 08:20:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 83D57F80273; Wed,  2 Jun 2021 08:20:31 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 16347F80273
 for <alsa-devel@alsa-project.org>; Wed,  2 Jun 2021 08:20:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 16347F80273
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com
 header.b="osPWG7HF"
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A4AD61A35AA;
 Wed,  2 Jun 2021 08:20:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com A4AD61A35AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com;
 s=nselector3; t=1622614822;
 bh=916qkDrbfLsKea6v3J9EiWiH16tJt1dJtsGTn8zGZMM=;
 h=From:To:Subject:Date:From;
 b=osPWG7HF4wbDUh6UkQpDFSqdLTOzxNN0k9Ej83Unbhh9ktSyxgehINw8ZDR1nnAFG
 FMX+E5a7dNtNMrcV6EhBg7K7XrZkfisvwH0lg2/nKqJhwVT+B0bySseDmq8dFDU/W6
 3+OrgsnwqhgjnmJbRiQ2mHQH9sSMgdFF3ZtKdQlTq9EMZbsxGUacHpEU3Ss/jiXyt/
 yAAb6A4GUGvk9Sv0YxDwBL8+eVU8uF9B28l+pczF8b5OOsyOnb/uY5quq9fStxvNf/
 IW1DTgnbXttRdNzN+9XcGnlvJDg7KOubIYqnPyLP5ODub+d+Mi+QmxNVbNt1BeNS0F
 8jyadsRh7WXFA==
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EDCA81A1E65;
 Wed,  2 Jun 2021 08:20:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 inva020.eu-rdc02.nxp.com EDCA81A1E65
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AE51F4028B;
 Wed,  2 Jun 2021 14:20:16 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: fsl-sai: Add compatible string for
 imx8mm/8mn/8mp/8ulp
Date: Wed,  2 Jun 2021 14:02:50 +0800
Message-Id: <1622613770-10220-1-git-send-email-shengjiu.wang@nxp.com>
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

Add compatible string for imx8mm/8mn/8mp/8ulp, these platforms all
support SAI IP.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 Documentation/devicetree/bindings/sound/fsl-sai.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/fsl-sai.txt b/Documentation/devicetree/bindings/sound/fsl-sai.txt
index 0dc83cc4a236..c71c5861d787 100644
--- a/Documentation/devicetree/bindings/sound/fsl-sai.txt
+++ b/Documentation/devicetree/bindings/sound/fsl-sai.txt
@@ -9,8 +9,10 @@ Required properties:
 
   - compatible		: Compatible list, contains "fsl,vf610-sai",
 			  "fsl,imx6sx-sai", "fsl,imx6ul-sai",
-			  "fsl,imx7ulp-sai", "fsl,imx8mq-sai" or
-			  "fsl,imx8qm-sai".
+			  "fsl,imx7ulp-sai", "fsl,imx8mq-sai",
+			  "fsl,imx8qm-sai", "fsl,imx8mm-sai",
+			  "fsl,imx8mn-sai", "fsl,imx8mp-sai", or
+			  "fsl,imx8ulp-sai".
 
   - reg			: Offset and length of the register set for the device.
 
-- 
2.27.0

