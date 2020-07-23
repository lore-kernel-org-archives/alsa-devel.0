Return-Path: <SRS0=vWr5=BC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C726DC433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:40:24 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50AE2206C1
	for <alsa-devel@archiver.kernel.org>; Thu, 23 Jul 2020 18:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NGXXQXwd";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="pwyRB5vA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AE2206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gerhold.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5E12167E;
	Thu, 23 Jul 2020 20:39:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5E12167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595529622;
	bh=dyRObqwrzzFxlD7kLUZ1nN+O1Uu0b6LWkANnuaFW4yU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=NGXXQXwdyfLqbyXgstpHmSwPTpCp8GUge7/WxCP3LCoRzgPSqW9yTYvVMr9S0Gy9s
	 ekHkLquS+v2dqgeIkCUbxF9LCg6g02H2j7YvcBkHhd1qo4jjl2V99wTtT9Uz9ejblb
	 ispWrMyl6X+bUY3K7f8JXnYxwJkMxnN4Hgg9FpbI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 07A81F8020D;
	Thu, 23 Jul 2020 20:39:32 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06615F80279; Thu, 23 Jul 2020 20:39:30 +0200 (CEST)
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de
 [81.169.146.171])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D2D2BF8011F
 for <alsa-devel@alsa-project.org>; Thu, 23 Jul 2020 20:39:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D2D2BF8011F
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=gerhold.net header.i=@gerhold.net
 header.b="pwyRB5vA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1595529562;
 s=strato-dkim-0002; d=gerhold.net;
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
 X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
 bh=qqJZLpdj7kgtM/H7lNwEulh1DlG+WWUJieHz73huek4=;
 b=pwyRB5vAGEkZ8RGScUrWeVN6+IY7pSridXH2afQ8YmO8ZJzqFhjSHk9ZowKb/hEHB7
 /JgSS/HOs7MS8qr87iaeNRSnNtlMqZ9AVXq5/31JbRlrrtRanpZN16ZNemUB5akOdh58
 PR5FCxfGyiKFcUKySmhmQK/aBXZPIK2wo1yIaaxSXiGjLUoqJDbWgG+4Uiz/q7+sJrGu
 x7yh8ETy1vAFBbWF+Hst8d7dKONJVDmNcCHPXe99746rNp7b5xehI9XIGpHIC5oZuQ6N
 F7A9ndqTOCX2A60dCamFAzrk+F2yGn7hjYFnJKVnDRL5fOSsA+7232foElfXYmYbFT26
 ZYiQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXS7IYBkLahKxB4W6OBfnv"
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
 by smtp.strato.de (RZmta 46.10.5 DYNA|AUTH)
 with ESMTPSA id Y0939ew6NIdJ5IH
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Thu, 23 Jul 2020 20:39:19 +0200 (CEST)
From: Stephan Gerhold <stephan@gerhold.net>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 2/7] ASoC: qcom: common: Use
 snd_soc_dai_link_set_capabilities()
Date: Thu, 23 Jul 2020 20:38:59 +0200
Message-Id: <20200723183904.321040-3-stephan@gerhold.net>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200723183904.321040-1-stephan@gerhold.net>
References: <20200723183904.321040-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>,
 Stephan Gerhold <stephan@gerhold.net>, Patrick Lai <plai@codeaurora.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 ~postmarketos/upstreaming@lists.sr.ht, Cheng-Yi Chiang <cychiang@chromium.org>
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

Commit a2120089251f ("ASoC: qcom: common: set correct directions for dailinks")
introduced a call to q6afe_is_rx_port() to set the dpcm_playback/capture
parameters correctly. This is necessary because those parameters are now
validated to match the capabilities of the DAIs. [1]

The disadvantage of introducing the call to q6afe_is_rx_port() is that
it makes the qcom_snd_parse_of() helper dependent on the QDSP6 driver.
When the ADSP is bypassed (e.g. in apq8016-sbc) QDSP6 is not used.

There is a generic solution for this now: The correct direction for the links
is already defined by the DAI capabilities (e.g. rx ports only support playback).

Commit 25612477d20b ("ASoC: soc-dai: set dai_link dpcm_ flags with a helper")
introduced the snd_soc_dai_link_set_capabilities() function that we can use
to set dpcm_playback/dpcm_capture according to the capabilities of the DAIs.

Use that for both FE/BE DAI links to avoid the dependency on the QDSP6 driver.

[1]: https://lore.kernel.org/alsa-devel/20200616085409.GA110999@gerhold.net/

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 sound/soc/qcom/common.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/sound/soc/qcom/common.c b/sound/soc/qcom/common.c
index d677e83828af..030df6026562 100644
--- a/sound/soc/qcom/common.c
+++ b/sound/soc/qcom/common.c
@@ -4,7 +4,6 @@
 
 #include <linux/module.h>
 #include "common.h"
-#include "qdsp6/q6afe.h"
 
 int qcom_snd_parse_of(struct snd_soc_card *card)
 {
@@ -102,15 +101,6 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			}
 			link->no_pcm = 1;
 			link->ignore_pmdown_time = 1;
-
-			if (q6afe_is_rx_port(link->id)) {
-				link->dpcm_playback = 1;
-				link->dpcm_capture = 0;
-			} else {
-				link->dpcm_playback = 0;
-				link->dpcm_capture = 1;
-			}
-
 		} else {
 			dlc = devm_kzalloc(dev, sizeof(*dlc), GFP_KERNEL);
 			if (!dlc)
@@ -123,10 +113,9 @@ int qcom_snd_parse_of(struct snd_soc_card *card)
 			link->codecs->dai_name = "snd-soc-dummy-dai";
 			link->codecs->name = "snd-soc-dummy";
 			link->dynamic = 1;
-			link->dpcm_playback = 1;
-			link->dpcm_capture = 1;
 		}
 
+		snd_soc_dai_link_set_capabilities(link);
 		link->ignore_suspend = 1;
 		link->nonatomic = 1;
 		link->stream_name = link->name;
-- 
2.27.0

