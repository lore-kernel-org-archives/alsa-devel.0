Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EE4C05027
	for <alsa-devel@archiver.kernel.org>; Fri, 17 Feb 2023 12:44:18 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 58394F2A;
	Fri, 17 Feb 2023 13:43:26 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 58394F2A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676637856;
	bh=egnooPJpNM4o/gc+8fNo8gZUG2pwChKFBH3+nnb+9yo=;
	h=From:To:Subject:Date:In-Reply-To:References:CC:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=R+cuEY8dhy9DrmH9gmU5NhmoD/Q8vj2+RAS8/KcEK7inogMLyzL6hEiyiEic8mdsL
	 1k1j5UXoqwl9K08qmw+8fKTJHbUuLnzxr9XzLqpnROBQRWbA080l8uz+9J10CDdTeO
	 cX19g0RAlXCllALa+17VV+DJsEoaGj/HYJDjKa78=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 4EFCBF80525;
	Fri, 17 Feb 2023 13:42:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 2D490F804B2; Fri, 17 Feb 2023 13:42:26 +0100 (CET)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id AC73FF800E4
	for <alsa-devel@alsa-project.org>; Fri, 17 Feb 2023 13:42:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AC73FF800E4
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=ZOjE8Sz7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1676637742; x=1708173742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=egnooPJpNM4o/gc+8fNo8gZUG2pwChKFBH3+nnb+9yo=;
  b=ZOjE8Sz7FTUNZcNBo9xVSZZDxTfOBS+5GMxImxcDHTzZWuiHpqNiJurx
   yGhgtDqpxO9ukYiuh+SqB0iAkxjYqbULysHydpGZwLrllVVIOkwziMkt1
   uVonfd9zoB2wCVpcnDKXt+FFeN3fiRPgGKufJpGGpqEZ4W9RxdZBRjLU2
   HpCnhnlDnttO1jDugSktlrgcdEpPm9iRqk8BQ5ZYazBFiP548XMZkPoq0
   gLiZYjidgG0VYFlsHXHyqjFidjShH8DYY3y0ogSfLhb7Q6uRDg48twp6i
   tRR2N3aNY+7/D0xzD2yEcn5QU0i/7aC6SRfjGIXgpt6mlliu5M3NZ568S
   g==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669100400";
   d="scan'208";a="212504683"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 17 Feb 2023 05:42:13 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 17 Feb 2023 05:42:13 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 17 Feb 2023 05:42:08 -0700
From: Claudiu Beznea <claudiu.beznea@microchip.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <perex@perex.cz>, <tiwai@suse.com>,
	<nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 2/3] ASoC: dt-bindings: sama7g5-pdmc: add
 microchip,startup-delay-us binding
Date: Fri, 17 Feb 2023 14:41:50 +0200
Message-ID: <20230217124151.236216-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230217124151.236216-1-claudiu.beznea@microchip.com>
References: <20230217124151.236216-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Message-ID-Hash: LAAXYUOLW35BAUZORZXC2HZZW62EFIQM
X-Message-ID-Hash: LAAXYUOLW35BAUZORZXC2HZZW62EFIQM
X-MailFrom: Claudiu.Beznea@microchip.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Claudiu Beznea <claudiu.beznea@microchip.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/LAAXYUOLW35BAUZORZXC2HZZW62EFIQM/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add microchip,startup-delay-us binding to let PDMC users to specify
startup delay.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
index c4cf1e5ab84b..9b40268537cb 100644
--- a/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
+++ b/Documentation/devicetree/bindings/sound/microchip,sama7g5-pdmc.yaml
@@ -67,6 +67,12 @@ properties:
     maxItems: 4
     uniqueItems: true
 
+  microchip,startup-delay-us:
+    description: |
+      Specifies the delay in microseconds that needs to be applied after
+      enabling the PDMC microphones to avoid unwanted noise due to microphones
+      not being ready.
+
 required:
   - compatible
   - reg
-- 
2.34.1

