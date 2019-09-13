Return-Path: <SRS0=rTHd=XI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B7CC49ED7
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:44:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E29C2081B
	for <alsa-devel@archiver.kernel.org>; Fri, 13 Sep 2019 09:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IEqzU2br"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E29C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C58071669;
	Fri, 13 Sep 2019 11:43:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C58071669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1568367864;
	bh=f+H40A8MEr15qnzIgsRCEF0Yh12TUhKOeaoNwCoDr9Y=;
	h=From:To:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=IEqzU2brKjpHn4diijqtTQQLoS1qRZuyeLw8t1+mrO/ZDeNK8DEsfaiXz8JTuxqB6
	 SDYP0TXv3w5hmnAcIHtoCdxuNqiIkjTA5GrYoHrBtpQVNdYeNVKnZRfvFGoNecgFI3
	 cYwUaGx14hjGf7GKm+fm6e3+0RdfbWDS7jRdWP8g=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC2B9F8036A;
	Fri, 13 Sep 2019 11:43:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8F0FBF804CF; Fri, 13 Sep 2019 11:43:32 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 17C6CF801EC
 for <alsa-devel@alsa-project.org>; Fri, 13 Sep 2019 11:43:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 17C6CF801EC
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B011820017C;
 Fri, 13 Sep 2019 11:43:27 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com
 [165.114.16.14])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6B9B62000E2;
 Fri, 13 Sep 2019 11:43:21 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net
 [10.192.224.44])
 by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 88E7140296;
 Fri, 13 Sep 2019 17:43:13 +0800 (SGT)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: timur@kernel.org, nicoleotsuka@gmail.com, Xiubo.Lee@gmail.com,
 festevam@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Date: Fri, 13 Sep 2019 17:42:13 +0800
Message-Id: <65e1f035aea2951aacda54aa3a751bc244f72f6a.1568367274.git.shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Subject: [alsa-devel] [PATCH V2 1/2] ASoC: fsl_mqs: add DT binding
	documentation
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

Add the DT binding documentation for NXP MQS driver

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
Changes in v2
-refine the comments for properties

 .../devicetree/bindings/sound/fsl,mqs.txt     | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/fsl,mqs.txt

diff --git a/Documentation/devicetree/bindings/sound/fsl,mqs.txt b/Documentation/devicetree/bindings/sound/fsl,mqs.txt
new file mode 100644
index 000000000000..40353fc30255
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/fsl,mqs.txt
@@ -0,0 +1,36 @@
+fsl,mqs audio CODEC
+
+Required properties:
+  - compatible : Must contain one of "fsl,imx6sx-mqs", "fsl,codec-mqs"
+		"fsl,imx8qm-mqs", "fsl,imx8qxp-mqs".
+  - clocks : A list of phandles + clock-specifiers, one for each entry in
+	     clock-names
+  - clock-names : "mclk" - must required.
+		  "core" - required if compatible is "fsl,imx8qm-mqs", it
+		           is for register access.
+  - gpr : A phandle of General Purpose Registers in IOMUX Controller.
+	  Required if compatible is "fsl,imx6sx-mqs".
+
+Required if compatible is "fsl,imx8qm-mqs":
+  - power-domains: A phandle of PM domain provider node.
+  - reg: Offset and length of the register set for the device.
+
+Example:
+
+mqs: mqs {
+	compatible = "fsl,imx6sx-mqs";
+	gpr = <&gpr>;
+	clocks = <&clks IMX6SX_CLK_SAI1>;
+	clock-names = "mclk";
+	status = "disabled";
+};
+
+mqs: mqs@59850000 {
+	compatible = "fsl,imx8qm-mqs";
+	reg = <0x59850000 0x10000>;
+	clocks = <&clk IMX8QM_AUD_MQS_IPG>,
+		 <&clk IMX8QM_AUD_MQS_HMCLK>;
+	clock-names = "core", "mclk";
+	power-domains = <&pd_mqs0>;
+	status = "disabled";
+};
-- 
2.21.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
