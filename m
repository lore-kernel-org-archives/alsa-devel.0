Return-Path: <SRS0=ac5z=QE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 461C7C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Nov 2021 10:45:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D446321B
	for <alsa-devel@archiver.kernel.org>; Wed, 17 Nov 2021 10:45:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 17D446321B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=foss.st.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B2E2A17E5;
	Wed, 17 Nov 2021 11:45:02 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B2E2A17E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637145952;
	bh=7USELQ1Jz9ySZXP6kFnSbeVLlpvGJcIRkovjeRds9HM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=X1EVCHSm1I0BB04S0bdfqhshxRfZuqPnnk1QVdrFxZDv2HNp++P9DfBzQhidrAvNu
	 bmQTRGUAE3KttCs1djSsPfgjf7MARUCnxJiZ2P9BRu6ry9UHe9EnlEf3sxHM5u+T+I
	 i6IF/iv7pHbDHgWE3K6UIYLbu3hMELnEFkJVUBh4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06C2FF80134;
	Wed, 17 Nov 2021 11:45:01 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 08F8FF8027D; Wed, 17 Nov 2021 11:45:00 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4ABF6F80134
 for <alsa-devel@alsa-project.org>; Wed, 17 Nov 2021 11:44:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4ABF6F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com
 header.b="Is+BCHvc"
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AH9HK1g024792;
 Wed, 17 Nov 2021 11:44:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=selector1;
 bh=6pg6K8gBh2cerBYz6mBDWC+nZHXKNeCSWupwbJmZ6RQ=;
 b=Is+BCHvc2dH6/lwryIQIMXmbes8Z35xUOTPUWzxzZx6DNH8QUbYaviJACApf+1Hmkulm
 m0Bstjgov1gMU6NIlyYvMf3pvrhsaDOdVLrmHc7PD0ym1Tj9RU2YKUU3YkMtsPMwJ5iJ
 qCPl5HN+2v2mJ3q3LH0tkXGNkos1Le5jqjKXZg4FlJXmnP/FHBcWzZwlLr1cG4RGpT3i
 BvfbNBTQs27QWLodi4BqEnswCO4YY7OJNKnJmfVQKebnKUVON8Ol4NIDRtvq17CDHN1G
 ySdXcqznaAPAN6B8AlmKg3NgfdIgQt+hYFwXJ6PRmqZfgY6sz/Zo/2MXjNRtvwXP9F1/ 1Q== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3ccxypgkmy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 17 Nov 2021 11:44:49 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6CA6610002A;
 Wed, 17 Nov 2021 11:44:48 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2A51E209300;
 Wed, 17 Nov 2021 11:44:48 +0100 (CET)
Received: from localhost (10.75.127.44) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 17 Nov 2021 11:44:47
 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Arnaud Pouliquen
 <arnaud.pouliquen@foss.st.com>, Jaroslav Kysela <perex@perex.cz>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Takashi Iwai <tiwai@suse.com>
Subject: [PATCH] ASoC: stm32: i2s: fix 32 bits channel length without mclk
Date: Wed, 17 Nov 2021 11:44:04 +0100
Message-ID: <20211117104404.3832-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-17_03,2021-11-17_01,2020-04-07_01
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com
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

Fix divider calculation in the case of 32 bits channel
configuration, when no master clock is used.

Fixes: e4e6ec7b127c ("ASoC: stm32: Add I2S driver")

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 sound/soc/stm/stm32_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 6254bacad6eb..717f45a83445 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -700,7 +700,7 @@ static int stm32_i2s_configure_clock(struct snd_soc_dai *cpu_dai,
 		if (ret < 0)
 			return ret;
 
-		nb_bits = frame_len * ((cgfr & I2S_CGFR_CHLEN) + 1);
+		nb_bits = frame_len * (FIELD_GET(I2S_CGFR_CHLEN, cgfr) + 1);
 		ret = stm32_i2s_calc_clk_div(i2s, i2s_clock_rate,
 					     (nb_bits * rate));
 		if (ret)
-- 
2.17.1

