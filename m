Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AB9C67871
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Oct 2022 22:02:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF5773DD8;
	Tue, 25 Oct 2022 00:01:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF5773DD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666648928;
	bh=d75fJH0ARJtURmP3T8+VteKCb9z0HW7yZAWSp5EIerU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hgMR5PN1J4nbTEx6kR7pQcbtqSxmZPXeWctK8Et5pkVH9vNDH7I22xhQwUDZX4Jjl
	 GfPgGUiqRDQQGjDApVWj8a2Qw1bB/LzSsBrRJuOkBnX1VQtKnd356/lNMm2BMLWqqe
	 1+LD8WO338sU0QfHO/kuWwXBe7RcZmmSBD4L+zqk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3CBACF8055A;
	Tue, 25 Oct 2022 00:00:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C06DFF80557; Tue, 25 Oct 2022 00:00:36 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 887FDF80552
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2022 00:00:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 887FDF80552
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="Xpmnsd13"
Received: from notapiano.myfiosgateway.com (unknown [194.36.25.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: nfraprado)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 049966602823;
 Mon, 24 Oct 2022 23:00:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1666648824;
 bh=d75fJH0ARJtURmP3T8+VteKCb9z0HW7yZAWSp5EIerU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Xpmnsd13nVFhEaTQPZgbYHf3o7odt8SGo6UH2G5nMif/BG2OP6Q1OwT/DwTGsOeqf
 ktD/4Ii4vd7yIqGQxhnGeWHjMNTDnNwoCQZGX4omRwq3yDjOVAJjqbOBF8UX42OglV
 UWuw43c/mVZ4NBEj9Zze6Of+cwucBjJRJjNFNBUR9FHifvMUAjkMWMEx7N0oTnYcvn
 OWkxToM4q9hyXtQxbIvNUr5zqpwWZH3RBwb14NoZSXtNnapaphsf9+FvHYqKu93+QU
 gehUqDGsjTwKNE9WmMGfSxpXVR6OSC8sF45tJ3URgg3iXwbluNkrJfUDD7bT1F/K3h
 05dI1WgFuONXA==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/4] ASoC: dt-bindings: realtek,
 rt5682s: Add #sound-dai-cells
Date: Mon, 24 Oct 2022 18:00:12 -0400
Message-Id: <20221024220015.1759428-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221024220015.1759428-1-nfraprado@collabora.com>
References: <20221024220015.1759428-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>,
 linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Derek Fang <derek.fang@realtek.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, kernel@collabora.com,
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

The rt5682s codec is a DAI provider with two interfaces - AIF1 and AIF2
- and therefore should have a #sound-dai-cells property that is equal to
1. Add it.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Changed commit message
- Changed value to 1

 Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
index ca5b8987b749..1c0b06d82369 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
@@ -87,6 +87,9 @@ properties:
     maxItems: 2
     description: Name given for DAI word clock and bit clock outputs.
 
+  "#sound-dai-cells":
+    const: 1
+
 additionalProperties: false
 
 required:
-- 
2.38.1

