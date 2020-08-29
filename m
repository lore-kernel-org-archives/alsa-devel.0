Return-Path: <SRS0=Trf1=CH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5EFC433E6
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Aug 2020 14:30:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB8F52065F
	for <alsa-devel@archiver.kernel.org>; Sat, 29 Aug 2020 14:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="KRA3985h";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ykSI5/vi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB8F52065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7903F18E5;
	Sat, 29 Aug 2020 16:29:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7903F18E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598711438;
	bh=6gznRRrKsqAQNWmMyK3EtnSRpMtqnII6P6GgV9nfPDo=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KRA3985hcN/9dcY9Ap/sNUThKGi9PQO0nNutqJn1XLKqqF8S1SgMYy1TTXr6b36W4
	 QvGuMbfLBKqB1NVT5tIzgHxIZG6KE6O3PjzPWNjPlHJ3m5vYR2kEeBYmMwyLwH77fB
	 iEdg7cqlsoK5umelYP7S1aScysFqTJoil6w1GQTY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 26153F802FF;
	Sat, 29 Aug 2020 16:26:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7A141F802EA; Sat, 29 Aug 2020 16:25:57 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 04920F802DF
 for <alsa-devel@alsa-project.org>; Sat, 29 Aug 2020 16:25:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 04920F802DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="ykSI5/vi"
Received: from localhost.localdomain (unknown [194.230.155.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D726820791;
 Sat, 29 Aug 2020 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598711153;
 bh=6gznRRrKsqAQNWmMyK3EtnSRpMtqnII6P6GgV9nfPDo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ykSI5/vivMZCJ/zaqQo1HfS6rLP0th/ECZU3qUrs4QBNLMpoSQCspQsQFh6kiqmsI
 Y7xEH8oXyzlvQRE0WpAD96kv0vIpwAirg6JrfcPFqBtItQV2RFbD6i68BEbOEhOJ9U
 6Z1iMrsvNt+/i83xi7toS8eLB4ehdk4S/hm47wFk=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Lee Jones <lee.jones@linaro.org>,
 Sangbeom Kim <sbkim73@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 alsa-devel@alsa-project.org
Subject: [PATCH 08/10] arm64: dts: exynos: Add compatibles to sysreg nodes
Date: Sat, 29 Aug 2020 16:24:59 +0200
Message-Id: <20200829142501.31478-8-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200829142501.31478-1-krzk@kernel.org>
References: <20200829142501.31478-1-krzk@kernel.org>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>,
 Chanwoo Choi <cw00.choi@samsung.com>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Inki Dae <inki.dae@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>
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

System register nodes, implementing syscon binding, should use
appropriate compatible.  This fixes dtbs_check warnings:

  arch/arm64/boot/dts/exynos/exynos5433-tm2.dt.yaml: syscon@13b80000:
    compatible: ['syscon'] is not valid under any of the given schemas

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 74ac4ac75865..b2eebdd88c3c 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -1015,17 +1015,17 @@
 		};
 
 		syscon_disp: syscon@13b80000 {
-			compatible = "syscon";
+			compatible = "samsung,exynos5433-sysreg", "syscon";
 			reg = <0x13b80000 0x1010>;
 		};
 
 		syscon_cam0: syscon@120f0000 {
-			compatible = "syscon";
+			compatible = "samsung,exynos5433-sysreg", "syscon";
 			reg = <0x120f0000 0x1020>;
 		};
 
 		syscon_cam1: syscon@145f0000 {
-			compatible = "syscon";
+			compatible = "samsung,exynos5433-sysreg", "syscon";
 			reg = <0x145f0000 0x1038>;
 		};
 
-- 
2.17.1

