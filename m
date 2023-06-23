Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F9D7EB64D7
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Jun 2023 11:32:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1E053E8A;
	Mon, 26 Jun 2023 13:31:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1E053E8A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1687779155;
	bh=JbsGFsYlFyr7Htiazu4hc2TYcucQMiz4ks01lMK9mTI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=egMJYjrLIyLPzWTZra7uGwKiLTvgRa/ITQBt/6TAK2ln+GY5fAfKVzxQiPIMA8NBW
	 OEfPrgaMbMFjDuMonpj+Hz+fBH1JDn2t9qkEsYLs7gGcY+ESXsY8yj0EyH8egCAAYS
	 H6CAmIKpi6aCKm1P9mqe49VL2i/igoV1HIpo96Ro=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 24F2BF80632; Mon, 26 Jun 2023 13:27:45 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 11294F8051E;
	Mon, 26 Jun 2023 13:27:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 32711F80141; Fri, 23 Jun 2023 23:03:13 +0200 (CEST)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id E5231F8003A
	for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2023 23:03:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E5231F8003A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=microchip.com header.i=@microchip.com
 header.a=rsa-sha256 header.s=mchp header.b=SOcXYKsv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687554191; x=1719090191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JbsGFsYlFyr7Htiazu4hc2TYcucQMiz4ks01lMK9mTI=;
  b=SOcXYKsvYKciFgWgaotc32cTY0kwSK5hKYV9xC3deCev42J5/CwP62E7
   m7xWfHyevHft2jebjzN+z+G6mOb1chWs/Lzh6vktfFWVF2yPasaZCvWaP
   lcAtklDMBZQ0UB5G01qGatNPQDw/PYddzoZALU5zrQ12eA38IiJp5s0wT
   8g5L92h46wBJzXozpD+yI0SIP+rt1N5+e6ZMaxBT4+DjHRXiYe/JsYchX
   nK5D3LpScpOF4CODL9471VWRczOO3aehEi9v/YaPg0ZjrU/h3KCp4ad/k
   xXyHkS21sZYQUFoaVdmTMuLM0w8QIqoI+7BngxTy96eMfv+iOCL4vx64L
   w==;
X-IronPort-AV: E=Sophos;i="6.01,153,1684825200";
   d="scan'208";a="231893588"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256;
 23 Jun 2023 14:03:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 23 Jun 2023 13:48:02 -0700
Received: from che-lt-i67070.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 23 Jun 2023 13:47:32 -0700
From: Varshini Rajendran <varshini.rajendran@microchip.com>
To: <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <nicolas.ferre@microchip.com>,
	<alexandre.belloni@bootlin.com>, <claudiu.beznea@microchip.com>,
	<mturquette@baylibre.com>, <sboyd@kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <vkoul@kernel.org>, <tglx@linutronix.de>,
	<maz@kernel.org>, <lee@kernel.org>, <ulf.hansson@linaro.org>,
	<tudor.ambarus@linaro.org>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
	<vigneshr@ti.com>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linus.walleij@linaro.org>, <p.zabel@pengutronix.de>,
	<olivia@selenic.com>, <a.zummo@towertech.it>, <radu_nicolae.pirea@upb.ro>,
	<richard.genoud@gmail.com>, <gregkh@linuxfoundation.org>,
	<lgirdwood@gmail.com>, <broonie@kernel.org>, <wim@linux-watchdog.org>,
	<linux@roeck-us.net>, <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
	<linux@armlinux.org.uk>, <sre@kernel.org>, <jerry.ray@microchip.com>,
	<horatiu.vultur@microchip.com>, <durai.manickamkr@microchip.com>,
	<varshini.rajendran@microchip.com>, <andrew@lunn.ch>,
	<alain.volmat@foss.st.com>, <neil.armstrong@linaro.org>,
	<mihai.sain@microchip.com>, <eugen.hristev@collabora.com>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <dmaengine@vger.kernel.org>,
	<linux-i2c@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
	<linux-mtd@lists.infradead.org>, <netdev@vger.kernel.org>,
	<linux-gpio@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<alsa-devel@alsa-project.org>, <linux-usb@vger.kernel.org>,
	<linux-watchdog@vger.kernel.org>, <linux-pm@vger.kernel.org>
CC: <Hari.PrasathGE@microchip.com>, <cristian.birsan@microchip.com>,
	<balamanikandan.gunasundar@microchip.com>, <manikandan.m@microchip.com>,
	<dharma.b@microchip.com>, <nayabbasha.sayed@microchip.com>,
	<balakrishnan.s@microchip.com>
Subject: [PATCH v2 34/45] dt-bindings: watchdog: sama5d4-wdt: add compatible
 for sam9x7-wdt
Date: Sat, 24 Jun 2023 02:00:45 +0530
Message-ID: <20230623203056.689705-35-varshini.rajendran@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230623203056.689705-1-varshini.rajendran@microchip.com>
References: <20230623203056.689705-1-varshini.rajendran@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MailFrom: Varshini.Rajendran@microchip.com
X-Mailman-Rule-Hits: nonmember-moderation
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1
Message-ID-Hash: A67UQJXKUSJRQXFMPI55DKLUZL5NGARI
X-Message-ID-Hash: A67UQJXKUSJRQXFMPI55DKLUZL5NGARI
X-Mailman-Approved-At: Mon, 26 Jun 2023 11:27:27 +0000
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/A67UQJXKUSJRQXFMPI55DKLUZL5NGARI/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Add compatible microchip,sam9x7-wdt to DT bindings documentation.

Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
---
 .../devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml          | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
index 816f85ee2c77..216e64dfddb2 100644
--- a/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/atmel,sama5d4-wdt.yaml
@@ -17,6 +17,7 @@ properties:
     enum:
       - atmel,sama5d4-wdt
       - microchip,sam9x60-wdt
+      - microchip,sam9x7-wdt
       - microchip,sama7g5-wdt
 
   reg:
-- 
2.25.1

