Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 597A0C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  9 May 2022 18:57:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 220B416BF;
	Mon,  9 May 2022 20:56:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 220B416BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652122649;
	bh=ZLYs6CI7s8Jj8EeHsrXSw3oRF8/mCUSKeayVDMKYyPg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Rm+2kIyIqVThYIWfJ3Ez/EgB90mdCupMW0Zizb8N3jCjj6GW4UmStFbGzeusoaC/f
	 K0l/J6BN2PiOi0nRjh0OcJTzBuajygu/fr2L5BOZHj5GD1HN4Tsr+bZ7/kyp0c+ZfT
	 5PpPli5muHjzdk7VthM88HTnTTVEnL+X5/Yekedo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B7CE2F8011C;
	Mon,  9 May 2022 20:56:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A22AAF8011C; Mon,  9 May 2022 20:56:37 +0200 (CEST)
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 79BE1F8011C
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2022 20:56:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 79BE1F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com
 header.b="HJiXLwHH"
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: nfraprado) with ESMTPSA id B58901F44049
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1652122590;
 bh=ZLYs6CI7s8Jj8EeHsrXSw3oRF8/mCUSKeayVDMKYyPg=;
 h=From:To:Cc:Subject:Date:From;
 b=HJiXLwHH5YEw2s3HHpeH4aPABH0EI2Upl5k26VzT/j4d5Pyx5F75JtEBDK4qU/Wwi
 UuMqI0weAy9luNMb7N1ZL3BxlwAYAJ7xwABSgHk/GIJ9aChTjiZqZP3z/+YJQYCW2K
 +vsBYYr1BxTJ8qu2KhjAOfsOHl3OUck2aUdZsLa8wDs2CFTfolSH6SctvjcXGnQNF3
 q3thmdZaq9qwWlbqPoH/yyHmJo+PwRfEzUpVpajC8CPKP4EjAkabUMIrX3K4V4yGym
 Dk2Guf3NbgXDSmrbsd79FcJLM3rU7hMUZNxVPRRGmfgCpvQZFuapCqYoFeeaAlWNRZ
 Hia2Y5fzdMpSQ==
From: =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] Revert "ASoC: dt-bindings: mediatek: mt8192: Add i2s-share
 properties"
Date: Mon,  9 May 2022 14:56:25 -0400
Message-Id: <20220509185625.580811-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=
 <nfraprado@collabora.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jiaxin Yu <jiaxin.yu@mediatek.com>, linux-kernel@vger.kernel.org,
 Shane Chien <shane.chien@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, kernel@collabora.com,
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

This reverts commit e056cf4341ae3f856f1e38da02b27cb04de4c69b. The commit
was merged while the property name and definition were still being
discussed. Revert the commit for now and a follow up commit will re-add
the property after it is further discussed and reviewed.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
index 5b03c8dbf318..7a25bc9b8060 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-afe-pcm.yaml
@@ -54,11 +54,6 @@ properties:
       - const: aud_infra_clk
       - const: aud_infra_26m_clk
 
-patternProperties:
-  "^i2s[0-35-9]-share$":
-    description: Name of the I2S bus that is shared with this bus
-    pattern: "^I2S[0-35-9]$"
-
 required:
   - compatible
   - interrupts
-- 
2.36.0

