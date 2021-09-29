Return-Path: <SRS0=CfAr=OT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91203C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 14:52:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7EC561440
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Sep 2021 14:52:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A7EC561440
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E580416BB;
	Wed, 29 Sep 2021 16:51:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E580416BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632927134;
	bh=jDjkbI9M6ZErjr5rpun3WMdTzOfZoU6M4/VZVrhTrN0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lTeF9cXCi5tGsRsAtRdlOZp13hHN5NXtBIvd8+LW057hXOlJcW0QegbVXSPzxQiPU
	 TGX8edd0jRGOWFREAUxKVg9Dp3vVpV8lnT1/+ku3kQ/CAZ2R/wApizL15/vIa8GH8l
	 IGUiv/F7D27bZ1rWlvZPuio6E5zv6Zg5vvjSxkTs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 365A4F801F7;
	Wed, 29 Sep 2021 16:51:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F5B7F80227; Wed, 29 Sep 2021 16:51:21 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 69359F80113
 for <alsa-devel@alsa-project.org>; Wed, 29 Sep 2021 16:51:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 69359F80113
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="RcOInJ5G"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18T5qbwM025601; 
 Wed, 29 Sep 2021 09:51:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=PODMain02222019;
 bh=j7CawL2JYw9l4rAzZ4MteugwqrAiecmBigrUjbkw7FU=;
 b=RcOInJ5GtzSGtmI+c11Cutu5Gbc2JhK/J5l3m9tHpUC5+rp8bIFK1XdtdKRJufIhPkKV
 TatQpJ9dvmHRmMqTdfD2Mq2SQtOs1oYD4fERwnIViShbmsMoLm1vWu8fy0rkKU3N0wU0
 0DxdyxnxE5jBdEqvp+i5hb/Opw0t8OCKoDVeAH3yRYsLvunHY3fKLD3EZUha3Itnzwox
 kz7bhZxsp+iHgoclaM5xoQxjR2k6BySk4hbMv+IC8XKy9okLuS1/KAUh8P7+cMSJz5dQ
 VCv2u1lWxL33CaZArAocVW3orkvC2edhrKyw9jXnfrcuPoOBdQ9hAPoNDbpF5Zmf8fPz iA== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 3bc62dhedd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Wed, 29 Sep 2021 09:51:09 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Wed, 29 Sep
 2021 15:51:08 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Wed, 29 Sep 2021 15:51:08 +0100
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.180])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B33EEB0E;
 Wed, 29 Sep 2021 14:51:01 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: wm_adsp: Fix compilation when debugfs is disabled
Date: Wed, 29 Sep 2021 15:50:40 +0100
Message-ID: <20210929145040.793252-1-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: z6ZCttdcZ5e3cCSuIvzrCCfH7IP8fPik
X-Proofpoint-ORIG-GUID: z6ZCttdcZ5e3cCSuIvzrCCfH7IP8fPik
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Simon Trimmer <simont@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
 kernel test robot <lkp@intel.com>
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

Guard the use of component->debufs_root against CONFIG_DEBUG_FS

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f17c749c24c3..03cfaa82b031 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1028,7 +1028,9 @@ int wm_adsp2_component_probe(struct wm_adsp *dsp, struct snd_soc_component *comp
 	snprintf(preload, ARRAY_SIZE(preload), "%s Preload", dsp->cs_dsp.name);
 	snd_soc_component_disable_pin(component, preload);
 
+#if IS_ENABLED(CONFIG_DEBUG_FS)
 	cs_dsp_init_debugfs(&dsp->cs_dsp, component->debugfs_root);
+#endif
 
 	dsp->component = component;
 
-- 
2.33.0

