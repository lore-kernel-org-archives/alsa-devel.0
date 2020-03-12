Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407C7C10DCE
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:40:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C550D206E2
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LSeGxQdX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C550D206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD2C6176A;
	Thu, 12 Mar 2020 20:39:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD2C6176A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584042008;
	bh=IeqCHSFn2b06SUcABCcxXtQ6OOtyClg64A7E6tdY2y4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LSeGxQdXSJeER2z5hk93MF5QdsUCOegEqxOSAP+ElXhBYZaUuypKFsKyVq4zRLGC2
	 U/U3k14MRPGTTAr82372THWFyjJWhz7R29NuivnBhk89FroKFj6mAxSYuD/UFePt4k
	 fBYOtJkmMwPF0n0bxEMy4qAL7QI9hgtg3IqZgujA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E4263F802E8;
	Thu, 12 Mar 2020 20:35:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C0791F802E9; Thu, 12 Mar 2020 20:35:20 +0100 (CET)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 51798F802DC
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 20:35:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 51798F802DC
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 12:35:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; d="scan'208";a="243142723"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com)
 ([10.251.241.169])
 by orsmga003.jf.intel.com with ESMTP; 12 Mar 2020 12:35:13 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 08/10] ASoC: SOF: Intel: hda: add parameter to control
 SoundWire clock stop quirks
Date: Thu, 12 Mar 2020 14:33:44 -0500
Message-Id: <20200312193346.3264-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
References: <20200312193346.3264-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Daniel Baluta <daniel.baluta@nxp.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de, gregkh@linuxfoundation.org,
 Takashi Iwai <tiwai@suse.com>, YueHaibing <yuehaibing@huawei.com>,
 linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Hui Wang <hui.wang@canonical.com>, vkoul@kernel.org, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, slawomir.blauciak@intel.com,
 Zhu Yingjiang <yingjiang.zhu@linux.intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
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

Add module parameter so that the different modes can be quickly tested.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index f7e5371789f2..32b02d3b6536 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -40,6 +40,16 @@
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_INTEL_SOUNDWIRE)
 
+/*
+ * The default for SoundWire clock stop quirks is to power gate the IP
+ * and do a Bus Reset, this will need to be modified when the DSP
+ * needs to remain in D0i3 so that the Master does not lose context
+ * and enumeration is not required on clock restart
+ */
+static int sdw_clock_stop_quirks = SDW_INTEL_CLK_STOP_BUS_RESET;
+module_param(sdw_clock_stop_quirks, int, 0444);
+MODULE_PARM_DESC(sdw_clock_stop_quirks, "SOF SoundWire clock stop quirks");
+
 static int sdw_params_stream(struct device *dev,
 			     struct sdw_intel_stream_params_data *params_data)
 {
@@ -149,6 +159,7 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 	res.parent = sdev->dev;
 	res.ops = &sdw_callback;
 	res.dev = sdev->dev;
+	res.clock_stop_quirks = sdw_clock_stop_quirks;
 
 	/*
 	 * ops and arg fields are not populated for now,
-- 
2.20.1

