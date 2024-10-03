Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77E49CF856E
	for <alsa-devel@archiver.kernel.org>; Thu,  3 Oct 2024 08:36:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 610C2832;
	Thu,  3 Oct 2024 10:36:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 610C2832
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1727944602;
	bh=aFhHoczV0rMWeh+VcHeNazYdIGsQ9DwYb7Mz6aNO70I=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=S2I8q89Bg8e1yKxx2Fslolnj2ZxznLkgPe2ZfOVCW0F1UTuHMWgVsSlm+yVBp6mDm
	 dorBHJj7Wv+V4i2Cln/RM8onABQaqcjgUAcNfIBXHt9+8H8HOz7/AyeJUZeWTQ38UQ
	 sieEj2fTc44WPuJx5WtBHjo+h/LKB76avwl0ipDM=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 7A977F80107; Thu,  3 Oct 2024 10:36:21 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 079DBF805B6;
	Thu,  3 Oct 2024 10:36:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 8D87AF80517; Thu,  3 Oct 2024 10:36:16 +0200 (CEST)
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::224])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 629A8F80107
	for <alsa-devel@alsa-project.org>; Thu,  3 Oct 2024 10:36:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 629A8F80107
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=b2kb5dVf
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5769FE0009;
	Thu,  3 Oct 2024 08:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727944572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sQ9rph851MPwAwZwNHdKiFp9HyVOi/6POo4Z12r84Ug=;
	b=b2kb5dVfJ4wTrXp881WOyqsREtea0iLIMGxJqHlw65SNFYfVdOFKQm/uufmr8futTjECFd
	8CFV/F5pTqt8ZSo8/tSlfqKyE+iUBwscK6SZSscopBAZAhxXDtpQLHZU/OschV8CGWLy4t
	IzZvUdB4lJ3vwke4kNymA2cQg/GVg6Bj+znq2Wk/gUWciqICGq5tKCmMIojl5utxXCs9TP
	8BCgYcqpir/TJUxBzpxGZvbMVUDbWVsbK7MHp6kM0xlVfuggkb7U1PalZdEQNUarhYXqU6
	HFtmMWa5bdMBV67G0zPUWY2jQ76dxGc7wmWzu2/8o7TYj0YI8mzjf7zrxx80Wg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Peter Ujfalusi <peter.ujfalusi@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jayesh Choudhary <j-choudhary@ti.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH] ASoC: dt-bindings: davinci-mcasp: Fix interrupt properties
Date: Thu,  3 Oct 2024 10:36:11 +0200
Message-ID: <20241003083611.461894-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: miquel.raynal@bootlin.com
Message-ID-Hash: E3VRBGR3TC554ZTWHDJPJAO463N6WKUP
X-Message-ID-Hash: E3VRBGR3TC554ZTWHDJPJAO463N6WKUP
X-MailFrom: miquel.raynal@bootlin.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/E3VRBGR3TC554ZTWHDJPJAO463N6WKUP/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Combinations of "tx" alone, "rx" alone and "tx", "rx" together are
supposedly valid (see link below), which is not the case today as "rx"
alone is not accepted by the current binding.

Let's rework the two interrupt properties to expose all correct
possibilities.

Cc: Péter Ujfalusi <peter.ujfalusi@gmail.com>
Link: https://lore.kernel.org/linux-sound/20241003102552.2c11840e@xps-13/T/#m277fce1d49c50d94e071f7890aed472fa2c64052
Fixes: 8be90641a0bb ("ASoC: dt-bindings: davinci-mcasp: convert McASP bindings to yaml schema")
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
Hello Mark,
This patch applies on top of the one you already took, but if you prefer
you can squash them together, I don't mind.
Cheers,
Miquèl
---
 .../bindings/sound/davinci-mcasp-audio.yaml    | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
index ab3206ffa4af..beef193aaaeb 100644
--- a/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
+++ b/Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
@@ -102,21 +102,21 @@ properties:
     default: 2
 
   interrupts:
-    oneOf:
-      - minItems: 1
-        items:
-          - description: TX interrupt
-          - description: RX interrupt
-      - items:
-          - description: common/combined interrupt
+    minItems: 1
+    maxItems: 2
 
   interrupt-names:
     oneOf:
-      - minItems: 1
+      - description: TX interrupt
+        const: tx
+      - description: RX interrupt
+        const: rx
+      - description: TX and RX interrupts
         items:
           - const: tx
           - const: rx
-      - const: common
+      - description: Common/combined interrupt
+        const: common
 
   fck_parent:
     $ref: /schemas/types.yaml#/definitions/string
-- 
2.43.0

