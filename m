Return-Path: <SRS0=elh7=Z2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7A4C43603
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:16:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3A5A2081B
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 15:16:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BgQ47hn2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3A5A2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E9C1B1682;
	Wed,  4 Dec 2019 16:15:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E9C1B1682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575472566;
	bh=zZ6YRw5EwWbFWK6z5mipLUy1YF+s/XGKd52/jEPNWh8=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BgQ47hn2JPay3ap+O0nNmx/knTiOcr+SojE3TCmm0KOn1Uler7/ZBkzffR7soAVI4
	 uVS2DIgGsSv7bbr0GrtZaULk5XdKG4FiKwg9PoJVkDLmkYaXR/WqQfP8XlxVl94ju7
	 xVUTJ8Y6/SYqvqSQuaXWViEVG/24gSeGxZ54cOiY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8655AF8023E;
	Wed,  4 Dec 2019 16:15:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF0D0F80240; Wed,  4 Dec 2019 16:15:00 +0100 (CET)
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6D31CF800B4
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2019 16:14:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6D31CF800B4
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 47836ACB8;
 Wed,  4 Dec 2019 15:14:57 +0000 (UTC)
From: Takashi Iwai <tiwai@suse.de>
To: Mark Brown <broonie@kernel.org>
Date: Wed,  4 Dec 2019 16:14:54 +0100
Message-Id: <20191204151454.21643-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Cc: alsa-devel@alsa-project.org
Subject: [alsa-devel] [PATCH] ASoC: core: Fix access to uninitialized list
	heads
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

The error path of soc_new_pcm_runtime() invokes soc_free_pcm_runtime()
that may cause a few problems.  First off, it calls list_del() for
rtd->list that may not be initialized.  Similarly,
snd_soc_pcm_component_free() traverses over the component list that
may not be initialized, either.  Such access to the uninitialized list
head would lead to either a BUG_ON() or a memory corruption.

This patch fixes the access to uninitialized list heads by
initializing the list heads properly at the beginning before those
error paths.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/soc-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 0e2e628302f1..726e5de850c4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -478,6 +478,12 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 		goto free_rtd;
 
 	rtd->dev = dev;
+	INIT_LIST_HEAD(&rtd->list);
+	INIT_LIST_HEAD(&rtd->component_list);
+	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_PLAYBACK].be_clients);
+	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_CAPTURE].be_clients);
+	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_PLAYBACK].fe_clients);
+	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_CAPTURE].fe_clients);
 	dev_set_drvdata(dev, rtd);
 	INIT_DELAYED_WORK(&rtd->delayed_work, close_delayed_work);
 
@@ -493,12 +499,6 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 	/*
 	 * rtd remaining settings
 	 */
-	INIT_LIST_HEAD(&rtd->component_list);
-	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_PLAYBACK].be_clients);
-	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_CAPTURE].be_clients);
-	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_PLAYBACK].fe_clients);
-	INIT_LIST_HEAD(&rtd->dpcm[SNDRV_PCM_STREAM_CAPTURE].fe_clients);
-
 	rtd->card = card;
 	rtd->dai_link = dai_link;
 	if (!rtd->dai_link->ops)
-- 
2.16.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
