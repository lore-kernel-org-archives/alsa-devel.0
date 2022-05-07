Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D8CC433F5
	for <alsa-devel@archiver.kernel.org>; Sat,  7 May 2022 12:27:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EA68B1862;
	Sat,  7 May 2022 14:27:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EA68B1862
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651926471;
	bh=8IM+R5bfzRNdQeTOtVRs4HpSDj9fLnvZYUxFwoiBvBE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Tsd5Lc5FfNygB6VXT15Z/cHd28NOxhK2AwR501550iIkaiFIg7s7NUUwvOPsSejKz
	 Gmo7YMyzAHWJHhTCaf0J3/nEYwE7Vje4Y+NiXmLSUwNo03QDSv1A5T0o+L8JguW1Ef
	 O+roflIWZmpbWzS5YOi8t2jfbLGZpTRe10n8GFxs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33EFDF802BE;
	Sat,  7 May 2022 14:26:28 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9FF0F80155; Sat,  7 May 2022 14:26:25 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6F15BF800FA
 for <alsa-devel@alsa-project.org>; Sat,  7 May 2022 14:26:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6F15BF800FA
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D5BAB1A07E0;
 Sat,  7 May 2022 14:26:18 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A7B7B1A07DC;
 Sat,  7 May 2022 14:26:18 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 29469180031D;
 Sat,  7 May 2022 20:26:17 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH 2/2] ASoc: fsl_micfil: explicitly clear CHnF flags
Date: Sat,  7 May 2022 20:14:14 +0800
Message-Id: <1651925654-32060-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651925654-32060-1-git-send-email-shengjiu.wang@nxp.com>
References: <1651925654-32060-1-git-send-email-shengjiu.wang@nxp.com>
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

There may be failure when start 1 channel recording after
8 channels recording. The reason is that the CHnF
flags are not cleared successfully by software reset.

This issue is triggerred by the change of clearing
software reset bit.

CHnF flags are write 1 clear bits. Clear them by force
write.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/fsl/fsl_micfil.c b/sound/soc/fsl/fsl_micfil.c
index 2149fac0dcc6..e4d1da55293e 100644
--- a/sound/soc/fsl/fsl_micfil.c
+++ b/sound/soc/fsl/fsl_micfil.c
@@ -190,6 +190,14 @@ static int fsl_micfil_reset(struct device *dev)
 	if (ret)
 		return ret;
 
+	/*
+	 * Set SRES should clear CHnF flags, But even add delay here
+	 * the CHnF may not be cleared sometimes, so clear CHnF explicitly.
+	 */
+	ret = regmap_write_bits(micfil->regmap, REG_MICFIL_STAT, 0xFF, 0xFF);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.17.1

