Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDEE3C4332F
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Nov 2022 18:21:31 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6654B1673;
	Wed,  2 Nov 2022 19:20:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6654B1673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667413289;
	bh=iEfgs5/IYGmZLK5vLu7xq05AP6DxnckLW0sEoea0frY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gQ+TJFwMxaTDOKKDfe+bI1zkj/XPAVlkQH8Zj+Quu7+uP2qtD5xVouKtfG8nbv5Mb
	 YmCGt7+jnY1xUsGVRk/Iqee4aiHoDyJoemOVUIGLlSD9poAiC+zq0aFhbnrpCyLm0Z
	 Iq7VViV/uyuDg5i3e5++mxP+O7/1F5vcTDOR5O2I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4DFF1F80423;
	Wed,  2 Nov 2022 19:20:18 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id EB663F80552; Wed,  2 Nov 2022 19:20:16 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B0E8F80254
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2022 19:20:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B0E8F80254
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="JtRxA8W7"
Received: from notapiano.myfiosgateway.com (unknown
 [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: nfraprado)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C37566028E7;
 Wed,  2 Nov 2022 18:20:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1667413209;
 bh=iEfgs5/IYGmZLK5vLu7xq05AP6DxnckLW0sEoea0frY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JtRxA8W7bF4/NcHMNMq2PIygyK9OwqM6gojFJZtfrdzUWgCwWIJ1+icj6wGwudqt5
 PzNGvMHcirjs4x71srNeg+LokD8kJ4nvjbmjdOivqdkqInWpfUs/GM8VqsNmlOHzbp
 JwS/5eEcJr9cxAOuuexzZdLbtJPFJpykDI24zVXWa5xn7N+VQLCLXU8rRrtO+maI5P
 exexpzKigGQt9GvuLvJqvVuVpI1EnaxFRg4GxpYR3kkAgwNjaOkLR+xLywCidA0C6D
 jFQOHCp5jR2W32OxAgZVMbOGTKBkd+diQMDc3qGY+5yQzbIR00tXUIY8rPaJR0eJcs
 Vu4KhtT3aze1g==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v2 1/8] ASoC: dt-bindings: realtek,
 rt5682s: Add AVDD and MICVDD supplies
Date: Wed,  2 Nov 2022 14:19:55 -0400
Message-Id: <20221102182002.255282-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102182002.255282-1-nfraprado@collabora.com>
References: <20221102182002.255282-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Derek Fang <derek.fang@realtek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Chen-Yu Tsai <wenst@chromium.org>, kernel@collabora.com,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

The rt5682s codec has two supplies - AVDD and MICVDD - which are already
used by sc7180-trogdor-kingoftown.dtsi. Document them in the binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

(no changes since v1)

 .../devicetree/bindings/sound/realtek,rt5682s.yaml   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
index 1c0b06d82369..b7338bfc0f5a 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
@@ -90,11 +90,20 @@ properties:
   "#sound-dai-cells":
     const: 1
 
+  AVDD-supply:
+    description: Regulator supplying analog power through the AVDD pin.
+
+  MICVDD-supply:
+    description: Regulator supplying power for the microphone bias through the
+      MICVDD pin.
+
 additionalProperties: false
 
 required:
   - compatible
   - reg
+  - AVDD-supply
+  - MICVDD-supply
 
 examples:
   - |
@@ -120,5 +129,8 @@ examples:
 
             clocks = <&osc>;
             clock-names = "mclk";
+
+            AVDD-supply = <&avdd_reg>;
+            MICVDD-supply = <&micvdd_reg>;
         };
     };
-- 
2.38.1

