Return-Path: <SRS0=Sdsu=W6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BB9C3A5A2
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:55:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1BC522CF8
	for <alsa-devel@archiver.kernel.org>; Tue,  3 Sep 2019 16:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="gLXD8Axm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1BC522CF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=katsuster.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E5B85168F;
	Tue,  3 Sep 2019 18:54:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E5B85168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567529730;
	bh=UaBQV6i3CpNd+kze16km+LfTKyzG6+ryDs/XDcBtxGc=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gLXD8AxmrUo7Bm5SGvRq5vyW9cBUleJPP1WbPwoqUih0tcX+MfOXEUtinOmpVb40X
	 2VziYh1S6hoPmARXrLTdNdWux2XIStFQxQP0GhPXue+wetuU/quDPc2juteh7okUzi
	 6KKyJKbGzCtQ8FTIMVN1ZB7qJahxTY1hDugnSIFU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 06405F805A1;
	Tue,  3 Sep 2019 18:53:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 97F61F8049B; Tue,  3 Sep 2019 18:53:41 +0200 (CEST)
Received: from www1102.sakura.ne.jp (www1102.sakura.ne.jp [219.94.129.142])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 969FCF803D7
 for <alsa-devel@alsa-project.org>; Tue,  3 Sep 2019 18:53:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 969FCF803D7
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id x83GrQDM037052;
 Wed, 4 Sep 2019 01:53:26 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp);
 Wed, 04 Sep 2019 01:53:26 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/530/fsav401.sakura.ne.jp)
Received: from localhost.localdomain (118.153.231.153.ap.dti.ne.jp
 [153.231.153.118]) (authenticated bits=0)
 by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id x83GrNwl037038
 (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
 Wed, 4 Sep 2019 01:53:25 +0900 (JST)
 (envelope-from katsuhiro@katsuster.net)
From: Katsuhiro Suzuki <katsuhiro@katsuster.net>
To: Mark Brown <broonie@kernel.org>, David Yang <yangxiaohua@everest-semi.com>,
 Daniel Drake <drake@endlessm.com>, Hans de Goede <hdegoede@redhat.com>
Date: Wed,  4 Sep 2019 01:53:20 +0900
Message-Id: <20190903165322.20791-2-katsuhiro@katsuster.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190903165322.20791-1-katsuhiro@katsuster.net>
References: <20190903165322.20791-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [alsa-devel] [PATCH v3 2/4] ASoC: es8316: add clock control of MCLK
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

This patch introduce clock property for MCLK master freq control.
Driver will set rate of MCLK master if set_sysclk is called and
changing sysclk by board driver.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>

---

Changes from v1:
  - Output logs if clock error is found
  - Disable and unprepare mclk when remove this driver
---
 sound/soc/codecs/es8316.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/sound/soc/codecs/es8316.c b/sound/soc/codecs/es8316.c
index 229808fa627c..ab41f2c056bd 100644
--- a/sound/soc/codecs/es8316.c
+++ b/sound/soc/codecs/es8316.c
@@ -9,6 +9,7 @@
 
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/i2c.h>
 #include <linux/mod_devicetable.h>
@@ -33,6 +34,7 @@ static const unsigned int supported_mclk_lrck_ratios[] = {
 
 struct es8316_priv {
 	struct mutex lock;
+	struct clk *mclk;
 	struct regmap *regmap;
 	struct snd_soc_component *component;
 	struct snd_soc_jack *jack;
@@ -363,12 +365,19 @@ static int es8316_set_dai_sysclk(struct snd_soc_dai *codec_dai,
 {
 	struct snd_soc_component *component = codec_dai->component;
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	es8316->sysclk = freq;
 
 	if (freq == 0)
 		return 0;
 
+	if (es8316->mclk) {
+		ret = clk_set_rate(es8316->mclk, freq);
+		if (ret)
+			return ret;
+	}
+
 	return 0;
 }
 
@@ -693,9 +702,26 @@ static int es8316_set_jack(struct snd_soc_component *component,
 static int es8316_probe(struct snd_soc_component *component)
 {
 	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	es8316->component = component;
 
+	es8316->mclk = devm_clk_get(component->dev, "mclk");
+	if (PTR_ERR(es8316->mclk) == -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	if (IS_ERR(es8316->mclk)) {
+		dev_err(component->dev, "clock is invalid, ignored\n");
+		es8316->mclk = NULL;
+	}
+
+	if (es8316->mclk) {
+		ret = clk_prepare_enable(es8316->mclk);
+		if (ret) {
+			dev_err(component->dev, "unable to enable clock\n");
+			return ret;
+		}
+	}
+
 	/* Reset codec and enable current state machine */
 	snd_soc_component_write(component, ES8316_RESET, 0x3f);
 	usleep_range(5000, 5500);
@@ -718,8 +744,17 @@ static int es8316_probe(struct snd_soc_component *component)
 	return 0;
 }
 
+static void es8316_remove(struct snd_soc_component *component)
+{
+	struct es8316_priv *es8316 = snd_soc_component_get_drvdata(component);
+
+	if (es8316->mclk)
+		clk_disable_unprepare(es8316->mclk);
+}
+
 static const struct snd_soc_component_driver soc_component_dev_es8316 = {
 	.probe			= es8316_probe,
+	.remove			= es8316_remove,
 	.set_jack		= es8316_set_jack,
 	.controls		= es8316_snd_controls,
 	.num_controls		= ARRAY_SIZE(es8316_snd_controls),
-- 
2.23.0.rc1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
