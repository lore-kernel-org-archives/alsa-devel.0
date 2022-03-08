Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F125C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Mar 2022 16:48:48 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5D6A11841;
	Tue,  8 Mar 2022 17:47:56 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5D6A11841
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646758126;
	bh=fdusk4mIRY3Gj3t70NFmlai8JLzeG3FfDwKkbbLpTi8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lTkDI2rSWdErM7SOZjSHxTZs0bI9bDFyoM/WXc8L2DGgWsAjC5xSB1DHx0KDV++H2
	 1bgWGal6qv5RcuZB9TohZZNQN7tyLBlU/k58w8dclYVAlqkIp9DJ+ULD2zRSYHT8pg
	 A2yRSo7VSVJ0ZQ6PqVvVcmLiie0l9ciz3MqMtduU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id CE39FF80570;
	Tue,  8 Mar 2022 17:44:30 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E7F6F8053D; Tue,  8 Mar 2022 17:44:23 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BC42F80515
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2022 17:44:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BC42F80515
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="PKJAI5WL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646757852; x=1678293852;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=fdusk4mIRY3Gj3t70NFmlai8JLzeG3FfDwKkbbLpTi8=;
 b=PKJAI5WLR03A5MetMXf4KGtcy3xcJMZgjzzCu//3FUzhintXIKYlHqo6
 z7blFEu9n2rTjWi28RIH4Q0rH2WgSnDDjZcDtAr+PlesF8UoiZ8/kpszJ
 LKe/BqruIkmPZX+1JkJ+YK0j4uN7zrQAgJXmU2BTsLDFKzaLzs358R7zh
 Nos8irOKFkRAfopoRu6l9H0tL93jr1aazt2M8Vekdzf//bGFWlbxdxgl3
 /2dL3iJVoVb6BNbHwIwFw5zfmxVPaLEUOdXeUSlMl2I5oSdTl3KaPmlTw
 LT3m1OC28/tgtieC3PkZ7xdY+TBGUrfpzQPjvm+psgsRd6MFz/wsaxgN4 g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252307215"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="252307215"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 08:43:53 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="537633232"
Received: from bustam3x-mobl.amr.corp.intel.com (HELO
 rsridh2-mobl1.localdomain) ([10.251.130.225])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 08:43:53 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 04/18] ASoC: SOF: sof-audio: removed unused function
Date: Tue,  8 Mar 2022 08:43:30 -0800
Message-Id: <20220308164344.577647-5-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308164344.577647-1-ranjani.sridharan@linux.intel.com>
References: <20220308164344.577647-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Ranjani Sridharan <ranjani.sridharan@intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, amadeuszx.slawinski@linux.intel.com,
 =?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

cppcheck warning:

sound/soc/sof/sof-audio.c:884:0: style: The function
'snd_sof_find_spcm_pcm_id' is never used. [unusedFunction]

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@intel.com>
---
 sound/soc/sof/sof-audio.c | 14 --------------
 sound/soc/sof/sof-audio.h |  2 --
 2 files changed, 16 deletions(-)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 4816473cfd7d..e39f18e824b4 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -866,20 +866,6 @@ struct snd_sof_pcm *snd_sof_find_spcm_comp(struct snd_soc_component *scomp,
 	return NULL;
 }
 
-struct snd_sof_pcm *snd_sof_find_spcm_pcm_id(struct snd_soc_component *scomp,
-					     unsigned int pcm_id)
-{
-	struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(scomp);
-	struct snd_sof_pcm *spcm;
-
-	list_for_each_entry(spcm, &sdev->pcm_list, list) {
-		if (le32_to_cpu(spcm->pcm.pcm_id) == pcm_id)
-			return spcm;
-	}
-
-	return NULL;
-}
-
 struct snd_sof_widget *snd_sof_find_swidget(struct snd_soc_component *scomp,
 					    const char *name)
 {
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 107e0ef93e16..f2f32f2065d3 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -220,8 +220,6 @@ struct snd_sof_pcm *snd_sof_find_spcm_name(struct snd_soc_component *scomp,
 struct snd_sof_pcm *snd_sof_find_spcm_comp(struct snd_soc_component *scomp,
 					   unsigned int comp_id,
 					   int *direction);
-struct snd_sof_pcm *snd_sof_find_spcm_pcm_id(struct snd_soc_component *scomp,
-					     unsigned int pcm_id);
 void snd_sof_pcm_period_elapsed(struct snd_pcm_substream *substream);
 void snd_sof_pcm_init_elapsed_work(struct work_struct *work);
 
-- 
2.25.1

