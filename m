Return-Path: <SRS0=wAKr=HN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D790AC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 17:22:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EF2864DE9
	for <alsa-devel@archiver.kernel.org>; Thu, 11 Feb 2021 17:22:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EF2864DE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D56716F1;
	Thu, 11 Feb 2021 18:21:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D56716F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613064132;
	bh=m7ZJqJVHf0DuNDSpGHkX8bbPJtoL/dwTdRTdE9HMYXI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Vj8ul45r2jJZYLoSBXOUmvrgw7dBddTcW/wtdO5BzSuN3tZ3MpbqqKzpjBFXGYDV9
	 BhzX87zWD4AOXv7cZWM36qwRd2j7cb/7icXnyob3+6ppvINjMKrDLYwSwIOIZLjVQQ
	 EKKdHWZ2J/oQaBwLV7vNqhJhNq0vb1Yd3cYkhSjY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CD5C0F8016B;
	Thu, 11 Feb 2021 18:21:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF323F801D5; Thu, 11 Feb 2021 18:21:19 +0100 (CET)
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E4E84F8014D
 for <alsa-devel@alsa-project.org>; Thu, 11 Feb 2021 18:21:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E4E84F8014D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="mWCSwAIV"
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
 by mx0a-001ae601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id
 11BHAumQ021507; Thu, 11 Feb 2021 11:21:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type;
 s=PODMain02222019; bh=fTvHwRBe2cQ/2tIZhu94EvsrE2z9b4Azi0/gslh0SB4=;
 b=mWCSwAIVynj/+AJI0sgxLYyXw4XM5eWp2VxpZ41oo9lOA1wNQMVTAtdyKTv7dPRgywvh
 c+nPEC24EZf2oS0/0d8RIyeTX5AnK9HsRiHGovWX/PcR+Tb6kem4awhA6G6Y9WgEqH6j
 FT8s5eMGtit+TCUFLuXPqCWAB0Xr+z/tEvuRb0TFbHeBAFDIpyXum4ZrL0/v+dmzT9y3
 bvMX0qgU5mezn5W+YNkXP3AHJrrqSr3K1MhPUBoVf9mJ3DW/B79zd9cr02XV1RUUYahW
 DIv8flvIn3hvoschYoWoYM3HINcEd54DQfXh2hwXljbsoNLNeALd/4QmVN3w/Z9spYTN zQ== 
Received: from ediex02.ad.cirrus.com ([87.246.76.36])
 by mx0a-001ae601.pphosted.com with ESMTP id 36jdacdyqd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 11 Feb 2021 11:21:08 -0600
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 11 Feb
 2021 17:21:06 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.1913.5 via Frontend
 Transport; Thu, 11 Feb 2021 17:21:06 +0000
Received: from algalon.ad.cirrus.com (algalon.ad.cirrus.com [198.90.251.122])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9BACA11CF;
 Thu, 11 Feb 2021 17:21:06 +0000 (UTC)
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASoC: wm_adsp: Remove unused control callback structure
Date: Thu, 11 Feb 2021 17:21:06 +0000
Message-ID: <20210211172106.16258-1-ckeepax@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=895
 phishscore=0
 clxscore=1011 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102110143
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
 lgirdwood@gmail.com, linux-kernel@vger.kernel.org
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

This callback structure has never been used and it is not clear why it
was added in the first place. Remove it to clear up the code a little.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 262c2db4f81ce..070ca7d8c6610 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -595,13 +595,6 @@ static const struct {
 	[WM_ADSP_FW_MISC] =     { .file = "misc" },
 };
 
-struct wm_coeff_ctl_ops {
-	int (*xget)(struct snd_kcontrol *kcontrol,
-		    struct snd_ctl_elem_value *ucontrol);
-	int (*xput)(struct snd_kcontrol *kcontrol,
-		    struct snd_ctl_elem_value *ucontrol);
-};
-
 struct wm_coeff_ctl {
 	const char *name;
 	const char *fw_name;
@@ -609,7 +602,6 @@ struct wm_coeff_ctl {
 	const char *subname;
 	unsigned int subname_len;
 	struct wm_adsp_alg_region alg_region;
-	struct wm_coeff_ctl_ops ops;
 	struct wm_adsp *dsp;
 	unsigned int enabled:1;
 	struct list_head list;
@@ -1497,8 +1489,6 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	}
 	ctl->enabled = 1;
 	ctl->set = 0;
-	ctl->ops.xget = wm_coeff_get;
-	ctl->ops.xput = wm_coeff_put;
 	ctl->dsp = dsp;
 
 	ctl->flags = flags;
-- 
2.11.0

