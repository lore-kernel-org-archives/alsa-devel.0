Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17014C6FA82
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Sep 2022 00:21:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7AD9F20B;
	Tue, 27 Sep 2022 02:20:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7AD9F20B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664238066;
	bh=RdjhQV6Zza7NCyG2S3xCru14mvboboefHS7jIUVCgLc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jqatDexj9U7njklQWWGStahuTrMcu5WrMON5utgjhg0kO9TiunjDlVOe/k6cauoIg
	 vHhIG09LAzHGd0elveI07rzwhlLaxjhNtmuWStYvwBwbc3p2J6xM5mfZMGfc4WgCzN
	 YXh4XktQsssl1MwhE3v0oMx0ScyGJPoNSkiVgtFg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0971AF8027D;
	Tue, 27 Sep 2022 02:20:16 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 71BA0F80134; Tue, 27 Sep 2022 02:20:14 +0200 (CEST)
Received: from phobos.denx.de (phobos.denx.de
 [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0149FF80134
 for <alsa-devel@alsa-project.org>; Tue, 27 Sep 2022 02:20:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0149FF80134
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de
 header.b="ry5a7XJN"
Received: from tr.lan (ip-86-49-12-201.bb.vodafone.cz [86.49.12.201])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 11A0884E31;
 Tue, 27 Sep 2022 02:20:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1664238007;
 bh=OBQwDC3kXdektDpa5NG0Pkr9pcNuEgOjGxQ588vpKHQ=;
 h=From:To:Cc:Subject:Date:From;
 b=ry5a7XJN4Rd+RUTewE+8p0QlSBNnPCSXKqf5Li4unj12nUKRDVsD1nAs/f9sMx1VD
 v5Dmmay739913SPifuAqRtFsu7KyX/fMMbfUyI/2IUNgmgRTGQ+/S6W8qj0k9zjpVs
 rhyvBjmv10m6HYvp+OU4rhp0UCkm0v00W3BWXjoWCiwYPRK4yYgybwAZQiQWAhAiyW
 2O4hw2rOyrtqh+gYTlyZpf4fk4mzvb1hR/SCLY1wFvXUNoTpK4nKq6xPxt2HY5uRLv
 X1z8GUwCJE/klCCJbdE7Ji8Nxg7A2ilWyodAtoc9PD1IRZzq3ELpnqUuF8vT1V71Ft
 leA8lIGfvMMsg==
From: Marek Vasut <marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: sound: st,
 stm32-sai: Document audio OF graph port
Date: Tue, 27 Sep 2022 02:20:04 +0200
Message-Id: <20220927002004.685108-1-marex@denx.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
Cc: Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Mark Brown <broonie@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
 linux-stm32@st-md-mailman.stormreply.com
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

It is expected that the SAI subnodes would contain audio OF graph port
with endpoint to link it with the other side of audio link. Document
the port: property.

Signed-off-by: Marek Vasut <marex@denx.de>
---
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: alsa-devel@alsa-project.org
Cc: linux-stm32@st-md-mailman.stormreply.com
To: linux-arm-kernel@lists.infradead.org
---
 Documentation/devicetree/bindings/sound/st,stm32-sai.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
index 1a3abc9495055..56d206f97a96c 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.yaml
@@ -122,6 +122,10 @@ patternProperties:
         description: Configure the SAI device as master clock provider.
         const: 0
 
+      port:
+        $ref: audio-graph-port.yaml#
+        unevaluatedProperties: false
+
     required:
       - compatible
       - "#sound-dai-cells"
-- 
2.35.1

