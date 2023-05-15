Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 323ACC77B7D
	for <alsa-devel@archiver.kernel.org>; Mon, 15 May 2023 11:21:29 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2809B828;
	Mon, 15 May 2023 13:20:37 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2809B828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684149687;
	bh=BWmCsXFODSqjlYPgcgP2bN6fOCCkfVCMQ184XpGh1Ko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=d8g3JnYbBP8HlBZyNfz0AvXueHvDmanQvnVVQ/H45C6UZAk0fl7ySAfp6sFDXB2kE
	 BDlPjv/fjKrGqnvRaYFgXAl1q42I6UKQVr1lIh9NE6GRroaiScfpgP0wF+YkQF81zQ
	 h9sGhjJQMTrKzn3O8BiGdnqQYr7FYL8k7KwN+FRQ=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id CA052F80579; Mon, 15 May 2023 13:19:44 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 18C6DF8016D;
	Mon, 15 May 2023 13:19:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 33FDCF80553; Mon, 15 May 2023 13:19:39 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 01311F8025A
	for <alsa-devel@alsa-project.org>; Mon, 15 May 2023 13:19:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01311F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=WW3Y55r+
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684149576; x=1715685576;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BWmCsXFODSqjlYPgcgP2bN6fOCCkfVCMQ184XpGh1Ko=;
  b=WW3Y55r+LD/5tcaGC/O+fRQu441PF8UKVB1GMUHpFIsWtsLCjElGHs1V
   xfSF9//n4xQP/+bEIv1W3YtiNbxug5wtYz6YZRMNt2PVgiL0++BjB8hhD
   si0uESTbfGHDJENVyBvcZ4KbWbyA7/pZ8b+P2JVRHGGs1a/ptXvkO/Ul7
   4D/ID40OnxbajUVmlcjaHe4vPMBVJubNRGZz76mYwWh/STj6r26k3BEXN
   jiaUsDCVHuriOMcunXO9DQwYX10/uyq+k3UrprcIU4PQL8Qai/e3348Td
   l+tZSS3R/nnq7qRHI1qdVD6lnTIfyCdnUIvX6bSXx/0MmMcr8oZPsydWo
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="379336182"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200";
   d="scan'208";a="379336182"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 04:19:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10710"; a="875142097"
X-IronPort-AV: E=Sophos;i="5.99,276,1677571200";
   d="scan'208";a="875142097"
Received: from lpilolli-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.48.230])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 May 2023 04:19:29 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH 1/2] ASoC: SOF: Intel: hda-dai-ops: Split the
 get_hext_stream() op for IPC4
Date: Mon, 15 May 2023 14:20:21 +0300
Message-Id: <20230515112022.30297-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515112022.30297-1-peter.ujfalusi@linux.intel.com>
References: <20230515112022.30297-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: I33QHBAQNUMVIUCE5QK575IMQIVVAULG
X-Message-ID-Hash: I33QHBAQNUMVIUCE5QK575IMQIVVAULG
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/I33QHBAQNUMVIUCE5QK575IMQIVVAULG/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Introduce a separate op implementation for get_hext_stream() for IPC4.
This op will also be used to set the skip_during_fe_trigger flag for the
BE DAI pipeline. With this change, we can remove the flag setting in
sof_ipc4_dai_config() which will further simplify support for
DMIC/SSP/Soundwire in the LunarLake platform.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/intel/hda-dai-ops.c | 22 +++++++++++++++++++++-
 sound/soc/sof/ipc4-topology.c     |  1 -
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-dai-ops.c b/sound/soc/sof/intel/hda-dai-ops.c
index 4b39cecacd68..4c04adff4c45 100644
--- a/sound/soc/sof/intel/hda-dai-ops.c
+++ b/sound/soc/sof/intel/hda-dai-ops.c
@@ -120,6 +120,26 @@ static struct hdac_ext_stream *hda_get_hext_stream(struct snd_sof_dev *sdev,
 	return snd_soc_dai_get_dma_data(cpu_dai, substream);
 }
 
+static struct hdac_ext_stream *hda_ipc4_get_hext_stream(struct snd_sof_dev *sdev,
+							struct snd_soc_dai *cpu_dai,
+							struct snd_pcm_substream *substream)
+{
+	struct snd_sof_widget *pipe_widget;
+	struct sof_ipc4_pipeline *pipeline;
+	struct snd_sof_widget *swidget;
+	struct snd_soc_dapm_widget *w;
+
+	w = snd_soc_dai_get_widget(cpu_dai, substream->stream);
+	swidget = w->dobj.private;
+	pipe_widget = swidget->spipe->pipe_widget;
+	pipeline = pipe_widget->private;
+
+	/* mark pipeline so that it can be skipped during FE trigger */
+	pipeline->skip_during_fe_trigger = true;
+
+	return snd_soc_dai_get_dma_data(cpu_dai, substream);
+}
+
 static struct hdac_ext_stream *hda_assign_hext_stream(struct snd_sof_dev *sdev,
 						      struct snd_soc_dai *cpu_dai,
 						      struct snd_pcm_substream *substream)
@@ -267,7 +287,7 @@ static int hda_ipc4_post_trigger(struct snd_sof_dev *sdev, struct snd_soc_dai *c
 }
 
 static const struct hda_dai_widget_dma_ops hda_ipc4_dma_ops = {
-	.get_hext_stream = hda_get_hext_stream,
+	.get_hext_stream = hda_ipc4_get_hext_stream,
 	.assign_hext_stream = hda_assign_hext_stream,
 	.release_hext_stream = hda_release_hext_stream,
 	.setup_hext_stream = hda_setup_hext_stream,
diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 059eebf0a687..91a89ac9cec3 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2507,7 +2507,6 @@ static int sof_ipc4_dai_config(struct snd_sof_dev *sdev, struct snd_sof_widget *
 		}
 		gtw_attr = ipc4_copier->gtw_attr;
 		gtw_attr->lp_buffer_alloc = pipeline->lp_mode;
-		pipeline->skip_during_fe_trigger = true;
 		fallthrough;
 	case SOF_DAI_INTEL_ALH:
 		/*
-- 
2.40.1

