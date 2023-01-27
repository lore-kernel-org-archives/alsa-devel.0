Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F1AC38142
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Jan 2023 12:02:21 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 14AA7EBB;
	Fri, 27 Jan 2023 13:01:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 14AA7EBB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674820939;
	bh=ErXZt99budl/AwAVcBjT9ltQP+XTzjusuCPQ2fqpFNE=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=B6uDy10cTwPizeO5Hxfurntz7q4QR6ctIhRZdQ9v23QqzxI/odBpMiFy2tCkzPEmC
	 fFNPjOYIetQ5L7wDXZQxvi728JEAMIVswy7AaMtB17DhVPyryur/JOX9cBqsk94QBf
	 JrAIJ/dwwC1Cs4xDbjJy12JlFBcK140N0+Oj7VdQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 711A9F8053D;
	Fri, 27 Jan 2023 13:00:39 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 401A9F804A9; Fri, 27 Jan 2023 13:00:36 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B2DDFF80154
 for <alsa-devel@alsa-project.org>; Fri, 27 Jan 2023 13:00:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B2DDFF80154
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=DjATl/ZV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674820832; x=1706356832;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ErXZt99budl/AwAVcBjT9ltQP+XTzjusuCPQ2fqpFNE=;
 b=DjATl/ZV4qVBgEhiNXvn9ksD8xTwP+qfVXkTh9LvdbttLSjWK+B+uGm9
 kFYF5aVoUNiRBKLhmQaR+klQtFsEWt0yQeiatTraN1lQEmIzim/+uPDIC
 5UeuIRIZSb/cin2n/AO4l7Mf9jAa2v/WHR/8MNg8r4FZwu4/KpQ3SRXdp
 q0EScNdhQjnAW6cxOA3+9XhsTiywt/IboT/wtqtzqDAKseQzF9BpUjCFJ
 B3SSZuQ2v/EpHnouJxvpS0LK7f4YAiSTROT1o6ABatfFO6HHUTguT/dOb
 4ZfXVvtMqM8oWC3uNa5FLQwMRGV0KaX7tkqp0mvF1uedrb4fO/Ggri49A Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="327091783"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; d="scan'208";a="327091783"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2023 04:00:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10602"; a="805782076"
X-IronPort-AV: E=Sophos;i="5.97,250,1669104000"; d="scan'208";a="805782076"
Received: from aaralsto-mobl.amr.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.30.130])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jan 2023 04:00:26 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH 01/18] ASoC: SOF: ipc4-topology: No need to unbind routes
 within a pipeline
Date: Fri, 27 Jan 2023 14:00:14 +0200
Message-Id: <20230127120031.10709-2-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127120031.10709-1-peter.ujfalusi@linux.intel.com>
References: <20230127120031.10709-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, rander.wang@intel.com,
 ranjani.sridharan@linux.intel.com, yung-chuan.liao@linux.intel.com
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

The FW currently ignores unbinding routes if the source and sink widgets
belong to the same pipeline. So no need to send the IPC at all in the
first place.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index ba99114e86a9..ae8ec98bb4eb 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -1805,12 +1805,19 @@ static int sof_ipc4_route_free(struct snd_sof_dev *sdev, struct snd_sof_route *s
 	struct sof_ipc4_fw_module *sink_fw_module = sink_widget->module_info;
 	struct sof_ipc4_msg msg = {{ 0 }};
 	u32 header, extension;
-	int ret;
+	int ret = 0;
 
 	dev_dbg(sdev->dev, "unbind modules %s:%d -> %s:%d\n",
 		src_widget->widget->name, sroute->src_queue_id,
 		sink_widget->widget->name, sroute->dst_queue_id);
 
+	/*
+	 * routes belonging to the same pipeline will be disconnected by the FW when the pipeline
+	 * is freed. So avoid sending this IPC which will be ignored by the FW anyway.
+	 */
+	if (src_widget->pipe_widget == sink_widget->pipe_widget)
+		goto out;
+
 	header = src_fw_module->man4_module_entry.id;
 	header |= SOF_IPC4_MOD_INSTANCE(src_widget->instance_id);
 	header |= SOF_IPC4_MSG_TYPE_SET(SOF_IPC4_MOD_UNBIND);
@@ -1829,7 +1836,7 @@ static int sof_ipc4_route_free(struct snd_sof_dev *sdev, struct snd_sof_route *s
 	if (ret < 0)
 		dev_err(sdev->dev, "failed to unbind modules %s -> %s\n",
 			src_widget->widget->name, sink_widget->widget->name);
-
+out:
 	sof_ipc4_put_queue_id(sink_widget, sroute->dst_queue_id, SOF_PIN_TYPE_SINK);
 	sof_ipc4_put_queue_id(src_widget, sroute->src_queue_id, SOF_PIN_TYPE_SOURCE);
 
-- 
2.39.1

