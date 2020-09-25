Return-Path: <SRS0=F9G0=DC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD82C4741F
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:28:30 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F0C421741
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Sep 2020 21:28:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="dNSfeAFZ";
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="so1WgW4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F0C421741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BE2D3193E;
	Fri, 25 Sep 2020 23:27:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BE2D3193E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601069306;
	bh=rsHa5G5XUTWQrB0dTJW/DaW7JfBwwh/edaPi/fi8Cdg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dNSfeAFZQKSuKllMB0YrUYX2BLv+qiSlAIhydcvqGxy+HafqBWqwdx5qek/PVce8U
	 IpU8NrvT5Dx+/0GvFnE3ATZ36RbKVEdyk+T/tUr6Sj9rh0XBeZk2qYmLbK4/ZGoN7V
	 yHaRPwrXTZO4yPt1g/98fPWfir9lMl62VyFel5is=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 40EB4F80171;
	Fri, 25 Sep 2020 23:27:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 93362F801EB; Fri, 25 Sep 2020 23:27:34 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9537F80162
 for <alsa-devel@alsa-project.org>; Fri, 25 Sep 2020 23:27:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9537F80162
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="so1WgW4A"
Received: from localhost.localdomain (unknown [194.230.155.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D440221741;
 Fri, 25 Sep 2020 21:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601069247;
 bh=rsHa5G5XUTWQrB0dTJW/DaW7JfBwwh/edaPi/fi8Cdg=;
 h=From:To:Cc:Subject:Date:From;
 b=so1WgW4A41kEgBXmlZ983DIIRJZ8dQ+xNADsEZ9Y9klOPzZvX4odBIAJJ9GKcYSRj
 XDloJBJv8TMRc0w+s39dfqjhAgNWAFBLzXNb4k5rRdsNgJY0tbepIlKjmoI0JTFgoi
 8Los6f3Eya1a5C0XBa7b4ykutdNHeSEJBjTTpkdU=
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>, Fabio Estevam <festevam@gmail.com>,
 alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dt-bindings: sgtl5000: Add common clock properties
Date: Fri, 25 Sep 2020 23:27:19 +0200
Message-Id: <20200925212719.23286-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Cc: Krzysztof Kozlowski <krzk@kernel.org>
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

Add common properties appearing in DTSes (assigned-clocks and similar)
to fix dtbs_check warnings like:

  arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dt.yaml: audio-codec@a:
    'assigned-clock-parents', 'assigned-clock-rates', 'assigned-clocks' do not match any of the regexes: 'pinctrl-[0-9]+'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 Documentation/devicetree/bindings/sound/sgtl5000.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/sgtl5000.yaml b/Documentation/devicetree/bindings/sound/sgtl5000.yaml
index 4f29b63c54d3..d116c174b545 100644
--- a/Documentation/devicetree/bindings/sound/sgtl5000.yaml
+++ b/Documentation/devicetree/bindings/sound/sgtl5000.yaml
@@ -19,6 +19,10 @@ properties:
   "#sound-dai-cells":
     const: 0
 
+  assigned-clock-parents: true
+  assigned-clock-rates: true
+  assigned-clocks: true
+
   clocks:
     items:
       - description: the clock provider of SYS_MCLK
-- 
2.17.1

