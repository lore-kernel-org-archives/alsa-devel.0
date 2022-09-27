Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D019C6FA82
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Sep 2022 00:55:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F72C3E8;
	Tue, 27 Sep 2022 02:54:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F72C3E8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664240139;
	bh=m1CPMmrk8gsAFRfcbeD+H6NkLeMKZ5n4xbWbkyr79Ko=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CWPqJmXuCCKjKb8zodNFT+xm6U9nEL7SydMq7IVGdktwEFkwnedY5XvjDVKF7ttO6
	 BVmPfdqMVR4460KdKWylUKhJpfxpA6LVd7PbTgsF0xtLu5bMz7LRBA7CROHZlihIME
	 2BzbjvWFJpgYVvf1kPowFUb8J94j8h6nkxDjhULg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3856FF80254;
	Tue, 27 Sep 2022 02:54:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 98E5EF8027D; Tue, 27 Sep 2022 02:54:48 +0200 (CEST)
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 818A7F80134
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2022 02:54:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 818A7F80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de
 header.b="d6ytqkik"
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 290A383869;
 Tue, 27 Sep 2022 02:54:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1664240081;
 bh=FsDScXFRX7C8vRitOr1X2Dru3V2z+v/UjgGzJhLlc4E=;
 h=From:To:Cc:Subject:Date:From;
 b=d6ytqkikv0e3VyowR4is+3zDBagPEot7wt7AczyufV/3SIsaIGbOdQsyqKbME+q7a
 z9KZ0xvBAee9z4Qzv17wrpHC/bNkcmTFkarLa2ERxGA9BffF9SM1vplHNTnC2HD32k
 5P542zJJT3Q8K21Ej3tiPBHCrDMS3FdTt8gsZHIrkPPCC5PzGdqMELEnch/1WoTksc
 fVINu4/NN2CfJTqKnBAJXi1tw+8kR0i/rkFFwDYPB8K2w2HpdYeK2T4k12PP7fqVWl
 hcr3m2Sgadhtl1XUVhgswcyWNwNo73HOra1tsDp5xQ4WYzohzMqktjqCX10NI9kRDt
 W4UV8Oz0b597Q==
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] ASoC: dt-bindings: Document audio OF graph dai-tdm-slot-num
 dai-tdm-slot-width props
Date: Tue, 27 Sep 2022 02:54:36 +0200
Message-Id: <20220927005436.690904-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Cc: Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mark Brown <broonie@kernel.org>
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

Document dai-tdm-slot-num and dai-tdm-slot-width props as those are
parsed by simple graph card and may therefore appear in audio OF graph
node.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: alsa-devel@alsa-project.org
To: linux-arm-kernel@lists.infradead.org
---
 Documentation/devicetree/bindings/sound/audio-graph-port.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index bc46a95ed8400..c282b81632d8f 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -74,6 +74,10 @@ patternProperties:
       convert-sample-format:
         $ref: "/schemas/sound/dai-params.yaml#/$defs/dai-sample-format"
 
+      dai-tdm-slot-num:
+        $ref: "#/definitions/dai-tdm-slot-num"
+      dai-tdm-slot-width:
+        $ref: "#/definitions/dai-tdm-slot-width"
       dai-tdm-slot-width-map:
         description: Mapping of sample widths to slot widths. For hardware
           that cannot support a fixed slot width or a slot width always
-- 
2.35.1

