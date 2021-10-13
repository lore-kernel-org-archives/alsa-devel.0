Return-Path: <SRS0=EWQz=PB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4B6C433EF
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 14:35:59 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0352E610FC
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 14:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0352E610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6EDD0169F;
	Wed, 13 Oct 2021 16:35:07 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6EDD0169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634135757;
	bh=lJMRjZzaXGyHHZJGudjzpT9d9MxIgBRr6gx/5vLtoMQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P70MBnyF+G2SAkytHAiHuvLP6qonmHX3Zc3LQvVHB2cnpXdn+us3h/RWmVtLDGShB
	 3eqdVODpAosUTvZkovXjV2WMmyxkEZQwxNbKWkdiLnze8kvsa4ZwlR9qIgu9VAo/Ly
	 hoQip1EP2NjCQuJvVv1Rob19jtgQshHQLDPAk+WM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 53E47F8053B;
	Wed, 13 Oct 2021 16:31:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A2A5CF80506; Wed, 13 Oct 2021 16:31:34 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 99480F80506
 for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2021 16:31:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 99480F80506
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="313639603"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="313639603"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 07:31:28 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="524649600"
Received: from ssafavib-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.164.198])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 07:31:27 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH v3 12/13] ASoC: soc-pcm: test refcount before triggering
Date: Wed, 13 Oct 2021 09:30:49 -0500
Message-Id: <20211013143050.244444-13-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
References: <20211013143050.244444-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, vkoul@kernel.org, broonie@kernel.org,
 Gyeongtaek Lee <gt82.lee@samsung.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
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

On start/pause_release/resume, when more than one FE is connected to
the same BE, it's possible that the trigger is sent more than
once. This is not desirable, we only want to trigger a BE once, which
is straightforward to implement with a refcount.

For stop/pause/suspend, the problem is more complicated: the check
implemented in snd_soc_dpcm_can_be_free_stop() may fail due to a
conceptual deadlock when we trigger the BE before the FE. In this
case, the FE states have not yet changed, so there are corner cases
where the TRIGGER_STOP is never sent - the dual case of start where
multiple triggers might be sent.

This patch suggests an unconditional trigger in all cases, without
checking the FE states, using a refcount protected by the BE PCM
stream lock.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-dpcm.h |  2 ++
 sound/soc/soc-pcm.c      | 53 +++++++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 11 deletions(-)

diff --git a/include/sound/soc-dpcm.h b/include/sound/soc-dpcm.h
index 8ed40b8f3da8..9464c588f71d 100644
--- a/include/sound/soc-dpcm.h
+++ b/include/sound/soc-dpcm.h
@@ -101,6 +101,8 @@ struct snd_soc_dpcm_runtime {
 	enum snd_soc_dpcm_state state;
 
 	int trigger_pending; /* trigger cmd + 1 if pending, 0 if not */
+
+	int be_start; /* refcount protected by BE stream pcm lock */
 };
 
 #define for_each_dpcm_fe(be, stream, _dpcm)				\
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index d115e9409c14..1967980d0f79 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -1600,7 +1600,7 @@ int dpcm_be_dai_startup(struct snd_soc_pcm_runtime *fe, int stream)
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_CLOSE;
 			goto unwind;
 		}
-
+		be->dpcm[stream].be_start = 0;
 		be->dpcm[stream].state = SND_SOC_DPCM_STATE_OPEN;
 		count++;
 	}
@@ -2096,14 +2096,21 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 		snd_soc_dpcm_be_lock_irqsave(be, stream, flags);
 		switch (cmd) {
 		case SNDRV_PCM_TRIGGER_START:
-			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
+			if (!be->dpcm[stream].be_start &&
+			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PREPARE) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_STOP) &&
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				goto unlock_be;
 
+			be->dpcm[stream].be_start++;
+			if (be->dpcm[stream].be_start != 1)
+				goto unlock_be;
+
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				be->dpcm[stream].be_start--;
 				goto unlock_be;
+			}
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
@@ -2111,9 +2118,15 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_SUSPEND))
 				goto unlock_be;
 
+			be->dpcm[stream].be_start++;
+			if (be->dpcm[stream].be_start != 1)
+				goto unlock_be;
+
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				be->dpcm[stream].be_start--;
 				goto unlock_be;
+			}
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
@@ -2121,9 +2134,15 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if ((be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				goto unlock_be;
 
+			be->dpcm[stream].be_start++;
+			if (be->dpcm[stream].be_start != 1)
+				goto unlock_be;
+
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				be->dpcm[stream].be_start--;
 				goto unlock_be;
+			}
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_START;
 			break;
@@ -2132,12 +2151,18 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				goto unlock_be;
 
-			if (!snd_soc_dpcm_can_be_free_stop_locked(fe, be, stream))
+			if (be->dpcm[stream].state == SND_SOC_DPCM_STATE_START)
+				be->dpcm[stream].be_start--;
+
+			if (be->dpcm[stream].be_start != 0)
 				goto unlock_be;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				if (be->dpcm[stream].state == SND_SOC_DPCM_STATE_START)
+					be->dpcm[stream].be_start++;
 				goto unlock_be;
+			}
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_STOP;
 			break;
@@ -2145,12 +2170,15 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
 				goto unlock_be;
 
-			if (!snd_soc_dpcm_can_be_free_stop_locked(fe, be, stream))
+			be->dpcm[stream].be_start--;
+			if (be->dpcm[stream].be_start != 0)
 				goto unlock_be;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				be->dpcm[stream].be_start++;
 				goto unlock_be;
+			}
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_SUSPEND;
 			break;
@@ -2158,12 +2186,15 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
 				goto unlock_be;
 
-			if (!snd_soc_dpcm_can_be_free_stop_locked(fe, be, stream))
+			be->dpcm[stream].be_start--;
+			if (be->dpcm[stream].be_start != 0)
 				goto unlock_be;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
-			if (ret)
+			if (ret) {
+				be->dpcm[stream].be_start++;
 				goto unlock_be;
+			}
 
 			be->dpcm[stream].state = SND_SOC_DPCM_STATE_PAUSED;
 			break;
-- 
2.25.1

