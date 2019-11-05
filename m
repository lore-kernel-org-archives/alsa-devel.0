Return-Path: <SRS0=4Snk=Y5=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2A3C5DF60
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 23:55:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 377622077B
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Nov 2019 23:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="qQ3yqtPc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="WRuJ8XQu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 377622077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 95E4A16EB;
	Wed,  6 Nov 2019 00:55:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 95E4A16EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572998157;
	bh=ePrX1QoLitnWVUVn86aJUgb7qRpGFNb7iTS7gO7LHj0=;
	h=From:To:In-Reply-To:Date:Cc:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From;
	b=qQ3yqtPc+Jmuoucl91CWx/yW+RXroGO9wgfHGL9EdE9cScScSPIjCBeYMB2DDkRx7
	 D/4uqCRtp5u3sbReQkq1uPDh9mdIznM5zPP067ZucqBzQJ5BV7tIKZC60MhM6eeAji
	 5E5rEwxklXiFDqJQeLJdqGUNo1rUUL7A5tDZVfzY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90523F8065A;
	Wed,  6 Nov 2019 00:51:44 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9D8D8F80639; Wed,  6 Nov 2019 00:51:30 +0100 (CET)
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 311BEF805DF
 for <alsa-devel@alsa-project.org>; Wed,  6 Nov 2019 00:51:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 311BEF805DF
Authentication-Results: alsa1.perex.cz;
 dkim=pass (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk
 header.b="WRuJ8XQu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
 Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
 List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
 List-Archive; bh=Qel+lEz1HNxh5vAYl64CMMids/i4gZ99T20CEHDTyok=; b=WRuJ8XQuCwHp
 R7Youn89jQr1ozX8kD4VDU4H7es93/WpsLSPErFmSPvZZ3CiYfYsHQcBPCx3ugNwaL35r+3E3/0xP
 LNJWKcu+3szZLNWGPF0Y7GiXRFazjzavzPBOvTsl4ym4zvprbwvnGmIdoYfvhGnAxXG5+jS9Tnse/
 0fW3U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net
 ([82.37.168.47] helo=ypsilon.sirena.org.uk)
 by heliosphere.sirena.org.uk with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256) (Exim 4.92)
 (envelope-from <broonie@sirena.co.uk>)
 id 1iS8ba-00081L-8l; Tue, 05 Nov 2019 23:51:22 +0000
Received: by ypsilon.sirena.org.uk (Postfix, from userid 1000)
 id B87F62743280; Tue,  5 Nov 2019 23:51:21 +0000 (GMT)
From: Mark Brown <broonie@kernel.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87y2wu2528.wl-kuninori.morimoto.gx@renesas.com>
X-Patchwork-Hint: ignore
Message-Id: <20191105235121.B87F62743280@ypsilon.sirena.org.uk>
Date: Tue,  5 Nov 2019 23:51:21 +0000 (GMT)
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Subject: [alsa-devel] Applied "ASoC: soc-core: move snd_soc_register_dai()"
	to the asoc tree
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

The patch

   ASoC: soc-core: move snd_soc_register_dai()

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.5

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

From daf7737335bf555abf14031530fe8e47b46b373a Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 5 Nov 2019 15:46:55 +0900
Subject: [PATCH] ASoC: soc-core: move snd_soc_register_dai()

This patch moves snd_soc_register_dai() next to
snd_soc_register_dais().
This is prepare for snd_soc_register_dais() cleanup.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Link: https://lore.kernel.org/r/87y2wu2528.wl-kuninori.morimoto.gx@renesas.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 72 ++++++++++++++++++++++----------------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0ce333669138..fb5f01497498 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2597,42 +2597,6 @@ static struct snd_soc_dai *soc_add_dai(struct snd_soc_component *component,
 	return dai;
 }
 
-/**
- * snd_soc_register_dais - Register a DAI with the ASoC core
- *
- * @component: The component the DAIs are registered for
- * @dai_drv: DAI driver to use for the DAIs
- * @count: Number of DAIs
- */
-static int snd_soc_register_dais(struct snd_soc_component *component,
-				 struct snd_soc_dai_driver *dai_drv,
-				 size_t count)
-{
-	struct device *dev = component->dev;
-	struct snd_soc_dai *dai;
-	unsigned int i;
-	int ret;
-
-	dev_dbg(dev, "ASoC: dai register %s #%zu\n", dev_name(dev), count);
-
-	for (i = 0; i < count; i++) {
-
-		dai = soc_add_dai(component, dai_drv + i, count == 1 &&
-				  !component->driver->non_legacy_dai_naming);
-		if (dai == NULL) {
-			ret = -ENOMEM;
-			goto err;
-		}
-	}
-
-	return 0;
-
-err:
-	snd_soc_unregister_dais(component);
-
-	return ret;
-}
-
 /**
  * snd_soc_register_dai - Register a DAI dynamically & create its widgets
  *
@@ -2676,6 +2640,42 @@ int snd_soc_register_dai(struct snd_soc_component *component,
 }
 EXPORT_SYMBOL_GPL(snd_soc_register_dai);
 
+/**
+ * snd_soc_register_dais - Register a DAI with the ASoC core
+ *
+ * @component: The component the DAIs are registered for
+ * @dai_drv: DAI driver to use for the DAIs
+ * @count: Number of DAIs
+ */
+static int snd_soc_register_dais(struct snd_soc_component *component,
+				 struct snd_soc_dai_driver *dai_drv,
+				 size_t count)
+{
+	struct device *dev = component->dev;
+	struct snd_soc_dai *dai;
+	unsigned int i;
+	int ret;
+
+	dev_dbg(dev, "ASoC: dai register %s #%zu\n", dev_name(dev), count);
+
+	for (i = 0; i < count; i++) {
+
+		dai = soc_add_dai(component, dai_drv + i, count == 1 &&
+				  !component->driver->non_legacy_dai_naming);
+		if (dai == NULL) {
+			ret = -ENOMEM;
+			goto err;
+		}
+	}
+
+	return 0;
+
+err:
+	snd_soc_unregister_dais(component);
+
+	return ret;
+}
+
 static int snd_soc_component_initialize(struct snd_soc_component *component,
 	const struct snd_soc_component_driver *driver, struct device *dev)
 {
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
