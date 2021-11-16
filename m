Return-Path: <SRS0=I3pN=QD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F326C433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 16:19:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9766A61872
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Nov 2021 16:19:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9766A61872
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D0FE9170C;
	Tue, 16 Nov 2021 17:19:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D0FE9170C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637079594;
	bh=VZOt9fLtvpr9O6ftieZnN53SCB+qbuBNv68jBMvcWkI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FJkGzxE+d8MJBULb4T4+KTDJr1mCgoxf8Ee+Q2EzTIdxLfChwcPCL+AONxBZ0aRkg
	 39AUuKvEXl3Re8XXW8BaiKLXZb/BPhDrZ7FECUIHNxIbkLQBRMN5Jx1Znt2mObTJVT
	 x/vxR+FJ6ho3vYx83OlhcGX8VABtSOf03zWmoW/A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ABC3FF8051B;
	Tue, 16 Nov 2021 17:16:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EF42F80510; Tue, 16 Nov 2021 17:16:33 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A9F5FF804C1
 for <alsa-devel@alsa-project.org>; Tue, 16 Nov 2021 17:16:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A9F5FF804C1
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="REugXjWT"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AG7fwnI025797;
 Tue, 16 Nov 2021 10:16:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=0qQJAVTMHpYzFRrVbUU4QMPmgdxw2s22267GJm0xoxk=;
 b=REugXjWT2YiikiwlK3OTsPPNJXfLUywnViTVEtTsFJM7mEFYJu6hqS+aqfqYzg4oA3Qc
 StkJT95TOfQhAvlG0BVdL70kG7YT9EmokltA2uSACGPXSJUI8DGR2yaCrscOMVL4Iq/9
 I5/Otl/eqglMmaIO4eh+dDXv+BSLjYndImsEA7wuQZVy1wpp1yfZpxUAgYQ0l4D/B756
 92x/GVPzLaMdY2ICrvoDwUdlU3xJFLTtKfhIiA0v8NUYr2QwY/SmPQj1LtCDoSwgNQSD
 g+gVZ5nrn59SyaOTl2FZlVmgOtW2RlfwyGmZW1SSKTcV1qmTXCrZd1mrPJr4xpTOoaJM Yg== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3cbjn01x5t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 16 Nov 2021 10:16:11 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Tue, 16 Nov
 2021 16:16:09 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2375.17 via
 Frontend Transport; Tue, 16 Nov 2021 16:16:09 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 3381611DC;
 Tue, 16 Nov 2021 16:16:09 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH 01/10] ASoC: wm_adsp: Remove the wmfw_add_ctl helper function
Date: Tue, 16 Nov 2021 16:16:00 +0000
Message-ID: <20211116161609.12223-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: HeGrMYLy5iTGLlmWGZ3yckd5kcH2vO8Y
X-Proofpoint-ORIG-GUID: HeGrMYLy5iTGLlmWGZ3yckd5kcH2vO8Y
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com
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

The helper function wmfw_add_ctl is only called from one place and that
place is a function with only 2 lines of code. Merge the helper function
into the work function to simplify the code.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 33 +++++++++------------------------
 1 file changed, 9 insertions(+), 24 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index d4f0d72cbcc80..404717e30f44d 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -537,15 +537,20 @@ static unsigned int wmfw_convert_flags(unsigned int in, unsigned int len)
 	return out;
 }
 
-static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
+static void wm_adsp_ctl_work(struct work_struct *work)
 {
+	struct wm_coeff_ctl *ctl = container_of(work,
+						struct wm_coeff_ctl,
+						work);
 	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
+	struct wm_adsp *dsp = container_of(cs_ctl->dsp,
+					   struct wm_adsp,
+					   cs_dsp);
 	struct snd_kcontrol_new *kcontrol;
-	int ret;
 
 	kcontrol = kzalloc(sizeof(*kcontrol), GFP_KERNEL);
 	if (!kcontrol)
-		return -ENOMEM;
+		return;
 
 	kcontrol->name = ctl->name;
 	kcontrol->info = wm_coeff_info;
@@ -571,29 +576,9 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 		break;
 	}
 
-	ret = snd_soc_add_component_controls(dsp->component, kcontrol, 1);
-	if (ret < 0)
-		goto err_kcontrol;
+	snd_soc_add_component_controls(dsp->component, kcontrol, 1);
 
 	kfree(kcontrol);
-
-	return 0;
-
-err_kcontrol:
-	kfree(kcontrol);
-	return ret;
-}
-
-static void wm_adsp_ctl_work(struct work_struct *work)
-{
-	struct wm_coeff_ctl *ctl = container_of(work,
-						struct wm_coeff_ctl,
-						work);
-	struct wm_adsp *dsp = container_of(ctl->cs_ctl->dsp,
-					   struct wm_adsp,
-					   cs_dsp);
-
-	wmfw_add_ctl(dsp, ctl);
 }
 
 static int wm_adsp_control_add(struct cs_dsp_coeff_ctl *cs_ctl)
-- 
2.11.0

