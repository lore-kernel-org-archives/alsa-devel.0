Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D0EC433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 16:03:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D59160FE6
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 16:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D59160FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 330EC167A;
	Mon, 13 Sep 2021 18:02:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 330EC167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631548983;
	bh=XFK/Nqh9i3eGvb/VMut9GPmkArzI4tFk1Ghgkffi3O4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gRQS3KPYYBMnJCJKyPxxmmpAJG2tEJnWjOiceGMt6ofFBsPMrI9Ow+9p+8XvQe7LO
	 Tgn+pxmjMCHmfZMCIZx9xqE55kXRj+0n0QKTjfmdy0SH7NySuygm//B6AVSZYpc0SC
	 BuyQy0zrLcQIJh+tGydm046LGYrs4DSkHjUUkors=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B5034F804D9;
	Mon, 13 Sep 2021 18:01:41 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 79444F80169; Mon, 13 Sep 2021 18:01:30 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EDC72F80169
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 18:01:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDC72F80169
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="EtT7p3xH"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DFp9L8002377; 
 Mon, 13 Sep 2021 11:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=/0zRk4bgJkrH0dwJlv8Bv+YE3XNYKWjZnfXNPmvVpXU=;
 b=EtT7p3xHNLUv6yuoWJALg3dceD6UUfZW070SFQroxEWJ0tbJCtbvw89RHhtrr0+6zL4T
 lRtxZNSlzsQCwI6Dz1lsep4sqAkh2StueVnsW43kz1D9GvqR5/+dHiS5y9zSSU0Sm51T
 8gNcek+eXPO/+eyITLH8y+89NpK0TIUF8QjGp8PSazUvfJNYcBh2luF1GVI8DS/XZdIc
 Uz4KF1ujH41MPzavCax5aMfI5adIdrGbBdw9eF5whS7Lm2v8ONsM7s1nmGgXG/liGMt7
 P294IPOVpBLWGPLAl3q35ZKQ3eXSeR3ImOwZHTdE6z3XTt/FI2grXFq+mGTw9U/l2i3C Ow== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 3b29n3r0ag-2
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
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 39D6FB2F;
 Mon, 13 Sep 2021 16:01:18 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH 02/16] ASoC: wm_adsp: Move check for control existence
Date: Mon, 13 Sep 2021 17:00:43 +0100
Message-ID: <20210913160057.103842-3-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913160057.103842-1-simont@opensource.cirrus.com>
References: <20210913160057.103842-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1YorRL9b9FhBxuapBYSWayCZRnnG7Z6l
X-Proofpoint-ORIG-GUID: 1YorRL9b9FhBxuapBYSWayCZRnnG7Z6l
X-Proofpoint-Spam-Reason: safe
Cc: Simon Trimmer <simont@opensource.cirrus.com>, patches@opensource.cirrus.com,
 alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>,
 linux-kernel@vger.kernel.org
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

From: Charles Keepax <ckeepax@opensource.cirrus.com>

Checking earlier in the function if a control already exists avoids
superfluous string construction and also prepares for future
refactoring.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index f5db6e3b9f60..b300af6fdd41 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1422,6 +1422,19 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 	const char *region_name;
 	int ret;
 
+	list_for_each_entry(ctl, &dsp->ctl_list, list) {
+		if (ctl->fw_name == wm_adsp_fw_text[dsp->fw] &&
+		    ctl->alg_region.alg == alg_region->alg &&
+		    ctl->alg_region.type == alg_region->type) {
+			if ((!subname && !ctl->subname) ||
+			    (subname && !strncmp(ctl->subname, subname, ctl->subname_len))) {
+				if (!ctl->enabled)
+					ctl->enabled = 1;
+				return 0;
+			}
+		}
+	}
+
 	region_name = wm_adsp_mem_region_name(alg_region->type);
 	if (!region_name) {
 		adsp_err(dsp, "Unknown region type: %d\n", alg_region->type);
@@ -1462,14 +1475,6 @@ static int wm_adsp_create_control(struct wm_adsp *dsp,
 			 " %.*s", subname_len - skip, subname + skip);
 	}
 
-	list_for_each_entry(ctl, &dsp->ctl_list, list) {
-		if (!strcmp(ctl->name, name)) {
-			if (!ctl->enabled)
-				ctl->enabled = 1;
-			return 0;
-		}
-	}
-
 	ctl = kzalloc(sizeof(*ctl), GFP_KERNEL);
 	if (!ctl)
 		return -ENOMEM;
-- 
2.33.0

