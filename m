Return-Path: <SRS0=lMNw=7A=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6D01C433E1
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2020 11:00:38 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 445F3207ED
	for <alsa-devel@archiver.kernel.org>; Mon, 18 May 2020 11:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FRPQIQdO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 445F3207ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9511216CF;
	Mon, 18 May 2020 12:59:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9511216CF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1589799636;
	bh=MqCdNyU6oaFEzAr6jLhmfnYeDSUooc4rf2P/QZv1F90=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FRPQIQdOB810OWYNEmm1xdNQYWLV7jNjnwNhMeuowVSsd5YUaaMX8B+nrnqjD0EMy
	 4WL43Un/73ndOcVWkbkdAdvRCr8YoXMswGQsbx3pPNU1agZmtUZl2eo7abZzi5HNWC
	 phScWeUvRHRJZKg20Bq2Da0IHA7ohLRzIzna0Vb8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 223DEF801D8;
	Mon, 18 May 2020 12:59:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27154F801DA; Mon, 18 May 2020 12:59:45 +0200 (CEST)
Received: from cmccmta2.chinamobile.com (cmccmta2.chinamobile.com
 [221.176.66.80])
 by alsa1.perex.cz (Postfix) with ESMTP id A38F0F80086
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2020 12:59:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A38F0F80086
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by
 rmmx-syy-dmz-app07-12007 (RichMail) with SMTP id 2ee75ec26a7c0ce-37816;
 Mon, 18 May 2020 18:59:08 +0800 (CST)
X-RM-TRANSID: 2ee75ec26a7c0ce-37816
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.25.154.146])
 by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35ec26a77c7e-45d26;
 Mon, 18 May 2020 18:59:06 +0800 (CST)
X-RM-TRANSID: 2ee35ec26a77c7e-45d26
From: Tang Bin <tangbin@cmss.chinamobile.com>
To: broonie@kernel.org, timur@kernel.org, nicoleotsuka@gmail.com,
 Xiubo.Lee@gmail.com, perex@perex.cz
Subject: [PATCH] ASoC: fsl_micfil: Fix indentation to put on one line affected
 code
Date: Mon, 18 May 2020 18:59:51 +0800
Message-Id: <20200518105951.19200-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Tang Bin <tangbin@cmss.chinamobile.com>
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

In the function fsl_micfil_startup(), the two lines of dev_err()
can be shortened to one line.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 sound/soc/fsl/fsl_micfil.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index f7f2d29f1..79cf488fa 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -217,8 +217,7 @@ static int fsl_micfil_startup(struct snd_pcm_substream *substream,
 	struct fsl_micfil *micfil = snd_soc_dai_get_drvdata(dai);
 
 	if (!micfil) {
-		dev_err(dai->dev,
-			"micfil dai priv_data not set\n");
+		dev_err(dai->dev, "micfil dai priv_data not set\n");
 		return -EINVAL;
 	}
 
-- 
2.20.1.windows.1



