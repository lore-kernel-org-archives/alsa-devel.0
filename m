Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8258C433F5
	for <alsa-devel@archiver.kernel.org>; Thu,  5 May 2022 07:47:00 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 010AA1713;
	Thu,  5 May 2022 09:46:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 010AA1713
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651736818;
	bh=JOxi3Dsd6R3N6vEOLGIynLm6gh6jfZdD55bmDv/6vCA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=I32MpSm1d4n2frJpbj5IxUDGNzUxnBmGJnO2An73ep6IITZNPws2u79K7iqm1IYPM
	 ym5YK1gQeUbAEGDO2RtuNUgtyjF4LYNTsoLzOUfXdws96Balo6CZ3leB3DtUPJvHGD
	 8ZthD+c00WdKmlvt5b20X8im8HhmHjN0jDCCN7Cs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8E383F8016A;
	Thu,  5 May 2022 09:46:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 769A1F800D3; Thu,  5 May 2022 09:46:06 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6381FF800D3
 for <alsa-devel@alsa-project.org>; Thu,  5 May 2022 09:46:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6381FF800D3
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6FC4F200216;
 Thu,  5 May 2022 09:45:59 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 385A1200215;
 Thu,  5 May 2022 09:45:59 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id AA0BB180031A;
 Thu,  5 May 2022 15:45:57 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, s.hauer@pengutronix.de,
 alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: fsl_micfil: fix the naming style for mask definition
Date: Thu,  5 May 2022 15:34:07 +0800
Message-Id: <1651736047-28809-1-git-send-email-shengjiu.wang@nxp.com>
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

Remove the _SHIFT for the mask definition.

Fixes: 17f2142bae4b ("ASoC: fsl_micfil: use GENMASK to define register bit fields")
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_micfil.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/fsl/fsl_micfil.h b/sound/soc/fsl/fsl_micfil.h
index 08901827047d..053caba3caf3 100644
--- a/sound/soc/fsl/fsl_micfil.h
+++ b/sound/soc/fsl/fsl_micfil.h
@@ -74,9 +74,9 @@
 #define MICFIL_FIFO_STAT_FIFOX_UNDER(ch)	BIT((ch) + 8)
 
 /* MICFIL HWVAD0 Control 1 Register -- REG_MICFIL_VAD0_CTRL1*/
-#define MICFIL_VAD0_CTRL1_CHSEL_SHIFT	GENMASK(26, 24)
-#define MICFIL_VAD0_CTRL1_CICOSR_SHIFT	GENMASK(19, 16)
-#define MICFIL_VAD0_CTRL1_INITT_SHIFT	GENMASK(12, 8)
+#define MICFIL_VAD0_CTRL1_CHSEL		GENMASK(26, 24)
+#define MICFIL_VAD0_CTRL1_CICOSR	GENMASK(19, 16)
+#define MICFIL_VAD0_CTRL1_INITT		GENMASK(12, 8)
 #define MICFIL_VAD0_CTRL1_ST10		BIT(4)
 #define MICFIL_VAD0_CTRL1_ERIE		BIT(3)
 #define MICFIL_VAD0_CTRL1_IE		BIT(2)
@@ -106,7 +106,7 @@
 
 /* MICFIL HWVAD0 Zero-Crossing Detector - REG_MICFIL_VAD0_ZCD */
 #define MICFIL_VAD0_ZCD_ZCDTH		GENMASK(25, 16)
-#define MICFIL_VAD0_ZCD_ZCDADJ_SHIFT	GENMASK(11, 8)
+#define MICFIL_VAD0_ZCD_ZCDADJ		GENMASK(11, 8)
 #define MICFIL_VAD0_ZCD_ZCDAND		BIT(4)
 #define MICFIL_VAD0_ZCD_ZCDAUT		BIT(2)
 #define MICFIL_VAD0_ZCD_ZCDEN		BIT(0)
-- 
2.17.1

