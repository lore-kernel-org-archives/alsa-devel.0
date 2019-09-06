Return-Path: <SRS0=qBPI=XB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B009C43331
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 01:28:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 068AC2082E
	for <alsa-devel@archiver.kernel.org>; Fri,  6 Sep 2019 01:28:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cboSRqOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 068AC2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CB68A1669;
	Fri,  6 Sep 2019 03:27:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CB68A1669
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1567733327;
	bh=uuHfqt9ctryYtgac62udfHECm4T+Zf51iZ+PYeSjJ/4=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=cboSRqOe4lpRHg4O9pnSun+UeiY/y7pNtz0SyiCxUX558XXM+QD8cZpAs3OJHYbyd
	 m2IU4m/1O9Cd3jdEYJx7sRHb6js94Zrt/WNbu2JXZwDuVWwpMRue5VTy4AZwpQhzO8
	 kst7Ae/BgiuyOejPhi9bL752dEg3EqXcRNKeTfmE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 44EC5F803D1;
	Fri,  6 Sep 2019 03:27:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E31AAF80448; Fri,  6 Sep 2019 03:27:54 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5C6C4F80227
 for <alsa-devel@alsa-project.org>; Fri,  6 Sep 2019 03:27:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5C6C4F80227
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Sep 2019 18:27:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,471,1559545200"; d="scan'208";a="383094043"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
 by fmsmga005.fm.intel.com with ESMTP; 05 Sep 2019 18:27:44 -0700
From: Brent Lu <brent.lu@intel.com>
To: alsa-devel@alsa-project.org
Date: Fri,  6 Sep 2019 09:24:18 +0800
Message-Id: <1567733058-9561-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: cezary.rojewski@intel.com, kuninori.morimoto.gx@renesas.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, yang.jie@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com,
 broonie@kernel.org, tglx@linutronix.de, brent.lu@intel.com
Subject: [alsa-devel] [PATCH] ASoC: bdw-rt5677: channel constraint support
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

BDW boards using this machine driver supports only stereo capture and
playback. Implement a constraint to enforce it.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/bdw-rt5677.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/sound/soc/intel/boards/bdw-rt5677.c b/sound/soc/intel/boards/bdw-rt5677.c
index 4a4d335..a312b55 100644
--- a/sound/soc/intel/boards/bdw-rt5677.c
+++ b/sound/soc/intel/boards/bdw-rt5677.c
@@ -22,6 +22,8 @@
 
 #include "../../codecs/rt5677.h"
 
+#define DUAL_CHANNEL 2
+
 struct bdw_rt5677_priv {
 	struct gpio_desc *gpio_hp_en;
 	struct snd_soc_component *component;
@@ -245,6 +247,36 @@ static int bdw_rt5677_init(struct snd_soc_pcm_runtime *rtd)
 	return 0;
 }
 
+static const unsigned int channels[] = {
+	DUAL_CHANNEL,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
+	.count = ARRAY_SIZE(channels),
+	.list = channels,
+	.mask = 0,
+};
+
+static int bdw_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	/*
+	 * On this platform for PCM device we support,
+	 * stereo
+	 */
+
+	runtime->hw.channels_max = DUAL_CHANNEL;
+	snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_CHANNELS,
+					   &constraints_channels);
+
+	return 0;
+}
+
+static const struct snd_soc_ops bdw_rt5677_fe_ops = {
+	.startup = bdw_fe_startup,
+};
+
 /* broadwell digital audio interface glue - connects codec <--> CPU */
 SND_SOC_DAILINK_DEF(dummy,
 	DAILINK_COMP_ARRAY(COMP_DUMMY()));
@@ -273,6 +305,7 @@ static struct snd_soc_dai_link bdw_rt5677_dais[] = {
 		},
 		.dpcm_capture = 1,
 		.dpcm_playback = 1,
+		.ops = &bdw_rt5677_fe_ops,
 		SND_SOC_DAILINK_REG(fe, dummy, platform),
 	},
 
-- 
2.7.4

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
