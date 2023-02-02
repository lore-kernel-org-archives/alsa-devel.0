Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4A86C05027
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Feb 2023 13:33:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 45BBDEA8;
	Thu,  2 Feb 2023 14:32:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 45BBDEA8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1675344804;
	bh=TjhwXLW+ISaVWh4oCIl17D1DQtIaO80qf9PbF9DFUNs=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=p8fliLSkhoDCjNRTCr7Y+54P9ajt9Ia4W0ioBymMcf62fFlUrUj6ZgXBbc/Flv58e
	 IJ9veGKsMhlnSvHDancRfsPNYopYXj3KOqRq2NCRIsgH4+qNt5m+fojNqSjGchZpY6
	 hWXNpre0Js3OCaUeX8x0NTIELbOGM9MuKaNeOL8M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B85AF80548;
	Thu,  2 Feb 2023 14:30:42 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C1224F8053D; Thu,  2 Feb 2023 14:30:40 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E8A0AF800E3
 for <alsa-devel@alsa-project.org>; Thu,  2 Feb 2023 14:30:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E8A0AF800E3
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ZhLGxSM4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1675344606; x=1706880606;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=TjhwXLW+ISaVWh4oCIl17D1DQtIaO80qf9PbF9DFUNs=;
 b=ZhLGxSM4OUt/5Zynpvo+KPrEkWY/bPuT+xbEY1QgatK22k0J4LDW1mjZ
 BHji72lOPcvAteB8MaGGH3yyWy5iORBDeuKnnsHK1Poa+AQsaz/6+Qg2l
 r7rcj8BUMR70zWox822BFwwlHpauAnwuLct+UCP/Otp+NI4gdIl9G4PS4
 PJCCW0nusQ6Y7RmwVkfzya4tUJyfrKgRixcx/3uWBSby378N+Zm9dwulw
 B1NODCP8u0vuNC1rt3tp1QgSaA/2wbvvIvwoC1/u3BwjAy/8M71lmcFGq
 b/oAyrLOWz4Xf6y7SXc4YVcgKewL4iGfdecsipW90+qZtM7Fn3mtNW2cK g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308783290"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; d="scan'208";a="308783290"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2023 05:30:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="658727389"
X-IronPort-AV: E=Sophos;i="5.97,267,1669104000"; d="scan'208";a="658727389"
Received: from jpdamery-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.1.104])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Feb 2023 05:29:59 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz
Subject: [PATCH v3 5/9] ASoC: SOF: ipc4-pcm: add hw_params
Date: Thu,  2 Feb 2023 15:29:50 +0200
Message-Id: <20230202132954.26773-6-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230202132954.26773-1-peter.ujfalusi@linux.intel.com>
References: <20230202132954.26773-1-peter.ujfalusi@linux.intel.com>
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

From: Rander Wang <rander.wang@intel.com>

Use the hw_params to init time info for ipc4 delay calculation.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/ipc4-pcm.c | 98 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 98 insertions(+)

diff --git a/sound/soc/sof/ipc4-pcm.c b/sound/soc/sof/ipc4-pcm.c
index 8071db487815..a457d4d479d8 100644
--- a/sound/soc/sof/ipc4-pcm.c
+++ b/sound/soc/sof/ipc4-pcm.c
@@ -459,7 +459,105 @@ static int sof_ipc4_pcm_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm
 	return 0;
 }
 
