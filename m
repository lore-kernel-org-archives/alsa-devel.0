Return-Path: <SRS0=2rKR=B6=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A68CCC433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:47:06 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD23208C7
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Aug 2020 15:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="aAUiDZdd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="dyMIlJXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FD23208C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8C9141677;
	Thu, 20 Aug 2020 17:46:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8C9141677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597938424;
	bh=oDCFAIhrgKgSJ63FISertzBLamCZVj9KnKRiDSb/Smc=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=aAUiDZddCb9DrGxsqqDeW1v9xcEmMsBxdnO8S4ltiGFSR16f88W2pgJQCZbn7bJmZ
	 2+8SnOykX//BnO52f2uCBw+NiL5vhl3ggB8v0xfRZOUAM7UOepaZvObS6acnB8wtoI
	 yngG+6OZZy9nJ2iCbGdfGOpdXEqXo/Qa4oYGHq5c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E7C7AF801F9;
	Thu, 20 Aug 2020 17:46:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0C759F80228; Thu, 20 Aug 2020 17:46:09 +0200 (CEST)
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de
 [81.169.146.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D1FC3F80114
 for <alsa-devel@alsa-project.org>; Thu, 20 Aug 2020 17:45:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D1FC3F80114
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="dyMIlJXo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1597938355;
 s=strato-dkim-0002; d=gerhold.net;
 h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
 Subject:Sender;
 bh=DweA/cq0/iloaXFFVeVyBdCPYwKcL/boO0u1r/q5j8o=;
 b=dyMIlJXoV8g+PAhEFiYGezGo993Wasr75ToJnNDT8ZOTpRuOWd+tCaD7YCY4jNn7vg
 UvPlLMqtURW6UXBhDnL1E+45YOTj6XNkR8zVxG+q+hkodnf1K/g2z+bTAMHY1M4h6ofZ
 KpZ72h2slFTHw1Nv3bacVowpkPh+0oEskntBqXxZV1VS5Ai9ypCiIgGe1s/CiHv2kEcP
 Gjj7pV165bRNusYJlyU/c8wpYn26OsjZ9+QrhHhoL20GV3+xdsPnrx+xnMye9rpGQCfF
 XEUDWL57yeHuS1sJR0+fvm8BGwP7vJofZpKRpjPw9WZ2hrbrI5ViBLwfPKk946/kF+7/
 cbRQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB5m6ONqVX"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
 by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
 with ESMTPSA id g0b6c1w7KFjsFVP
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 20 Aug 2020 17:45:54 +0200 (CEST)
From: Stephan Gerhold <stephan@gerhold.net>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: qcom: Set card->owner to avoid warnings
Date: Thu, 20 Aug 2020 17:45:11 +0200
Message-Id: <20200820154511.203072-1-stephan@gerhold.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kenneth Westfield <kwestfie@codeaurora.org>,
 Banajit Goswami <bgoswami@codeaurora.org>,
 Stephan Gerhold <stephan@gerhold.net>, alsa-devel@alsa-project.org,
 Patrick Lai <plai@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Rohit kumar <rohitkr@codeaurora.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
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

On Linux 5.9-rc1 I get the following warning with apq8016-sbc:

WARNING: CPU: 2 PID: 69 at sound/core/init.c:207 snd_card_new+0x36c/0x3b0 [snd]
CPU: 2 PID: 69 Comm: kworker/2:1 Not tainted 5.9.0-rc1 #1
Workqueue: events deferred_probe_work_func
pc : snd_card_new+0x36c/0x3b0 [snd]
lr : snd_card_new+0xf4/0x3b0 [snd]
Call trace:
 snd_card_new+0x36c/0x3b0 [snd]
 snd_soc_bind_card+0x340/0x9a0 [snd_soc_core]
 snd_soc_register_card+0xf4/0x110 [snd_soc_core]
 devm_snd_soc_register_card+0x44/0xa0 [snd_soc_core]
 apq8016_sbc_platform_probe+0x11c/0x140 [snd_soc_apq8016_sbc]

This warning was introduced in
commit 81033c6b584b ("ALSA: core: Warn on empty module").
It looks like we are supposed to set card->owner to THIS_MODULE.

Fix this for all the qcom ASoC drivers.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Fixes: 79119c798649 ("ASoC: qcom: Add Storm machine driver")
Fixes: bdb052e81f62 ("ASoC: qcom: add apq8016 sound card support")
Fixes: a6f933f63f2f ("ASoC: qcom: apq8096: Add db820c machine driver")
Fixes: 6b1687bf76ef ("ASoC: qcom: add sdm845 sound card support")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 sound/soc/qcom/apq8016_sbc.c | 1 +
 sound/soc/qcom/apq8096.c     | 1 +
 sound/soc/qcom/sdm845.c      | 1 +
 sound/soc/qcom/storm.c       | 1 +
 4 files changed, 4 insertions(+)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index 083413abc2f6..575e2aefefe3 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -143,6 +143,7 @@ static int apq8016_sbc_platform_probe(struct platform_device *pdev)
 
 	card = &data->card;
 	card->dev = dev;
+	card->owner = THIS_MODULE;
 	card->dapm_widgets = apq8016_sbc_dapm_widgets;
 	card->num_dapm_widgets = ARRAY_SIZE(apq8016_sbc_dapm_widgets);
 
diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index 253549600c5a..1a69baefc5ce 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -114,6 +114,7 @@ static int apq8096_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	card->dev = dev;
+	card->owner = THIS_MODULE;
 	dev_set_drvdata(dev, card);
 	ret = qcom_snd_parse_of(card);
 	if (ret)
diff --git a/sound/soc/qcom/sdm845.c b/sound/soc/qcom/sdm845.c
index 0d10fba53945..ab1bf23c21a6 100644
--- a/sound/soc/qcom/sdm845.c
+++ b/sound/soc/qcom/sdm845.c
@@ -555,6 +555,7 @@ static int sdm845_snd_platform_probe(struct platform_device *pdev)
 	card->dapm_widgets = sdm845_snd_widgets;
 	card->num_dapm_widgets = ARRAY_SIZE(sdm845_snd_widgets);
 	card->dev = dev;
+	card->owner = THIS_MODULE;
 	dev_set_drvdata(dev, card);
 	ret = qcom_snd_parse_of(card);
 	if (ret)
diff --git a/sound/soc/qcom/storm.c b/sound/soc/qcom/storm.c
index c0c388d4db82..80c9cf2f254a 100644
--- a/sound/soc/qcom/storm.c
+++ b/sound/soc/qcom/storm.c
@@ -96,6 +96,7 @@ static int storm_platform_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	card->dev = &pdev->dev;
+	card->owner = THIS_MODULE;
 
 	ret = snd_soc_of_parse_card_name(card, "qcom,model");
 	if (ret) {
-- 
2.28.0

