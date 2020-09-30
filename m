Return-Path: <SRS0=iKRb=DH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B96C4727C
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:54:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C8F62076B
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 14:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="R5uRpUM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C8F62076B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AF96A17EA;
	Wed, 30 Sep 2020 16:53:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AF96A17EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601477683;
	bh=PVaLrX+9nnoDA1goMMGnFwWu1Y0GcKPZQlNA7n6CwN4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=R5uRpUM2lbmN0SVWfg5aaBe0oin4XLA4PpiIKp46kt569xeRex0a24E4Sd88DabwL
	 1KyDKdMOMuZNKFflX0bc/r8LHPHiRqakJQHnCEBFCfGnE42ezxdGbVUtIdzdobXY92
	 v3coIAcSjh2O0Hqtfmnt/01gkAGyvE3zdVS7Uf8E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 3A35FF801D8;
	Wed, 30 Sep 2020 16:53:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5DD63F801ED; Wed, 30 Sep 2020 16:53:51 +0200 (CEST)
Received: from relay12.mail.gandi.net (relay12.mail.gandi.net [217.70.178.232])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0E6EBF800DF
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2020 16:53:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0E6EBF800DF
Received: from localhost (lfbn-lyo-1-1908-165.w90-65.abo.wanadoo.fr
 [90.65.88.165]) (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 7D698200006;
 Wed, 30 Sep 2020 14:53:38 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH] ASoC: atmel-pcm: remove unnecessary include
Date: Wed, 30 Sep 2020 16:53:30 +0200
Message-Id: <20200930145330.3043528-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
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

Since commit 95e0e07e710e ("ASoC: atmel-pcm: use generic dmaengine
framework"), the driver is using dmaengine and is not using any definition
from include/linux/platform_data/dma-atmel.h, stop including it.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 sound/soc/atmel/atmel-pcm-dma.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/atmel/atmel-pcm-dma.c b/sound/soc/atmel/atmel-pcm-dma.c
index e597e35459ce..96a8c7dba98f 100644
--- a/sound/soc/atmel/atmel-pcm-dma.c
+++ b/sound/soc/atmel/atmel-pcm-dma.c
@@ -18,7 +18,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/dmaengine.h>
 #include <linux/atmel-ssc.h>
-#include <linux/platform_data/dma-atmel.h>
 
 #include <sound/core.h>
 #include <sound/pcm.h>
-- 
2.26.2

