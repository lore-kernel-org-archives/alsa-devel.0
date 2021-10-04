Return-Path: <SRS0=RGWB=OY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E172C433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 18:56:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C26761058
	for <alsa-devel@archiver.kernel.org>; Mon,  4 Oct 2021 18:56:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5C26761058
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BD0991685;
	Mon,  4 Oct 2021 20:56:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BD0991685
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633373813;
	bh=yuWFH/oIhictHBApSx4tW8L3mEiQKQLN5bpMN9Dahg0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=VM1WwpFuDEEKCtpq2o2tjhGMmANKRtArJoTS7x+16QowIdSbLjC7ZIbMBO98mdlDb
	 TkKtDy0DNppa6IZk3r98R28L+yH+hY5HnbIpv++ifkU7cr1uH3mLpLcjKDG9LARPbU
	 c5sfX7tQ6VOH9TNYHGwB4/u5ZVfIQIg7N7d4lG90=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4B943F804E5;
	Mon,  4 Oct 2021 20:55:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 69D0AF804E5; Mon,  4 Oct 2021 20:55:15 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43138F800BA
 for <alsa-devel@alsa-project.org>; Mon,  4 Oct 2021 20:55:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43138F800BA
X-IronPort-AV: E=McAfee;i="6200,9189,10127"; a="206360928"
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; d="scan'208";a="206360928"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2021 10:14:42 -0700
X-IronPort-AV: E=Sophos;i="5.85,346,1624345200"; d="scan'208";a="523435367"
Received: from mbrescia-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.77.4])
 by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Oct 2021 10:14:41 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/5] ASoC: SOF: Intel: hda: add new flags for DAI_CONFIG
Date: Mon,  4 Oct 2021 12:14:28 -0500
Message-Id: <20211004171430.103674-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211004171430.103674-1-pierre-louis.bossart@linux.intel.com>
References: <20211004171430.103674-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Brent Lu <brent.lu@intel.com>,
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

The DAI_CONFIG is used for both hw_params and hw_free. Use flags to
specify what stage the configuration applies to.

the DAI_CONFIG IPC may be sent also during the widget setup so each
flag is cleared after the IPC to restore the state.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/sof/intel/hda.c | 6 ++++++
 sound/soc/sof/sof-audio.c | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 066e90506ae6..1463f3de01bc 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -71,6 +71,9 @@ int hda_ctrl_dai_widget_setup(struct snd_soc_dapm_widget *w)
 		return ret;
 	}
 
+	/* set HW_PARAMS flag */
+	config->flags = FIELD_PREP(SOF_DAI_CONFIG_FLAGS_MASK, SOF_DAI_CONFIG_FLAGS_HW_PARAMS);
+
 	/* send DAI_CONFIG IPC */
 	ret = sof_ipc_tx_message(sdev->ipc, config->hdr.cmd, config, config->hdr.size,
 				 &reply, sizeof(reply));
@@ -107,6 +110,9 @@ int hda_ctrl_dai_widget_free(struct snd_soc_dapm_widget *w)
 
 	config = &sof_dai->dai_config[sof_dai->current_config];
 
+	/* set HW_FREE flag */
+	config->flags = FIELD_PREP(SOF_DAI_CONFIG_FLAGS_MASK, SOF_DAI_CONFIG_FLAGS_HW_FREE);
+
 	ret = sof_ipc_tx_message(sdev->ipc, config->hdr.cmd, config, config->hdr.size,
 				 &reply, sizeof(reply));
 	if (ret < 0)
diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index c4cabe26b157..262cb3ad4674 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -8,6 +8,7 @@
 // Author: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
 //
 
+#include <linux/bitfield.h>
 #include "sof-audio.h"
 #include "ops.h"
 
@@ -55,6 +56,9 @@ static int sof_dai_config_setup(struct snd_sof_dev *sdev, struct snd_sof_dai *da
 		return -EINVAL;
 	}
 
+	/* set NONE flag to clear all previous settings */
+	config->flags = FIELD_PREP(SOF_DAI_CONFIG_FLAGS_MASK, SOF_DAI_CONFIG_FLAGS_NONE);
+
 	ret = sof_ipc_tx_message(sdev->ipc, config->hdr.cmd, config, config->hdr.size,
 				 &reply, sizeof(reply));
 
-- 
2.25.1

