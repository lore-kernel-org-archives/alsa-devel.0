Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D717C38A2D
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Oct 2022 23:08:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2313C6370;
	Tue, 25 Oct 2022 01:07:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2313C6370
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666652880;
	bh=syu6x+tQMYyXRnROEzYyOqlWI3pV6D/rMZw1lLuGM5g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WvT57TjKttb/+4Rj5yBQt7eWlx4qMnqIT9wxa8STWn7bCx6/oEcXCQcVlSq3qURwA
	 FY26byk67u2/bJw78+2upSic2nQUaeL4qMx/QW8kULZIsJKxFKfLFyvRV2OrXT9hTf
	 YkirzbD10W14wOrS/fhYh3lqnLrgRn/mYNaSV7kw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B097CF8052F;
	Tue, 25 Oct 2022 01:07:09 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 62FE3F80533; Tue, 25 Oct 2022 01:07:08 +0200 (CEST)
Received: from madras.collabora.co.uk (madras.collabora.co.uk
 [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 23FC7F80240
 for <alsa-devel@alsa-project.org>; Tue, 25 Oct 2022 01:07:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 23FC7F80240
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="bMUwQ7iy"
Received: from notapiano.myfiosgateway.com (unknown [194.36.25.51])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: nfraprado)
 by madras.collabora.co.uk (Postfix) with ESMTPSA id 7D27D6602319;
 Tue, 25 Oct 2022 00:07:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1666652824;
 bh=syu6x+tQMYyXRnROEzYyOqlWI3pV6D/rMZw1lLuGM5g=;
 h=From:To:Cc:Subject:Date:From;
 b=bMUwQ7iyuh1NncKE+xbrlV4imgXvN327I0B1FFYOlO9RvlB4/vL5xDB5HkHfSrltg
 jqoPN/y0eDEWf0R0TqfMACGkLH/iC88vUEJEyjIy2hzRo2TL51zDjk84uo8rEZ2O2u
 fJ3Q9lCEFsbQAMMS+eT8uN+bdrbkWyQXLKaw+AN7nnZBTdJ1GopP7mGKT72fbCCtJA
 QkLmUSxiIDx2kftHEj3WQeYtpXNQpLRoBXZK4KrZRyce8QGIaCa5Kw/+2RRTT/6RPo
 wSsVI2XKgM9bJnwXyzcxPRU/XPrCf+rLUiVsmj0VlLDEDvu5t7q4vIC9N4KP15I8HQ
 S+iDU7uVQPNDA==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: dt-bindings: mt8192-mt6359: Set maxItems, not type,
 for sound-dai
Date: Mon, 24 Oct 2022 19:06:57 -0400
Message-Id: <20221024230658.1772907-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, linux-kernel@vger.kernel.org,
 Shane Chien <shane.chien@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, kernel@collabora.com,
 linux-arm-kernel@lists.infradead.org,
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

sound-dai is a standard property whose type is already set to
phandle-array by sound-dai.yaml, so there's no need to set it (and
wrongly so for headset-codec) in this binding. What should be set
however is the maximum number of items, which for headset-codec should
be 1.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 .../devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
index 478be7e3fa29..c6e614c1c30b 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
@@ -34,7 +34,7 @@ properties:
 
     properties:
       sound-dai:
-        $ref: /schemas/types.yaml#/definitions/phandle
+        maxItems: 1
     required:
       - sound-dai
 
@@ -48,7 +48,6 @@ properties:
         maxItems: 2
         items:
           maxItems: 1
-        $ref: /schemas/types.yaml#/definitions/phandle-array
     required:
       - sound-dai
 
-- 
2.38.1

