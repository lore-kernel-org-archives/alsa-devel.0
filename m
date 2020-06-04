Return-Path: <SRS0=e91y=7R=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95B1DC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2020 07:11:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FD12074B
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jun 2020 07:11:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Y6sXVDlj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FD12074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7A637165D;
	Thu,  4 Jun 2020 09:10:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7A637165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1591254708;
	bh=OmQBG9FFsoMy+UajODaCoqs7dDQufDqizO+vsvAaIns=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Y6sXVDljMCNvFBfdllem7kUVFT8xbBsqrtiUhTFrAjdTLUwQdbiCGUO8PM3ElTVA9
	 l46Ug398zYXdqlZflXOkDMI1w/xD9u+xAhmzTLX5T0aHPMo3KZqnFaW5BH36civHRb
	 65eAL3ioJ0oVg1TufYqpz5eIkf46BkzCowLsGwb4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F368DF800BC;
	Thu,  4 Jun 2020 09:10:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2A8EF80254; Thu,  4 Jun 2020 09:10:55 +0200 (CEST)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 258F6F800BC
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2020 09:10:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 258F6F800BC
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0547AjRT2031084,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
 by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0547AjRT2031084
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
 Thu, 4 Jun 2020 15:10:45 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 4 Jun 2020 15:10:45 +0800
Received: from localhost.localdomain (172.22.102.1) by RTEXMB01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 4 Jun 2020
 15:10:45 +0800
From: Oder Chiou <oder_chiou@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: rl6231: Modify the target DMIC clock rate
Date: Thu, 4 Jun 2020 15:10:16 +0800
Message-ID: <20200604071016.3981-1-oder_chiou@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.102.1]
X-ClientProxiedBy: RTEXMB06.realtek.com.tw (172.21.6.99) To
 RTEXMB01.realtek.com.tw (172.21.6.94)
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com,
 alsa-devel@alsa-project.org, cychiang@google.com, albertchen@realtek.com,
 derek.fang@realtek.com, shumingf@realtek.com, flove@realtek.com
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

Some DMIC components will not work correctly in the clock rate 3.072MHz.
We recommend the clock rate 1.536MHz in the gerenal case.

Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
---
 sound/soc/codecs/rl6231.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rl6231.c b/sound/soc/codecs/rl6231.c
index 2586d1cafc0c..8c9daf32bab8 100644
--- a/sound/soc/codecs/rl6231.c
+++ b/sound/soc/codecs/rl6231.c
@@ -80,8 +80,8 @@ int rl6231_calc_dmic_clk(int rate)
 	for (i = 0; i < ARRAY_SIZE(div); i++) {
 		if ((div[i] % 3) == 0)
 			continue;
-		/* find divider that gives DMIC frequency below 3.072MHz */
-		if (3072000 * div[i] >= rate)
+		/* find divider that gives DMIC frequency below 1.536MHz */
+		if (1536000 * div[i] >= rate)
 			return i;
 	}
 
-- 
2.25.1

