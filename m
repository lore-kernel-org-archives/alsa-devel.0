Return-Path: <SRS0=EWQz=PB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA8DC4332F
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 14:34:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABF98610FC
	for <alsa-devel@archiver.kernel.org>; Wed, 13 Oct 2021 14:34:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ABF98610FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE7671689;
	Wed, 13 Oct 2021 16:34:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE7671689
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1634135692;
	bh=mi2GlDRku2+GbIlYtPaZXAo7SEgr/ULdCFMsOQKXuAw=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qRDG/k6XY7Q81sxYs+w0CuIbJDLDx6oNcRhP+b7Z1c73+4SXA44cLTVDF00WmFytv
	 XfVmryse93yGq8uj36j1p4lcKtnRVCyQLCNk4Dx0nV45CeAb+sbIJ9/4nmlwkxZLd8
	 C2F5uRQcqyFlsZc02iXIPA5ZlWCNZF35UUZC+3N8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 51A14F8051F;
	Wed, 13 Oct 2021 16:31:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 13AC2F80510; Wed, 13 Oct 2021 16:31:31 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 998FAF80430
 for <alsa-devel@alsa-project.org>; Wed, 13 Oct 2021 16:31:17 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 998FAF80430
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="313639548"
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="313639548"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 07:31:16 -0700
X-IronPort-AV: E=Sophos;i="5.85,371,1624345200"; d="scan'208";a="524649529"
Received: from ssafavib-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.209.164.198])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2021 07:31:14 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH v3 06/13] ASoC: soc-pcm: remove dpcm spin_lock,
 use PCM stream lock
Date: Wed, 13 Oct 2021 09:30:43 -0500
Message-Id: <20211013143050.244444-7-pierre-louis.bossart@linux.intel.com>
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

There is no need for a DPCM-specific lock at the card level, we can
use the FE-specific PCM lock instead. In addition, these PCM locks will
rely on either a spin-lock or a mutex depending on atomicity.

Since the FE PCM lock is already taken during the trigger, new
_locked versions of the helpers snd_soc_dpcm_can_be_free_stop() and
snd_soc_dpcm_check_state() are introduced. Without these changes a
conceptual deadlock happens on TRIGGER_STOP.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc.h  |  2 --
 sound/soc/soc-core.c |  1 -
 sound/soc/soc-pcm.c  | 55 +++++++++++++++++++++++++++++++++++---------
 3 files changed, 44 insertions(+), 14 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 8e6dd8a257c5..5872a8864f3b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -893,8 +893,6 @@ struct snd_soc_card {
 	struct mutex pcm_mutex;
 	enum snd_soc_pcm_subclass pcm_subclass;
 
-	spinlock_t dpcm_lock;
-
 	int (*probe)(struct snd_soc_card *card);
 	int (*late_probe)(struct snd_soc_card *card);
 	int (*remove)(struct snd_soc_card *card);
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 80ca260595fd..b029e07ad1e1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2339,7 +2339,6 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
 	mutex_init(&card->pcm_mutex);
-	spin_lock_init(&card->dpcm_lock);
 
 	return snd_soc_bind_card(card);
 }
diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index f22bbf95319d..797f0d114c83 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -31,13 +31,13 @@
 
 void snd_soc_dpcm_fe_lock_irq(struct snd_soc_pcm_runtime *fe, int stream)
 {
-	spin_lock_irq(&fe->card->dpcm_lock);
+	snd_pcm_stream_lock_irq(snd_soc_dpcm_get_substream(fe, stream));
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_fe_lock_irq);
 
 void snd_soc_dpcm_fe_unlock_irq(struct snd_soc_pcm_runtime *fe, int stream)
 {
-	spin_unlock_irq(&fe->card->dpcm_lock);
+	snd_pcm_stream_unlock_irq(snd_soc_dpcm_get_substream(fe, stream));
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_fe_unlock_irq);
 
@@ -45,6 +45,9 @@ EXPORT_SYMBOL_GPL(snd_soc_dpcm_fe_unlock_irq);
 static int snd_soc_dpcm_can_be_free_stop(struct snd_soc_pcm_runtime *fe,
 					 struct snd_soc_pcm_runtime *be, int stream);
 
