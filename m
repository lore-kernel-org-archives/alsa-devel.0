Return-Path: <SRS0=duqq=OS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A1F4C4332F
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 10:27:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 722AE61130
	for <alsa-devel@archiver.kernel.org>; Tue, 28 Sep 2021 10:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 722AE61130
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 592C51690;
	Tue, 28 Sep 2021 12:26:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 592C51690
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1632824856;
	bh=4EpJ2OG10Qv80WMeRqHP1XN1hOo/iAH3w/Mw4S219E4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vHgTFU6hxE/ANxZQyZILp1jcgekydCtiFB3lQyCTvvhn3LTtKpr4G36vd7urwohxv
	 7AbjR4xRUqMljqMdEG5j1DNPkWd24AH/MC6qJOL/9RC+oqr414ZA6hYsMhnRU6cunf
	 A7aLUiBHqe/F3ib8xWuV0+OI1Ni5U9QjunvK/wB8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C9B80F8032C;
	Tue, 28 Sep 2021 12:26:45 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4F31FF804AD; Tue, 28 Sep 2021 12:26:44 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8FE6CF800DE
 for <alsa-devel@alsa-project.org>; Tue, 28 Sep 2021 12:26:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8FE6CF800DE
X-IronPort-AV: E=McAfee;i="6200,9189,10120"; a="288328079"
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; d="scan'208";a="288328079"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 03:26:34 -0700
X-IronPort-AV: E=Sophos;i="5.85,329,1624345200"; d="scan'208";a="553935468"
Received: from elisabal-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.220.25])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Sep 2021 03:26:31 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, marc.herbert@intel.com
Subject: [PATCH] ASoC: SOF: prefix some terse and cryptic dev_dbg() with
 __func__
Date: Tue, 28 Sep 2021 13:26:35 +0300
Message-Id: <20210928102635.26227-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, ranjani.sridharan@linux.intel.com,
 kai.vehmanen@linux.intel.com
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

From: Marc Herbert <marc.herbert@intel.com>

These helped troubleshoot some DMA issue in SOF.

Signed-off-by: Marc Herbert <marc.herbert@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/intel/hda-stream.c | 7 ++++---
 sound/soc/sof/trace.c            | 5 +++--
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index 63c367478f1c..ab051f67e0e8 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -89,13 +89,13 @@ int hda_dsp_stream_setup_bdl(struct snd_sof_dev *sdev,
 	int remain, ioc;
 
 	period_bytes = stream->period_bytes;
-	dev_dbg(sdev->dev, "period_bytes:0x%x\n", period_bytes);
+	dev_dbg(sdev->dev, "%s: period_bytes:0x%x\n", __func__, period_bytes);
 	if (!period_bytes)
 		period_bytes = stream->bufsize;
 
 	periods = stream->bufsize / period_bytes;
 
-	dev_dbg(sdev->dev, "periods:%d\n", periods);
+	dev_dbg(sdev->dev, "%s: periods:%d\n", __func__, periods);
 
 	remain = stream->bufsize % period_bytes;
 	if (remain)
@@ -244,7 +244,8 @@ int hda_dsp_stream_put(struct snd_sof_dev *sdev, int direction, int stream_tag)
 					HDA_VS_INTEL_EM2_L1SEN, HDA_VS_INTEL_EM2_L1SEN);
 
 	if (!found) {
-		dev_dbg(sdev->dev, "stream_tag %d not opened!\n", stream_tag);
+		dev_dbg(sdev->dev, "%s: stream_tag %d not opened!\n",
+			__func__, stream_tag);
 		return -ENODEV;
 	}
 
diff --git a/sound/soc/sof/trace.c b/sound/soc/sof/trace.c
index 58f6ca5cf491..e3afc3dac7d1 100644
--- a/sound/soc/sof/trace.c
+++ b/sound/soc/sof/trace.c
@@ -417,7 +417,7 @@ int snd_sof_init_trace_ipc(struct snd_sof_dev *sdev)
 			"error: fail in snd_sof_dma_trace_init %d\n", ret);
 		return ret;
 	}
-	dev_dbg(sdev->dev, "stream_tag: %d\n", params.stream_tag);
+	dev_dbg(sdev->dev, "%s: stream_tag: %d\n", __func__, params.stream_tag);
 
 	/* send IPC to the DSP */
 	ret = sof_ipc_tx_message(sdev->ipc,
@@ -480,7 +480,8 @@ int snd_sof_init_trace(struct snd_sof_dev *sdev)
 		goto table_err;
 
 	sdev->dma_trace_pages = ret;
-	dev_dbg(sdev->dev, "dma_trace_pages: %d\n", sdev->dma_trace_pages);
+	dev_dbg(sdev->dev, "%s: dma_trace_pages: %d\n",
+		__func__, sdev->dma_trace_pages);
 
 	if (sdev->first_boot) {
 		ret = trace_debugfs_create(sdev);
-- 
2.33.0

