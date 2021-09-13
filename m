Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB337C433F5
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 16:05:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B86F604D1
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 16:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5B86F604D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E17C616D1;
	Mon, 13 Sep 2021 18:04:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E17C616D1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631549111;
	bh=VuJHjiDt3GlVZ9IDkDip2im9PlEGNwf434Xyt9WFLVc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=nOwHlujdZi58UB5RRW5QUb8CIyeBLVwsmEzuXoYV7qbL2vLpEGyvhD5XQroQd8S2S
	 nhk4Hzt2recUatSGgP6zAfvpVTZnoMQXBbI9EN1e0zDvq46ikoN5ylmgpk1u8yqO4X
	 1Rh6lVgvKQxO7pm/C6AU6J2fw4eQsGY4R32ZiDKo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 084BDF80128;
	Mon, 13 Sep 2021 18:02:08 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E8842F804FE; Mon, 13 Sep 2021 18:01:46 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CC669F804E2
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 18:01:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CC669F804E2
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="Tfs2inei"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DFp9LE002377; 
 Mon, 13 Sep 2021 11:01:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=uvU6r4Nqgz/YCOcaAcLLxBcuewaZ+lrmvctjnct3PTw=;
 b=Tfs2ineifu0UsNg13gwhy+uejkzRvWz78DcOV73dAZxN3ne2mQmyk7xYoPJWgFVV9xG+
 b59qekeOLVlZEZ02u+ACIgmYrhd0WjdmRrsGFoI+mWmpEjexBUDfYSRLjro149wXbPyL
 wjKJkphLKcm0+GMLr7yuUvsCNa06XILZJtaBm3sbIIxfyo1x13lWG2p9wlYtYGZMXdBX
 5M41eIKmaV8gTWr8C/tfO8RErwBCffNOZcjZ0TvOo1/UjNJwmyZaYATDWelNM4KRpD/7
 nLPekQFo7yj4uTXJJ54dC8906CcTFFUjoXgqvA+XrNcsn2MTb/Hce8x+Xm7usdQTU9WF SA== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 3b29n3r0ag-8
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 13 Sep 2021 11:01:27 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 13 Sep
 2021 17:01:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Mon, 13 Sep 2021 17:01:21 +0100
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.152])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 65C0F2A9;
 Mon, 13 Sep 2021 16:01:21 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH 12/16] ASoC: wm_adsp: Pass firmware names as parameters when
 starting DSP core
Date: Mon, 13 Sep 2021 17:00:53 +0100
Message-ID: <20210913160057.103842-13-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913160057.103842-1-simont@opensource.cirrus.com>
References: <20210913160057.103842-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: IwwJbQSpALsUihXCDgwAeN3box0Fr9Ml
X-Proofpoint-ORIG-GUID: IwwJbQSpALsUihXCDgwAeN3box0Fr9Ml
X-Proofpoint-Spam-Reason: safe
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 Simon Trimmer <simont@opensource.cirrus.com>, linux-kernel@vger.kernel.org,
 Charles Keepax <ckeepax@opensource.cirrus.com>
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

