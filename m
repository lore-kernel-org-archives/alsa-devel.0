Return-Path: <SRS0=5/4N=36=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295FFC352A3
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:06:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A70382080C
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Feb 2020 15:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dVnuwNEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A70382080C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E462C86F;
	Mon, 10 Feb 2020 16:05:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E462C86F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1581347201;
	bh=70TwGuVL585FFlFP8ABezxpYhFzwPZdY2BERv1HFLl0=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dVnuwNEGFQEDEfiQ2TWin273AIauB4nnGLvPJDyT8ZJONZeJG12tHnRRy8OF1oa3k
	 AEm56Z6l21aV7JgBBzLpYy0gHiYGS38nKARunY4CPE1WfqhDjCnXXtxHS68rp3mgP0
	 Oqc5KFSOHKFdD+hcRvYh77jBVjICABKm+EHN8qUQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6010BF800FD;
	Mon, 10 Feb 2020 16:05:50 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 52F90F80157; Mon, 10 Feb 2020 16:05:49 +0100 (CET)
Received: from huawei.com (szxga04-in.huawei.com [45.249.212.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 71C59F800FD
 for <alsa-devel@alsa-project.org>; Mon, 10 Feb 2020 16:05:45 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 71C59F800FD
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 9AD5DEF4CB4E4FB8C5F8;
 Mon, 10 Feb 2020 23:05:39 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Mon, 10 Feb 2020
 23:05:30 +0800
From: YueHaibing <yuehaibing@huawei.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
 <tiwai@suse.com>, <pierre-louis.bossart@linux.intel.com>,
 <srinivas.kandagatla@linaro.org>, <yuehaibing@huawei.com>
Date: Mon, 10 Feb 2020 23:04:21 +0800
Message-ID: <20200210150421.34680-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH -next] ASoC: wcd934x: Remove set but not unused
	variable 'hph_comp_ctrl7'
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

sound/soc/codecs/wcd934x.c: In function wcd934x_codec_hphdelay_lutbypass:
sound/soc/codecs/wcd934x.c:3395:6: warning: variable hph_comp_ctrl7 set but not used [-Wunused-but-set-variable]

commit da3e83f8bb86 ("ASoC: wcd934x: add audio routings")
involved this unused variable.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/codecs/wcd934x.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
index 158e878..11c0439 100644
--- a/sound/soc/codecs/wcd934x.c
+++ b/sound/soc/codecs/wcd934x.c
@@ -3392,18 +3392,15 @@ static void wcd934x_codec_hphdelay_lutbypass(struct snd_soc_component *comp,
 {
 	u8 hph_dly_mask;
 	u16 hph_lut_bypass_reg = 0;
-	u16 hph_comp_ctrl7 = 0;
 
 	switch (interp_idx) {
 	case INTERP_HPHL:
 		hph_dly_mask = 1;
 		hph_lut_bypass_reg = WCD934X_CDC_TOP_HPHL_COMP_LUT;
-		hph_comp_ctrl7 = WCD934X_CDC_COMPANDER1_CTL7;
 		break;
 	case INTERP_HPHR:
 		hph_dly_mask = 2;
 		hph_lut_bypass_reg = WCD934X_CDC_TOP_HPHR_COMP_LUT;
-		hph_comp_ctrl7 = WCD934X_CDC_COMPANDER2_CTL7;
 		break;
 	default:
 		return;
-- 
2.7.4


_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
