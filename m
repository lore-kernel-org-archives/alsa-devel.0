Return-Path: <SRS0=gzS/=BF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7154C433E1
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Jul 2020 16:14:36 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4040B206D8
	for <alsa-devel@archiver.kernel.org>; Sun, 26 Jul 2020 16:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="tmSwB0op"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4040B206D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C65C91615;
	Sun, 26 Jul 2020 18:13:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C65C91615
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1595780074;
	bh=9reshNCRcfi8DmbRs7Qs1f26XGgE+PFli+K2kvKwzbo=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=tmSwB0opMOC3mDnb4PGx2BMpW/u1f9Q2RbNwpCJXOSPHaL+IwbsoCj2JieOgGW6sz
	 MBlpdyWlJzxJhIGO3pJJyFClOhV7VgNtHlRGGtSWrQj7CAWN5m9I1IYOX8CDj3LhXe
	 04NVfIsoQZji6d/ujAxOCQL9ai0Qwqx3jvfwTRb4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 38331F801F7;
	Sun, 26 Jul 2020 18:13:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 39BA9F8020B; Sun, 26 Jul 2020 18:13:42 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C83BAF80134
 for <alsa-devel@alsa-project.org>; Sun, 26 Jul 2020 18:13:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C83BAF80134
IronPort-SDR: C5NhnU0WvHdt/1mK6dVQ7SIJoHB37LFBsG1GnYKOTILr8yYOvp2OHi61GZ40ODCuj6cNACE3RJ
 98wP8oG5angw==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="148387501"
X-IronPort-AV: E=Sophos;i="5.75,399,1589266800"; d="scan'208";a="148387501"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jul 2020 09:13:30 -0700
IronPort-SDR: yY+zWewQlmIQQ4SZm4+Nwpo6JVvW6PCWzRkaV6S7B8WFSsqloF5rtBvgtjoH2MxNNHuoXi08YD
 rVQppWcFXqng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,399,1589266800"; d="scan'208";a="319798585"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
 by orsmga008.jf.intel.com with ESMTP; 26 Jul 2020 09:13:28 -0700
From: Brent Lu <brent.lu@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Intel: Atom: use hardware counter to update hw_ptr
Date: Mon, 27 Jul 2020 00:08:47 +0800
Message-Id: <1595779727-31404-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, linux-kernel@vger.kernel.org,
 Takashi Iwai <tiwai@suse.com>, Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
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

The ring buffer counter runs faster than hardware counter if the
period size in hw_param is larger than 240. Although the differce is
not much (around 2k frames), it causes false underrun in CRAS
sometimes because it's using 256 frames as period size in hw_param.
Using the hardware counter could provide precise hw_ptr to user space
and avoid the false underrun in CRAS.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/atom/sst/sst_drv_interface.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_drv_interface.c b/sound/soc/intel/atom/sst/sst_drv_interface.c
index 7624953..1949ad9 100644
--- a/sound/soc/intel/atom/sst/sst_drv_interface.c
+++ b/sound/soc/intel/atom/sst/sst_drv_interface.c
@@ -485,7 +485,6 @@ static inline int sst_calc_tstamp(struct intel_sst_drv *ctx,
 		struct snd_pcm_substream *substream,
 		struct snd_sst_tstamp *fw_tstamp)
 {
-	size_t delay_bytes, delay_frames;
 	size_t buffer_sz;
 	u32 pointer_bytes, pointer_samples;
 
@@ -493,22 +492,14 @@ static inline int sst_calc_tstamp(struct intel_sst_drv *ctx,
 			fw_tstamp->ring_buffer_counter);
 	dev_dbg(ctx->dev, "mrfld hardware_counter %llu in bytes\n",
 			 fw_tstamp->hardware_counter);
-	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-		delay_bytes = (size_t) (fw_tstamp->ring_buffer_counter -
-					fw_tstamp->hardware_counter);
-	else
-		delay_bytes = (size_t) (fw_tstamp->hardware_counter -
-					fw_tstamp->ring_buffer_counter);
-	delay_frames = bytes_to_frames(substream->runtime, delay_bytes);
+
 	buffer_sz = snd_pcm_lib_buffer_bytes(substream);
-	div_u64_rem(fw_tstamp->ring_buffer_counter, buffer_sz, &pointer_bytes);
+	div_u64_rem(fw_tstamp->hardware_counter, buffer_sz, &pointer_bytes);
 	pointer_samples = bytes_to_samples(substream->runtime, pointer_bytes);
 
-	dev_dbg(ctx->dev, "pcm delay %zu in bytes\n", delay_bytes);
-
 	info->buffer_ptr = pointer_samples / substream->runtime->channels;
+	info->pcm_delay = 0;
 
-	info->pcm_delay = delay_frames;
 	dev_dbg(ctx->dev, "buffer ptr %llu pcm_delay rep: %llu\n",
 			info->buffer_ptr, info->pcm_delay);
 	return 0;
-- 
2.7.4

