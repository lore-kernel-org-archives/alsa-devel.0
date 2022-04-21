Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C2F2C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 21 Apr 2022 05:13:33 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 28F2A1DE7;
	Thu, 21 Apr 2022 07:12:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 28F2A1DE7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1650518011;
	bh=/f7tvFFs8fqs07+xKFKbZrGTZqcY2cT8P/BuGuSQzEM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=AN7BYFTNRuT2oQmi4OIGUl7EeM6n7BGzgSwfOY5MmNDAGThOvAAh68Ef1BHEuvEYE
	 iMOATkxpzhnd7uOjfLJ9hBRHsAUcloUf93nDxPbYLFt1qD4WOKxzuJcxd6gz+D202g
	 ybcEehNOI1R6ZKJlnxjK29dCmzCzF/2PIREQOa+w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 45809F804DA;
	Thu, 21 Apr 2022 04:45:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 895C4F804F1; Thu, 21 Apr 2022 04:45:34 +0200 (CEST)
Received: from mail.meizu.com (edge05.meizu.com [157.122.146.251])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F0A9EF804C1
 for <alsa-devel@alsa-project.org>; Thu, 21 Apr 2022 04:45:27 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F0A9EF804C1
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail12.meizu.com
 (172.16.1.108) with Microsoft SMTP Server (TLS) id 14.3.487.0; Thu, 21 Apr
 2022 10:45:24 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Thu, 21 Apr
 2022 10:45:22 +0800
From: Haowen Bai <baihaowen@meizu.com>
To: Shengjiu Wang <shengjiu.wang@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Fabio Estevam <festevam@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, "Pengutronix
 Kernel Team" <kernel@pengutronix.de>, NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH] ASoC: imx-hdmi: remove useless null check before call
 of_node_put()
Date: Thu, 21 Apr 2022 10:45:20 +0800
Message-ID: <1650509120-25377-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org,
 Haowen Bai <baihaowen@meizu.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

No need to add null check before call of_node_put(), since the
implementation of of_node_put() has done it.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 sound/soc/fsl/imx-hdmi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/fsl/imx-hdmi.c b/sound/soc/fsl/imx-hdmi.c
index e10136afa741..2ae1a889c68d 100644
--- a/sound/soc/fsl/imx-hdmi.c
+++ b/sound/soc/fsl/imx-hdmi.c
@@ -206,8 +206,7 @@ static int imx_hdmi_probe(struct platform_device *pdev)
 	}
 
 fail:
-	if (cpu_np)
-		of_node_put(cpu_np);
+	of_node_put(cpu_np);
 
 	return ret;
 }
-- 
2.7.4

