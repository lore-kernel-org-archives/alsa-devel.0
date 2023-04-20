Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F254C77B73
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Apr 2023 10:35:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 962C5EEC;
	Thu, 20 Apr 2023 12:34:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 962C5EEC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1681986911;
	bh=O2qvnlDJSnNedy6jdEu7OlBeGpJQbZqSdYcpdMGQifU=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=lDg1GilFZzhnRY8MN2uFPKhQYwVpvyHTxpcQH6IvEgHU7p/mbrwMJBMMP5QHSb3FX
	 IkcsXG6Bsj7Gh4O48DSrEEsJKGw4kIkqQI2mcvvAxavHA+b8zTxpVPiVzM+jkVu/vP
	 1M9A/auFOoMIMYFglsEUIDUPElP9dbMg4jzqlqQ0=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id AAC5FF80558;
	Thu, 20 Apr 2023 12:33:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 3C399F80149; Thu, 20 Apr 2023 04:42:07 +0200 (CEST)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id EB3D5F80155
	for <alsa-devel@alsa-project.org>; Thu, 20 Apr 2023 04:41:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EB3D5F80155
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 1048F24E203;
	Thu, 20 Apr 2023 10:41:21 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 20 Apr
 2023 10:41:21 +0800
Received: from SD-Server.starfivetech.com (113.72.144.253) by
 EXMBX168.cuchost.com (172.16.6.78) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Thu, 20 Apr 2023 10:41:20 +0800
From: Walker Chen <walker.chen@starfivetech.com>
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, "Rob
 Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Walker Chen <walker.chen@starfivetech.com>
Subject: [PATCH v2 2/4] dt-bindings: riscv: Add item for StarFive JH7110 audio
 board
Date: Thu, 20 Apr 2023 10:41:16 +0800
Message-ID: <20230420024118.22677-3-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230420024118.22677-1-walker.chen@starfivetech.com>
References: <20230420024118.22677-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.253]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-MailFrom: walker.chen@starfivetech.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: 3Y274MM26LIMUEBACCZAWYWTQJIBYXHT
X-Message-ID-Hash: 3Y274MM26LIMUEBACCZAWYWTQJIBYXHT
X-Mailman-Approved-At: Thu, 20 Apr 2023 10:33:14 +0000
CC: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/3Y274MM26LIMUEBACCZAWYWTQJIBYXHT/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add bindings to describe the audio board that works in conjunction with
the VisionFive2 board.

Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
---
 Documentation/devicetree/bindings/riscv/starfive.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/riscv/starfive.yaml b/Documentation/devicetree/bindings/riscv/starfive.yaml
index cc4d92f0a1bf..581d07718fde 100644
--- a/Documentation/devicetree/bindings/riscv/starfive.yaml
+++ b/Documentation/devicetree/bindings/riscv/starfive.yaml
@@ -28,6 +28,7 @@ properties:
           - enum:
               - starfive,visionfive-2-v1.2a
               - starfive,visionfive-2-v1.3b
+              - starfive,visionfive-2-audio
           - const: starfive,jh7110
 
 additionalProperties: true
-- 
2.17.1

