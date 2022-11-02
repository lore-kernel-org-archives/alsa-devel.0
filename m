Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2C84C4332F
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Nov 2022 18:22:03 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 56F721689;
	Wed,  2 Nov 2022 19:21:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 56F721689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667413321;
	bh=XreP8pLNPdmHQfo0+zus9VHh3oAKdgBVqoqtrPoAkGE=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PTFs8D8AFNW/SdH9ILkOKHZxejVLjisks9qeYdQ5zERHF0strlJ0erdpLuXg3zl6N
	 dZxBgcHv54pPo2SGxKo5y4OaFfxPW1Asn26cecHUgJ6vzGNdgXhWyhcpNIDCPbNvYy
	 elFkDypY1AWimp0ELOC2W7+rfW2fqCZ5h4ZsMHVE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9732F8055B;
	Wed,  2 Nov 2022 19:20:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88D06F80558; Wed,  2 Nov 2022 19:20:19 +0100 (CET)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4E49DF801D5
 for <alsa-devel@alsa-project.org>; Wed,  2 Nov 2022 19:20:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4E49DF801D5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="DzrG8ead"
Received: from notapiano.myfiosgateway.com (unknown
 [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: nfraprado)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id F00BF66028C5;
 Wed,  2 Nov 2022 18:20:09 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1667413211;
 bh=XreP8pLNPdmHQfo0+zus9VHh3oAKdgBVqoqtrPoAkGE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=DzrG8eadOfxEzZBS9K6GzlezW9SFPw4pfPCJF8Og2axj/E7qE8ax0bfb/iLBTQzXm
 1CtK92x5oD8NiBEyf/uzIT0fhfoAeJxS0brRuKQf7lTDXSciMlhi37GYvfXuExdvTe
 LFP3yaxPBLiEA6IrTYnIncu2tfW6esFBimzicYLWt//iV+Yes8+ahiPzalbteNGJWM
 vL/P3xTOQGQEKMSxqHV8K+iYuLYGI6GvrcBRsh8NadLFrWAY4ZXtKzY7gPHSyBTjm9
 V19JXyACh5qP45pZHiUrPElIRXHjyno3qlh9MP3KdthKIQ8v9OnHwOaQ1wtshGZmTD
 DkEO754P4pjRA==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v2 2/8] ASoC: dt-bindings: realtek,
 rt5682s: Add DBVDD and LDO1-IN supplies
Date: Wed,  2 Nov 2022 14:19:56 -0400
Message-Id: <20221102182002.255282-3-nfraprado@collabora.com>
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

The rt5682s codec has two additional power supply pins, DBVDD and
LDO1_IN, that aren't currently described in the binding. Add them.

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Made names uppercase

 .../devicetree/bindings/sound/realtek,rt5682s.yaml    | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
index b7338bfc0f5a..dc418652f241 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
@@ -97,6 +97,13 @@ properties:
     description: Regulator supplying power for the microphone bias through the
       MICVDD pin.
 
+  DBVDD-supply:
+    description: Regulator supplying I/O power through the DBVDD pin.
+
+  LDO1-IN-supply:
+    description: Regulator supplying power to the digital core and charge pump
+      through the LDO1_IN pin.
+
 additionalProperties: false
 
 required:
@@ -104,6 +111,8 @@ required:
   - reg
   - AVDD-supply
   - MICVDD-supply
+  - DBVDD-supply
+  - LDO1-IN-supply
 
 examples:
   - |
@@ -132,5 +141,7 @@ examples:
 
             AVDD-supply = <&avdd_reg>;
             MICVDD-supply = <&micvdd_reg>;
+            DBVDD-supply = <&dbvdd_reg>;
+            LDO1-IN-supply = <&ldo1_in_reg>;
         };
     };
-- 
2.38.1

