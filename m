Return-Path: <SRS0=cfk+=QG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73542C433F5
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Nov 2021 19:38:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F34CD61221
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Nov 2021 19:38:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F34CD61221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 67C1A178F;
	Fri, 19 Nov 2021 20:37:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 67C1A178F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637350699;
	bh=QLwgm5bE5qUf1AgDzlOGibL9HRkHPJXl6cMtYS0snR4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=n0ay/BJpCAHcPoWXkZCblrhNdW1ipkYGPikXCaQ/6ykNLCHL6o7bfjCD3kt9dEU4X
	 S3K0tiXgBoUSNd9nV6HwO1HL9e0W87Mkwg7jQ7jaoenR43VPMDf2unH5GhBWYfXIkm
	 VzZX9msnh8aAMCt3QktWue3PjzaiOzx6ssdA5T9w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E78BDF80510;
	Fri, 19 Nov 2021 20:34:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 58F67F8052D; Fri, 19 Nov 2021 20:34:50 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8EE63F80510
 for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2021 20:34:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8EE63F80510
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="221697776"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; d="scan'208";a="221697776"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2021 11:34:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; d="scan'208";a="473651235"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga002.jf.intel.com with ESMTP; 19 Nov 2021 11:34:17 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 06/10] ASoC: SOF: topology: remove sof_load_pipeline_ipc()
Date: Fri, 19 Nov 2021 21:26:17 +0200
Message-Id: <20211119192621.4096077-7-kai.vehmanen@linux.intel.com>
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

Remove the function sof_load_pipeline_ipc() and directly
send the IPC instead. The pipeline core is already enabled
with the call to sof_pipeline_core_enable() in sof_widget_setup().

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/sof-audio.c |  3 ++-
 sound/soc/sof/sof-audio.h |  4 ----
 sound/soc/sof/topology.c  | 17 -----------------
 3 files changed, 2 insertions(+), 22 deletions(-)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 7cbe757c1fe2..a019355e0bcf 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -203,7 +203,8 @@ int sof_widget_setup(struct snd_sof_dev *sdev, struct snd_sof_widget *swidget)
 		break;
 	case snd_soc_dapm_scheduler:
 		pipeline = swidget->private;
-		ret = sof_load_pipeline_ipc(sdev, pipeline, &r);
+		ret = sof_ipc_tx_message(sdev->ipc, pipeline->hdr.cmd, pipeline,
+					 sizeof(*pipeline), &r, sizeof(r));
 		break;
 	default:
 		hdr = swidget->private;
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 05e98e231b85..6c591b7a531c 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -184,10 +184,6 @@ void snd_sof_control_notify(struct snd_sof_dev *sdev,
 int snd_sof_load_topology(struct snd_soc_component *scomp, const char *file);
 int snd_sof_complete_pipeline(struct snd_sof_dev *sdev,
 			      struct snd_sof_widget *swidget);
-
-int sof_load_pipeline_ipc(struct snd_sof_dev *sdev,
-			  struct sof_ipc_pipe_new *pipeline,
-			  struct sof_ipc_comp_reply *r);
 int sof_pipeline_core_enable(struct snd_sof_dev *sdev,
 			     const struct snd_sof_widget *swidget);
 
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 10caf2b1a33c..3a49d7910326 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1707,23 +1707,6 @@ static int sof_widget_load_pcm(struct snd_soc_component *scomp, int index,
 /*
  * Pipeline Topology
  */
-int sof_load_pipeline_ipc(struct snd_sof_dev *sdev,
-			  struct sof_ipc_pipe_new *pipeline,
-			  struct sof_ipc_comp_reply *r)
-{
-	int ret = sof_core_enable(sdev, pipeline->core);
-
-	if (ret < 0)
-		return ret;
-
-	ret = sof_ipc_tx_message(sdev->ipc, pipeline->hdr.cmd, pipeline,
-				 sizeof(*pipeline), r, sizeof(*r));
-	if (ret < 0)
-		dev_err(sdev->dev, "error: load pipeline ipc failure\n");
-
-	return ret;
-}
-
 static int sof_widget_load_pipeline(struct snd_soc_component *scomp, int index,
 				    struct snd_sof_widget *swidget,
 				    struct snd_soc_tplg_dapm_widget *tw)
-- 
2.33.0

