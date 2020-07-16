Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE95C43446
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:23:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD45420657
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="f6k80jJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD45420657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 42AFC165E;
	Thu, 16 Jul 2020 19:23:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 42AFC165E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594920230;
	bh=998cjcBdQDu4FsUt2cqstkDDg4GMwoMNGAXX+tGlOtA=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=f6k80jJaHrjtw9P2hRjv7Ad/Aq6ISFSuaZ+bRqxdb9HXNYjVg7cYVt5yg8EDGlXTL
	 YBqhJVvK06GPDjNbK4WKGfsrcV0PaC0wfS394xNlVCGfzOLR1b75uYA2iPzwv0Te8F
	 4aJsPqYgdnQxekkKqW73Tgp8r20WbHqtdzTD2VK0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6E93F802F7;
	Thu, 16 Jul 2020 19:19:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC09FF802F7; Thu, 16 Jul 2020 19:19:17 +0200 (CEST)
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
 [210.160.252.171])
 by alsa1.perex.cz (Postfix) with ESMTP id 9CC07F802E8
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 19:19:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9CC07F802E8
X-IronPort-AV: E=Sophos;i="5.75,360,1589209200"; d="scan'208";a="52318924"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie5.idc.renesas.com with ESMTP; 17 Jul 2020 02:19:14 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 23F5940B55DE;
 Fri, 17 Jul 2020 02:19:08 +0900 (JST)
From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Jens Axboe <axboe@kernel.dk>,
 Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Marek Vasut <marek.vasut+renesas@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Mark Brown <broonie@kernel.org>, Niklas <niklas.soderlund@ragnatech.se>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@ti.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Magnus Damm <magnus.damm@gmail.com>, devicetree@vger.kernel.org
Subject: [PATCH 06/20] arm64: dts: renesas: r8a774e1: Add USB2.0 phy and host
 (EHCI/OHCI) device nodes
Date: Thu, 16 Jul 2020 18:18:21 +0100
Message-Id: <1594919915-5225-7-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <1594919915-5225-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: alsa-devel@alsa-project.org, linux-pci@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-renesas-soc@vger.kernel.org, linux-ide@vger.kernel.org,
 Prabhakar <prabhakar.csengg@gmail.com>, linux-i2c@vger.kernel.org,
 dmaengine@vger.kernel.org, linux-media@vger.kernel.org
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

Add USB2.0 phy and host (EHCI/OHCI) device nodes on RZ/G2H SoC dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774e1.dtsi | 55 ++++++++++++++++++-----
 1 file changed, 43 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
index 4cd67f360cc0..6f5f82492cee 100644
--- a/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774e1.dtsi
@@ -1406,45 +1406,76 @@
 		};
 
 		ohci0: usb@ee080000 {
+			compatible = "generic-ohci";
 			reg = <0 0xee080000 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
+			phys = <&usb2_phy0 1>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		ohci1: usb@ee0a0000 {
+			compatible = "generic-ohci";
 			reg = <0 0xee0a0000 0 0x100>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1 1>;
+			phy-names = "usb";
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		ehci0: usb@ee080100 {
+			compatible = "generic-ehci";
 			reg = <0 0xee080100 0 0x100>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
+			phys = <&usb2_phy0 2>;
+			phy-names = "usb";
+			companion = <&ohci0>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 703>, <&cpg 704>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		ehci1: usb@ee0a0100 {
+			compatible = "generic-ehci";
 			reg = <0 0xee0a0100 0 0x100>;
+			interrupts = <GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 702>;
+			phys = <&usb2_phy1 2>;
+			phy-names = "usb";
+			companion = <&ohci1>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		usb2_phy0: usb-phy@ee080200 {
+			compatible = "renesas,usb2-phy-r8a774e1",
+				     "renesas,rcar-gen3-usb2-phy";
 			reg = <0 0xee080200 0 0x700>;
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 703>, <&cpg CPG_MOD 704>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 703>, <&cpg 704>;
+			#phy-cells = <1>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		usb2_phy1: usb-phy@ee0a0200 {
+			compatible = "renesas,usb2-phy-r8a774e1",
+				     "renesas,rcar-gen3-usb2-phy";
 			reg = <0 0xee0a0200 0 0x700>;
+			clocks = <&cpg CPG_MOD 702>;
+			power-domains = <&sysc R8A774E1_PD_ALWAYS_ON>;
+			resets = <&cpg 702>;
+			#phy-cells = <1>;
 			status = "disabled";
-
-			/* placeholder */
 		};
 
 		sdhi0: sd@ee100000 {
-- 
2.17.1

