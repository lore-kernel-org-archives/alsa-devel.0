Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC67C2D0E5
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:17:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B787920719
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 21:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="COuhfVdr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B787920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00EB416AA;
	Wed, 25 Mar 2020 22:16:19 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00EB416AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585171029;
	bh=866l1hkt7fIR/YqXnb7hX1rj/au8WB7l94hCl4vRMDs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=COuhfVdrhNOCNeKD+LBVJ10+9OIz9cuwp5L4XjbkHHjXlRMUqpRm9kIX9P2E8yiHp
	 9AG0t9/WrVoHxlj58ebP5DH8JeE5c5OO2GVbzeOOmk8+Qk0HUdLvgIyZnp0BiROkZA
	 de4zDHDo/3Qqzpq0122BEvceE8nsikpht3Fi6ooo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 16FDDF802BC;
	Wed, 25 Mar 2020 22:13:08 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E4A71F8028E; Wed, 25 Mar 2020 22:12:58 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CADE6F8015A
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 22:12:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CADE6F8015A
IronPort-SDR: ZEi1mJB3gBcPjvsONGuX3zYv4VfWKF01q1E9S2/CbXqpu+UdpLDYdrGN/P8Hag429Uf3EHom4P
 ucwhCLjRC9NQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 14:12:48 -0700
IronPort-SDR: 4YSJfSEXKxsAPOChONEuneAl4bECG4GpwgJlXzmy7CtiUmtdxCF1ElKiub16LtQgwTW3JaM4A4
 eHyMzPspS49g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; d="scan'208";a="357935850"
Received: from abeljans.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.233.195])
 by fmsmga001.fm.intel.com with ESMTP; 25 Mar 2020 14:12:48 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/5] ASoC: SOF: Intel: hda: call codec wake at chip init
Date: Wed, 25 Mar 2020 16:12:33 -0500
Message-Id: <20200325211233.27394-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325211233.27394-1-pierre-louis.bossart@linux.intel.com>
References: <20200325211233.27394-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Further align HDA init sequence to the legacy non-DSP HDA driver by
calling snd_hdac_set_codec_wakeup() during the chip init sequence.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda-ctrl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/sof/intel/hda-ctrl.c b/sound/soc/sof/intel/hda-ctrl.c
index 93be6fc51ccd..f88dbcc4ba66 100644
--- a/sound/soc/sof/intel/hda-ctrl.c
+++ b/sound/soc/sof/intel/hda-ctrl.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <sound/hdaudio_ext.h>
 #include <sound/hda_register.h>
+#include <sound/hda_component.h>
 #include "../ops.h"
 #include "hda.h"
 
@@ -176,6 +177,9 @@ int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev, bool full_reset)
 	if (bus->chip_init)
 		return 0;
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	snd_hdac_set_codec_wakeup(bus, true);
+#endif
 	hda_dsp_ctrl_misc_clock_gating(sdev, false);
 
 	if (full_reset) {
@@ -271,6 +275,9 @@ int hda_dsp_ctrl_init_chip(struct snd_sof_dev *sdev, bool full_reset)
 
 err:
 	hda_dsp_ctrl_misc_clock_gating(sdev, true);
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
+	snd_hdac_set_codec_wakeup(bus, false);
+#endif
 
 	return ret;
 }
-- 
2.20.1

