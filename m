Return-Path: <SRS0=ik9t=YS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6BF6CA9EBC
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:05:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F38421D81
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Oct 2019 23:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="GJQM9cAX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F38421D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1DBCC1AB5;
	Sat, 26 Oct 2019 00:57:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1DBCC1AB5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1572044294;
	bh=xk7/hD0AT8ix/zfKiNCkFlbF2gn6XCin3qD365/vTUI=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=GJQM9cAX+DjloaVLVQmdVMU2r3AAOAyEBZqzUs3mMAB8xRNPClBpBMVxhl9inZ/Wj
	 ZfyABb6LtVxJJiWf6ueLo9i/KHPwFsb+yF2nLkEQ+XO8AhrtR+FoCqckfEfhpHxRWs
	 CR1dUHq/r0L4ySETrgjF0VtRujfmHEYaOcab24yU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B6BA0F80797;
	Sat, 26 Oct 2019 00:42:34 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33D32F8065E; Sat, 26 Oct 2019 00:42:13 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0378AF802A0
 for <alsa-devel@alsa-project.org>; Sat, 26 Oct 2019 00:41:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0378AF802A0
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 25 Oct 2019 15:41:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,230,1569308400"; d="scan'208";a="210458229"
Received: from archagam-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.252.139.180])
 by fmsmga001.fm.intel.com with ESMTP; 25 Oct 2019 15:41:51 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 25 Oct 2019 17:41:18 -0500
Message-Id: <20191025224122.7718-23-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191025224122.7718-1-pierre-louis.bossart@linux.intel.com>
References: <20191025224122.7718-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 22/26] ASoC: SOF: ignore suspend/resume for
	D0ix compatible streams
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

From: Keyon Jie <yang.jie@linux.intel.com>

During system suspend, the PM framework will freeze all applications and
the ALSA/ASoC core will suspend all RUNNING PCM streams.

However, D0ix-compatible PCM streams should keep the related pipelines
active in the DSP when the system is entering S0ix. The TRIGGER_SUSPEND
event is trapped in such cases to prevent the pipelines from being
stopped. Likewise, the TRIGGER_RESUME/START events should not affect the
pipeline state.

The SOF driver also triggers some DSP Firmware pipelines based on the
DAPM widgets power events. In such cases, we also ignore PRE_PMU and
POST_PMD events to keep the pipelines active.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/pcm.c      | 31 +++++++++++++++++++++++++++++++
 sound/soc/sof/topology.c | 17 ++++++++++++++++-
 2 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 9ba505cf5966..3d5cd1b445ba 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -346,6 +346,16 @@ static int sof_pcm_trigger(struct snd_soc_component *component,
 		stream.hdr.cmd |= SOF_IPC_STREAM_TRIG_RELEASE;
 		break;
 	case SNDRV_PCM_TRIGGER_RESUME:
+		if (spcm->stream[substream->stream].suspend_ignored) {
+			/*
+			 * this case will be triggered when INFO_RESUME is
+			 * supported, no need to resume streams that remained
+			 * enabled in D0ix.
+			 */
+			spcm->stream[substream->stream].suspend_ignored = false;
+			return 0;
+		}
+
 		/* set up hw_params */
 		ret = sof_pcm_prepare(component, substream);
 		if (ret < 0) {
@@ -356,9 +366,30 @@ static int sof_pcm_trigger(struct snd_soc_component *component,
 
 		/* fallthrough */
 	case SNDRV_PCM_TRIGGER_START:
+		if (spcm->stream[substream->stream].suspend_ignored) {
+			/*
+			 * This case will be triggered when INFO_RESUME is
+			 * not supported, no need to re-start streams that
+			 * remained enabled in D0ix.
+			 */
+			spcm->stream[substream->stream].suspend_ignored = false;
+			return 0;
+		}
 		stream.hdr.cmd |= SOF_IPC_STREAM_TRIG_START;
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
+		if (sdev->s0_suspend &&
+		    spcm->stream[substream->stream].d0i3_compatible) {
+			/*
+			 * trap the event, not sending trigger stop to
+			 * prevent the FW pipelines from being stopped,
+			 * and mark the flag to ignore the upcoming DAPM
+			 * PM events.
+			 */
+			spcm->stream[substream->stream].suspend_ignored = true;
+			return 0;
+		}
+		/* fallthrough */
 	case SNDRV_PCM_TRIGGER_STOP:
 		stream.hdr.cmd |= SOF_IPC_STREAM_TRIG_STOP;
 		ipc_first = true;
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index cc138ac6a8eb..e0e2ae734632 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -135,7 +135,9 @@ static int sof_keyword_dapm_event(struct snd_soc_dapm_widget *w,
 				  struct snd_kcontrol *k, int event)
 {
 	struct snd_sof_widget *swidget = w->dobj.private;
+	int stream = SNDRV_PCM_STREAM_CAPTURE;
 	struct snd_sof_dev *sdev;
+	struct snd_sof_pcm *spcm;
 	int ret = 0;
 
 	if (!swidget)
@@ -146,11 +148,19 @@ static int sof_keyword_dapm_event(struct snd_soc_dapm_widget *w,
 	dev_dbg(sdev->dev, "received event %d for widget %s\n",
 		event, w->name);
 
+	/* get runtime PCM params using widget's stream name */
+	spcm = snd_sof_find_spcm_name(sdev, swidget->widget->sname);
+
 	/* process events */
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
+		if (spcm->stream[stream].suspend_ignored) {
+			dev_dbg(sdev->dev, "PRE_PMU event ignored, KWD pipeline is already RUNNING\n");
+			return 0;
+		}
+
 		/* set pcm params */
-		ret = ipc_pcm_params(swidget, SOF_IPC_STREAM_CAPTURE);
+		ret = ipc_pcm_params(swidget, stream);
 		if (ret < 0) {
 			dev_err(sdev->dev,
 				"error: failed to set pcm params for widget %s\n",
@@ -166,6 +176,11 @@ static int sof_keyword_dapm_event(struct snd_soc_dapm_widget *w,
 				swidget->widget->name);
 		break;
 	case SND_SOC_DAPM_POST_PMD:
+		if (spcm->stream[stream].suspend_ignored) {
+			dev_dbg(sdev->dev, "POST_PMD even ignored, KWD pipeline will remain RUNNING\n");
+			return 0;
+		}
+
 		/* stop trigger */
 		ret = ipc_trigger(swidget, SOF_IPC_STREAM_TRIG_STOP);
 		if (ret < 0)
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
