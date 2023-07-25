Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52D3AC00528
	for <alsa-devel@archiver.kernel.org>; Tue, 25 Jul 2023 06:49:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 79D97EA2;
	Tue, 25 Jul 2023 08:48:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 79D97EA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1690267764;
	bh=ghyByKwXwa+DtjZfl7PXeeAaasAr5BA7170VDRPYKHs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=sdqyA7MCN0SGvsk3tg8pzMhAndcfrWGRgs049G+V+Iy8xEezt23ZGPu4VqmLUJfMo
	 7z76Uk1j1su3dF2upH9xomL5XUC0m0/7LhmZ8oYMJCtmbF5fRRPBnnCDNmn13nYofH
	 Wf/n8cdnUYtTP7UAzv7IJq4OY9eRPFIgus+4qQDw=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 65050F805C2; Tue, 25 Jul 2023 08:46:53 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id D438FF805BE;
	Tue, 25 Jul 2023 08:46:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 15BF4F802E8; Tue, 25 Jul 2023 08:46:40 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EDDF6F802E8
	for <alsa-devel@alsa-project.org>; Tue, 25 Jul 2023 08:46:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EDDF6F802E8
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 966991A1629;
	Tue, 25 Jul 2023 08:46:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E4921A1618;
	Tue, 25 Jul 2023 08:46:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 799B01802183;
	Tue, 25 Jul 2023 14:46:23 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: hverkuil@xs4all.nl,
	sakari.ailus@iki.fi,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 6/7] ASoC: fsl_asrc: register m2m platform device
Date: Tue, 25 Jul 2023 14:12:19 +0800
Message-Id: <1690265540-25999-7-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Message-ID-Hash: TJPCY4WS2JRHQOX6UBRRJ6EUYGMJIFUT
X-Message-ID-Hash: TJPCY4WS2JRHQOX6UBRRJ6EUYGMJIFUT
X-MailFrom: shengjiu.wang@nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TJPCY4WS2JRHQOX6UBRRJ6EUYGMJIFUT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Register m2m platform device, that user can
use M2M feature.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/sound/fsl_asrc_common.h |  2 ++
 sound/soc/fsl/fsl_asrc.c        | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/sound/fsl_asrc_common.h b/include/sound/fsl_asrc_common.h
index 191302711ea6..0f3effa42308 100644
--- a/include/sound/fsl_asrc_common.h
+++ b/include/sound/fsl_asrc_common.h
@@ -69,6 +69,7 @@ struct fsl_asrc_pair {
  * @dma_params_rx: DMA parameters for receive channel
  * @dma_params_tx: DMA parameters for transmit channel
  * @pdev: platform device pointer
+ * @m2m_pdev: m2m platform device pointer
  * @regmap: regmap handler
  * @paddr: physical address to the base address of registers
  * @mem_clk: clock source to access register
@@ -102,6 +103,7 @@ struct fsl_asrc {
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct platform_device *pdev;
+	struct platform_device *m2m_pdev;
 	struct regmap *regmap;
 	unsigned long paddr;
 	struct clk *mem_clk;
diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 30190ccb74e7..0d1dfa30271e 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1198,6 +1198,7 @@ static int fsl_asrc_runtime_suspend(struct device *dev);
 static int fsl_asrc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct fsl_asrc_m2m_pdata m2m_pdata;
 	struct fsl_asrc_priv *asrc_priv;
 	struct fsl_asrc *asrc;
 	struct resource *res;
@@ -1380,6 +1381,12 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		goto err_pm_get_sync;
 	}
 
+	m2m_pdata.asrc = asrc;
+	asrc->m2m_pdev = platform_device_register_data(&pdev->dev,
+						       "fsl_asrc_m2m",
+						       PLATFORM_DEVID_AUTO,
+						       &m2m_pdata,
+						       sizeof(m2m_pdata));
 	return 0;
 
 err_pm_get_sync:
@@ -1392,6 +1399,11 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 
 static void fsl_asrc_remove(struct platform_device *pdev)
 {
+	struct fsl_asrc *asrc = dev_get_drvdata(&pdev->dev);
+
+	if (asrc->m2m_pdev && !IS_ERR(asrc->m2m_pdev))
+		platform_device_unregister(asrc->m2m_pdev);
+
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		fsl_asrc_runtime_suspend(&pdev->dev);
-- 
2.34.1