+static int snd_soc_dpcm_can_be_free_stop_locked(struct snd_soc_pcm_runtime *fe,
+						struct snd_soc_pcm_runtime *be, int stream);
+
 /* can this BE perform a hw_params() */
 static int snd_soc_dpcm_can_be_params(struct snd_soc_pcm_runtime *fe,
 				      struct snd_soc_pcm_runtime *be, int stream);
@@ -2101,7 +2104,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			    (be->dpcm[stream].state != SND_SOC_DPCM_STATE_PAUSED))
 				continue;
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+			if (!snd_soc_dpcm_can_be_free_stop_locked(fe, be, stream))
 				continue;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
@@ -2114,7 +2117,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
 				continue;
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+			if (!snd_soc_dpcm_can_be_free_stop_locked(fe, be, stream))
 				continue;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
@@ -2127,7 +2130,7 @@ int dpcm_be_dai_trigger(struct snd_soc_pcm_runtime *fe, int stream,
 			if (be->dpcm[stream].state != SND_SOC_DPCM_STATE_START)
 				continue;
 
-			if (!snd_soc_dpcm_can_be_free_stop(fe, be, stream))
+			if (!snd_soc_dpcm_can_be_free_stop_locked(fe, be, stream))
 				continue;
 
 			ret = soc_pcm_trigger(be_substream, cmd);
@@ -2873,18 +2876,17 @@ struct snd_pcm_substream *
 }
 EXPORT_SYMBOL_GPL(snd_soc_dpcm_get_substream);
 
-static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
-				    struct snd_soc_pcm_runtime *be,
-				    int stream,
-				    const enum snd_soc_dpcm_state *states,
-				    int num_states)
+static int snd_soc_dpcm_check_state_locked(struct snd_soc_pcm_runtime *fe,
+					   struct snd_soc_pcm_runtime *be,
+					   int stream,
+					   const enum snd_soc_dpcm_state *states,
+					   int num_states)
 {
 	struct snd_soc_dpcm *dpcm;
 	int state;
 	int ret = 1;
 	int i;
 
-	snd_soc_dpcm_fe_lock_irq(fe, stream);
 	for_each_dpcm_fe(be, stream, dpcm) {
 
 		if (dpcm->fe == fe)
@@ -2898,12 +2900,43 @@ static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
 			}
 		}
 	}
+
+	/* it's safe to do this BE DAI */
+	return ret;
+}
+
+static int snd_soc_dpcm_check_state(struct snd_soc_pcm_runtime *fe,
+				    struct snd_soc_pcm_runtime *be,
+				    int stream,
+				    const enum snd_soc_dpcm_state *states,
+				    int num_states)
+{
+	int ret;
+
+	snd_soc_dpcm_fe_lock_irq(fe, stream);
+	ret = snd_soc_dpcm_check_state_locked(fe, be, stream, states, num_states);
 	snd_soc_dpcm_fe_unlock_irq(fe, stream);
 
 	/* it's safe to do this BE DAI */
 	return ret;
 }
 
+/*
+ * We can only hw_free, stop, pause or suspend a BE DAI if any of it's FE
+ * are not running, paused or suspended for the specified stream direction.
+ */
+static int snd_soc_dpcm_can_be_free_stop_locked(struct snd_soc_pcm_runtime *fe,
+		struct snd_soc_pcm_runtime *be, int stream)
+{
+	const enum snd_soc_dpcm_state state[] = {
+		SND_SOC_DPCM_STATE_START,
+		SND_SOC_DPCM_STATE_PAUSED,
+		SND_SOC_DPCM_STATE_SUSPEND,
+	};
+
+	return snd_soc_dpcm_check_state_locked(fe, be, stream, state, ARRAY_SIZE(state));
+}
+
 /*
  * We can only hw_free, stop, pause or suspend a BE DAI if any of it's FE
  * are not running, paused or suspended for the specified stream direction.
-- 
2.25.1

