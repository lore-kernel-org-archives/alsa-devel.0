Return-Path: <SRS0=ik9t=YS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DA5ECA9EBD
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:05:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5862084C
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 13:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pzOKuMqt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h+WU6R17"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5862084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E193C17C8;
	Fri, 25 Oct 2019 15:04:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E193C17C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572008727;
	bh=kN0Nc9POSTcAdfsjgk4QFJMdxtRcjnV3laSl3kSFlh8=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=pzOKuMqtpj05JkGobHMtXNKzcZBbSwcS1WQhSsAZXPUaOPe9aTNtElRhYKvgyIM5Y
	 JOm8mPhXLzbtgL1PaSEy3EVQut02uxo+00obBHVwHPtBocnnnK2c1a7GYWWXBtttxS
	 X5Knj92VxZ4xUzjrmtiop5OGT5nI1na6mDT2/trI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 7F81CF802A0;
	Fri, 25 Oct 2019 15:04:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 151C2F80368; Fri, 25 Oct 2019 15:04:35 +0200 (CEST)
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5BB96F80112
 for <alsa-devel@alsa-project.org>; Fri, 25 Oct 2019 15:04:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5BB96F80112
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="h+WU6R17"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x9PD4Sdu038853;
 Fri, 25 Oct 2019 08:04:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1572008668;
 bh=P8Jbxp8qjaqsqyxiwg7v1ZgSDea+4jE9jJMRCXAvkR8=;
 h=From:To:CC:Subject:Date;
 b=h+WU6R17jWYt97uthCjwtEBlE6p9TDWiUn3OhVRcJ3b/kYR65sxmZDdlWORQo8q46
 1Pz4yw3CEalTdcYUTkkCDUK9N9GUnMPW++/eGhl+RX3DK/NatL4M4Co+JjacXMl6p4
 rH640bY7xGvpas4sudRPlgzFDuFBOwYoYKslfEpI=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x9PD4SWD082929
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 25 Oct 2019 08:04:28 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Fri, 25
 Oct 2019 08:04:17 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Fri, 25 Oct 2019 08:04:17 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
 by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x9PD4PfJ092315;
 Fri, 25 Oct 2019 08:04:25 -0500
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
To: <broonie@kernel.org>, <lgirdwood@gmail.com>, <jarkko.nikula@bitmer.com>
Date: Fri, 25 Oct 2019 16:05:28 +0300
Message-ID: <20191025130528.3556-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Cc: tony@atomide.com, hns@goldelico.com, alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH v2] ASoC: ti: omap-mcpdm: Add support for
	pdmclk clock handling
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

McPDM module receives it's functional clock from external source. This
clock is the pdmclk provided by the twl6040 audio IC. If the clock is not
available all register accesses to McPDM fails and the module is not
operational.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Jarkko Nikula <jarkko.nikula@bitmer.com>
---
Hi,

this has been lurking in my next-wip branch for some time...
It might not needed anymore as I have not heard about issues with McPDM for a
while.

It was dropped back then because some core parts were not picked in time and
this caused some issues, but can not find the exact reason

Regards,
Peter

 sound/soc/ti/omap-mcpdm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/soc/ti/omap-mcpdm.c b/sound/soc/ti/omap-mcpdm.c
index b8c8290265c7..2c536947b69f 100644
--- a/sound/soc/ti/omap-mcpdm.c
+++ b/sound/soc/ti/omap-mcpdm.c
@@ -17,6 +17,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/clk.h>
 #include <linux/slab.h>
 #include <linux/pm_runtime.h>
 #include <linux/of_device.h>
@@ -42,6 +43,7 @@ struct omap_mcpdm {
 	int irq;
 	struct pm_qos_request pm_qos_req;
 	int latency[2];
+	struct clk *pdmclk;
 
 	struct mutex mutex;
 
@@ -416,6 +418,10 @@ static int omap_mcpdm_probe(struct snd_soc_dai *dai)
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
+	ret = clk_prepare_enable(mcpdm->pdmclk);
+	if (ret)
+		return ret;
+
 	pm_runtime_enable(mcpdm->dev);
 
 	/* Disable lines while request is ongoing */
@@ -454,6 +460,7 @@ static int omap_mcpdm_remove(struct snd_soc_dai *dai)
 	if (pm_qos_request_active(&mcpdm->pm_qos_req))
 		pm_qos_remove_request(&mcpdm->pm_qos_req);
 
+	clk_disable_unprepare(mcpdm->pdmclk);
 	return 0;
 }
 
@@ -473,12 +480,19 @@ static int omap_mcpdm_suspend(struct snd_soc_dai *dai)
 		mcpdm->pm_active_count++;
 	}
 
+	clk_disable_unprepare(mcpdm->pdmclk);
+
 	return 0;
 }
 
 static int omap_mcpdm_resume(struct snd_soc_dai *dai)
 {
 	struct omap_mcpdm *mcpdm = snd_soc_dai_get_drvdata(dai);
+	int ret;
+
+	ret = clk_prepare_enable(mcpdm->pdmclk);
+	if (ret)
+		return ret;
 
 	if (mcpdm->pm_active_count) {
 		while (mcpdm->pm_active_count--)
@@ -573,6 +587,15 @@ static int asoc_mcpdm_probe(struct platform_device *pdev)
 
 	mcpdm->dev = &pdev->dev;
 
+	mcpdm->pdmclk = devm_clk_get(&pdev->dev, "pdmclk");
+	if (IS_ERR(mcpdm->pdmclk)) {
+		if (PTR_ERR(mcpdm->pdmclk) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+		dev_warn(&pdev->dev, "Error getting pdmclk (%ld)!\n",
+			 PTR_ERR(mcpdm->pdmclk));
+		mcpdm->pdmclk = NULL;
+	}
+
 	ret =  devm_snd_soc_register_component(&pdev->dev,
 					       &omap_mcpdm_component,
 					       &omap_mcpdm_dai, 1);
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
