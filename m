Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F617C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 10 Jun 2022 06:03:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A9FA02229;
	Fri, 10 Jun 2022 08:02:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A9FA02229
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654841015;
	bh=H32E54ZU9PUbCRyODIdStRk4/T+fCmAwQ3IqJzbdo9w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HxAQqXNBLL1bWZd/p21Pr/SxhMUtDRr9oipF28X2mwm5zOPBEvR3FQ6ctWMaBNWms
	 /QJmj9q9Mh/i3WRpspuzzti7ZzJ3riKlS6mUF2jnZL+UtFeSjgY9n1MzT7YJHvlUtd
	 DuNana0wHfTBt5uA7lCimo1w8fyxjb197SBtBnno=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 595D5F804CF;
	Fri, 10 Jun 2022 08:02:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 55331F804D2; Fri, 10 Jun 2022 08:02:43 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BB960F800C7
 for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2022 08:01:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BB960F800C7
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3EE3F1A00BF;
 Fri, 10 Jun 2022 08:01:16 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EB9501A005B;
 Fri, 10 Jun 2022 08:01:15 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 8217D1802202;
 Fri, 10 Jun 2022 14:01:14 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
 shengjiu.wang@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 robh+dt@kernel.org, krzk+dt@kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 2/2] ASoC: fsl_mqs: Add support for i.MX93 platform
Date: Fri, 10 Jun 2022 13:47:22 +0800
Message-Id: <1654840042-7069-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1654840042-7069-1-git-send-email-shengjiu.wang@nxp.com>
References: <1654840042-7069-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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

Add i.MX93 compatible string and specific soc data

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl_mqs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/sound/soc/fsl/fsl_mqs.c b/sound/soc/fsl/fsl_mqs.c
index 8a8d727319d6..aefb73cab59c 100644
--- a/sound/soc/fsl/fsl_mqs.c
+++ b/sound/soc/fsl/fsl_mqs.c
@@ -338,9 +338,23 @@ static const struct fsl_mqs_soc_data fsl_mqs_imx6sx_data = {
 	.div_shift = IMX6SX_GPR2_MQS_CLK_DIV_SHIFT,
 };
 
+static const struct fsl_mqs_soc_data fsl_mqs_imx93_data = {
+	.use_gpr = true,
+	.ctrl_off = 0x20,
+	.en_mask  = BIT(1),
+	.en_shift = 1,
+	.rst_mask = BIT(2),
+	.rst_shift = 2,
+	.osr_mask = BIT(3),
+	.osr_shift = 3,
+	.div_mask = GENMASK(15, 8),
+	.div_shift = 8,
+};
+
 static const struct of_device_id fsl_mqs_dt_ids[] = {
 	{ .compatible = "fsl,imx8qm-mqs", .data = &fsl_mqs_imx8qm_data },
 	{ .compatible = "fsl,imx6sx-mqs", .data = &fsl_mqs_imx6sx_data },
+	{ .compatible = "fsl,imx93-mqs", .data = &fsl_mqs_imx93_data },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_mqs_dt_ids);
-- 
2.17.1

