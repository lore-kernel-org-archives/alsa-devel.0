Return-Path: <SRS0=6Vr6=3D=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2ADEC33C9E
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:32:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BA7624656
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jan 2020 16:32:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="C4xL0zhY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="dko2t7vD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BA7624656
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 801FE1890;
	Tue, 14 Jan 2020 17:31:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 801FE1890
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1579019532;
	bh=ZImDRYb3Y2Id6BDX+e/HQUaTKDPMRJAxvPFjWq1kJ8s=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=C4xL0zhY1g01TVu9kh/pellxOZTXcFcIRUkWhFu7vMkzDLjqf4D58uRRhlLqbZxCX
	 sxX9joc6mwZVw7lEVgb4z3KQFq7TpgttWQLAZO47mGo3Tzxbmtzj28mrx8meKnNfNQ
	 tRhwQzYOZ20Y06lGsvZAVHKAw69OMcijw/MxH9sE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C05AF802A1;
	Tue, 14 Jan 2020 17:19:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80FF6F8026A; Tue, 14 Jan 2020 17:18:53 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6EA22F800B9
 for <alsa-devel@alsa-project.org>; Tue, 14 Jan 2020 17:18:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6EA22F800B9
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="dko2t7vD"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id
 00EG83Oq018646; Tue, 14 Jan 2020 10:18:45 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=nJHfqdUKyvy0vEGXQvKAt1IgE3I/VmVTz+evXBdz+MA=;
 b=dko2t7vD1Xr9N6NROYlxhFh6m6vh5NNIzqw5BMG9rbLBI3BC3EZxlOPhMjt7wFbU7o5A
 pKjcUflh+eKDHTnPxH9TozIvwoNyNuCh+xh2L01jj65d9Jk3iovEGl/2Sn6pPySYfWqw
 dMIpoe/ypat3cx/nZs0Tx/jx2nPhN+6EknxIB+xwdYkv5AGbzJUbKXmB5c4JQyIcq1NS
 2Y6x4WDuIykMS4Q1VI8zCeXbZq5sYYItP9wwQ4sAUbksMY+zADD8h4Vp1uCZ9ZeFCrhy
 L/AjyT4TSd7caqFq5iM+BdKy5rBSSFIHBe2KggvbEIBo33mFWkdvME/jfBwrDItjK9R0 0g== 
Authentication-Results: ppops.net;
 spf=fail smtp.mailfrom=ckeepax@opensource.cirrus.com
Received: from ediex01.ad.cirrus.com ([5.172.152.52])
 by mx0a-001ae601.pphosted.com with ESMTP id 2xfcn7vrvp-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Tue, 14 Jan 2020 10:18:45 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1591.10; Tue, 14 Jan
 2020 16:18:41 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1591.10 via
 Frontend Transport; Tue, 14 Jan 2020 16:18:41 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 998EC2D1;
 Tue, 14 Jan 2020 16:18:41 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Date: Tue, 14 Jan 2020 16:18:38 +0000
Message-ID: <20200114161841.451-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
X-Proofpoint-SPF-Result: fail
X-Proofpoint-SPF-Record: v=spf1 include:spf-001ae601.pphosted.com
 include:spf.protection.outlook.com -all
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0
 impostorscore=0 phishscore=0 clxscore=1015 bulkscore=0 spamscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=1
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-2001140137
Cc: li.xu@cirrus.com, patches@opensource.cirrus.com,
 alsa-devel@alsa-project.org, lgirdwood@gmail.com, david.rhodes@cirrus.com
Subject: [alsa-devel] [PATCH 1/4] ASoC: wm_adsp: Correct cache handling of
	new kernel control API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The recently added API that exposes firmware mixer controls to the
kernel is missing cache handling and all writes bypass the cache, this
obviously causes the cache to get out of sync with the hardware. Factor
out the cache handling into two new helper functions and call those from
both the normal ALSA control handlers and the new kernel API.

