Return-Path: <SRS0=TC80=MT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31216C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 05:34:16 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6853610D2
	for <alsa-devel@archiver.kernel.org>; Tue, 27 Jul 2021 05:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C6853610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6F4A21AEA;
	Tue, 27 Jul 2021 07:33:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6F4A21AEA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627364052;
	bh=bM7buRkCZUBxra241Ll4g8wWOV2m3XW4UbSbzECfuIw=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kxon7wbCmkCKY6aql6HEIPxrvmaUdHyiM4x9gxQ3CeUrHGtHBrBIIBoaTYm3PFFR0
	 //lkdqf69yy2qX3mxJHZ8EZARPfsECsLoIwIX8wxd5TZ+A98TDv0jLfTzesw8LzUIW
	 KXPivqodn3YO3kPbvMvsEfUVZBQ64rPepFnbkFiM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EABACF80258;
	Tue, 27 Jul 2021 07:33:21 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0A2A5F8020D; Tue, 27 Jul 2021 07:33:20 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0B384F8020D
 for <alsa-devel@alsa-project.org>; Tue, 27 Jul 2021 07:33:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0B384F8020D
X-IronPort-AV: E=McAfee;i="6200,9189,10057"; a="212093944"
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; d="scan'208";a="212093944"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2021 22:33:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,272,1620716400"; d="scan'208";a="516656281"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2021 22:33:04 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH] soundwire: intel: trap TRIGGER_SUSPEND in .trigger callback
Date: Tue, 27 Jul 2021 13:32:56 +0800
Message-Id: <20210727053256.29949-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: vkoul@kernel.org, alsa-devel@alsa-project.org,
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

This patch provides both a simplification of the suspend flows and a
better balanced operation during suspend/resume transition.

The exiting code relies on a convoluted way of dealing with suspend
signals. Since there is no .suspend DAI callback, we used the
component .suspend and marked all the component DAI dmas as
'suspended'. The information was used in the .prepare stage to
differentiate resume operations from xrun handling, and only
reinitialize SHIM registers and DMA in the former case.

While this solution has been working reliably for about 2 years, there
is a much better solution consisting in trapping the TRIGGER_SUSPEND
in the .trigger DAI ops. The DMA is still marked in the same way for
the .prepare op to run, but in addition the callbacks sent to DSP
firmware are now balanced.

Normal operation:
hw_params -> intel_params_stream
hw_free   -> intel_free_stream

suspend    -> intel_free_stream
prepare    -> intel_params_stream

This balanced operation was not required with existing SOF firmware
relying on static pipelines instantiated at every boot. With the
on-going transition to dynamic pipelines, it's however a requirement
to keep the use count for the DAI widget balanced across all
transitions.

Co-developed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 53 +++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index fb9c23e13206..a0178779a5ba 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1005,29 +1005,6 @@ static void intel_shutdown(struct snd_pcm_substream *substream,
 	pm_runtime_put_autosuspend(cdns->dev);
 }
 
-static int intel_component_dais_suspend(struct snd_soc_component *component)
-{
-	struct sdw_cdns_dma_data *dma;
-	struct snd_soc_dai *dai;
-
-	for_each_component_dais(component, dai) {
-		/*
-		 * we don't have a .suspend dai_ops, and we don't have access
-		 * to the substream, so let's mark both capture and playback
-		 * DMA contexts as suspended
-		 */
-		dma = dai->playback_dma_data;
-		if (dma)
-			dma->suspended = true;
-
-		dma = dai->capture_dma_data;
-		if (dma)
-			dma->suspended = true;
-	}
-
-	return 0;
-}
-
 static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
 				    void *stream, int direction)
 {
@@ -1056,11 +1033,39 @@ static void *intel_get_sdw_stream(struct snd_soc_dai *dai,
 	return dma->stream;
 }
 
+static int intel_trigger(struct snd_pcm_substream *substream, int cmd, struct snd_soc_dai *dai)
+{
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
+	struct sdw_cdns_dma_data *dma;
+
+	/*
+	 * The .prepare callback is used to deal with xruns and resume operations. In the case
+	 * of xruns, the DMAs and SHIM registers cannot be touched, but for resume operations the
+	 * DMAs and SHIM registers need to be initialized.
+	 * the .trigger callback is used to track the suspend case only.
+	 */
+	if (cmd != SNDRV_PCM_TRIGGER_SUSPEND)
+		return 0;
+
+	dma = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dma) {
+		dev_err(dai->dev, "failed to get dma data in %s\n",
+			__func__);
+		return -EIO;
+	}
+
+	dma->suspended = true;
+
+	return intel_free_stream(sdw, substream, dai, sdw->instance);
+}
+
 static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 	.startup = intel_startup,
 	.hw_params = intel_hw_params,
 	.prepare = intel_prepare,
 	.hw_free = intel_hw_free,
+	.trigger = intel_trigger,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pcm_set_sdw_stream,
 	.get_sdw_stream = intel_get_sdw_stream,
@@ -1071,6 +1076,7 @@ static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
 	.hw_params = intel_hw_params,
 	.prepare = intel_prepare,
 	.hw_free = intel_hw_free,
+	.trigger = intel_trigger,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pdm_set_sdw_stream,
 	.get_sdw_stream = intel_get_sdw_stream,
@@ -1078,7 +1084,6 @@ static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
 
 static const struct snd_soc_component_driver dai_component = {
 	.name           = "soundwire",
-	.suspend	= intel_component_dais_suspend
 };
 
 static int intel_create_dai(struct sdw_cdns *cdns,
-- 
2.17.1

