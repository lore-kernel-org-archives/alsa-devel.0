Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD27C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jun 2022 07:45:09 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E2A3A18C4;
	Tue,  7 Jun 2022 09:44:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E2A3A18C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1654587908;
	bh=1jPp8fMmVfccfQKI95Y2ZdbPWmwS1nxMggTP71GqSJM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=lREw3gWP9UEHVKVLWpXUXan6ohtEEo3+DsbY/3qJVFOwbuQKuHen/AfYFxFAL6CfO
	 etIwvsAVia8InxQJGT+DCvTEex3t/d33D9o6qQIZfgXf3YMAMvScLxQ1L+UwGH5ThW
	 sgUgi6QNA66gTdqWeli1P3/bfUoMwjVC1pr20uag=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 82EA2F80116;
	Tue,  7 Jun 2022 09:44:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7974AF80116; Tue,  7 Jun 2022 09:44:16 +0200 (CEST)
Received: from mail.shift-gmbh.com (mail.shift-gmbh.com [85.10.195.145])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6902FF80116
 for <alsa-devel@alsa-project.org>; Tue,  7 Jun 2022 09:44:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6902FF80116
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=shiftphones.com header.i=@shiftphones.com
 header.b="APfhe2yp"
From: Alexander Martinz <amartinz@shiftphones.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shiftphones.com;
 s=2018; t=1654587849;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=GgHqv91xtDPT2OEbMPNAx9fBgy2xHBtE3Y0HuLoRfss=;
 b=APfhe2ypnM9Th4dzKXX3dmJlMsKRxitnyLVzNQlNbNU+ZKcNKJfZ92KaxkWtHbKCwfokae
 ggassWgauXib4xD8oBibMonVeVb5btUMkj7EmYx/kAWQS9ndp2u87Mkm0aXg3z8fFrHqUZ
 qc3i9WvuwixveMkXq2GabkQbALv4eAfN74cGfXmFArL8JsbXe3bUCo25MpnLc7+l4rP8z6
 fmrgGWV/TB7CZLVR9BHha1ocLIG/VifxAUzYTGUwU8bdWqIYHyQ96eeFB/ZGxrfRASTLrr
 eJKMiowGtfLNvgxOXfxTyyzR4Y+mq7CPghM/0MlFDPiHq097mSrs65B247Jq7g==
To: ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH v2 1/2] ASoC: dt-bindings: nxp,tfa989x: Add tfa9890 support
Date: Tue,  7 Jun 2022 09:43:29 +0200
Message-Id: <20220607074329.13129-1-amartinz@shiftphones.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
 auth=pass smtp.auth=amartinz@shiftphones.com
 smtp.mailfrom=amartinz@shiftphones.com
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
 Stephan Gerhold <stephan@gerhold.net>, Dylan Van Assche <me@dylanvanassche.be>,
 Alexander Martinz <amartinz@shiftphones.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Caleb Connolly <caleb@connolly.tech>, Mark Brown <broonie@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 phone-devel@vger.kernel.org, Rob Herring <robh@kernel.org>
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

Document TFA9890 binding for tfa989x.

Signed-off-by: Alexander Martinz <amartinz@shiftphones.com>
Reviewed-by: Stephan Gerhold <stephan@gerhold.net>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
index b9b1dba40856..7f2e68ff6d34 100644
--- a/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
+++ b/Documentation/devicetree/bindings/sound/nxp,tfa989x.yaml
@@ -15,6 +15,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - nxp,tfa9890
       - nxp,tfa9895
       - nxp,tfa9897
 
-- 
2.36.1

