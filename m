Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24EC1C38A2D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Oct 2022 22:01:50 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DF4186759;
	Tue, 25 Oct 2022 00:00:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DF4186759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666648908;
	bh=zH2yLaAyOCI8HWlnuIsMKt/wbk7W63NEAC2PrYHIQu4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kpN+J22TqvMPV1MyQ4stD8iUkiAfNgGtTEQB8JbagxuCkRGpGCOJqPcKLtTEK3lrI
	 YyV4isJD06EPC4kDwbb6TXOpoydzzwwPrEoAgpKa17Az0KdSVPXS4dUBYHq5zO1rtH
	 8tJ4Dv1K419ae/yt0RV7/+R7tSN4q21t6yov44pg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C6EADF80553;
	Tue, 25 Oct 2022 00:00:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A3147F80558; Tue, 25 Oct 2022 00:00:34 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 46B83F80431
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2022 00:00:28 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 46B83F80431
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="hN3evVtj"
Received: from notapiano.myfiosgateway.com (unknown [194.36.25.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: nfraprado)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 6002A66026E6;
 Mon, 24 Oct 2022 23:00:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1666648827;
 bh=zH2yLaAyOCI8HWlnuIsMKt/wbk7W63NEAC2PrYHIQu4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=hN3evVtjPXxYFgB91bDh1SQXIwQjNmNjTD5fUwYDtrR4pu3rNv3JwNveKdsTVHyp3
 OCy+7bWb3wX07X4CFPH7gGcCL4rrSECV8UlZ4ko3si3GUMdPmuj6L084wCC5AlpP96
 GHvxYvjMDleeoMN2Ay37cIOH14ngJukjKFHjqS96Ftm70UOjxG3y0aCmfMc0wugHFh
 6GB0dI+/qqekdcQqGfiESiworEzu7X36uWPsLRr1YbS5KihfwA/rWpJt53ZASINSrl
 arQMfpSXATYqIhh/ncTeVb3bPythieLhBbc+tUEE5BzKLOtXgnLcGqoarhPdgiN++S
 LpES3IS0bGotg==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 2/4] ASoC: dt-bindings: realtek,
 rt5682s: Add AVDD and MICVDD supplies
Date: Mon, 24 Oct 2022 18:00:13 -0400
Message-Id: <20221024220015.1759428-3-nfraprado@collabora.com>
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

The rt5682s codec can have two supplies: AVDD and MICVDD. They are
already used by sc7180-trogdor-kingoftown.dtsi, so document them in the
binding.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Added mention that property is already used in a DT to the commit
  message

 Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
index 1c0b06d82369..ac1dea5b4450 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
@@ -90,6 +90,10 @@ properties:
   "#sound-dai-cells":
     const: 1
 
+  AVDD-supply: true
+
+  MICVDD-supply: true
+
 additionalProperties: false
 
 required:
-- 
2.38.1