As preparation for moving the generic DSP support out of ASoC pass the
firmware names used when loading files as parameters as the generic code
can't refer directly to the array specific to wm_adsp. The code
remaining in wm_adsp.c doesn't need to change, it can continue to use
the string arrays directly.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 43 +++++++++++++++++++++++---------------
 sound/soc/codecs/wm_adsp.h |  1 +
 2 files changed, 27 insertions(+), 17 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 1c8bf818dab9..c2e1eb8ff357 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1499,7 +1499,7 @@ static int cs_dsp_create_control(struct wm_adsp *dsp,
 	int ret;
 
 	list_for_each_entry(ctl, &dsp->ctl_list, list) {
-		if (ctl->fw_name == wm_adsp_fw_text[dsp->fw] &&
+		if (ctl->fw_name == dsp->fw_name &&
 		    ctl->alg_region.alg == alg_region->alg &&
 		    ctl->alg_region.type == alg_region->type) {
 			if ((!subname && !ctl->subname) ||
@@ -1514,7 +1514,8 @@ static int cs_dsp_create_control(struct wm_adsp *dsp,
 	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
 	if (!ctl)
 		return -ENOMEM;
-	ctl->fw_name = wm_adsp_fw_text[dsp->fw];
+
+	ctl->fw_name = dsp->fw_name;
 	ctl->alg_region = *alg_region;
 	if (subname && dsp->fw_ver >= 2) {
 		ctl->subname_len = subname_len;
@@ -1836,7 +1837,7 @@ static bool cs_dsp_halo_validate_version(struct wm_adsp *dsp, unsigned int versi
 	}
 }
 
-static int cs_dsp_load(struct wm_adsp *dsp)
+static int cs_dsp_load(struct wm_adsp *dsp, const char *fw_file_name)
 {
 	LIST_HEAD(buf_list);
 	const struct firmware *firmware;
@@ -1859,7 +1860,7 @@ static int cs_dsp_load(struct wm_adsp *dsp)
 		return -ENOMEM;
 
 	snprintf(file, PAGE_SIZE, "%s-%s-%s.wmfw", dsp->part, dsp->fwf_name,
-		 wm_adsp_fw[dsp->fw].file);
+		 fw_file_name);
 	file[PAGE_SIZE - 1] = '\0';
 
 	ret = request_firmware(&firmware, file, dsp->dev);
@@ -2047,13 +2048,12 @@ static struct cs_dsp_coeff_ctl *cs_dsp_get_ctl(struct wm_adsp *dsp,
 					       unsigned int alg)
 {
 	struct cs_dsp_coeff_ctl *pos, *rslt = NULL;
-	const char *fw_txt = wm_adsp_fw_text[dsp->fw];
 
 	list_for_each_entry(pos, &dsp->ctl_list, list) {
 		if (!pos->subname)
 			continue;
 		if (strncmp(pos->subname, name, pos->subname_len) == 0 &&
-		    pos->fw_name == fw_txt &&
+		    pos->fw_name == dsp->fw_name &&
 		    pos->alg_region.alg == alg &&
 		    pos->alg_region.type == type) {
 			rslt = pos;
@@ -2131,7 +2131,7 @@ static void cs_dsp_ctl_fixup_base(struct wm_adsp *dsp,
 	struct cs_dsp_coeff_ctl *ctl;
 
 	list_for_each_entry(ctl, &dsp->ctl_list, list) {
-		if (ctl->fw_name == wm_adsp_fw_text[dsp->fw] &&
+		if (ctl->fw_name == dsp->fw_name &&
 		    alg_region->alg == ctl->alg_region.alg &&
 		    alg_region->type == ctl->alg_region.type) {
 			ctl->alg_region.base = alg_region->base;
@@ -2582,7 +2582,7 @@ static int cs_dsp_halo_setup_algs(struct wm_adsp *dsp)
 	return ret;
 }
 
-static int cs_dsp_load_coeff(struct wm_adsp *dsp)
+static int cs_dsp_load_coeff(struct wm_adsp *dsp, const char *fw_file_name)
 {
 	LIST_HEAD(buf_list);
 	struct regmap *regmap = dsp->regmap;
@@ -2601,7 +2601,7 @@ static int cs_dsp_load_coeff(struct wm_adsp *dsp)
 		return -ENOMEM;
 
 	snprintf(file, PAGE_SIZE, "%s-%s-%s.bin", dsp->part, dsp->fwf_name,
-		 wm_adsp_fw[dsp->fw].file);
+		 fw_file_name);
 	file[PAGE_SIZE - 1] = '\0';
 
 	ret = request_firmware(&firmware, file, dsp->dev);
@@ -2837,13 +2837,15 @@ int wm_adsp1_init(struct wm_adsp *dsp)
 }
 EXPORT_SYMBOL_GPL(wm_adsp1_init);
 
-static int cs_dsp_adsp1_power_up(struct wm_adsp *dsp)
+static int cs_dsp_adsp1_power_up(struct wm_adsp *dsp, const char *fw_file_name, const char *fw_name)
 {
 	unsigned int val;
 	int ret;
 
 	mutex_lock(&dsp->pwr_lock);
 
+	dsp->fw_name = fw_name;
+
 	regmap_update_bits(dsp->regmap, dsp->base + ADSP1_CONTROL_30,
 			   ADSP1_SYS_ENA, ADSP1_SYS_ENA);
 
@@ -2869,7 +2871,7 @@ static int cs_dsp_adsp1_power_up(struct wm_adsp *dsp)
 		}
 	}
 
-	ret = cs_dsp_load(dsp);
+	ret = cs_dsp_load(dsp, fw_file_name);
 	if (ret != 0)
 		goto err_ena;
 
@@ -2877,7 +2879,7 @@ static int cs_dsp_adsp1_power_up(struct wm_adsp *dsp)
 	if (ret != 0)
 		goto err_ena;
 
-	ret = cs_dsp_load_coeff(dsp);
+	ret = cs_dsp_load_coeff(dsp, fw_file_name);
 	if (ret != 0)
 		goto err_ena;
 
@@ -2952,7 +2954,9 @@ int wm_adsp1_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_POST_PMU:
-		ret = cs_dsp_adsp1_power_up(dsp);
+		ret = cs_dsp_adsp1_power_up(dsp,
+					    wm_adsp_fw[dsp->fw].file,
+					    wm_adsp_fw_text[dsp->fw]);
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
 		cs_dsp_adsp1_power_down(dsp);
@@ -3172,12 +3176,15 @@ static void cs_dsp_halo_stop_watchdog(struct wm_adsp *dsp)
 			   HALO_WDT_EN_MASK, 0);
 }
 
-static void cs_dsp_power_up(struct wm_adsp *dsp)
+static void cs_dsp_power_up(struct wm_adsp *dsp, const char *fw_file_name,
+			    const char *fw_name)
 {
 	int ret;
 
 	mutex_lock(&dsp->pwr_lock);
 
+	dsp->fw_name = fw_name;
+
 	if (dsp->ops->enable_memory) {
 		ret = dsp->ops->enable_memory(dsp);
 		if (ret != 0)
@@ -3190,7 +3197,7 @@ static void cs_dsp_power_up(struct wm_adsp *dsp)
 			goto err_mem;
 	}
 
-	ret = cs_dsp_load(dsp);
+	ret = cs_dsp_load(dsp, fw_file_name);
 	if (ret != 0)
 		goto err_ena;
 
@@ -3198,7 +3205,7 @@ static void cs_dsp_power_up(struct wm_adsp *dsp)
 	if (ret != 0)
 		goto err_ena;
 
-	ret = cs_dsp_load_coeff(dsp);
+	ret = cs_dsp_load_coeff(dsp, fw_file_name);
 	if (ret != 0)
 		goto err_ena;
 
@@ -3258,7 +3265,9 @@ static void wm_adsp_boot_work(struct work_struct *work)
 					   struct wm_adsp,
 					   boot_work);
 
-	cs_dsp_power_up(dsp);
+	cs_dsp_power_up(dsp,
+			wm_adsp_fw[dsp->fw].file,
+			wm_adsp_fw_text[dsp->fw]);
 }
 
 int wm_adsp_early_event(struct snd_soc_dapm_widget *w,
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index eee298e94946..3bad022c4bb1 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -94,6 +94,7 @@ struct wm_adsp {
 
 	struct list_head alg_regions;
 
+	const char *fw_name;
 	unsigned int fw_id;
 	unsigned int fw_id_version;
 	unsigned int fw_vendor_id;
-- 
2.33.0

