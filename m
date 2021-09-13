Return-Path: <SRS0=eqSS=OD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8474C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 16:04:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 029EF604D1
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Sep 2021 16:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 029EF604D1
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8711216D3;
	Mon, 13 Sep 2021 18:03:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8711216D3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631549070;
	bh=AnRbgDuUZCuWQrEMuIl3L2Ol6D+MHhZ38I9vV+Zi6aw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=c5RLT/a6ZIKuQirxPfjj5D8IY8tglhFXSLyz7G4UEtTa3PwAMgkdlEO8SHwUYekRq
	 wKPVG0B7uRmvOxN3UcY8XnQ9+1foq/gzrj1oVslq9n+ijNCge9vBpOQqbdmh3tmkuv
	 lCcfMoaFbnoyWPR1ds0Gga3LgLpVM3azgYr5vhts=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D64B5F80507;
	Mon, 13 Sep 2021 18:02:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3944BF804ED; Mon, 13 Sep 2021 18:01:42 +0200 (CEST)
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 13C61F804E6
 for <alsa-devel@alsa-project.org>; Mon, 13 Sep 2021 18:01:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 13C61F804E6
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com
 header.b="pYVwK4x2"
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
 by mx0b-001ae601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18DFp9LD002377; 
 Mon, 13 Sep 2021 11:01:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=PODMain02222019;
 bh=tbdHTZRi7Od3F9nMj5YJ7/gwr9t4G1zuAUo0AIFhyww=;
 b=pYVwK4x2IKkDUFg9vKlHUmtcoaKyueEjCGMrjWQfJLckL6xa/KpdX7mrXgvkr9RRMcmg
 qhh+GXSp/yy3p4bzvPg6Q8deenF6B/Tn9UfeCEA/n4tMCYlgrhDXMvqbpqyioRtd07zr
 GugO+nObNxcA7HkzuP58p46FK1HEa5lNzW+zf13pt7Ipv8Ab8wReTFT5H6/bj7LZtdnG
 s9L6dbxTuWm8tFLsU8oXBWnaWDO6dxPcdYqU5pW9TATahKITRlhpi2kC8cFS+TXpLAKC
 JylHvyJHFh6GwQKk0rqnUjHoqS5+rPwc7d9Ya2UO3PkKX9xjRmUMj+qO1dkx+8fXaMvB Ow== 
Received: from ediex01.ad.cirrus.com ([87.246.76.36])
 by mx0b-001ae601.pphosted.com with ESMTP id 3b29n3r0ag-7
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Mon, 13 Sep 2021 11:01:26 -0500
Received: from EDIEX01.ad.cirrus.com (198.61.84.80) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.12; Mon, 13 Sep
 2021 17:01:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by EDIEX01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.1.2242.12 via
 Frontend Transport; Mon, 13 Sep 2021 17:01:21 +0100
Received: from simont-vb.lan?044ad.cirrus.com (unknown [198.90.238.152])
 by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 27ECBB16;
 Mon, 13 Sep 2021 16:01:21 +0000 (UTC)
From: Simon Trimmer <simont@opensource.cirrus.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH 11/16] ASoC: wm_adsp: Move check of dsp->running to better
 place
Date: Mon, 13 Sep 2021 17:00:52 +0100
Message-ID: <20210913160057.103842-12-simont@opensource.cirrus.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913160057.103842-1-simont@opensource.cirrus.com>
References: <20210913160057.103842-1-simont@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: YPPGxAXPQ209QJKbTjIL8IeYGVTRTi7e
X-Proofpoint-ORIG-GUID: YPPGxAXPQ209QJKbTjIL8IeYGVTRTi7e
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

In preparation for moving the generic DSP support out of ASoC, move
the check of dsp->running to a more appropriate place that will move
to the generic code.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/wm_adsp.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index bd335e4240e5..1c8bf818dab9 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -976,6 +976,9 @@ static int cs_dsp_coeff_write_acked_control(struct cs_dsp_coeff_ctl *ctl,
 	unsigned int reg;
 	int i, ret;
 
+	if (!dsp->running)
+		return -EPERM;
+
 	ret = cs_dsp_coeff_base_reg(ctl, &reg);
 	if (ret)
 		return ret;
@@ -1129,7 +1132,7 @@ static int wm_coeff_put_acked(struct snd_kcontrol *kctl,
 
 	mutex_lock(&cs_ctl->dsp->pwr_lock);
 
-	if (cs_ctl->enabled && cs_ctl->dsp->running)
+	if (cs_ctl->enabled)
 		ret = cs_dsp_coeff_write_acked_control(cs_ctl, val);
 	else
 		ret = -EPERM;
-- 
2.33.0

