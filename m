Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65CCBC433EF
	for <alsa-devel@archiver.kernel.org>; Tue, 23 Nov 2021 16:32:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 557051671;
	Tue, 23 Nov 2021 17:31:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 557051671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637685154;
	bh=KcmY8aUKRXEUEgZWIOD+OJQDfzv3cQ7OdDebNRS6PMk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=VkDpf9ROXel6PxgQetKCmOH7cdpDDABqdoyPUC9Yj+iOIRIPXSKxVdtdhVgqlh8et
	 fdAuiSvUOKzFDbLQys86DlwEpnec6r3svej+XCZyqW7pBsc7bfx8U0uqZyHKoTj21G
	 FMkkJ1+NGKcib6jrO5nr5UY9yIEbW/a+F1O2BQp0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C47B5F80430;
	Tue, 23 Nov 2021 17:31:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9BABF8049E; Tue, 23 Nov 2021 17:31:41 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 215C9F80154
 for <alsa-devel@alsa-project.org>; Tue, 23 Nov 2021 17:31:31 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 215C9F80154
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="298466261"
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; d="scan'208";a="298466261"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2021 08:31:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,258,1631602800"; d="scan'208";a="553481480"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga008.fm.intel.com with ESMTP; 23 Nov 2021 08:31:22 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH] ASoC: SOF: handle paused streams during system suspend
Date: Tue, 23 Nov 2021 18:23:47 +0200
Message-Id: <20211123162347.120336-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, Paul Olaru <paul.olaru@oss.nxp.com>,
 daniel.baluta@nxp.com, Bard Liao <bard.liao@intel.com>
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

During system suspend, paused streams do not get suspended.
Therefore, we need to explicitly free these PCMs in the DSP
and free the associated DAPM widgets so that they can be set
up again during resume.

Fixes: 5fcdbb2d45df ("ASoC: SOF: Add support for dynamic pipelines")
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/pcm.c       |  5 ++-
 sound/soc/sof/sof-audio.c | 74 +++++++++++++++++++++++++++++++++++++--
 sound/soc/sof/sof-audio.h |  2 ++
 3 files changed, 76 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 31dd79b794f1..0ceb1a9cbf73 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -100,9 +100,8 @@ void snd_sof_pcm_period_elapsed(struct snd_pcm_substream *substream)
 }
 EXPORT_SYMBOL(snd_sof_pcm_period_elapsed);
 
-static int sof_pcm_dsp_pcm_free(struct snd_pcm_substream *substream,
-				struct snd_sof_dev *sdev,
-				struct snd_sof_pcm *spcm)
+int sof_pcm_dsp_pcm_free(struct snd_pcm_substream *substream, struct snd_sof_dev *sdev,
+			 struct snd_sof_pcm *spcm)
 {
 	struct sof_ipc_stream stream;
 	struct sof_ipc_reply reply;
diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 0f2566f7c094..038cdb4a9aa2 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -129,6 +129,14 @@ int sof_widget_free(struct snd_sof_dev *sdev, struct snd_sof_widget *swidget)
 	case snd_soc_dapm_buffer:
 		ipc_free.hdr.cmd |= SOF_IPC_TPLG_BUFFER_FREE;
 		break;
+	case snd_soc_dapm_dai_in:
+	case snd_soc_dapm_dai_out:
+	{
+		struct snd_sof_dai *dai = swidget->private;
+
+		dai->configured = false;
+		fallthrough;
+	}
 	default:
 		ipc_free.hdr.cmd |= SOF_IPC_TPLG_COMP_FREE;
 		break;
@@ -705,6 +713,55 @@ int sof_set_up_pipelines(struct snd_sof_dev *sdev, bool verify)
 	return 0;
 }
 
