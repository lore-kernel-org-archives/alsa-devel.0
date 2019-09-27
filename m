Return-Path: <SRS0=P2CN=XW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF168C4360C
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:09:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E134207E0
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LFfSkKOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E134207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E6715167A;
	Fri, 27 Sep 2019 22:08:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E6715167A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569614977;
	bh=s0QsAFONRC+yxIKns1FlbUYWNzQCAk9/u7TTDDw5OIk=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LFfSkKOM1IMMbNUgkjyyP5t0dCuNdgoNZJZu6YsahiNa7HGqYhEDPkmD1gDLQKxmr
	 8s2OFoIel0ZUVhPLacPXz2t6XQLsuJ/yHkbW4PSPh2oNNafvRoPY/uBai7KG7KP6gl
	 Rry+/AbD1Sl8l1wh747WBYut9H75UvIX+koHcxPE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 03AEBF80611;
	Fri, 27 Sep 2019 22:06:15 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3BFE7F8060D; Fri, 27 Sep 2019 22:06:08 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CA11CF805DF
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2019 22:06:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CA11CF805DF
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Sep 2019 13:05:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,556,1559545200"; d="scan'208";a="190444261"
Received: from wcui-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.251.146.136])
 by fmsmga007.fm.intel.com with ESMTP; 27 Sep 2019 13:05:46 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 27 Sep 2019 15:05:31 -0500
Message-Id: <20190927200538.660-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190927200538.660-1-pierre-louis.bossart@linux.intel.com>
References: <20190927200538.660-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Pan Xiuli <xiuli.pan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 06/13] ASoC: SOF: pcm: harden PCM STOP sequence
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Pan Xiuli <xiuli.pan@linux.intel.com>

The old STOP sequence is: 1. stop DMA 2. send STOP ipc
If delay happen before the steps 1 and 2, the DMA buffer will be empty in
short time and cause pipeline xrun then stop the pipeline.
Then the step 2 ipc stop will return error as pipeline is already stopped.

Suggested change to avoid the issue is to switch the order of steps 1 and 2
for the stop sequence.

Signed-off-by: Pan Xiuli <xiuli.pan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/pcm.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index fa7769dd825c..2b876d497447 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -323,6 +323,7 @@ static int sof_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct sof_ipc_stream stream;
 	struct sof_ipc_reply reply;
 	bool reset_hw_params = false;
+	bool ipc_first = false;
 	int ret;
 
 	/* nothing to do for BE */
@@ -343,6 +344,7 @@ static int sof_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		stream.hdr.cmd |= SOF_IPC_STREAM_TRIG_PAUSE;
+		ipc_first = true;
 		break;
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		stream.hdr.cmd |= SOF_IPC_STREAM_TRIG_RELEASE;
@@ -363,6 +365,7 @@ static int sof_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 	case SNDRV_PCM_TRIGGER_STOP:
 		stream.hdr.cmd |= SOF_IPC_STREAM_TRIG_STOP;
+		ipc_first = true;
 		reset_hw_params = true;
 		break;
 	default:
@@ -370,12 +373,22 @@ static int sof_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		return -EINVAL;
 	}
 
-	snd_sof_pcm_platform_trigger(sdev, substream, cmd);
+	/*
+	 * DMA and IPC sequence is different for start and stop. Need to send
+	 * STOP IPC before stop DMA
+	 */
+	if (!ipc_first)
+		snd_sof_pcm_platform_trigger(sdev, substream, cmd);
 
 	/* send IPC to the DSP */
 	ret = sof_ipc_tx_message(sdev->ipc, stream.hdr.cmd, &stream,
 				 sizeof(stream), &reply, sizeof(reply));
 
+	/* need to STOP DMA even if STOP IPC failed */
+	if (ipc_first)
+		snd_sof_pcm_platform_trigger(sdev, substream, cmd);
+
+	/* free PCM if reset_hw_params is set and the STOP IPC is successful */
 	if (!ret && reset_hw_params)
 		ret = sof_pcm_dsp_pcm_free(substream, sdev, spcm);
 
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
