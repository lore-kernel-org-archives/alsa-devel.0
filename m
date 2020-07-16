Return-Path: <SRS0=SelE=A3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF854C433EB
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:24:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7E22065E
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jul 2020 17:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="IG/zN/qj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7E22065E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EB4D91660;
	Thu, 16 Jul 2020 19:23:58 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EB4D91660
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594920289;
	bh=ooPKUA5o6Rm896RN6LwBwXCYlHsVUM6NORO0UpGLL1M=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IG/zN/qjfwK7w19zlo2BAaEeVx2vtFk6EpyR58316XCuwti2jOGfglvTYU3ZchJmX
	 QEeqWPhVGHvHzfjdLcVLr8dC6iSm+zHsyxBOrm7oPOFrYOOumARb9wF9hEboqKnuWH
	 5eaLVHOhoHEKH2hzoc5TE5uGWf/7riFkWTdvIHGs=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3599AF80304;
	Thu, 16 Jul 2020 19:19:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 76098F80306; Thu, 16 Jul 2020 19:19:33 +0200 (CEST)
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
 [210.160.252.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 4C974F802F9
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2020 19:19:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4C974F802F9
X-IronPort-AV: E=Sophos;i="5.75,360,1589209200"; d="scan'208";a="52107209"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
 by relmlie6.idc.renesas.com with ESMTP; 17 Jul 2020 02:19:25 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
 by relmlir6.idc.renesas.com (Postfix) with ESMTP id 0A76740B55DE;
 Fri, 17 Jul 2020 02:19:19 +0900 (JST)
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
Subject: [PATCH 08/20] dt-bindings: usb: usb-xhci: Document r8a774e1 support
Date: Thu, 16 Jul 2020 18:18:23 +0100
Message-Id: <1594919915-5225-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Document r8a774e1 xhci support. The driver will use the fallback
compatible string "renesas,rcar-gen3-xhci", therefore no driver
change is needed.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
---
 Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
index b120dd6612a2..df91a0bb1eeb 100644
--- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
+++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
@@ -13,6 +13,7 @@ Required properties:
     - "renesas,xhci-r8a774a1" for r8a774a1 SoC
     - "renesas,xhci-r8a774b1" for r8a774b1 SoC
     - "renesas,xhci-r8a774c0" for r8a774c0 SoC
+    - "renesas,xhci-r8a774e1" for r8a774e1 SoC
     - "renesas,xhci-r8a7790" for r8a7790 SoC
     - "renesas,xhci-r8a7791" for r8a7791 SoC
     - "renesas,xhci-r8a7793" for r8a7793 SoC
-- 
2.17.1

