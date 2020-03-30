Return-Path: <SRS0=jBUr=5P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC07C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:35:27 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BDD3206DB
	for <alsa-devel@archiver.kernel.org>; Mon, 30 Mar 2020 14:35:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="eBNZonBY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BDD3206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5DFF11657;
	Mon, 30 Mar 2020 16:34:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5DFF11657
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585578925;
	bh=YweIgrcZR44ev35RtHjH3sJZZjrni88+9NR9wXvR6dE=;
	h=Date:From:To:Subject:In-Reply-To:Cc:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=eBNZonBYAsHStSLlEV8gnqPT3jPVDk6MTEO9R2AG8fOvnHE11H6HmHoM0tyJmkoEn
	 cYA9cVUQu24UwjAu6yQ1iHToxK4MAPVIJWMPLm+/5HCkzoTl0nu0qnGfJjpM+HgzeU
	 TO6JKxdFSgPvYdv/VesI6zZDcgINuNGiGnRb1s44=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AFEDCF80254;
	Mon, 30 Mar 2020 16:33:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 46F5AF8015C; Mon, 30 Mar 2020 16:32:59 +0200 (CEST)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by alsa1.perex.cz (Postfix) with ESMTP id 61013F800AA
 for <alsa-devel@alsa-project.org>; Mon, 30 Mar 2020 16:32:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 61013F800AA
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F02C9113E;
 Mon, 30 Mar 2020 07:32:54 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73A053F71E;
 Mon, 30 Mar 2020 07:32:54 -0700 (PDT)
Date: Mon, 30 Mar 2020 15:32:52 +0100
From: Mark Brown <broonie@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Subject: Applied "dt-bindings: sound: cs42l51: Remove unneeded I2C unit name"
 to the asoc tree
In-Reply-To: <20200327155721.7596-1-festevam@gmail.com>
Message-Id: <applied-20200327155721.7596-1-festevam@gmail.com>
X-Patchwork-Hint: ignore
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 benjamin.gaignard@st.com, Rob Herring <robh@kernel.org>, robh+dt@kernel.org,
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

The patch

   dt-bindings: sound: cs42l51: Remove unneeded I2C unit name

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From f3ca3f5b0966cfc2737178cca8a7a65b09991898 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <festevam@gmail.com>
Date: Fri, 27 Mar 2020 12:57:21 -0300
Subject: [PATCH] dt-bindings: sound: cs42l51: Remove unneeded I2C unit name

The following warning is seen with 'make dt_binding_check':

Documentation/devicetree/bindings/sound/cirrus,cs42l51.example.dts:18.15-34.11: Warning (unit_address_vs_reg): /example-0/i2c@0: node has a unit name, but no reg or ranges property

Fix it by removing the unneeded i2c unit name.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Rob Herring <robh@kernel.org>
Link: https://lore.kernel.org/r/20200327155721.7596-1-festevam@gmail.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml b/Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml
index efce847a3408..83f44f07ac3f 100644
--- a/Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml
+++ b/Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml
@@ -49,7 +49,7 @@ required:
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
-    i2c@0 {
+    i2c {
       #address-cells = <1>;
       #size-cells = <0>;
 
-- 
2.20.1

