Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C312C6FA82
	for <alsa-devel@archiver.kernel.org>; Thu, 15 Sep 2022 01:29:22 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD21018ED;
	Thu, 15 Sep 2022 03:28:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD21018ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1663205359;
	bh=DbVOWhPv3V0BMM1CvwixPaQHkzOCc8Uz8urdIlOknwQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dqDQH5iIpOgVEJ68hfG89V/ZrmMpWp0LmqCmOIkIOJBSgrZd9PgnDbLQ2QPASqrA0
	 gXXlElnUFzURAb4vca34YjersVXCKE6/cH1ZzaCytYbvEzjPSyWCB/l34GJ7j0ZLDi
	 T2ioAsnTMx7bdMNcnJBOxhZbzVNLt8T3Id2tWk0M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 433B2F8014B;
	Thu, 15 Sep 2022 03:28:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD1D4F8014E; Thu, 15 Sep 2022 03:28:25 +0200 (CEST)
Received: from maillog.nuvoton.com (maillog.nuvoton.com [202.39.227.15])
 by alsa1.perex.cz (Postfix) with ESMTP id 998BBF800C0
 for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2022 03:28:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 998BBF800C0
Received: from NTHCCAS01.nuvoton.com (NTHCCAS01.nuvoton.com [10.1.8.28])
 by maillog.nuvoton.com (Postfix) with ESMTP id 7DAF31C81206;
 Thu, 15 Sep 2022 09:28:13 +0800 (CST)
Received: from NTHCML01B.nuvoton.com (10.1.8.178) by NTHCCAS01.nuvoton.com
 (10.1.8.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 15 Sep
 2022 09:28:13 +0800
Received: from NTHCCAS04.nuvoton.com (10.1.8.29) by NTHCML01B.nuvoton.com
 (10.1.8.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Thu, 15 Sep
 2022 09:28:13 +0800
Received: from localhost.localdomain (10.11.36.27) by NTHCCAS04.nuvoton.com
 (10.1.12.25) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Thu, 15 Sep 2022 09:28:12 +0800
From: Wallace Lin <SJLIN0@nuvoton.com>
To: <broonie@kernel.org>
Subject: [PATCH] ASOC: nau8824: Fix semaphore is released unexpectedly
Date: Thu, 15 Sep 2022 09:28:00 +0800
Message-ID: <20220915012800.825196-1-SJLIN0@nuvoton.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Cc: alsa-devel@alsa-project.org, scott6986@gmail.com, WTLI@nuvoton.com,
 SJLIN0@nuvoton.com, KCHSU0@nuvoton.com, lgirdwood@gmail.com,
 YHCHuang@nuvoton.com, CTLIN0@nuvoton.com, dardar923@gmail.com,
 savagecin@gmail.com, supercraig0719@gmail.com
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

From: SJLIN0 <SJLIN0@nuvoton.com>

On resuming, we anticipate that the jack is detected before playback
or capture. Therefore, we use semaphore to control the jack detection
done without any bothering. During booting, the driver launches jack
detection and releases the semaphore. However, it doesn't perceive the
maniputation of semaphore is not like resuming procedure. This makes 
the semaphore's count value become to 2. There is more than one thread
can enter into the critical section. This may get unexpected situation
and make some chaos.


Signed-off-by: SJLIN0 <SJLIN0@nuvoton.com>
Signed-off-by: Wallace Lin <savagecin@gmail.com>
---
 sound/soc/codecs/nau8824.c | 17 ++++++++++++++---
 sound/soc/codecs/nau8824.h |  1 +
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 15596452ca37..4f19fd9b65d1 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -901,7 +901,10 @@ static void nau8824_jdet_work(struct work_struct *work)
 		NAU8824_IRQ_KEY_RELEASE_DIS |
 		NAU8824_IRQ_KEY_SHORT_PRESS_DIS, 0);
 
-	nau8824_sema_release(nau8824);
+	if (nau8824->resume_lock) {
+		nau8824_sema_release(nau8824);
+		nau8824->resume_lock = false;
+	}
 }
 
 static void nau8824_setup_auto_irq(struct nau8824 *nau8824)
@@ -966,7 +969,10 @@ static irqreturn_t nau8824_interrupt(int irq, void *data)
 		/* release semaphore held after resume,
 		 * and cancel jack detection
 		 */
-		nau8824_sema_release(nau8824);
+		if (nau8824->resume_lock) {
+			nau8824_sema_release(nau8824);
+			nau8824->resume_lock = false;
+		}
 		cancel_work_sync(&nau8824->jdet_work);
 	} else if (active_irq & NAU8824_KEY_SHORT_PRESS_IRQ) {
 		int key_status, button_pressed;
@@ -1524,6 +1530,7 @@ static int __maybe_unused nau8824_suspend(struct snd_soc_component *component)
 static int __maybe_unused nau8824_resume(struct snd_soc_component *component)
 {
 	struct nau8824 *nau8824 = snd_soc_component_get_drvdata(component);
+	int ret;
 
 	regcache_cache_only(nau8824->regmap, false);
 	regcache_sync(nau8824->regmap);
@@ -1531,7 +1538,10 @@ static int __maybe_unused nau8824_resume(struct snd_soc_component *component)
 		/* Hold semaphore to postpone playback happening
 		 * until jack detection done.
 		 */
-		nau8824_sema_acquire(nau8824, 0);
+		nau8824->resume_lock = true;
+		ret = nau8824_sema_acquire(nau8824, 0);
+		if (ret)
+			nau8824->resume_lock = false;
 		enable_irq(nau8824->irq);
 	}
 
@@ -1940,6 +1950,7 @@ static int nau8824_i2c_probe(struct i2c_client *i2c)
 	nau8824->regmap = devm_regmap_init_i2c(i2c, &nau8824_regmap_config);
 	if (IS_ERR(nau8824->regmap))
 		return PTR_ERR(nau8824->regmap);
+	nau8824->resume_lock = false;
 	nau8824->dev = dev;
 	nau8824->irq = i2c->irq;
 	sema_init(&nau8824->jd_sem, 1);
diff --git a/sound/soc/codecs/nau8824.h b/sound/soc/codecs/nau8824.h
index de4bae8281d0..5fcfc43dfc85 100644
--- a/sound/soc/codecs/nau8824.h
+++ b/sound/soc/codecs/nau8824.h
@@ -436,6 +436,7 @@ struct nau8824 {
 	struct semaphore jd_sem;
 	int fs;
 	int irq;
+	int resume_lock;
 	int micbias_voltage;
 	int vref_impedance;
 	int jkdet_polarity;
-- 
2.25.1