+/*
+ * Free the PCM, its associated widgets and set the prepared flag to false for all PCMs that
+ * did not get suspended(ex: paused streams) so the widgets can be set up again during resume.
+ */
+static int sof_tear_down_left_over_pipelines(struct snd_sof_dev *sdev)
+{
+	struct snd_sof_widget *swidget;
+	struct snd_sof_pcm *spcm;
+	int dir, ret;
+
+	/*
+	 * free all PCMs and their associated DAPM widgets if their connected DAPM widget
+	 * list is not NULL. This should only be true for paused streams at this point.
+	 * This is equivalent to the handling of FE DAI suspend trigger for running streams.
+	 */
+	list_for_each_entry(spcm, &sdev->pcm_list, list)
+		for_each_pcm_streams(dir) {
+			struct snd_pcm_substream *substream = spcm->stream[dir].substream;
+
+			if (!substream || !substream->runtime)
+				continue;
+
+			if (spcm->stream[dir].list) {
+				ret = sof_pcm_dsp_pcm_free(substream, sdev, spcm);
+				if (ret < 0)
+					return ret;
+
+				ret = sof_widget_list_free(sdev, spcm, dir);
+				if (ret < 0) {
+					dev_err(sdev->dev, "failed to free widgets during suspend\n");
+					return ret;
+				}
+			}
+		}
+
+	/*
+	 * free any left over DAI widgets. This is equivalent to the handling of suspend trigger
+	 * for the BE DAI for running streams.
+	 */
+	list_for_each_entry(swidget, &sdev->widget_list, list)
+		if (WIDGET_IS_DAI(swidget->id) && swidget->use_count == 1) {
+			ret = sof_widget_free(sdev, swidget);
+			if (ret < 0)
+				return ret;
+		}
+
+	return 0;
+}
+
 /*
  * For older firmware, this function doesn't free widgets for static pipelines during suspend.
  * It only resets use_count for all widgets.
@@ -719,8 +776,8 @@ int sof_tear_down_pipelines(struct snd_sof_dev *sdev, bool verify)
 	/*
 	 * This function is called during suspend and for one-time topology verification during
 	 * first boot. In both cases, there is no need to protect swidget->use_count and
-	 * sroute->setup because during suspend all streams are suspended and during topology
-	 * loading the sound card unavailable to open PCMs.
+	 * sroute->setup because during suspend all running streams are suspended and during
+	 * topology loading the sound card unavailable to open PCMs.
 	 */
 	list_for_each_entry_reverse(swidget, &sdev->widget_list, list) {
 		if (swidget->dynamic_pipeline_widget)
@@ -739,6 +796,19 @@ int sof_tear_down_pipelines(struct snd_sof_dev *sdev, bool verify)
 			return ret;
 	}
 
+	/*
+	 * Tear down all pipelines associated with PCMs that did not get suspended
+	 * and unset the prepare flag so that they can be set up again during resume.
+	 * Skip this step for older firmware.
+	 */
+	if (!verify && v->abi_version >= SOF_ABI_VER(3, 19, 0)) {
+		ret = sof_tear_down_left_over_pipelines(sdev);
+		if (ret < 0) {
+			dev_err(sdev->dev, "failed to tear down paused pipelines\n");
+			return ret;
+		}
+	}
+
 	list_for_each_entry(sroute, &sdev->route_list, list)
 		sroute->setup = false;
 
diff --git a/sound/soc/sof/sof-audio.h b/sound/soc/sof/sof-audio.h
index 389d56ac3aba..1c4f59d34717 100644
--- a/sound/soc/sof/sof-audio.h
+++ b/sound/soc/sof/sof-audio.h
@@ -265,4 +265,6 @@ int sof_widget_free(struct snd_sof_dev *sdev, struct snd_sof_widget *swidget);
 /* PCM */
 int sof_widget_list_setup(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm, int dir);
 int sof_widget_list_free(struct snd_sof_dev *sdev, struct snd_sof_pcm *spcm, int dir);
+int sof_pcm_dsp_pcm_free(struct snd_pcm_substream *substream, struct snd_sof_dev *sdev,
+			 struct snd_sof_pcm *spcm);
 #endif

base-commit: 65c16dd2942f4476a3f96a2625b1475c6137c09a
-- 
2.33.0

