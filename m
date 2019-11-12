Return-Path: <SRS0=v73L=ZE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19A8C43331
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 19:25:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43BE721A49
	for <alsa-devel@archiver.kernel.org>; Tue, 12 Nov 2019 19:25:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="n0bjCBeO";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="it+Piydf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43BE721A49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1218A1667;
	Tue, 12 Nov 2019 20:17:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1218A1667
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573586314;
	bh=7c9rqTAaVx4fc+5FEiU1SNU/kDZGp2j4CsAM15wKHv0=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=n0bjCBeOROZMHchVNELVWT7EKMxn4TF9jNsN256WKd3kUwv6D100Pz6OZnwKTiOEl
	 5++xm4qBMTEcfEecSHF4bk524kowCjvbb/GVmvLjZUVwq0QHl0rCvv8ymldF1EanzS
	 MEJ451KBXwnMeoGdg62AzirtJNuqUh9Umyq43TVo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8FE51F8048F;
	Tue, 12 Nov 2019 20:17:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7602CF8049C; Tue, 12 Nov 2019 20:17:42 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1C339F80275
 for <alsa-devel@alsa-project.org>; Tue, 12 Nov 2019 20:17:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1C339F80275
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="it+Piydf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=jKE+HdM/O060TtCOHemxkHkonhg7iC568/HaSxJiGOY=; b=it+PiydfDGka
 UA3jHkMAxitVC5Py1G5fw8IXG6govPTwkVUY9E2h8ky4kgoWAQb9H8M4ixJfncsoS4rg9iSRqGcEd
 ReBbSlSS0Q2P5f3gK5cJyG5WzU/BkrgSKEGPFkMLo1XIFXrGAVuzksCde9ET7AL2W+cfC0W/c3rZf
 5NvE4=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iUbfX-0000Co-He; Tue, 12 Nov 2019 19:17:39 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id 0B9AC274299F; Tue, 12 Nov 2019 19:17:38 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
In-Reply-To: <20191108153538.11970-1-robh@kernel.org>
X-Patchwork-Hint: ignore
Message-Id: <20191112191739.0B9AC274299F@ypsilon.sirena.org.uk>
Date: Tue, 12 Nov 2019 19:17:38 +0000 (GMT)
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Mark Brown <broonie@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [alsa-devel] Applied "dt-bindings: vendor-prefixes: Add 'fsi[ab]'
	to the list of non-vendor prefixes" to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   dt-bindings: vendor-prefixes: Add 'fsi[ab]' to the list of non-vendor prefixes

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From 5cff6fddb8dca9b3a367c190ec043f4f484c0679 Mon Sep 17 00:00:00 2001
From: Rob Herring <robh@kernel.org>
Date: Fri, 8 Nov 2019 09:35:38 -0600
Subject: [PATCH] dt-bindings: vendor-prefixes: Add 'fsi[ab]' to the list of
 non-vendor prefixes

'fsia' and 'fsib' property prefixes were added as schema in commit
2f52475bac7e ("ASoC: fsi: switch to yaml base Documentation").
Unfortunately to do checks on actual vendor prefixes, we have to track
the handful of prefixes which are not vendors like 'fsia' and 'fsib'.

Fixes: 2f52475bac7e ASoC: fsi: switch to yaml base Documentation
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>
Signed-off-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20191108153538.11970-1-robh@kernel.org
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 967e78c5ec0a..67b89db54aa2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -16,7 +16,7 @@ properties: {}
 patternProperties:
   # Prefixes which are not vendors, but followed the pattern
   # DO NOT ADD NEW PROPERTIES TO THIS LIST
-  "^(at25|devbus|dmacap|dsa|exynos|gpio-fan|gpio|gpmc|hdmi|i2c-gpio),.*": true
+  "^(at25|devbus|dmacap|dsa|exynos|fsi[ab]|gpio-fan|gpio|gpmc|hdmi|i2c-gpio),.*": true
   "^(keypad|m25p|max8952|max8997|max8998|mpmc),.*": true
   "^(pinctrl-single|#pinctrl-single|PowerPC),.*": true
   "^(pl022|pxa-mmc|rcar_sound|rotary-encoder|s5m8767|sdhci),.*": true
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
