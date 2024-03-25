Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFC28C54E58
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Mar 2024 11:35:38 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A945F21E2;
	Mon, 25 Mar 2024 12:35:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A945F21E2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1711366536;
	bh=DtND/2TH2HecycIPvl0bQ7o+Uh9mDNNleYg4w3UFX/k=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=KTCm9vqpKlAcRUUyIaBfa2nw9pVOWO7TBoeqIThVbKZ5+tfsBeA4y+lORhtZzNaDQ
	 yGMNDwzKIvywndGZ0OEimsuu8qPwSST7Ov2R5x0NGaCehTqm2iyMqEQ575WuKX/4/P
	 MgO21OY2TQEKaiYjYs6ACPzFYE6HXU8P/1hmZdDA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id C9E4EF8057C; Mon, 25 Mar 2024 12:34:13 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4185BF8061E;
	Mon, 25 Mar 2024 12:34:13 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A2323F80236; Mon, 25 Mar 2024 12:33:29 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AE840F8015B
	for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2024 12:31:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AE840F8015B
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=cirrus.com header.i=@cirrus.com header.a=rsa-sha256
 header.s=PODMain02222019 header.b=hAZBgus+
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 42P4qkf5007553;
	Mon, 25 Mar 2024 06:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=s1A3sEsy8QLu47lwBUxBo7IgUoNvvzU56aJ+ojynQBQ=; b=
	hAZBgus++QqTo91R9+0lwTstUiNyOi68eSTlbEwJ7N6eDQmI5a6jJFEw/jbACMDp
	AC1UircWKayQcyELCh5g7VxvEJCdx9QrlPQdIoixJxiWcEGtsrD+/N8WexPjMto3
	55OxtVVFaHcIVW2qZvq/pMJcuQPO1cRzna7wADtGYKS1PfGks8y3eCowhGCt4S4L
	nwN47QQ1hOmYc/FXMPO/BbBnU4wMUXF3ksU5aoiZAvqg9NTXhvoGJrag4mXmRY9F
	a9+rqCKhnB0nb0MswYZWNFAq05ZTxvsPIBvs2oqFQR2vwLezO6p6d0P7Y8tLZcTM
	s7/wJgV0kMdnsb917/JhNg==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3x1vfyb6v0-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 06:31:31 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 25 Mar
 2024 11:31:27 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1544.4 via Frontend Transport; Mon, 25 Mar 2024 11:31:27 +0000
Received: from ediswws06.ad.cirrus.com (ediswws06.ad.cirrus.com
 [198.90.208.18])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 41DBA82024D;
	Mon, 25 Mar 2024 11:31:27 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <linux-sound@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Simon
 Trimmer" <simont@opensource.cirrus.com>,
        Richard Fitzgerald
	<rf@opensource.cirrus.com>
Subject: [PATCH 2/5] ASoC: wm_adsp: Use
 cs_dsp_coeff_lock_and_[read|write]_ctrl()
Date: Mon, 25 Mar 2024 11:31:24 +0000
Message-ID: <20240325113127.112783-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240325113127.112783-1-rf@opensource.cirrus.com>
References: <20240325113127.112783-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: A9SwOO9lWnUqNlKhK1VT9Lw8RetoN_Fj
X-Proofpoint-GUID: A9SwOO9lWnUqNlKhK1VT9Lw8RetoN_Fj
X-Proofpoint-Spam-Reason: safe
Message-ID-Hash: 52YN35PCOKU4P6SSZVUEEMPG54RD7F4T
X-Message-ID-Hash: 52YN35PCOKU4P6SSZVUEEMPG54RD7F4T
X-MailFrom: prvs=081491209a=rf@opensource.cirrus.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/52YN35PCOKU4P6SSZVUEEMPG54RD7F4T/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Simon Trimmer <simont@opensource.cirrus.com>

Using the cs_dsp_coeff_lock_and_[read|write]_ctrl() wrappers tidies
the calling functions as it does not need to manage the DSP pwr_lock.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 7d5c096e06cd..8e366902ee4e 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -403,13 +403,8 @@ static int wm_coeff_put(struct snd_kcontrol *kctl,
 	struct wm_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
 	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
 	char *p = ucontrol->value.bytes.data;
-	int ret = 0;
-
-	mutex_lock(&cs_ctl->dsp->pwr_lock);
-	ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, p, cs_ctl->len);
-	mutex_unlock(&cs_ctl->dsp->pwr_lock);
 
-	return ret;
+	return cs_dsp_coeff_lock_and_write_ctrl(cs_ctl, 0, p, cs_ctl->len);
 }
 
 static int wm_coeff_tlv_put(struct snd_kcontrol *kctl,
@@ -426,13 +421,11 @@ static int wm_coeff_tlv_put(struct snd_kcontrol *kctl,
 	if (!scratch)
 		return -ENOMEM;
 
-	if (copy_from_user(scratch, bytes, size)) {
+	if (copy_from_user(scratch, bytes, size))
 		ret = -EFAULT;
-	} else {
-		mutex_lock(&cs_ctl->dsp->pwr_lock);
-		ret = cs_dsp_coeff_write_ctrl(cs_ctl, 0, scratch, size);
-		mutex_unlock(&cs_ctl->dsp->pwr_lock);
-	}
+	else
+		ret = cs_dsp_coeff_lock_and_write_ctrl(cs_ctl, 0, scratch, size);
+
 	vfree(scratch);
 
 	return ret;
@@ -474,13 +467,8 @@ static int wm_coeff_get(struct snd_kcontrol *kctl,
 	struct wm_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
 	struct cs_dsp_coeff_ctl *cs_ctl = ctl->cs_ctl;
 	char *p = ucontrol->value.bytes.data;
-	int ret;
 
-	mutex_lock(&cs_ctl->dsp->pwr_lock);
-	ret = cs_dsp_coeff_read_ctrl(cs_ctl, 0, p, cs_ctl->len);
-	mutex_unlock(&cs_ctl->dsp->pwr_lock);
-
-	return ret;
+	return cs_dsp_coeff_lock_and_read_ctrl(cs_ctl, 0, p, cs_ctl->len);
 }
 
 static int wm_coeff_tlv_get(struct snd_kcontrol *kctl,
-- 
2.39.2

