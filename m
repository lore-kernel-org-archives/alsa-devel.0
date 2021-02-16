Return-Path: <SRS0=ZdwS=HS=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67475C433DB
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Feb 2021 17:27:34 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A7A64E00
	for <alsa-devel@archiver.kernel.org>; Tue, 16 Feb 2021 17:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A7A64E00
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55252851;
	Tue, 16 Feb 2021 18:26:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55252851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613496451;
	bh=kXGwd/cEZ9PPyDr8DW9gjBOqzzT5zYbi+0KrZR9seY0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=H5sDb/KayQHl71cox3sHMmzomxBgyzX7/AVAEGse/TNfWsZme4L2LLAAxaSUtexG9
	 3J+cutycTLBwlhCzxrWj2G16roHKf+YrkdOd1NeoqIlz1nLMcQAXsc+PVnu4yKagju
	 gB3lTTjqDxTXFUvmQRx68ko1e38iV85Bpha6kjSY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BBC00F80155;
	Tue, 16 Feb 2021 18:26:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D4D72F8015A; Tue, 16 Feb 2021 18:26:39 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5EC99F80059
 for <alsa-devel@alsa-project.org>; Tue, 16 Feb 2021 18:26:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5EC99F80059
IronPort-SDR: gsD+x7hViUQ/XJKvAOYbv03/GKQURNOnwRzah035VtNMu32L92HrlHa6E4tKgnEJGEpVe0MMI5
 B4WrV4obUgrg==
X-IronPort-AV: E=McAfee;i="6000,8403,9897"; a="247021883"
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; d="scan'208";a="247021883"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 09:26:25 -0800
IronPort-SDR: yHZFhroZlUMsplkqzacA350k6yChUup7ev16vHaAGEjavTsQ6mcXR4jfwMi+Y8hx/XXRA1IvDa
 pKR+QTI3otgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,184,1610438400"; d="scan'208";a="399591396"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga008.jf.intel.com with ESMTP; 16 Feb 2021 09:26:21 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org, broonie@kernel.org,
 kuninori.morimoto.gx@renesas.com
Subject: [PATCH v2] ASoC: soc-pcm: fix hw param limits calculation for
 multi-DAI
Date: Tue, 16 Feb 2021 19:22:51 +0200
Message-Id: <20210216172251.3023723-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
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

In case DPCM runtime has multiple CPU DAIs, dpcm_init_runtime_hw() is
called multiple times, once for each CPU DAI. This will lead to
ignoring hw limits of all but the last DAI.

Fix this by moving soc_pcm_hw_init() up by one level to
dpcm_init_runtime_hw().

Fixes: 140f553d1298 ("ASoC: soc-pcm: fix hwparams min/max init for dpcm")
Suggested-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/soc-pcm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

v2 changes:
 - fixed incorrect text in commit message, no functional change

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 37094aeff440..14d85ca1e435 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1531,10 +1531,12 @@ static void dpcm_init_runtime_hw(struct snd_pcm_runtime *runtime,
 {
 	struct snd_pcm_hardware *hw = &runtime->hw;
 
-	soc_pcm_hw_init(hw);
 	soc_pcm_hw_update_rate(hw, stream);
 	soc_pcm_hw_update_chan(hw, stream);
-	soc_pcm_hw_update_format(hw, stream);
+	if (runtime->hw.formats)
+		runtime->hw.formats &= stream->formats;
+	else
+		runtime->hw.formats = stream->formats;
 }
 
 static void dpcm_runtime_merge_format(struct snd_pcm_substream *substream,
@@ -1662,10 +1664,13 @@ static void dpcm_runtime_merge_rate(struct snd_pcm_substream *substream,
 static void dpcm_set_fe_runtime(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_pcm_hardware *hw = &runtime->hw;
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_dai *cpu_dai;
 	int i;
 
+	soc_pcm_hw_init(hw);
+
 	for_each_rtd_cpu_dais(rtd, i, cpu_dai) {
 		/*
 		 * Skip CPUs which don't support the current stream

base-commit: 140f553d1298e0ddbe21983efe5789fe8b484273
-- 
2.29.2

