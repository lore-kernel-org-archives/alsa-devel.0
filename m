Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B588C00140
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Aug 2022 07:03:13 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 59AB1850;
	Fri,  5 Aug 2022 09:02:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 59AB1850
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1659682991;
	bh=kp3NmNVBoBNCULb4O1R7IQ2w9cpctjp0dAcNzwgqiCw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=khB2t3VwqapvENpj2lPXMbw3QCPaN9XDdaHtayoEBQGNdlizOU+kU1GH4H1kq6WQQ
	 fG3wXL7KiCkcO0bhNzCvdKBNilQ9QoZxHIRz18IbRoiag8pJwkp7WoevrpQtowfD+s
	 4dBaPVGrz4OvgxquUug6m1UirnqG7ng6hMr0A/0Y=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EA274F80238;
	Fri,  5 Aug 2022 09:02:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF698F8025A; Fri,  5 Aug 2022 09:02:19 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8C47BF8013D
 for <alsa-devel@alsa-project.org>; Fri,  5 Aug 2022 09:02:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8C47BF8013D
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 92BE71A1929;
 Fri,  5 Aug 2022 09:02:12 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 679611A1912;
 Fri,  5 Aug 2022 09:02:12 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E4C6A180031C;
 Fri,  5 Aug 2022 15:02:10 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: fsl_sai: Update slots number according to bclk_ratio
Date: Fri,  5 Aug 2022 14:45:26 +0800
Message-Id: <1659681926-13493-1-git-send-email-shengjiu.wang@nxp.com>
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

The bclk_ratio is set by .set_bclk_ratio API.
bclk_ratio = slots * slot_width
So if slots is not set by .set_tdm_slot, then it can be calculated
by bclk_ratio.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_sai.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 7523bb944b21..acf76ea21138 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -535,12 +535,14 @@ static int fsl_sai_hw_params(struct snd_pcm_substream *substream,
 	u32 pins, bclk;
 	int ret, i;
 
-	if (sai->slots)
-		slots = sai->slots;
-
 	if (sai->slot_width)
 		slot_width = sai->slot_width;
 
+	if (sai->slots)
+		slots = sai->slots;
+	else if (sai->bclk_ratio)
+		slots = sai->bclk_ratio / slot_width;
+
 	pins = DIV_ROUND_UP(channels, slots);
 
 	/*
-- 
2.17.1

