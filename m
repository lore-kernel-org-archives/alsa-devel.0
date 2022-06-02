Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C75C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jun 2022 07:19:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D47A51739;
	Thu,  2 Jun 2022 09:18:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D47A51739
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654154386;
	bh=YnYk3jBVATGtUqWazW4COkkGNWpgLs90RPVbRbNohwg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=GzXyIAc1wowvYaQg9OXt7mc34U3hCo8YDI93X1cf/XnLewgqbYL4R1x3gHxzDnP60
	 XKG9wAv4MGTJcLiDMYLH9QXSCY/7iXsNBBHMbJ2ZpuFLDE+JIyXgbiX+an0Y9tmdM/
	 wLyU8GqMkmWeoVfOH6sovVU6JOgcEjzmRgnt4+m4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1E9C3F80272;
	Thu,  2 Jun 2022 09:18:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EFD1CF80425; Thu,  2 Jun 2022 09:18:40 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E6BFAF80149
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2022 09:18:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E6BFAF80149
Received: from kwepemi100013.china.huawei.com (unknown [172.30.72.55])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LDHPq3DzZzgYlg;
 Thu,  2 Jun 2022 15:16:47 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (7.193.23.54) by
 kwepemi100013.china.huawei.com (7.221.188.136) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 2 Jun 2022 15:18:28 +0800
Received: from huawei.com (10.90.53.225) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 2 Jun
 2022 15:18:28 +0800
From: zhangqilong <zhangqilong3@huawei.com>
To: <shengjiu.wang@gmail.com>, <Xiubo.Lee@gmail.com>, <perex@perex.cz>,
 <tiwai@suse.com>
Subject: [PATCH V4] ASoC: fsl_xcvr:Fix unbalanced pm_runtime_enable in
 fsl_xcvr_probe
Date: Thu, 2 Jun 2022 15:20:24 +0800
Message-ID: <20220602072024.33236-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600014.china.huawei.com (7.193.23.54)
X-CFilter-Loop: Reflected
Cc: alsa-devel@alsa-project.org, festevam@gmail.com, lgirdwood@gmail.com,
 nicoleotsuka@gmail.com, broonie@kernel.org, linuxppc-dev@lists.ozlabs.org
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

a) Add missing pm_runtime_disable() when probe error out. It could
avoid pm_runtime implementation complains when removing and probing
again the driver.
b) Add remove for missing pm_runtime_disable().

Fix:c590fa80b3928 ("ASoC: fsl_xcvr: register platform component before registering cpu dai")
Signed-off-by: Zhang Qilong <zhangqilong3@huawei.com>
---
v2:
- Add remove to put PM usage counter.

v3:
- Modify the commit message.
---
 sound/soc/fsl/fsl_xcvr.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index d0556c79fdb1..55e640cba87d 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -1228,6 +1228,7 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 	 */
 	ret = devm_snd_dmaengine_pcm_register(dev, NULL, 0);
 	if (ret) {
+		pm_runtime_disable(dev);
 		dev_err(dev, "failed to pcm register\n");
 		return ret;
 	}
@@ -1235,6 +1236,7 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 	ret = devm_snd_soc_register_component(dev, &fsl_xcvr_comp,
 					      &fsl_xcvr_dai, 1);
 	if (ret) {
+		pm_runtime_disable(dev);
 		dev_err(dev, "failed to register component %s\n",
 			fsl_xcvr_comp.name);
 	}
@@ -1242,6 +1244,12 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int fsl_xcvr_remove(struct platform_device *pdev)
+{
+	pm_runtime_disable(&pdev->dev);
+	return 0;
+}
+
 static __maybe_unused int fsl_xcvr_runtime_suspend(struct device *dev)
 {
 	struct fsl_xcvr *xcvr = dev_get_drvdata(dev);
@@ -1370,6 +1378,7 @@ static struct platform_driver fsl_xcvr_driver = {
 		.pm = &fsl_xcvr_pm_ops,
 		.of_match_table = fsl_xcvr_dt_ids,
 	},
+	.remove = fsl_xcvr_remove,
 };
 module_platform_driver(fsl_xcvr_driver);
 
-- 
2.31.1

