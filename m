Return-Path: <SRS0=htQG=NI=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E54C4338F
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 16:43:19 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1168B60E09
	for <alsa-devel@archiver.kernel.org>; Tue, 17 Aug 2021 16:43:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1168B60E09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 949591683;
	Tue, 17 Aug 2021 18:42:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 949591683
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629218596;
	bh=opU0yc57NnppprOvbDoCfk1rDfvw04Wyp8pyexzC9q4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e1mUYbq2jjmKGuGORITKEfT3B7Vedxhi7F5tS+2bIrONGZaGfL6NskYYmPl2vsAMI
	 NOBj/idK5dmq4z5xhwFUA9xkoAUyl5OD5o3UnFcgH/6qEGz5+1uPi1anmfmfdvbjm7
	 BiQEYD+ymi8hU+te+v+VSKjO4KviqCOZ/+erMml8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CB49AF804CF;
	Tue, 17 Aug 2021 18:41:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2129DF802C4; Tue, 17 Aug 2021 18:41:33 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0C957F8026D
 for <alsa-devel@alsa-project.org>; Tue, 17 Aug 2021 18:41:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0C957F8026D
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="279884373"
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; d="scan'208";a="279884373"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2021 09:41:15 -0700
X-IronPort-AV: E=Sophos;i="5.84,329,1620716400"; d="scan'208";a="449342716"
Received: from aaadelek-mobl3.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.12.89])
 by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2021 09:41:14 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 1/2] ASoC: soc-pcm: protect BE dailink state changes in
 trigger
Date: Tue, 17 Aug 2021 11:40:53 -0500
Message-Id: <20210817164054.250028-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817164054.250028-1-pierre-louis.bossart@linux.intel.com>
References: <20210817164054.250028-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, liam.r.girdwood@linux.intel.com,
 vkoul@kernel.org, broonie@kernel.org
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

When more than one FE is connected to a BE, e.g. in a mixing use case,
the BE can be triggered multiple times when the FE are opened/started
concurrently. This race condition is problematic in the case of
SoundWire BE dailinks, and this is not desirable in a general
case. The code carefully checks when the BE can be stopped or
hw_free'ed, but the trigger code does not use any mutual exclusion.

Fix by using the same spinlock already used to check FE states, and
set the state before the trigger. In case of errors,  the initial
state will be restored.

This patch does not change how the triggers are handled, it only makes
sure the states are handled in critical sections.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/soc-pcm.c | 103 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 85 insertions(+), 18 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 48f71bb81a2f..0717f39d2eec 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1999,6 +1999,8 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 	struct snd_soc_pcm_runtime *be;
 	struct snd_soc_dpcm *dpcm;
 	int ret = 0;
+	unsigned long flags;
+	enum snd_soc_dpcm_state state;
 
 	for_each_dpcm_be(fe, stream, dpcm) {
 		struct snd_pcm_substream *be_substream;
@@ -2015,76 +2017,141 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 
 		switch (cmd) {
 		case SNDRV_PCM_TRIGGER_START:
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
-			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED)) {
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
+			}
+			state = be->dpcm[stream].state;
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+				be->dpcm[stream].state = state;
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
+			}
 
-			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_RESUME:
-			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND) {
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
+			}
+
+			state = be->dpcm[stream].state;
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+				be->dpcm[stream].state = state;
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
+			}
 
-			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED) {
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
+			}
+
+			state = be->dpcm[stream].state;
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+				be->dpcm[stream].state = state;
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
+			}
 
-			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
 		case SNDRV_PCM_TRIGGER_STOP:
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) &&
-			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED)) {
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
+			}
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
 				continue;
 
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+			state = be->dpcm[stream].state;
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
+
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+				be->dpcm[stream].state = state;
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
+			}
 
-			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
 			break;
 		case SNDRV_PCM_TRIGGER_SUSPEND:
-			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) {
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
+			}
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
 				continue;
 
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+			state = be->dpcm[stream].state;
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
+
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+				be->dpcm[stream].state = state;
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
+			}
 
-			be->dpcm[stream].state = SND_SOC_DPCM_STATE_SUSPEND;
 			break;
 		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START) {
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				continue;
+			}
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 
 			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
 				continue;
 
+			spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+			state = be->dpcm[stream].state;
+			be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
+			spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
+
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				spin_lock_irqsave(&fe->card->dpcm_lock, flags);
+				be->dpcm[stream].state = state;
+				spin_unlock_irqrestore(&fe->card->dpcm_lock, flags);
 				goto end;
+			}
 
-			be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
 			break;
 		}
 	}
-- 
2.25.1

