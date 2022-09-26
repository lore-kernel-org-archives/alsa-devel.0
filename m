Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DACCC32771
	for <alsa-devel@archiver.kernel.org>; Mon, 26 Sep 2022 16:59:25 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 113381E4;
	Mon, 26 Sep 2022 18:58:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 113381E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1664211562;
	bh=9I21n5VpqNXXeBUHD6j3FB4WOKBTn143jGs7HvFqcAY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=eATDrkscSzwLx7cmMEhmiHbJwXigCkcVbU7hWIHA5BKO9ygQVBI7yvWmhnyLZgvXi
	 +/XEEWwdCdh5NXImwowe3YWbiVd5jNvR8ekKMu3UEp/iPjpCOseFMoGdRsIU+3rHWm
	 8lpGEwtImrii9bA7uzq8FAgnGbn3f28iZFwtDsvM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DECFF80254;
	Mon, 26 Sep 2022 18:58:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 485F6F8027D; Mon, 26 Sep 2022 18:58:30 +0200 (CEST)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 12AC2F8011C
 for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2022 18:58:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 12AC2F8011C
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id 22BEC5202DB;
 Mon, 26 Sep 2022 18:58:20 +0200 (CEST)
Received: from localhost.localdomain (10.72.94.2) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.12; Mon, 26 Sep
 2022 18:58:19 +0200
From: Eugeniu Rosca <erosca@de.adit-jv.com>
To: Lars-Peter Clausen <lars@metafoo.de>, Vinod Koul <vkoul@kernel.org>, Mark
 Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>, <alsa-devel@alsa-project.org>,
 <linux-kernel@vger.kernel.org>
Subject: [PATCH] ALSA: dmaengine: increment buffer pointer atomically
Date: Mon, 26 Sep 2022 18:58:13 +0200
Message-ID: <1664211493-11789-1-git-send-email-erosca@de.adit-jv.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.72.94.2]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
Cc: Jiada Wang <jiada_wang@mentor.com>, Dean Jenkins <Dean_Jenkins@mentor.com>,
 Eugeniu Rosca <erosca@de.adit-jv.com>, Andreas Pape <apape@de.adit-jv.com>,
 Eugeniu Rosca <roscaeugeniu@gmail.com>
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

From: Andreas Pape <apape@de.adit-jv.com>

Setting pointer and afterwards checking for wraparound leads
to the possibility of returning the inconsistent pointer position.

This patch increments buffer pointer atomically to avoid this issue.

Fixes: e7f73a1613567a ("ASoC: Add dmaengine PCM helper functions")
Signed-off-by: Andreas Pape <apape@de.adit-jv.com>
Signed-off-by: Eugeniu Rosca <erosca@de.adit-jv.com>
---
 sound/core/pcm_dmaengine.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 5b2ca028f5aa..494ec0c207fa 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -133,12 +133,14 @@ EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_config_from_dai_data);
 
 static void dmaengine_pcm_dma_complete(void *arg)
 {
+	unsigned int new_pos;
 	struct snd_pcm_substream *substream = arg;
 	struct dmaengine_pcm_runtime_data *prtd = substream_to_prtd(substream);
 
-	prtd->pos += snd_pcm_lib_period_bytes(substream);
-	if (prtd->pos >= snd_pcm_lib_buffer_bytes(substream))
-		prtd->pos = 0;
+	new_pos = prtd->pos + snd_pcm_lib_period_bytes(substream);
+	if (new_pos >= snd_pcm_lib_buffer_bytes(substream))
+		new_pos = 0;
+	prtd->pos = new_pos;
 
 	snd_pcm_period_elapsed(substream);
 }
-- 
2.37.2

