Return-Path: <SRS0=Vq+j=XC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD1EC43331
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Sep 2019 16:39:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1091721871
	for <alsa-devel@archiver.kernel.org>; Sat,  7 Sep 2019 16:39:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="TjNQImGY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1091721871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 33BC815F8;
	Sat,  7 Sep 2019 18:38:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 33BC815F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567874342;
	bh=T+mlFnD7eUvjqhmkQPMUZ1yQiPCKSokrKV6ZbVXuCjU=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=TjNQImGYJzauanaazsRu0k9SaJZPlGRYaTY48ew6CRKQvNTu2VXc98FnOixcYDTFg
	 Mrg3lo6kmkeANRwejDnF60Ogbnns5rUAzlzyPjGKkr6xhna39lkbVEDZa7Uvu1HgT1
	 6F4/HR4zHPWOFnnp1rxW3jVQlp8oVDZSHqecdnnc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8B069F80529;
	Sat,  7 Sep 2019 18:37:19 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0598EF805E2; Sat,  7 Sep 2019 18:37:17 +0200 (CEST)
Received: from www1102.sakura.ne.jp (www1102.sakura.ne.jp [219.94.129.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4BCAF800C6
 for <alsa-devel@alsa-project.org>; Sat,  7 Sep 2019 18:37:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4BCAF800C6
Received: from fsav106.sakura.ne.jp (fsav106.sakura.ne.jp [27.133.134.233])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x87GawEt091896;
 Sun, 8 Sep 2019 01:36:58 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav106.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp);
 Sun, 08 Sep 2019 01:36:58 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav106.sakura.ne.jp)
Received: from localhost.localdomain (118.153.231.153.ap.dti.ne.jp
 [153.231.153.118]) (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x87GatL2091872
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Sun, 8 Sep 2019 01:36:57 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
To: Mark Brown <broonie@kernel.org>, David Yang <yangxiaohua@everest-semi.com>,
 Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>
Date: Sun,  8 Sep 2019 01:36:52 +0900
Message-Id: <20190907163653.9382-1-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH 1/2] ASoC: es8316: fix redundant codes of clock
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

This patch removes redundant null checks for optional MCLK clock.
And fix DT binding document for changing clock property to optional
from required.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
---
 .../bindings/sound/everest,es8316.txt         |  3 ++
 sound/soc/codecs/es8316.c                     | 31 ++++++++-----------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.txt b/Documentation/devicetree/bindings/sound/everest,es8316.txt
index aefcff9c48a2..1bf03c5f2af4 100644
--- a/Documentation/devicetree/bindings/sound/everest,es8316.txt
+++ b/Documentation/devicetree/bindings/sound/everest,es8316.txt
@@ -6,6 +6,9 @@ Required properties:
 
   - compatible  : should be "everest,es8316"
   - reg : the I2C address of the device for I2C
+
+Optional properties:
+
   - clocks : a list of phandle, should contain entries for clock-names
   - clock-names : should include as follows:
          "mclk" : master clock (MCLK) of the device
diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index d07d50f51b28..1424ecd6952c 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -373,11 +373,9 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 	if (freq == 0)
 		return 0;
 
-	if (es8316->mclk) {
-		ret = clk_set_rate(es8316->mclk, freq);
-		if (ret)
-			return ret;
-	}
+	ret = clk_set_rate(es8316->mclk, freq);
+	if (ret)
+		return ret;
 
 	/* Limit supported sample rates to ones that can be autodetected
 	 * by the codec running in slave mode.
@@ -712,20 +710,18 @@ static int es8316_probe(struct snd_soc_component *component)
 
 	es8316->component = component;
 
-	es8316->mclk = devm_clk_get(component->dev, "mclk");
-	if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
+	es8316->mclk = devm_clk_get_optional(component->dev, "mclk");
 	if (IS_ERR(es8316->mclk)) {
-		dev_err(component->dev, "clock is invalid, ignored\n");
-		es8316->mclk = NULL;
+		dev_err(component->dev, "unable to get mclk\n");
+		return PTR_ERR(es8316->mclk);
 	}
+	if (!es8316->mclk)
+		dev_warn(component->dev, "assuming static mclk\n");
 
-	if (es8316->mclk) {
-		ret = clk_prepare_enable(es8316->mclk);
-		if (ret) {
-			dev_err(component->dev, "unable to enable clock\n");
-			return ret;
-		}
+	ret = clk_prepare_enable(es8316->mclk);
+	if (ret) {
+		dev_err(component->dev, "unable to enable mclk\n");
+		return ret;
 	}
 
 	/* Reset codec and enable current state machine */
@@ -754,8 +750,7 @@ static void es8316_remove(struct snd_soc_component *component)
 {
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
 
-	if (es8316->mclk)
-		clk_disable_unprepare(es8316->mclk);
+	clk_disable_unprepare(es8316->mclk);
 }
 
 static const struct snd_soc_component_driver soc_component_dev_es8316 = {
-- 
2.23.0.rc1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
