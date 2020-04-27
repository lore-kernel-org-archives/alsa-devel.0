Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D73C4CECC
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 17:48:14 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C700721707
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 17:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="OgF7u9hj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C700721707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2EA47168F;
	Mon, 27 Apr 2020 19:47:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2EA47168F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588009692;
	bh=FMt1vf6yW7K1R4Nnbn+PofdvzH5DJMyN4j77S03X46k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OgF7u9hjGbI+k9+b8df+JUJJJuyGCqbnHGUEkVNPllYVA4MJ2Azt3f8Cq95zULBxn
	 wpf5bMLCbfIgo19uIUQYD1du3dzIRtItSip+v8TejN+jUqtMFtmfHNYchMTp5cIJKe
	 5aWVLCa9LfVWKCTlhXSgTbeAZJ3OJW3infkW5RHE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53F32F8028C;
	Mon, 27 Apr 2020 19:20:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 21E20F80245; Mon, 27 Apr 2020 19:19:54 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AA4F1F80112
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 19:19:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AA4F1F80112
IronPort-SDR: i+lGf2E2UXAvkRn/dCFoPCgQip8RGqM2iIsOW4ve1ZCcTNrF0UPD+BPyjrEucUuKEI0zzUs+Ra
 BTkivECTdRJg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 10:19:48 -0700
IronPort-SDR: DADqqs2VzvU4RMSSL6T60L9KHe4i0BJ0rYCBdBIHkENHyPdaStM4QkMLCKL6kggUXRPd4ZJut5
 q69mUwJ6AJ1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; d="scan'208";a="458932342"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
 by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2020 10:19:45 -0700
From: Brent Lu <brent.lu@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 2/3] ASoC: bdw-rt5650: add channel constraint
Date: Tue, 28 Apr 2020 01:13:33 +0800
Message-Id: <1588007614-25061-3-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
References: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Ben Zhang <benzh@chromium.org>, Mac Chiang <mac.chiang@intel.com>,
 Mark Brown <broonie@kernel.org>, Brent Lu <brent.lu@intel.com>
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

BDW boards using this machine driver supports only 2 or 4-channel capture.
Implement a constraint to enforce it.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/bdw-rt5650.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/intel/boards/bdw-rt5650.c b/sound/soc/intel/boards/bdw-rt5650.c
index af2f502..a97e912 100644
--- a/sound/soc/intel/boards/bdw-rt5650.c
+++ b/sound/soc/intel/boards/bdw-rt5650.c
@@ -162,6 +162,34 @@ static int bdw_rt5650_rtd_init(struct snd_soc_pcm_runtime *rtd)
 }
 #endif
 
+static const unsigned int channels[] = {
+	2, 4,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
+	.count = ARRAY_SIZE(channels),
+	.list = channels,
+	.mask = 0,
+};
+
+static int bdw_rt5650_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	/* Board supports stereo and quad configurations for capture */
+	if (substream->stream != SNDRV_PCM_STREAM_CAPTURE)
+		return 0;
+
+	runtime->hw.channels_max = 4;
+	return snd_pcm_hw_constraint_list(runtime, 0,
+					  SNDRV_PCM_HW_PARAM_CHANNELS,
+					  &constraints_channels);
+}
+
+static const struct snd_soc_ops bdw_rt5650_fe_ops = {
+	.startup = bdw_rt5650_fe_startup,
+};
+
 static int bdw_rt5650_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct bdw_rt5650_priv *bdw_rt5650 =
@@ -234,6 +262,7 @@ static struct snd_soc_dai_link bdw_rt5650_dais[] = {
 		.name = "System PCM",
 		.stream_name = "System Playback",
 		.dynamic = 1,
+		.ops = &bdw_rt5650_fe_ops,
 #if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
 		.init = bdw_rt5650_rtd_init,
 #endif
-- 
2.7.4

