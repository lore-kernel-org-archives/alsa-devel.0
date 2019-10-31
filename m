Return-Path: <SRS0=tVg1=YY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127F0CA9EC3
	for <alsa-devel@archiver.kernel.org>; Thu, 31 Oct 2019 12:08:25 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 71EE92086D
	for <alsa-devel@archiver.kernel.org>; Thu, 31 Oct 2019 12:08:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Vf+ytKIi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71EE92086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52DA6209B;
	Thu, 31 Oct 2019 13:07:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52DA6209B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572523702;
	bh=MXxAcdhVJFupHVltgiYWbh1riZk6mykD88I6XTPUgtM=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Vf+ytKIiU/F54uWIpWNzYeyZr0HmrO594oKE8Ri0gkLDsBgwA8/IZru1GhBbm/aCG
	 WshjqLNpMn6b8OcQDPZYdJUi1qBe5mWsQEGl8lJdS//UXaw19HlPi2A/0ZxlJJNa7U
	 YhjN/VW17tKBL+chhP4ARMHccJrtNQ9RMGzi9Eno=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 192AAF805FB;
	Thu, 31 Oct 2019 13:06:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6395FF8045D; Thu, 31 Oct 2019 13:04:25 +0100 (CET)
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 02E3BF803CF
 for <alsa-devel@alsa-project.org>; Thu, 31 Oct 2019 12:54:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 02E3BF803CF
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x9VBsJhE001978,
 This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCAS11.realtek.com.tw[172.21.6.12])
 by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x9VBsJhE001978
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 31 Oct 2019 19:54:19 +0800
Received: from localhost.localdomain (172.22.102.1) by
 RTITCAS11.realtek.com.tw (172.21.6.12) with Microsoft SMTP Server id
 14.3.468.0; Thu, 31 Oct 2019 19:54:17 +0800
From: <shumingf@realtek.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>
Date: Thu, 31 Oct 2019 19:54:14 +0800
Message-ID: <20191031115414.20951-1-shumingf@realtek.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-Originating-IP: [172.22.102.1]
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org,
 lars@metafoo.de, tzungbi@google.com, derek.fang@realtek.com,
 Shuming Fan <shumingf@realtek.com>, flove@realtek.com
Subject: [alsa-devel] [PATCH 2/5] ASoC: rt1011: improve the
	rt1011_set_dai_fmt() function
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

From: Shuming Fan <shumingf@realtek.com>

If there is a wrong format setting,
the driver will goto the end of the function directly.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt1011.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/rt1011.c b/sound/soc/codecs/rt1011.c
index 8a74f374d779..57a3a34b5f18 100644
--- a/sound/soc/codecs/rt1011.c
+++ b/sound/soc/codecs/rt1011.c
@@ -1631,6 +1631,7 @@ static int rt1011_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		break;
 	default:
 		ret = -EINVAL;
+		goto _set_fmt_err_;
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
@@ -1641,6 +1642,7 @@ static int rt1011_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		break;
 	default:
 		ret = -EINVAL;
+		goto _set_fmt_err_;
 	}
 
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
@@ -1657,6 +1659,7 @@ static int rt1011_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		break;
 	default:
 		ret = -EINVAL;
+		goto _set_fmt_err_;
 	}
 
 	switch (dai->id) {
@@ -1674,6 +1677,7 @@ static int rt1011_set_dai_fmt(struct snd_soc_dai *dai, unsigned int fmt)
 		ret = -EINVAL;
 	}
 
+_set_fmt_err_:
 	snd_soc_dapm_mutex_unlock(dapm);
 	return ret;
 }
-- 
2.23.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
