Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C533C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 16:08:20 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23CA60698
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 16:08:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D23CA60698
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 706AA178B;
	Mon, 13 Sep 2021 18:07:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 706AA178B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631549298;
	bh=JWxvtMh4E1FSZBcwMPdfMI5JdPHdGgEsXKyCJEyUaLU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mldSg4uhIL3eMbtv4IWfhwwb77rCCuyf2qzEQ738t0NQSQ8lwex2J9h+Jq7xoekRf
	 6kXTpqdkLAq6hvymxcSGkQbXbhUXYOss0bDYOuX5A0BSA38QaEg/Ea9T0JhA2/ud/i
	 slPXwYTK2Rd8PWW52WQxqbwxhMLtxv9sW8sNlnO8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DF59BF805AD;
	Mon, 13 Sep 2021 18:02:43 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DC810F8032C; Mon, 13 Sep 2021 18:02:40 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B0349F8027C
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 18:01:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B0349F8027C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="oKSrgmgc"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DFp9L9002377; 
 Mon, 13 Sep 2021 11:01:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=gAi6bsx98UZU8FZXLBW0SVx/jzJTeMZYBy0/3ptxLfc=;
 b=oKSrgmgcBIa/9DkNtAHwKS1tZBAcCbeaNFLfLiNmT2mudasV26PCLjK/0jhL+nY9oN2s
 9/ECf2pDXCBOrI9SHWqU8pGaThG2Ii8aySGTZCnWhu0UpvGYEQDwSUq8mPtDbXSW0pqQ
 ww4W7fZfGJJW+jZvlyIFh6P4VX5g2aHcgY3HfDDDg8SnahxwCDtn9iSoAjVBSRNX+Wdi
 86ERD2ZmDTXrfHJOOCQxG3zNn8+PbHhY7SSO6rsFizvhoMjaoOcyOs5cB3wtjHaS9ZeC
 isFxevrqILxLZ1P/Q+3ny7yFB3XgMoEX3Fufb2o3wG0VJpycibKiJhdwdgHo2jDCRe7q Xw== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 3b29n3r0ag-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 13 Sep 2021 11:01:21 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 13 Sep
 2021 17:01:18 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Mon, 13 Sep 2021 17:01:18 +0100
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.152])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id B6357B2F;
 Mon, 13 Sep 2021 16:01:18 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH 04/16] ASoC: wm_adsp: Cancel ongoing work when removing
 controls
Date: Mon, 13 Sep 2021 17:00:45 +0100
Message-ID: <20210913160057.103842-5-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913160057.103842-1-simont@opensource.cirrus.com>
References: <20210913160057.103842-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 9-IliWsje6IfdbC7PSjKOs1BrOHTRnfr
X-Proofpoint-ORIG-GUID: 9-IliWsje6IfdbC7PSjKOs1BrOHTRnfr
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Simon Trimmer <simont@opensource.cirrus.com>, linux-kernel@vger.kernel.org
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

Removes wm_adsp_ctl_work and integrates the work_struct into
wm_coeff_ctl so it may be referenced.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 9c3d4b96fd7c..c1b5ea3b5718 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -613,6 +613,7 @@ struct wm_coeff_ctl {
 	struct soc_bytes_ext bytes_ext;
 	unsigned int flags;
 	unsigned int type;
+	struct work_struct work;
 };
 
 static const char *wm_adsp_mem_region_name(unsigned int type)
@@ -1240,12 +1241,6 @@ static int wm_coeff_get_acked(struct snd_kcontrol *kcontrol,
 	return 0;
 }
 
-struct wmfw_ctl_work {
-	struct wm_adsp *dsp;
-	struct wm_coeff_ctl *ctl;
-	struct work_struct work;
-};
-
 static unsigned int wmfw_convert_flags(unsigned int in, unsigned int len)
 {
 	unsigned int out, rd, wr, vol;
@@ -1394,16 +1389,17 @@ static void wm_adsp_signal_event_controls(struct wm_adsp *dsp,
 
 static void wm_adsp_ctl_work(struct work_struct *work)
 {
-	struct wmfw_ctl_work *ctl_work = container_of(work,
-						      struct wmfw_ctl_work,
-						      work);
+	struct wm_coeff_ctl *ctl = container_of(work,
+						struct wm_coeff_ctl,
+						work);
 
-	wmfw_add_ctl(ctl_work->dsp, ctl_work->ctl);
-	kfree(ctl_work);
+	wmfw_add_ctl(ctl->dsp, ctl);
 }
 
 static void wm_adsp_free_ctl_blk(struct wm_coeff_ctl *ctl)
 {
+	cancel_work_sync(&ctl->work);
+
 	kfree(ctl->cache);
 	kfree(ctl->name);
 	kfree(ctl->subname);
@@ -1417,7 +1413,6 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 				  unsigned int flags, unsigned int type)
 {
 	struct wm_coeff_ctl *ctl;
-	struct wmfw_ctl_work *ctl_work;
 	char name[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
 	const char *region_name;
 	int ret;
@@ -1513,22 +1508,11 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	if (flags & WMFW_CTL_FLAG_SYS)
 		return 0;
 
-	ctl_work = kzalloc(sizeof(*ctl_work), GFP_KERNEL);
-	if (!ctl_work) {
-		ret = -ENOMEM;
-		goto err_list_del;
-	}
-
-	ctl_work->dsp = dsp;
-	ctl_work->ctl = ctl;
-	INIT_WORK(&ctl_work->work, wm_adsp_ctl_work);
-	schedule_work(&ctl_work->work);
+	INIT_WORK(&ctl->work, wm_adsp_ctl_work);
+	schedule_work(&ctl->work);
 
 	return 0;
 
-err_list_del:
-	list_del(&ctl->list);
-	kfree(ctl->cache);
 err_ctl_subname:
 	kfree(ctl->subname);
 err_ctl_name:
-- 
2.33.0

