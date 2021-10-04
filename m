Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68552C433EF
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 18:57:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915BE61425
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 18:57:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 915BE61425
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FCB8166E;
	Mon,  4 Oct 2021 20:57:06 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FCB8166E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633373876;
	bh=g5i3/v1QBIE0SuBkA/Qluu0b2fEZ0pCghh45bbPQDCI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Z8J5pm8KrZYrB7ojUYNPCsNcTbTI/vNTXFyPlTEANZiBLTD7LFWdy/VMB4qHwvqu7
	 ph3Pkf78pgxE5irL1m3JwPxpQcuabInH43IzNWpece9q00M2cCp2ez5OpyjYEv/BXJ
	 nDb4YCP5sDq0/kPUuDitoLejbbY40RyV2Hl2c2hI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B27A2F804EB;
	Mon,  4 Oct 2021 20:55:25 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2ED37F804FC; Mon,  4 Oct 2021 20:55:24 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 036D9F804EB
 for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2021 20:55:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 036D9F804EB
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="206360944"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; d="scan'208";a="206360944"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2021 10:14:44 -0700
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; d="scan'208";a="523435382"
Received: from mbrescia-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.77.4])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2021 10:14:43 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/5] ASoC: SOF: Intel: hda-dai: improve SSP DAI handling for
 dynamic pipelines
Date: Mon,  4 Oct 2021 12:14:30 -0500
Message-Id: <20211004171430.103674-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004171430.103674-1-pierre-louis.bossart@linux.intel.com>
References: <20211004171430.103674-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
 Bard Liao <bard.liao@intel.com>
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

In order to keep the widget use_count balanced, make sure the DAI
widgets are allocated once in hw_params and released in hw_free. A
'setup' status flag is used to deal with cases where the .hw_params
callback is invoked multiple times, and likewise with cases where
hw_free is invoked without hw_params being called first (which can
happen if the FE hw_params fails).

In addition, this patch frees the widgets in the suspend transition,
and reallocates them in the .prepare callback. The 'setup' flag helps
in this case differentiate between resume (setup needed) and
xruns (setup not needed).

This balanced operation was not needed previously but will be required
when SOF dynamic pipelines are enabled.

Co-developed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c | 82 ++++++++++++++++++++++++++++++++++-
 1 file changed, 80 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 59d6750c6a20..dfd2df0b1bc3 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -440,6 +440,11 @@ static const struct snd_soc_dai_ops hda_link_dai_ops = {
 
 #endif
 
+/* only one flag used so far to harden hw_params/hw_free/trigger/prepare */
+struct ssp_dai_dma_data {
+	bool setup;
+};
+
 static int ssp_dai_setup_or_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai,
 				 bool setup)
 {
@@ -469,22 +474,95 @@ static int ssp_dai_setup_or_free(struct snd_pcm_substream *substream, struct snd
 	return hda_ctrl_dai_widget_free(w);
 }
 
+static int ssp_dai_startup(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	struct ssp_dai_dma_data *dma_data;
+
+	dma_data = kzalloc(sizeof(*dma_data), GFP_KERNEL);
+	if (!dma_data)
+		return -ENOMEM;
+
+	snd_soc_dai_set_dma_data(dai, substream, dma_data);
+
+	return 0;
+}
+
+static int ssp_dai_setup(struct snd_pcm_substream *substream,
+			 struct snd_soc_dai *dai,
+			 bool setup)
+{
+	struct ssp_dai_dma_data *dma_data;
+	int ret = 0;
+
+	dma_data = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dma_data) {
+		dev_err(dai->dev, "%s: failed to get dma_data\n", __func__);
+		return -EIO;
+	}
+
+	if (dma_data->setup != setup) {
+		ret = ssp_dai_setup_or_free(substream, dai, setup);
+		if (!ret)
+			dma_data->setup = setup;
+	}
+	return ret;
+}
+
 static int ssp_dai_hw_params(struct snd_pcm_substream *substream,
 			     struct snd_pcm_hw_params *params,
 			     struct snd_soc_dai *dai)
 {
-	return ssp_dai_setup_or_free(substream, dai, true);
+	/* params are ignored for now */
+	return ssp_dai_setup(substream, dai, true);
+}
+
+static int ssp_dai_prepare(struct snd_pcm_substream *substream,
+			   struct snd_soc_dai *dai)
+{
+	/*
+	 * the SSP will only be reconfigured during resume operations and
+	 * not in case of xruns
+	 */
+	return ssp_dai_setup(substream, dai, true);
+}
+
+static int ssp_dai_trigger(struct snd_pcm_substream *substream,
+			   int cmd, struct snd_soc_dai *dai)
+{
+	if (cmd != SNDRV_PCM_TRIGGER_SUSPEND)
+		return 0;
+
+	return ssp_dai_setup(substream, dai, false);
 }
 
 static int ssp_dai_hw_free(struct snd_pcm_substream *substream,
 			   struct snd_soc_dai *dai)
 {
-	return ssp_dai_setup_or_free(substream, dai, false);
+	return ssp_dai_setup(substream, dai, false);
+}
+
+static void ssp_dai_shutdown(struct snd_pcm_substream *substream,
+			     struct snd_soc_dai *dai)
+{
+	struct ssp_dai_dma_data *dma_data;
+
+	dma_data = snd_soc_dai_get_dma_data(dai, substream);
+	if (!dma_data) {
+		dev_err(dai->dev, "%s: failed to get dma_data\n", __func__);
+		return;
+	}
+	snd_soc_dai_set_dma_data(dai, substream, NULL);
+	kfree(dma_data);
 }
 
 static const struct snd_soc_dai_ops ssp_dai_ops = {
+	.startup = ssp_dai_startup,
 	.hw_params = ssp_dai_hw_params,
+	.prepare = ssp_dai_prepare,
+	.trigger = ssp_dai_trigger,
 	.hw_free = ssp_dai_hw_free,
+	.shutdown = ssp_dai_shutdown,
 };
 
 /*
-- 
2.25.1

