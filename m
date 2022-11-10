Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534A7C433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Nov 2022 08:46:04 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF262163C;
	Thu, 10 Nov 2022 09:45:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF262163C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1668069962;
	bh=aDgmqR5773Sk4Y7HpsRFgHoXbbvdxLtj4VTajvJ4dGI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=FPKJtGkbPv71xkI0a0mqD8I99hRHdX1hIzTUSNbIKn+5WocGlA7g2RZITP6t3Z9mU
	 vF+xmamfV1/PFAtUrquDD0Qg+HFSanG7/pwwBP73rpU3AxFd76Vv99UyDdyo5ziQHf
	 ieRbic52eX/+/ongCwodyMjdV82v6FKfN6PV96B8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57741F80163;
	Thu, 10 Nov 2022 09:45:12 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id AF561F8021D; Thu, 10 Nov 2022 09:45:09 +0100 (CET)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [185.132.182.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 86A3DF80104
 for <alsa-devel@alsa-project.org>; Thu, 10 Nov 2022 09:45:03 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 86A3DF80104
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com
 header.b="yaRQfVwV"
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
 by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 2AA8bR7U012563; Thu, 10 Nov 2022 09:45:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=selector1;
 bh=6Q/BJ+yH7QNtYOt6tTbme4eART79NuYynx686HaXT/Y=;
 b=yaRQfVwVeQk7QcktjF14+F0Sr2bcE9eC7pmpb30bt5DaI+ZKFyXpFhAK6zE2/cPLaRl5
 9WjMzf0kLbgz1cJq+A452OmWwIgUbw+CKEcIvOaQOyYV+t5pgy0j+scRMlwDZhLJQf6z
 zz/l6erCH+deuF7D5r+LNN/YusDeOnpxTKRDKCSoKO59SnNcka333qxGiTBzaav7JWaA
 VbeQYAIAdJTgGJ9OOMzTNgrRzy85qR5jpI/4S1oxuLCNTrRON2P9DZ1OPfcbDrWomY3f
 QCjRs3+a7pMp+rOQ8lofgiHKKV/dCYl0rqezZJq5ifcPmfsq1bSdnmwskdB8FTidkTam Bg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
 by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3krwxyr223-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 10 Nov 2022 09:45:02 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
 by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0053010003A;
 Thu, 10 Nov 2022 09:44:56 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
 by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9BB3B20BE73;
 Thu, 10 Nov 2022 09:44:56 +0100 (CET)
Received: from localhost (10.211.13.61) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.32; Thu, 10 Nov
 2022 09:44:56 +0100
From: Olivier Moysan <olivier.moysan@foss.st.com>
To: Olivier Moysan <olivier.moysan@foss.st.com>, Arnaud Pouliquen
 <arnaud.pouliquen@foss.st.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH] ASoC: stm32: i2s: remove irqf_oneshot flag
Date: Thu, 10 Nov 2022 09:44:06 +0100
Message-ID: <20221110084406.287117-1-olivier.moysan@foss.st.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.211.13.61]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-10_06,2022-11-09_01,2022-06-22_01
Cc: alsa-devel@alsa-project.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

The IRQF_ONESHOT flag allows to ensure that the interrupt is not
unmasked after the hard interrupt context handler has been executed
and the thread has been woken. The interrupt line is unmasked after
the thread handler function has been executed.

The STM32 I2S driver does not implement a threaded IRQ handler.
So, the IRQF_ONESHOT flag is not useful in I2S driver.
Remove this flag to allow the interrupt routine to be managed
as a thread in RT mode.

Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
---
 sound/soc/stm/stm32_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index ce7f6942308f..f3dd9f8e621c 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -1077,7 +1077,7 @@ static int stm32_i2s_parse_dt(struct platform_device *pdev,
 	if (irq < 0)
 		return irq;
 
-	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, IRQF_ONESHOT,
+	ret = devm_request_irq(&pdev->dev, irq, stm32_i2s_isr, 0,
 			       dev_name(&pdev->dev), i2s);
 	if (ret) {
 		dev_err(&pdev->dev, "irq request returned %d\n", ret);
-- 
2.25.1

