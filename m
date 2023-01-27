Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625AAC38142
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Jan 2023 16:53:41 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 13118EA0;
	Fri, 27 Jan 2023 17:52:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 13118EA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674838419;
	bh=r6TTKTMI0Cdn6naYC87vnvpk/cqw0oL3VJ2+1BkCX9o=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=mxwnPr4Mb4dfMZaihxGIdBIulLYcrVPT29a9vdB6wQs5cuqXH47HTEf8kjjJGupZg
	 xAV36Ej+QYSVZFqlW3Fn1Tq7nBatJAelobl+tdaRF22GletrqubQ511JX9G1Xgs0mU
	 Cuuap6Q5LJZpmFWZe9DG8LaNty3PPHbGCVsR6N4I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 259FFF80553;
	Fri, 27 Jan 2023 17:51:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 038F8F80431; Fri, 27 Jan 2023 17:51:37 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D8F36F80272
 for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2023 17:51:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D8F36F80272
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=pAq8R4og
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 30R9k8LQ030633; Fri, 27 Jan 2023 10:51:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=G9V2GgFsHCD4LlZjSXpjsXaP7aw6r58g0ViRdqShLNs=;
 b=pAq8R4ogu88VG1tLwgWoH27+P9aCmKhssleshjJAYK/SBFd9xRgByHhUM/XFbK1gyado
 xzMihy/E0bZUuseesdpo3wWgTv+K8Tnbhi801cpY8uYsF6Q1SK3qKE4vXwYRSmZUMHUQ
 0eGjKXVGl77nc065RLGPOPSbeSPDJsroeTMP50ACHvI+22HDWqMLl1waH2fgTC8FaWly
 F98ISowC1LV40mfe2aUVV/sgm5lsLvUCFlCRyCCBkWa0i8eGBBcjHRf8/Zkkd140FlIQ
 jNheJWJSyhYDorMx5YhJWRrsXh2b9vqV8Oua5vaP+/Pd4TSXabSwjyI95DDk7+qVHw0/ /g== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
 by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3n8dbsvrd1-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 27 Jan 2023 10:51:31 -0600
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.21; Fri, 27 Jan
 2023 10:51:28 -0600
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.21 via
 Frontend Transport; Fri, 27 Jan 2023 10:51:28 -0600
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.202.160])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 81BB1475;
 Fri, 27 Jan 2023 16:51:28 +0000 (UTC)
From: Stefan Binding <sbinding@opensource.cirrus.com>
To: Vinod Koul <vkoul@kernel.org>, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 2/8] ASoC: cs42l42: Add SOFT_RESET_REBOOT register
Date: Fri, 27 Jan 2023 16:51:05 +0000
Message-ID: <20230127165111.3010960-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
References: <20230127165111.3010960-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: f1gOs6M17WECR6i-8ovWH8yAllEhuxQj
X-Proofpoint-GUID: f1gOs6M17WECR6i-8ovWH8yAllEhuxQj
X-Proofpoint-Spam-Reason: safe
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Richard Fitzgerald <rf@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
 Stefan Binding <sbinding@opensource.cirrus.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Richard Fitzgerald <rf@opensource.cirrus.com>

The SOFT_RESET_REBOOT register is needed to recover CS42L42 state after
a Soundwire bus reset.

This is required to be set whenever there is severe/hard bus reset.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 include/sound/cs42l42.h    | 5 +++++
 sound/soc/codecs/cs42l42.c | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/sound/cs42l42.h b/include/sound/cs42l42.h
index 1d1c24fdd0cae..3994e933db195 100644
--- a/include/sound/cs42l42.h
+++ b/include/sound/cs42l42.h
@@ -34,6 +34,7 @@
 #define CS42L42_PAGE_24		0x2400
 #define CS42L42_PAGE_25		0x2500
 #define CS42L42_PAGE_26		0x2600
+#define CS42L42_PAGE_27		0x2700
 #define CS42L42_PAGE_28		0x2800
 #define CS42L42_PAGE_29		0x2900
 #define CS42L42_PAGE_2A		0x2A00
@@ -720,6 +721,10 @@
 
 #define CS42L42_SRC_SDOUT_FS		(CS42L42_PAGE_26 + 0x09)
 
+/* Page 0x27 DMA */
+#define CS42L42_SOFT_RESET_REBOOT	(CS42L42_PAGE_27 + 0x01)
+#define CS42L42_SFT_RST_REBOOT_MASK	BIT(1)
+
 /* Page 0x28 S/PDIF Registers */
 #define CS42L42_SPDIF_CTL1		(CS42L42_PAGE_28 + 0x01)
 #define CS42L42_SPDIF_CTL2		(CS42L42_PAGE_28 + 0x02)
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 2fefbcf7bd130..82aa11d6937be 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -293,6 +293,7 @@ bool cs42l42_readable_register(struct device *dev, unsigned int reg)
 	case CS42L42_SPDIF_SW_CTL1:
 	case CS42L42_SRC_SDIN_FS:
 	case CS42L42_SRC_SDOUT_FS:
+	case CS42L42_SOFT_RESET_REBOOT:
 	case CS42L42_SPDIF_CTL1:
 	case CS42L42_SPDIF_CTL2:
 	case CS42L42_SPDIF_CTL3:
@@ -358,6 +359,7 @@ bool cs42l42_volatile_register(struct device *dev, unsigned int reg)
 	case CS42L42_LOAD_DET_DONE:
 	case CS42L42_DET_STATUS1:
 	case CS42L42_DET_STATUS2:
+	case CS42L42_SOFT_RESET_REBOOT:
 		return true;
 	default:
 		return false;
-- 
2.34.1