+static void sof_ipc4_build_time_info(struct snd_sof_dev *sdev, struct snd_sof_pcm_stream *spcm)
+{
+	struct sof_ipc4_copier *host_copier = NULL;
+	struct sof_ipc4_copier *dai_copier = NULL;
+	struct sof_ipc4_llp_reading_slot llp_slot;
+	struct sof_ipc4_timestamp_info *info;
+	struct snd_soc_dapm_widget *widget;
+	struct snd_sof_dai *dai;
+	int i;
+
+	/* find host & dai to locate info in memory window */
+	for_each_dapm_widgets(spcm->list, i, widget) {
+		struct snd_sof_widget *swidget = widget->dobj.private;
+
+		if (!swidget)
+			continue;
+
+		if (WIDGET_IS_AIF(swidget->widget->id)) {
+			host_copier = swidget->private;
+		} else if (WIDGET_IS_DAI(swidget->widget->id)) {
+			dai = swidget->private;
+			dai_copier = dai->private;
+		}
+	}
+
+	/* both host and dai copier must be valid for time_info */
+	if (!host_copier || !dai_copier) {
+		dev_err(sdev->dev, "host or dai copier are not found\n");
+		return;
+	}
+
+	info = spcm->private;
+	info->host_copier = host_copier;
+	info->dai_copier = dai_copier;
+	info->llp_offset = offsetof(struct sof_ipc4_fw_registers, llp_gpdma_reading_slots) +
+				    sdev->fw_info_box.offset;
+
+	/* find llp slot used by current dai */
+	for (i = 0; i < SOF_IPC4_MAX_LLP_GPDMA_READING_SLOTS; i++) {
+		sof_mailbox_read(sdev, info->llp_offset, &llp_slot, sizeof(llp_slot));
+		if (llp_slot.node_id == dai_copier->data.gtw_cfg.node_id)
+			break;
+
+		info->llp_offset += sizeof(llp_slot);
+	}
+
+	if (i < SOF_IPC4_MAX_LLP_GPDMA_READING_SLOTS)
+		return;
+
+	/* if no llp gpdma slot is used, check aggregated sdw slot */
+	info->llp_offset = offsetof(struct sof_ipc4_fw_registers, llp_sndw_reading_slots) +
+					sdev->fw_info_box.offset;
+	for (i = 0; i < SOF_IPC4_MAX_LLP_SNDW_READING_SLOTS; i++) {
+		sof_mailbox_read(sdev, info->llp_offset, &llp_slot, sizeof(llp_slot));
+		if (llp_slot.node_id == dai_copier->data.gtw_cfg.node_id)
+			break;
+
+		info->llp_offset += sizeof(llp_slot);
+	}
+
+	if (i < SOF_IPC4_MAX_LLP_SNDW_READING_SLOTS)
+		return;
+
+	/* check EVAD slot */
+	info->llp_offset = offsetof(struct sof_ipc4_fw_registers, llp_evad_reading_slot) +
+					sdev->fw_info_box.offset;
+	sof_mailbox_read(sdev, info->llp_offset, &llp_slot, sizeof(llp_slot));
+	if (llp_slot.node_id != dai_copier->data.gtw_cfg.node_id) {
+		dev_info(sdev->dev, "no llp found, fall back to default HDA path");
+		info->llp_offset = 0;
+	}
+}
+
+static int sof_ipc4_pcm_hw_params(struct snd_soc_component *component,
+				  struct snd_pcm_substream *substream,
+				  struct snd_pcm_hw_params *params,
+				  struct snd_sof_platform_stream_params *platform_params)
+{
+	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct sof_ipc4_timestamp_info *time_info;
+	struct snd_sof_pcm *spcm;
+
+	spcm = snd_sof_find_spcm_dai(component, rtd);
+	time_info = spcm->stream[substream->stream].private;
+	/* delay calculation is not supported by current fw_reg ABI */
+	if (!time_info)
+		return 0;
+
+	time_info->stream_start_offset = SOF_IPC4_INVALID_STREAM_POSITION;
+	time_info->llp_offset = 0;
+
+	sof_ipc4_build_time_info(sdev, &spcm->stream[substream->stream]);
+
+	return 0;
+}
+
 const struct sof_ipc_pcm_ops ipc4_pcm_ops = {
+	.hw_params = sof_ipc4_pcm_hw_params,
 	.trigger = sof_ipc4_pcm_trigger,
 	.hw_free = sof_ipc4_pcm_hw_free,
 	.dai_link_fixup = sof_ipc4_pcm_dai_link_fixup,
-- 
2.39.1

