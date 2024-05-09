Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B01C10F1A
	for <alsa-devel@archiver.kernel.org>; Thu,  9 May 2024 03:20:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C78DC843;
	Thu,  9 May 2024 05:20:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C78DC843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1715224818;
	bh=VGDmCzZ+i4TZSCedBs+r4B2MJ2hukWvZ1niBtixa1e4=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=ZDnArLqa/dIB/OwFrfX347FZZvuGHCvpCHofET3yIKvJ7tpoKXdoMHAi51Tj19LXs
	 vysgRgm1YeU42jTQNFzmEXOv8wtS7NalymDO52YOqCfJm4vP60r8IjVhzbZOBbdOL2
	 Bze0xk5gf2k1H2r/nooiDzMyl1e1Sai5YDIDPNkI=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 59BF9F80618; Thu,  9 May 2024 05:19:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id A0ACAF8060F;
	Thu,  9 May 2024 05:19:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0DCFAF805ED; Thu,  9 May 2024 05:18:57 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EB44EF8049C
	for <alsa-devel@alsa-project.org>; Thu,  9 May 2024 05:18:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB44EF8049C
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 90A97200AA9;
	Thu,  9 May 2024 05:18:42 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 456D42007D5;
	Thu,  9 May 2024 05:18:42 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 2B099181D0FC;
	Thu,  9 May 2024 11:18:40 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 3/4] ASoC: fsl_xcvr: Support reparent pll clocks for phy_clk
Date: Thu,  9 May 2024 10:57:39 +0800
Message-Id: <1715223460-32662-4-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
References: <1715223460-32662-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Message-ID-Hash: 7T3R2I2HTAYDGFU3VIWUOHS5C3CAJJ5X
X-Message-ID-Hash: 7T3R2I2HTAYDGFU3VIWUOHS5C3CAJJ5X
X-MailFrom: shengjiu.wang@nxp.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/7T3R2I2HTAYDGFU3VIWUOHS5C3CAJJ5X/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

When there are 'pll8k' and 'pll11k' clock existing, the clock
source of 'phy_clk' can be changed for different sample rate
requirement.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_xcvr.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/fsl/fsl_xcvr.c b/sound/soc/fsl/fsl_xcvr.c
index c46f64557a7f..0ffa10e924ef 100644
--- a/sound/soc/fsl/fsl_xcvr.c
+++ b/sound/soc/fsl/fsl_xcvr.c
@@ -15,6 +15,7 @@
 #include <sound/pcm_params.h>
 
 #include "fsl_xcvr.h"
+#include "fsl_utils.h"
 #include "imx-pcm.h"
 
 #define FSL_XCVR_CAPDS_SIZE	256
@@ -33,6 +34,8 @@ struct fsl_xcvr {
 	struct clk *pll_ipg_clk;
 	struct clk *phy_clk;
 	struct clk *spba_clk;
+	struct clk *pll8k_clk;
+	struct clk *pll11k_clk;
 	struct reset_control *reset;
 	u8 streams;
 	u32 mode;
@@ -362,6 +365,8 @@ static int fsl_xcvr_en_aud_pll(struct fsl_xcvr *xcvr, u32 freq)
 
 	freq = xcvr->soc_data->spdif_only ? freq / 5 : freq;
 	clk_disable_unprepare(xcvr->phy_clk);
+	fsl_asoc_reparent_pll_clocks(dev, xcvr->phy_clk,
+				     xcvr->pll8k_clk, xcvr->pll11k_clk, freq);
 	ret = clk_set_rate(xcvr->phy_clk, freq);
 	if (ret < 0) {
 		dev_err(dev, "Error while setting AUD PLL rate: %d\n", ret);
@@ -1287,6 +1292,9 @@ static int fsl_xcvr_probe(struct platform_device *pdev)
 		return PTR_ERR(xcvr->pll_ipg_clk);
 	}
 
+	fsl_asoc_get_pll_clocks(dev, &xcvr->pll8k_clk,
+				&xcvr->pll11k_clk);
+
 	xcvr->ram_addr = devm_platform_ioremap_resource_byname(pdev, "ram");
 	if (IS_ERR(xcvr->ram_addr))
 		return PTR_ERR(xcvr->ram_addr);
-- 
2.34.1