Fixes: eb65ccdb0836 ("ASoC: wm_adsp: Expose mixer control API")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 98 ++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 47 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 2a9b610f6d435..d3d32b501acae 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1030,8 +1030,8 @@ static int wm_coeff_write_acked_control(struct wm_coeff_ctl *ctl,
 	return -ETIMEDOUT;
 }
 
-static int wm_coeff_write_control(struct wm_coeff_ctl *ctl,
-				  const void *buf, size_t len)
+static int wm_coeff_write_ctrl_raw(struct wm_coeff_ctl *ctl,
+				   const void *buf, size_t len)
 {
 	struct wm_adsp *dsp = ctl->dsp;
 	void *scratch;
@@ -1061,6 +1061,23 @@ static int wm_coeff_write_control(struct wm_coeff_ctl *ctl,
 	return 0;
 }
 
+static int wm_coeff_write_ctrl(struct wm_coeff_ctl *ctl,
+			       const void *buf, size_t len)
+{
+	int ret = 0;
+
+	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
+		ret = -EPERM;
+	else if (buf != ctl->cache)
+		memcpy(ctl->cache, buf, len);
+
+	ctl->set = 1;
+	if (ctl->enabled && ctl->dsp->running)
+		ret = wm_coeff_write_ctrl_raw(ctl, buf, len);
+
+	return ret;
+}
+
 static int wm_coeff_put(struct snd_kcontrol *kctl,
 			struct snd_ctl_elem_value *ucontrol)
 {
@@ -1071,16 +1088,7 @@ static int wm_coeff_put(struct snd_kcontrol *kctl,
 	int ret = 0;
 
 	mutex_lock(&ctl->dsp->pwr_lock);
-
-	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
-		ret = -EPERM;
-	else
-		memcpy(ctl->cache, p, ctl->len);
-
-	ctl->set = 1;
-	if (ctl->enabled && ctl->dsp->running)
-		ret = wm_coeff_write_control(ctl, p, ctl->len);
-
+	ret = wm_coeff_write_ctrl(ctl, p, ctl->len);
 	mutex_unlock(&ctl->dsp->pwr_lock);
 
 	return ret;
@@ -1096,15 +1104,10 @@ static int wm_coeff_tlv_put(struct snd_kcontrol *kctl,
 
 	mutex_lock(&ctl->dsp->pwr_lock);
 
-	if (copy_from_user(ctl->cache, bytes, size)) {
+	if (copy_from_user(ctl->cache, bytes, size))
 		ret = -EFAULT;
-	} else {
-		ctl->set = 1;
-		if (ctl->enabled && ctl->dsp->running)
-			ret = wm_coeff_write_control(ctl, ctl->cache, size);
-		else if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
-			ret = -EPERM;
-	}
+	else
+		ret = wm_coeff_write_ctrl(ctl, ctl->cache, size);
 
 	mutex_unlock(&ctl->dsp->pwr_lock);
 
@@ -1135,8 +1138,8 @@ static int wm_coeff_put_acked(struct snd_kcontrol *kctl,
 	return ret;
 }
 
-static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
-				 void *buf, size_t len)
+static int wm_coeff_read_ctrl_raw(struct wm_coeff_ctl *ctl,
+				  void *buf, size_t len)
 {
 	struct wm_adsp *dsp = ctl->dsp;
 	void *scratch;
@@ -1166,29 +1169,37 @@ static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
 	return 0;
 }
 
-static int wm_coeff_get(struct snd_kcontrol *kctl,
-			struct snd_ctl_elem_value *ucontrol)
+static int wm_coeff_read_ctrl(struct wm_coeff_ctl *ctl, void *buf, size_t len)
 {
-	struct soc_bytes_ext *bytes_ext =
-		(struct soc_bytes_ext *)kctl->private_value;
-	struct wm_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
-	char *p = ucontrol->value.bytes.data;
 	int ret = 0;
 
-	mutex_lock(&ctl->dsp->pwr_lock);
-
 	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE) {
 		if (ctl->enabled && ctl->dsp->running)
-			ret = wm_coeff_read_control(ctl, p, ctl->len);
+			return wm_coeff_read_ctrl_raw(ctl, buf, len);
 		else
-			ret = -EPERM;
+			return -EPERM;
 	} else {
 		if (!ctl->flags && ctl->enabled && ctl->dsp->running)
-			ret = wm_coeff_read_control(ctl, ctl->cache, ctl->len);
+			ret = wm_coeff_read_ctrl_raw(ctl, ctl->cache, ctl->len);
 
-		memcpy(p, ctl->cache, ctl->len);
+		if (buf != ctl->cache)
+			memcpy(buf, ctl->cache, len);
 	}
 
+	return ret;
+}
+
+static int wm_coeff_get(struct snd_kcontrol *kctl,
+			struct snd_ctl_elem_value *ucontrol)
+{
+	struct soc_bytes_ext *bytes_ext =
+		(struct soc_bytes_ext *)kctl->private_value;
+	struct wm_coeff_ctl *ctl = bytes_ext_to_ctl(bytes_ext);
+	char *p = ucontrol->value.bytes.data;
+	int ret;
+
+	mutex_lock(&ctl->dsp->pwr_lock);
+	ret = wm_coeff_read_ctrl(ctl, p, ctl->len);
 	mutex_unlock(&ctl->dsp->pwr_lock);
 
 	return ret;
@@ -1204,15 +1215,7 @@ static int wm_coeff_tlv_get(struct snd_kcontrol *kctl,
 
 	mutex_lock(&ctl->dsp->pwr_lock);
 
-	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE) {
-		if (ctl->enabled && ctl->dsp->running)
-			ret = wm_coeff_read_control(ctl, ctl->cache, size);
-		else
-			ret = -EPERM;
-	} else {
-		if (!ctl->flags && ctl->enabled && ctl->dsp->running)
-			ret = wm_coeff_read_control(ctl, ctl->cache, size);
-	}
+	ret = wm_coeff_read_ctrl_raw(ctl, ctl->cache, size);
 
 	if (!ret && copy_to_user(bytes, ctl->cache, size))
 		ret = -EFAULT;
@@ -1340,7 +1343,7 @@ static int wm_coeff_init_control_caches(struct wm_adsp *dsp)
 		 * created so we don't need to do anything.
 		 */
 		if (!ctl->flags || (ctl->flags & WMFW_CTL_FLAG_READABLE)) {
-			ret = wm_coeff_read_control(ctl, ctl->cache, ctl->len);
+			ret = wm_coeff_read_ctrl_raw(ctl, ctl->cache, ctl->len);
 			if (ret < 0)
 				return ret;
 		}
@@ -1358,7 +1361,8 @@ static int wm_coeff_sync_controls(struct wm_adsp *dsp)
 		if (!ctl->enabled)
 			continue;
 		if (ctl->set && !(ctl->flags & WMFW_CTL_FLAG_VOLATILE)) {
-			ret = wm_coeff_write_control(ctl, ctl->cache, ctl->len);
+			ret = wm_coeff_write_ctrl_raw(ctl, ctl->cache,
+						      ctl->len);
 			if (ret < 0)
 				return ret;
 		}
@@ -2048,7 +2052,7 @@ int wm_adsp_write_ctl(struct wm_adsp *dsp, const char *name, int type,
 	if (len > ctl->len)
 		return -EINVAL;
 
-	ret = wm_coeff_write_control(ctl, buf, len);
+	ret = wm_coeff_write_ctrl(ctl, buf, len);
 
 	kcontrol = snd_soc_card_get_kcontrol(dsp->component->card, ctl->name);
 	snd_ctl_notify(dsp->component->card->snd_card,
@@ -2070,7 +2074,7 @@ int wm_adsp_read_ctl(struct wm_adsp *dsp, const char *name, int type,
 	if (len > ctl->len)
 		return -EINVAL;
 
-	return wm_coeff_read_control(ctl, buf, len);
+	return wm_coeff_read_ctrl(ctl, buf, len);
 }
 EXPORT_SYMBOL_GPL(wm_adsp_read_ctl);
 
-- 
2.11.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
