Return-Path: <SRS0=CIz3=4U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D96C3F2CD
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 03:00:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A54C217F4
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Mar 2020 03:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Rz+2neKz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A54C217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7E8B21670;
	Tue,  3 Mar 2020 03:59:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7E8B21670
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583204425;
	bh=SNotp8DXsUiyim7dLXY1LqLcqyb14XzmjHoUzkGelEQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Rz+2neKzULZ2qR9WP9f/HuZ0Gt1GoRmIQUetbCZo7fUIz4n9wyGqJBhdEwQ4cLjdk
	 LgLKzHHoNfEjB9FEojkI8cZaZ4h6uelEb1fX7DabaLV/hMZRj6Esry+MZaKhtMbDRD
	 IIRALW+cElbzGn/f88q0iDkUL4GFdnSMT/dp/jNQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DEA81F8012D;
	Tue,  3 Mar 2020 03:59:34 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8FC8DF8025F; Tue,  3 Mar 2020 03:59:33 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1D614F8012D
 for <alsa-devel@alsa-project.org>; Tue,  3 Mar 2020 03:59:27 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1D614F8012D
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0232xKj8010512,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
 by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0232xKj8010512
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 3 Mar 2020 10:59:20 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 3 Mar 2020 10:59:20 +0800
Received: from localhost.localdomain (172.22.102.1) by RTEXMB01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 3 Mar 2020
 10:59:19 +0800
From: <jack.yu@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Subject: [PATCH] ASoC: rt1015: modify pre-divider for sysclk
Date: Tue, 3 Mar 2020 10:59:13 +0800
Message-ID: <20200303025913.24499-1-jack.yu@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.22.102.1]
X-ClientProxiedBy: RTEXMB05.realtek.com.tw (172.21.6.98) To
 RTEXMB01.realtek.com.tw (172.21.6.94)
Cc: oder_chiou@realtek.com, Jack Yu <jack.yu@realtek.com>,
 alsa-devel@alsa-project.org, lars@metafoo.de, kent_chen@realtek.com,
 kenny_chen@realtek.com, derek.fang@realtek.com, shumingf@realtek.com,
 albertwang@realtek.com, flove@realtek.com
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

From: Jack Yu <jack.yu@realtek.com>

Modify pre-divider for system clock.

Signed-off-by: Jack Yu <jack.yu@realtek.com>
---
 sound/soc/codecs/rt1015.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt1015.c b/sound/soc/codecs/rt1015.c
index 5fa21d8ab620..bb310bc7febd 100644
--- a/sound/soc/codecs/rt1015.c
+++ b/sound/soc/codecs/rt1015.c
@@ -664,7 +664,7 @@ static int rt1015_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_component_update_bits(component, RT1015_TDM_MASTER,
 		RT1015_I2S_DL_MASK, val_len);
 	snd_soc_component_update_bits(component, RT1015_CLK2,
-		RT1015_FS_PD_MASK, pre_div);
+		RT1015_FS_PD_MASK, pre_div << RT1015_FS_PD_SFT);
 
 	return 0;
 }
-- 
2.25.1

