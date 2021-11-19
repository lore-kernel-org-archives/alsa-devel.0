Return-Path: <SRS0=cfk+=QG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6F3C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Nov 2021 19:38:02 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 387AD61221
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Nov 2021 19:38:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 387AD61221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 953DA1795;
	Fri, 19 Nov 2021 20:37:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 953DA1795
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637350680;
	bh=U/8LllcCT+neSY6N7n0i0jsCyk3FaI4lFyyXaw+qoBs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=DvjsRRsWNEzLqQ7Ho7Yjid5tBltjLkaBTJqRs/1Vx0jc6CmpER6RYbjRF7uLe86sU
	 4b9wnwoTQgIVnq/y/8VfWG38SGkEHR3w+PuN4u1hejT4Nk2tfa9NQKz4i16LPgJS+t
	 xEkICTq/HESIVy0iDKBjziGHvnBNIvBsgtGJE8Q4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B3810F80525;
	Fri, 19 Nov 2021 20:34:49 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DE484F80517; Fri, 19 Nov 2021 20:34:46 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E7803F80517
 for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2021 20:34:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E7803F80517
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="234716047"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; d="scan'208";a="234716047"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2021 11:34:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; d="scan'208";a="473651331"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga002.jf.intel.com with ESMTP; 19 Nov 2021 11:34:30 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 10/10] ASoC: SOF: Intel: hda: free DAI widget during stop and
 suspend
Date: Fri, 19 Nov 2021 21:26:21 +0200
Message-Id: <20211119192621.4096077-11-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211119192621.4096077-1-kai.vehmanen@linux.intel.com>
References: <20211119192621.4096077-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

To keep the widget use_counts balanced, free the DAI widget
during suspend and also during the stop trigger.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai.c | 23 ++---------------------
 1 file changed, 2 insertions(+), 21 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index 76579383d290..5c9ee6c49473 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -182,24 +182,6 @@ static struct sof_ipc_dai_config *hda_dai_update_config(struct snd_soc_dapm_widg
 	return config;
 }
 
-static int hda_link_config_ipc(struct sof_intel_hda_stream *hda_stream,
-			       struct snd_soc_dapm_widget *w, int channel)
-{
-	struct snd_sof_dev *sdev = hda_stream->sdev;
-	struct sof_ipc_dai_config *config;
-	struct sof_ipc_reply reply;
-
-	config = hda_dai_update_config(w, channel);
-	if (!config) {
-		dev_err(sdev->dev, "error: no config for DAI %s\n", w->name);
-		return -ENOENT;
-	}
-
-	/* send DAI_CONFIG IPC */
-	return sof_ipc_tx_message(sdev->ipc, config->hdr.cmd, config, config->hdr.size,
-				  &reply, sizeof(reply));
-}
-
 static int hda_link_dai_widget_update(struct sof_intel_hda_stream *hda_stream,
 				      struct snd_soc_dapm_widget *w,
 				      int channel, bool widget_setup)
@@ -353,10 +335,9 @@ static int hda_link_pcm_trigger(struct snd_pcm_substream *substream,
 			w = dai->capture_widget;
 
 		/*
-		 * clear link DMA channel. It will be assigned when
-		 * hw_params is set up again after resume.
+		 * free DAI widget during stop/suspend to keep widget use_count's balanced.
 		 */
-		ret = hda_link_config_ipc(hda_stream, w, DMA_CHAN_INVALID);
+		ret = hda_link_dai_widget_update(hda_stream, w, DMA_CHAN_INVALID, false);
 		if (ret < 0)
 			return ret;
 
-- 
2.33.0

