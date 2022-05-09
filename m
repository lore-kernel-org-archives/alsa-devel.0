Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74497C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  9 May 2022 20:59:54 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E617F16D9;
	Mon,  9 May 2022 22:59:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E617F16D9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652129992;
	bh=j+wdfrc3FXi43X0VkODadFay6bg9FKNBstYCTMpecA8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=qfCENUZIMIev0cIF4IgI/2UwzPXJK3BrX5d4nCZLt/WvmHIkA1DOu4v76noV7+y1b
	 kotdqPGrU82iiN3usI6aOjWQN6fA4sCnPQeRQC8F6zFzxMXifI0OlXLgJA/z89S3qe
	 aDZGc92pCayfjkLG1xyViBJs7kUNYcMnNKh+no4E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6C2E7F80237;
	Mon,  9 May 2022 22:59:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4B32EF8025D; Mon,  9 May 2022 22:58:59 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0AFF7F800D3
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2022 22:58:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0AFF7F800D3
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="U74Ljn72"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: nfraprado) with ESMTPSA id 564EA1F42F48
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652129932;
 bh=j+wdfrc3FXi43X0VkODadFay6bg9FKNBstYCTMpecA8=;
 h=From:To:Cc:Subject:Date:From;
 b=U74Ljn728Csp+ET2xThho9d1REqGnsswajm8GHfb67k2/RQZQWrjH38iHELrF44Nj
 xjNY6xlKH4B+68AQjDzJ4U9UXWZJZvRQXVg+CE577q+KjYL03FmMa/3TLtBWPFbaJc
 CZtRlFSbP4P6LvKc4+03hk9wBfEX4V83iyBOVw4o1AuuX92sETE6/YrYOK5HC+RLse
 usJnlXHQmatb4Tr1cmtTPqJ7rXIY3//R6J9m5ZXiAvwzZW6PwC2awkxQcnstozW5iT
 i1yFHZ/MGA/PZzO3rWICOJ8hBGFEU41lmBA6aSosZ+mnNFsx4iQ1oOlQOIjrv9EE/V
 Tc+X6cFr8gC1Q==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties
Date: Mon,  9 May 2022 16:58:47 -0400
Message-Id: <20220509205847.607076-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
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

The Mediatek AFE PCM controller for MT8192 allows two I2S interfaces to
share the same clock and act as a single interface with both input and
output. Add patterns for these properties in the dt-binding. The
property is split into two patterns in order to allow all valid
interface pairings.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
The series from v1 of this patch was merged although some changes were
still needed in this patch, so the v1 of this patch was reverted [1] and
this standalone commit addresses the feedback from v1 and readds the
property.

[1] https://lore.kernel.org/all/20220509185625.580811-1-nfraprado@collabora.com

v1: https://lore.kernel.org/all/20220429203039.2207848-2-nfraprado@collabora.com/

Changes in v2:
- Added "mediatek," prefix to property
- Rewrote and added more information to property description
- Split into two patterns to validate that output-input pairings are
  done

 .../bindings/sound/mt8192-afe-pcm.yaml           | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
index 7a25bc9b8060..2abf43c6c2c3 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
@@ -54,6 +54,22 @@ properties:
       - const: aud_infra_clk
       - const: aud_infra_26m_clk
 
+patternProperties:
+  "^mediatek,i2s[13579]-share$":
+    description:
+      Each I2S interface has a single data line, input if its index is even or
+      output if the index is odd. An input and an output I2S interface can be
+      used together as if they were a single I2S interface with both input and
+      output data lines by sharing the same clock. This property represents this
+      pairing. The value should be the name of the interface whose clock is
+      used, and the property name the other interface that depends on this
+      clock.
+    pattern: "^I2S[0268]$"
+
+  "^mediatek,i2s[0268]-share$":
+    description: Same as above.
+    pattern: "^I2S[13579]$"
+
 required:
   - compatible
   - interrupts
-- 
2.36.0

