Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3245EC4332F
	for <alsa-devel@archiver.kernel.org>; Thu, 24 Nov 2022 05:58:34 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 31E4E16E8;
	Thu, 24 Nov 2022 06:57:42 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 31E4E16E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669269512;
	bh=PkaX/hCGwuAwSuBQQJYYpwL96/ix3QXdgk5qRBflZcc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CMr1vg5H7X3/eHTSgNQhAM+piFLoQOBwRqcvpTap1eTdnxkGIfwTk0pOLa8QkCMVc
	 YbIO+WbQ7YbY7IruubzOkqdaxg+gh/kHewMWlaKbq3a5r3SlEVwMrvr0uH4tVPYwqz
	 rSjxWIjIQpedBJSU5coaaeLDVSzbdAG3G4hI4y3A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E9BCFF80448;
	Thu, 24 Nov 2022 06:57:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D6D25F80431; Thu, 24 Nov 2022 06:57:17 +0100 (CET)
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa1.perex.cz (Postfix) with ESMTP id 8144EF80149
 for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2022 06:57:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8144EF80149
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
 by maillog.nuvoton.com (Postfix) with ESMTP id 7F7101C80FF5;
 Thu, 24 Nov 2022 13:57:05 +0800 (CST)
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.7; Thu, 24 Nov
 2022 13:57:05 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 24 Nov 2022 13:57:05 +0800
From: David Lin <CTLIN0@nuvoton.com>
To: <broonie@kernel.org>
Subject: [PATCH 2/2] ASoC: dt-bindings: add compatible string for NAU8318
Date: Thu, 24 Nov 2022 13:56:58 +0800
Message-ID: <20221124055658.53828-2-CTLIN0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124055658.53828-1-CTLIN0@nuvoton.com>
References: <20221124055658.53828-1-CTLIN0@nuvoton.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, ctlin0.linux@gmail.com, WTLI@nuvoton.com,
 SJLIN0@nuvoton.com, KCHSU0@nuvoton.com, lgirdwood@gmail.com,
 YHCHuang@nuvoton.com, David Lin <CTLIN0@nuvoton.com>
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

The audio amplifier NAU8318 is almost functionally identical to NAU8315.
Adds compatible string "nuvoton,nau8318" for driver reuse.

Signed-off-by: David Lin <CTLIN0@nuvoton.com>
---
 Documentation/devicetree/bindings/sound/nau8315.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nau8315.txt b/Documentation/devicetree/bindings/sound/nau8315.txt
index 6eaec46f384c..1cd94517d45e 100644
--- a/Documentation/devicetree/bindings/sound/nau8315.txt
+++ b/Documentation/devicetree/bindings/sound/nau8315.txt
@@ -2,6 +2,7 @@ Nuvoton NAU8315 Mono Class-D Amplifier
 
 Required properties:
 - compatible   : "nuvoton,nau8315"
+                 "nuvoton,nau8318"
 
 Optional properties:
 - enable-gpios : GPIO specifier for the chip's device enable input(EN) pin.
@@ -16,3 +17,8 @@ nau8315 {
 	compatible = "nuvoton,nau8315";
 	enable-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
 };
+
+nau8318 {
+	compatible = "nuvoton,nau8318";
+	enable-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
+};
-- 
2.25.1

