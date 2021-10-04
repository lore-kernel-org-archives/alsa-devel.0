Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4787C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 11:28:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBAD061354
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 11:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CBAD061354
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5B88D1691;
	Mon,  4 Oct 2021 13:27:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5B88D1691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633346905;
	bh=HGAOu243eW/p5oIur9xXjqI6vixKkoCNC1KvfZoybsc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=grfLiq/jcnMeig4XlBpj8mrAiffC/lvDo7ra4pihHH4ThsGWaQKzl9aGBrQzKZ0B2
	 EFv1lsbavZtQRF7cGGcmMdLQ2rHFcyP/VOVswIXr5ZaSRKarvrfhE1kyIfDZ795HFz
	 myzHLq8I6jsVVXE75Egw64EkSG6GceiTpHbGx1SQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38B0BF8025C;
	Mon,  4 Oct 2021 13:26:50 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E6F98F80240; Mon,  4 Oct 2021 04:12:41 +0200 (CEST)
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
 by alsa1.perex.cz (Postfix) with ESMTP id 2ECEFF800BA
 for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2021 04:12:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2ECEFF800BA
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
 by mx.socionext.com with ESMTP; 04 Oct 2021 11:12:27 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
 by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 7B48C2059034;
 Mon,  4 Oct 2021 11:12:27 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP;
 Mon, 4 Oct 2021 11:12:27 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
 by kinkan2.css.socionext.com (Postfix) with ESMTP id DE589B62B7;
 Mon,  4 Oct 2021 11:12:26 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] ASoC: dt-bindings: uniphier: Add description of each port
 number
Date: Mon,  4 Oct 2021 11:12:26 +0900
Message-Id: <1633313546-23258-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
X-Mailman-Approved-At: Mon, 04 Oct 2021 13:26:48 +0200
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
 Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

To eliminate FIXME, add descriptions of what each port number is
associated with.

Cc: Rob Herring <robh@kernel.org>
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../bindings/sound/socionext,uniphier-aio.yaml     | 22 +++++++++++++++++++++-
 .../bindings/sound/socionext,uniphier-evea.yaml    |  6 +++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml b/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml
index 55ae198..70f62ec 100644
--- a/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml
+++ b/Documentation/devicetree/bindings/sound/socionext,uniphier-aio.yaml
@@ -46,7 +46,27 @@ properties:
 
 patternProperties:
   "^port@[0-9]$":
-    description: FIXME, Need to define what each port is.
+    description: |
+      Port number of DT node is specified by the following DAI channels that
+      depends on SoC.
+      ld11-aio,ld20-aio:
+        0: hdmi
+        1: pcmin2
+        2: line
+        3: hpcmout1
+        4: pcmout3
+        5: hiecout1
+        6: epcmout2
+        7: epcmout3
+        8: hieccompout1
+      pxs2-aio:
+        0: hdmi
+        1: line
+        2: aux
+        3: hiecout1
+        4: iecout1
+        5: hieccompout1
+        6: ieccompout1
     $ref: audio-graph-port.yaml#
     unevaluatedProperties: false
 
diff --git a/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml b/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
index 48ddfcb..be6acfd 100644
--- a/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
+++ b/Documentation/devicetree/bindings/sound/socionext,uniphier-evea.yaml
@@ -40,7 +40,11 @@ properties:
 
 patternProperties:
   "^port@[0-9]$":
-    description: FIXME, Need to define what each port is.
+    description: |
+      Port number of DT node is specified by the following DAI channels.
+        0: line1
+        1: hp
+        2: line2
     $ref: audio-graph-port.yaml#
     unevaluatedProperties: false
 
-- 
2.7.4

