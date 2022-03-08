Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 449C4C433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  8 Mar 2022 16:47:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C9FF1779;
	Tue,  8 Mar 2022 17:46:22 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C9FF1779
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646758032;
	bh=GvwRtUM5etc5jOpQmyBLezTHk4i8Qjvpq6in2Y5Q8Bk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fuTSL8WNzVXnjO1kzF3SbcXbF5grYkmDUMks6ev63brkrRhJE/zE9vIoXWbzhDq3Y
	 a7/mhF2obKJxYK3kgGs8VfRoxo3TEZHSZyDcJUA1N2W7Kpi0WkJccWVQajRrMlfdLl
	 ToAV5UL28dhyXmbYLymeDgTn9remOzpW74q9k2g4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C383AF80539;
	Tue,  8 Mar 2022 17:44:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E0058F8052D; Tue,  8 Mar 2022 17:44:16 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A98FCF8026D
 for <alsa-devel@alsa-project.org>; Tue,  8 Mar 2022 17:44:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A98FCF8026D
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ac9Lkz6/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646757848; x=1678293848;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=GvwRtUM5etc5jOpQmyBLezTHk4i8Qjvpq6in2Y5Q8Bk=;
 b=ac9Lkz6/Ie/m+O1RAqwe/oAjTwrD/nRrXqichMrFIHcX2NVGBwJue24x
 2zMca5/IkJaGOPNRgqANwopI5X1LcucamvWRb2LklV9tdH+mJQg72y/A8
 BgMgXmARSFup2cdeO3VQhTdXis1Nz2aZ7XG2eAP7MvoRdKWaA7CpSsStB
 O6kp16IttJhSbDcM64H7PgOGU+CjZYO+tL4Bh4TZJmGC7Ta5mG1jKa5Lj
 YF8W0MPBQNv7Vx4YM0StYgdU59WAaBTnKYTfXk29bSfiThYpd+CarGaA/
 PpnWrnspjXI3r+H1KYjd2fe/3m1forgrxIBZBHnFJaPCpeyAzBpsFkhYk g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="252307203"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="252307203"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 08:43:52 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; d="scan'208";a="537633205"
Received: from bustam3x-mobl.amr.corp.intel.com (HELO
 rsridh2-mobl1.localdomain) ([10.251.130.225])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Mar 2022 08:43:51 -0800
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 01/18] ASoC: SOF: remove snd_sof_pipeline_find()
Date: Tue,  8 Mar 2022 08:43:27 -0800
Message-Id: <20220308164344.577647-2-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220308164344.577647-1-ranjani.sridharan@linux.intel.com>
References: <20220308164344.577647-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com,
 Bard Liao <yung-chuan.liao@linux.intel.com>
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

It is not used.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/sof-audio.c | 16 ----------------
 sound/soc/sof/sof-audio.h |  2 --
 2 files changed, 18 deletions(-)

diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 9e76b796502f..ac1edb4a082d 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -624,22 +624,6 @@ int sof_set_hw_params_upon_resume(struct device *dev)
 	return snd_sof_dsp_hw_params_upon_resume(sdev);
 }
 
-const struct sof_ipc_pipe_new *snd_sof_pipeline_find(struct snd_sof_dev *sdev,
-						     int pipeline_id)
-{
-	const struct snd_sof_widget *swidget;
-
-	list_for_each_entry(swidget, &sdev->widget_list, list)
-		if (swidget->id == snd_soc_dapm_scheduler) {
-			const struct sof_ipc_pipe_new *pipeline =
-				swidget->private;
-			if (pipeline->pipeline_id == pipeline_id)
-				return pipeline;
-		}
-
-	return NULL;
-}
-
 int sof_set_up_pipelines(struct snd_sof_dev *sdev, bool verify)
 {
 	struct sof_ipc_fw_version *v = &sdev->fw_ready.version;
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index f3009e6b91a1..107e0ef93e16 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -222,8 +222,6 @@ struct snd_sof_pcm *snd_sof_find_spcm_comp(struct snd_soc_component *scomp,
 					   int *direction);
 struct snd_sof_pcm *snd_sof_find_spcm_pcm_id(struct snd_soc_component *scomp,
 					     unsigned int pcm_id);
-const struct sof_ipc_pipe_new *snd_sof_pipeline_find(struct snd_sof_dev *sdev,
-						     int pipeline_id);
 void snd_sof_pcm_period_elapsed(struct snd_pcm_substream *substream);
 void snd_sof_pcm_init_elapsed_work(struct work_struct *work);
 
-- 
2.25.1

