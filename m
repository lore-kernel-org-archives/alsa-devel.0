Return-Path: <SRS0=wkXm=LE=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32E10C48BD1
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 20:56:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB9761407
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Jun 2021 20:56:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB9761407
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 66A9E17D8;
	Thu, 10 Jun 2021 22:55:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 66A9E17D8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1623358586;
	bh=tN4IvoEx0a1A9Pppwk9QZKLfCtyYJSwSnVJT/NEb/EM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Mh3kY3xHwi459E+8FWT4IJxjCEIH35KQap4dxNgmsieq6mtdiA0MlVBIOP5gQ56qo
	 5WHsQFBxbyNOkUG6d0OYhG61mOc3TzMqTgpkU3DyMSOpVOHxs66mAvAqe+2FjuAx5W
	 WjTM1pgARHIZQIBTpL8xE1jTVIw6lXjOMonEY4Gw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F16BBF80256;
	Thu, 10 Jun 2021 22:54:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 318CCF804CB; Thu, 10 Jun 2021 22:54:10 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D6A9FF80218
 for <alsa-devel@alsa-project.org>; Thu, 10 Jun 2021 22:54:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D6A9FF80218
IronPort-SDR: k6fjhRinoUlhjcVT0l/PJ7TnSJq3mHDKhRG1a2SObwiT4k495pcdY34OVSHXLQ01sgGlXPZAgq
 GuadRpi8HApg==
X-IronPort-AV: E=McAfee;i="6200,9189,10011"; a="226812417"
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; d="scan'208";a="226812417"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2021 13:53:50 -0700
IronPort-SDR: Q/zXwKmU63mRxyPJs57o390VAekzzIHPXieasR/DpnWu1l4Ye9o+xwvlmJ7CgcfWfXlm9EYV2w
 BdKhDbSpStPg==
X-IronPort-AV: E=Sophos;i="5.83,264,1616482800"; d="scan'208";a="620183623"
Received: from umedepal-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.213.170.65])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Jun 2021 13:53:50 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/8] ASoC: SOF: pcm: add mechanisms to disable ALSA
 pause_push/release
Date: Thu, 10 Jun 2021 15:53:21 -0500
Message-Id: <20210610205326.1176400-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610205326.1176400-1-pierre-louis.bossart@linux.intel.com>
References: <20210610205326.1176400-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

PulseAudio, PipeWire and CRAS do not use pause push/release, which
means that we can optionally disable this capability without any
impact on most users.

In addition, on some platforms, e.g. based on HDaudio DMAs, support for
pause_push/release prevents the system from entering low-power
states.

This patch suggests an opt-in selection via kconfig or kernel
parameter to disable pause.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/Kconfig | 9 +++++++++
 sound/soc/sof/pcm.c   | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
index cd659493b5df..81b834558a2d 100644
--- a/sound/soc/sof/Kconfig
+++ b/sound/soc/sof/Kconfig
@@ -55,6 +55,15 @@ config SND_SOC_SOF_DEBUG_PROBES
 	  Say Y if you want to enable probes.
 	  If unsure, select "N".
 
+config SND_SOC_SOF_PCM_DISABLE_PAUSE
+	bool "SOF disable pause push/release"
+	help
+	  This option disables ALSA pause push/release capabilities for
+	  SOF drivers. These capabilities are not used by typical
+	  sound servers such as PulseAudio, PipeWire and CRAS.
+	  Say Y if you want to disable pause push/release
+	  If unsure, select "N".
+
 config SND_SOC_SOF_DEVELOPER_SUPPORT
 	bool "SOF developer options support"
 	depends on EXPERT
diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 9893b182da43..bab837ed8c7f 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -10,6 +10,7 @@
 // PCM Layer, interface between ALSA and IPC.
 //
 
+#include <linux/moduleparam.h>
 #include <linux/pm_runtime.h>
 #include <sound/pcm_params.h>
 #include <sound/sof.h>
@@ -20,6 +21,10 @@
 #include "compress.h"
 #endif
 
+static bool pcm_disable_pause = IS_ENABLED(CONFIG_SND_SOC_SOF_PCM_DISABLE_PAUSE);
+module_param_named(disable_pause, pcm_disable_pause, bool, 0444);
+MODULE_PARM_DESC(disable_pause, "SOF HDA disable pause");
+
 /* Create DMA buffer page table for DSP */
 static int create_page_table(struct snd_soc_component *component,
 			     struct snd_pcm_substream *substream,
@@ -480,6 +485,8 @@ static int sof_pcm_open(struct snd_soc_component *component,
 
 	/* set runtime config */
 	runtime->hw.info = ops->hw_info; /* platform-specific */
+	if (pcm_disable_pause)
+		runtime->hw.info &= ~SNDRV_PCM_INFO_PAUSE;
 
 	/* set any runtime constraints based on topology */
 	runtime->hw.formats = le64_to_cpu(caps->formats);
-- 
2.25.1

