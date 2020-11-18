Return-Path: <SRS0=NmsS=EY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1EAC6379D
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 14:09:18 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3DD122244
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Nov 2020 14:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WIZ/WemU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3DD122244
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9906E1616;
	Wed, 18 Nov 2020 15:08:24 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9906E1616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1605708554;
	bh=SrpwpDQ4uVNu8L+qJL5JZwcAWJoWwKBtFhfz62ZiSNM=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WIZ/WemUGVCJwK784W4g8oaEYq9tMLdRjVEv9Ylo7wRQ1xVp+1ZdYNkzSz/V0oUtj
	 njz4MCagAJ4cG+4DNzZhrQCT7bviWp9oJq56Mj4SCeOCXlsOSpowBw0wSA4XfN4Ds2
	 kvXmhX9VYpJ4ysgSXZ8jK2N/AFvq5sBHjl8U5UcU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 27857F8010A;
	Wed, 18 Nov 2020 15:08:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4A523F8016D; Wed, 18 Nov 2020 15:08:22 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D4B06F800EE
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2020 15:08:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D4B06F800EE
IronPort-SDR: Aze0/kzGHOIjngVzqTylS3PjoceOLMv8EiuY34K4UUdvKzCL9DE//XXfv4S9oqcPQ9Ac2pVL0u
 tvqi1udOBAXg==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="168547610"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; d="scan'208";a="168547610"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Nov 2020 06:08:06 -0800
IronPort-SDR: CT1WILVLTQVYfbOY55Wpp3hS5yeZ6JmokSx0Ka2hNZWN2K4i1q04gsSHTeS711a4Nvlg/dvStm
 pYOlixvUd9OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; d="scan'208";a="330512884"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga006.jf.intel.com with ESMTP; 18 Nov 2020 06:08:03 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 1/2] ASoC: SOF: relax PCM period and buffer size constraints
Date: Wed, 18 Nov 2020 16:05:44 +0200
Message-Id: <20201118140545.2138895-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: lgirdwood@gmail.com, daniel.baluta@nxp.com,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

Current SOF implementation limits period and buffer sizes to multiples
of period_min. Period_min is defined in topology, but is in practise set
to align with the SOF DSP timer tick (typically 1ms).

While this approach helps user-space to avoid period sizes, which are
not aligned to the DSP timer tick, it causes problems to applications
which want to align data processing size to that of ALSA period size.
One example is JACK audio server, which limits period sizes to power of
two values.

Other ALSA drivers where audio data transfer is driven by a timer tick,
like USB, do not constraint period and buffer sizes to exact multiple of
the timer tick.

To align SOF to follow the same behaviour, drop the additional alignment
constraints. As a side-effect, this patch can cause irregularity to
period wakeup timing. This happens when application chooses settings
which were previously forbidden. For example, if application configures
period size to 2^14 bytes and audio config of S32_LE/2ch/48000Hz, one
period represents 42.667ms of audio. Without this patch, this
configuration is not allowed by SOF. With the patch applied,
configuration is allowed but the wakeups are paced by the DSP timer
tick, which is typically 1ms. Application will see period wakeups with a
42/43/42/43ms repeating pattern.

Both approaches are valid within ALSA context, but relaxing the
constraints is better aligned with existing applications and other ALSA
drivers like USB audio.

BugLink: https://github.com/thesofproject/linux/issues/2391
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/pcm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 0a70e685f826..37d12162e448 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -478,17 +478,10 @@ static int sof_pcm_open(struct snd_soc_component *component,
 
 	caps = &spcm->pcm.caps[substream->stream];
 
-	/* set any runtime constraints based on topology */
-	snd_pcm_hw_constraint_step(substream->runtime, 0,
-				   SNDRV_PCM_HW_PARAM_BUFFER_BYTES,
-				   le32_to_cpu(caps->period_size_min));
-	snd_pcm_hw_constraint_step(substream->runtime, 0,
-				   SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
-				   le32_to_cpu(caps->period_size_min));
-
 	/* set runtime config */
 	runtime->hw.info = ops->hw_info; /* platform-specific */
 
+	/* set any runtime constraints based on topology */
 	runtime->hw.formats = le64_to_cpu(caps->formats);
 	runtime->hw.period_bytes_min = le32_to_cpu(caps->period_size_min);
 	runtime->hw.period_bytes_max = le32_to_cpu(caps->period_size_max);
-- 
2.28.0

