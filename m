Return-Path: <SRS0=rI3+=CL=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2DFC433E2
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:12:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72A3220829
	for <alsa-devel@archiver.kernel.org>; Wed,  2 Sep 2020 14:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BSQE6VOG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72A3220829
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04C80182B;
	Wed,  2 Sep 2020 16:12:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04C80182B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599055972;
	bh=aWdCuss9/q2kgeRo5Bmc+DD03pSHm7qUhUfoYtIdiog=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BSQE6VOGjnvPhOTOQgBQk5a1+vYIUjhzmBpXstIN3x0npDnCsjJmKMUv8GClDbJt0
	 gE0Ec931FTnYXXw3OEW9scyUv0eHwLY0SzVBFAgKHxsZakAQqYrGNCI4PrgSgS4Zq1
	 FOnStI2n6lpwnSe8Z9Kl/C97jBKsrkjWgQLgFj1w=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D7C45F802E2;
	Wed,  2 Sep 2020 16:09:44 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DCE51F802C3; Wed,  2 Sep 2020 16:09:41 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 37EFEF80212
 for <alsa-devel@alsa-project.org>; Wed,  2 Sep 2020 16:09:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 37EFEF80212
IronPort-SDR: mT3/5oXZS/qTcNXk4FQM7z0G8QwAOUoajiLqP+mzlsA8ibmXjYTCNCW0mDgG5DthairEwSCP2/
 clusJIZe77kw==
X-IronPort-AV: E=McAfee;i="6000,8403,9731"; a="156649990"
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; d="scan'208";a="156649990"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2020 07:09:20 -0700
IronPort-SDR: 7MKlwMIJR6bpzMH7dO8v8/kwkOjWF7PB2Boqm2S5q3x8h6HFr1xgICCU9HJ0pUqKrNiGhqh4E1
 lW12McEQb6Rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,383,1592895600"; d="scan'208";a="338934365"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by FMSMGA003.fm.intel.com with ESMTP; 02 Sep 2020 07:09:18 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 1/3] ASoC: SOF: add a "core" parameter to widget loading
 functions
Date: Wed,  2 Sep 2020 17:07:54 +0300
Message-Id: <20200902140756.1427005-2-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200902140756.1427005-1-kai.vehmanen@linux.intel.com>
References: <20200902140756.1427005-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 daniel.baluta@nxp.com, pierre-louis.bossart@linux.intel.com,
 kai.vehmanen@linux.intel.com, ranjani.sridharan@linux.intel.com
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

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

We want to be able to explicitly assign cores to individual pipeline
components. This patch adds a "core" parameter to widget loading
functions to be sent to the DSP for appropriate component scheduling.

Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/sof-priv.h |  3 ++
 sound/soc/sof/topology.c | 74 +++++++++++++++++++++++++---------------
 2 files changed, 50 insertions(+), 27 deletions(-)

diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 53d26be88f64..1c51d99f0459 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -54,6 +54,9 @@ extern int sof_core_debug;
 	(IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_ENABLE_DEBUGFS_CACHE) || \
 	 IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST))
 
+/* So far the primary core on all DSPs has ID 0 */
+#define SOF_DSP_PRIMARY_CORE 0
+
 /* DSP power state */
 enum sof_dsp_power_states {
 	SOF_DSP_PM_D0,
diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 95e63d138326..d41df9337328 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -1360,7 +1360,7 @@ static int sof_connect_dai_widget(struct snd_soc_component *scomp,
 }
 
 static int sof_widget_load_dai(struct snd_soc_component *scomp, int index,
-			       struct snd_sof_widget *swidget,
+			       struct snd_sof_widget *swidget, int core,
 			       struct snd_soc_tplg_dapm_widget *tw,
 			       struct sof_ipc_comp_reply *r,
 			       struct snd_sof_dai *dai)
@@ -1377,6 +1377,7 @@ static int sof_widget_load_dai(struct snd_soc_component *scomp, int index,
 	comp_dai.comp.id = swidget->comp_id;
 	comp_dai.comp.type = SOF_COMP_DAI;
 	comp_dai.comp.pipeline_id = index;
+	comp_dai.comp.core = core;
 	comp_dai.config.hdr.size = sizeof(comp_dai.config);
 
 	ret = sof_parse_tokens(scomp, &comp_dai, dai_tokens,
@@ -1417,7 +1418,7 @@ static int sof_widget_load_dai(struct snd_soc_component *scomp, int index,
  */
 
 static int sof_widget_load_buffer(struct snd_soc_component *scomp, int index,
-				  struct snd_sof_widget *swidget,
+				  struct snd_sof_widget *swidget, int core,
 				  struct snd_soc_tplg_dapm_widget *tw,
 				  struct sof_ipc_comp_reply *r)
 {
@@ -1436,6 +1437,7 @@ static int sof_widget_load_buffer(struct snd_soc_component *scomp, int index,
 	buffer->comp.id = swidget->comp_id;
 	buffer->comp.type = SOF_COMP_BUFFER;
 	buffer->comp.pipeline_id = index;
+	buffer->comp.core = core;
 
 	ret = sof_parse_tokens(scomp, buffer, buffer_tokens,
 			       ARRAY_SIZE(buffer_tokens), private->array,
@@ -1487,7 +1489,7 @@ static int spcm_bind(struct snd_soc_component *scomp, struct snd_sof_pcm *spcm,
  */
 
 static int sof_widget_load_pcm(struct snd_soc_component *scomp, int index,
-			       struct snd_sof_widget *swidget,
+			       struct snd_sof_widget *swidget, int core,
 			       enum sof_ipc_stream_direction dir,
 			       struct snd_soc_tplg_dapm_widget *tw,
 			       struct sof_ipc_comp_reply *r)
@@ -1507,6 +1509,7 @@ static int sof_widget_load_pcm(struct snd_soc_component *scomp, int index,
 	host->comp.id = swidget->comp_id;
 	host->comp.type = SOF_COMP_HOST;
 	host->comp.pipeline_id = index;
+	host->comp.core = core;
 	host->direction = dir;
 	host->config.hdr.size = sizeof(host->config);
 
@@ -1592,8 +1595,8 @@ int sof_load_pipeline_ipc(struct device *dev,
 	return ret;
 }
 
-static int sof_widget_load_pipeline(struct snd_soc_component *scomp,
-				    int index, struct snd_sof_widget *swidget,
+static int sof_widget_load_pipeline(struct snd_soc_component *scomp, int index,
+				    struct snd_sof_widget *swidget,
 				    struct snd_soc_tplg_dapm_widget *tw,
 				    struct sof_ipc_comp_reply *r)
 {
@@ -1655,7 +1658,7 @@ static int sof_widget_load_pipeline(struct snd_soc_component *scomp,
  */
 
 static int sof_widget_load_mixer(struct snd_soc_component *scomp, int index,
-				 struct snd_sof_widget *swidget,
+				 struct snd_sof_widget *swidget, int core,
 				 struct snd_soc_tplg_dapm_widget *tw,
 				 struct sof_ipc_comp_reply *r)
 {
@@ -1674,6 +1677,7 @@ static int sof_widget_load_mixer(struct snd_soc_component *scomp, int index,
 	mixer->comp.id = swidget->comp_id;
 	mixer->comp.type = SOF_COMP_MIXER;
 	mixer->comp.pipeline_id = index;
+	mixer->comp.core = core;
 	mixer->config.hdr.size = sizeof(mixer->config);
 
 	ret = sof_parse_tokens(scomp, &mixer->config, comp_tokens,
@@ -1702,7 +1706,7 @@ static int sof_widget_load_mixer(struct snd_soc_component *scomp, int index,
  * Mux topology
  */
 static int sof_widget_load_mux(struct snd_soc_component *scomp, int index,
-			       struct snd_sof_widget *swidget,
+			       struct snd_sof_widget *swidget, int core,
 			       struct snd_soc_tplg_dapm_widget *tw,
 			       struct sof_ipc_comp_reply *r)
 {
@@ -1721,6 +1725,7 @@ static int sof_widget_load_mux(struct snd_soc_component *scomp, int index,
 	mux->comp.id = swidget->comp_id;
 	mux->comp.type = SOF_COMP_MUX;
 	mux->comp.pipeline_id = index;
+	mux->comp.core = core;
 	mux->config.hdr.size = sizeof(mux->config);
 
 	ret = sof_parse_tokens(scomp, &mux->config, comp_tokens,
@@ -1750,7 +1755,7 @@ static int sof_widget_load_mux(struct snd_soc_component *scomp, int index,
  */
 
 static int sof_widget_load_pga(struct snd_soc_component *scomp, int index,
-			       struct snd_sof_widget *swidget,
+			       struct snd_sof_widget *swidget, int core,
 			       struct snd_soc_tplg_dapm_widget *tw,
 			       struct sof_ipc_comp_reply *r)
 {
@@ -1779,6 +1784,7 @@ static int sof_widget_load_pga(struct snd_soc_component *scomp, int index,
 	volume->comp.id = swidget->comp_id;
 	volume->comp.type = SOF_COMP_VOLUME;
 	volume->comp.pipeline_id = index;
+	volume->comp.core = core;
 	volume->config.hdr.size = sizeof(volume->config);
 
 	ret = sof_parse_tokens(scomp, volume, volume_tokens,
@@ -1828,7 +1834,7 @@ static int sof_widget_load_pga(struct snd_soc_component *scomp, int index,
  */
 
 static int sof_widget_load_src(struct snd_soc_component *scomp, int index,
-			       struct snd_sof_widget *swidget,
+			       struct snd_sof_widget *swidget, int core,
 			       struct snd_soc_tplg_dapm_widget *tw,
 			       struct sof_ipc_comp_reply *r)
 {
@@ -1847,6 +1853,7 @@ static int sof_widget_load_src(struct snd_soc_component *scomp, int index,
 	src->comp.id = swidget->comp_id;
 	src->comp.type = SOF_COMP_SRC;
 	src->comp.pipeline_id = index;
+	src->comp.core = core;
 	src->config.hdr.size = sizeof(src->config);
 
 	ret = sof_parse_tokens(scomp, src, src_tokens,
@@ -1887,7 +1894,7 @@ static int sof_widget_load_src(struct snd_soc_component *scomp, int index,
  */
 
 static int sof_widget_load_asrc(struct snd_soc_component *scomp, int index,
-				struct snd_sof_widget *swidget,
+				struct snd_sof_widget *swidget, int core,
 				struct snd_soc_tplg_dapm_widget *tw,
 				struct sof_ipc_comp_reply *r)
 {
@@ -1906,6 +1913,7 @@ static int sof_widget_load_asrc(struct snd_soc_component *scomp, int index,
 	asrc->comp.id = swidget->comp_id;
 	asrc->comp.type = SOF_COMP_ASRC;
 	asrc->comp.pipeline_id = index;
+	asrc->comp.core = core;
 	asrc->config.hdr.size = sizeof(asrc->config);
 
 	ret = sof_parse_tokens(scomp, asrc, asrc_tokens,
@@ -1948,7 +1956,7 @@ static int sof_widget_load_asrc(struct snd_soc_component *scomp, int index,
  */
 
 static int sof_widget_load_siggen(struct snd_soc_component *scomp, int index,
-				  struct snd_sof_widget *swidget,
+				  struct snd_sof_widget *swidget, int core,
 				  struct snd_soc_tplg_dapm_widget *tw,
 				  struct sof_ipc_comp_reply *r)
 {
@@ -1967,6 +1975,7 @@ static int sof_widget_load_siggen(struct snd_soc_component *scomp, int index,
 	tone->comp.id = swidget->comp_id;
 	tone->comp.type = SOF_COMP_TONE;
 	tone->comp.pipeline_id = index;
+	tone->comp.core = core;
 	tone->config.hdr.size = sizeof(tone->config);
 
 	ret = sof_parse_tokens(scomp, tone, tone_tokens,
@@ -2204,7 +2213,7 @@ static int sof_process_load(struct snd_soc_component *scomp, int index,
  */
 
 static int sof_widget_load_process(struct snd_soc_component *scomp, int index,
-				   struct snd_sof_widget *swidget,
+				   struct snd_sof_widget *swidget, int core,
 				   struct snd_soc_tplg_dapm_widget *tw,
 				   struct sof_ipc_comp_reply *r)
 {
@@ -2219,6 +2228,7 @@ static int sof_widget_load_process(struct snd_soc_component *scomp, int index,
 	}
 
 	memset(&config, 0, sizeof(config));
+	config.comp.core = core;
 
 	/* get the process token */
 	ret = sof_parse_tokens(scomp, &config, process_tokens,
@@ -2283,6 +2293,9 @@ static int sof_widget_ready(struct snd_soc_component *scomp, int index,
 	struct snd_sof_dai *dai;
 	struct sof_ipc_comp_reply reply;
 	struct snd_sof_control *scontrol;
+	struct sof_ipc_comp comp = {
+		.core = SOF_DSP_PRIMARY_CORE,
+	};
 	int ret = 0;
 
 	swidget = kzalloc(sizeof(*swidget), GFP_KERNEL);
@@ -2313,8 +2326,8 @@ static int sof_widget_ready(struct snd_soc_component *scomp, int index,
 			return -ENOMEM;
 		}
 
-		ret = sof_widget_load_dai(scomp, index, swidget, tw, &reply,
-					  dai);
+		ret = sof_widget_load_dai(scomp, index, swidget, comp.core,
+					  tw, &reply, dai);
 		if (ret == 0) {
 			sof_connect_dai_widget(scomp, w, tw, dai);
 			list_add(&dai->list, &sdev->dai_list);
@@ -2324,10 +2337,12 @@ static int sof_widget_ready(struct snd_soc_component *scomp, int index,
 		}
 		break;
 	case snd_soc_dapm_mixer:
-		ret = sof_widget_load_mixer(scomp, index, swidget, tw, &reply);
+		ret = sof_widget_load_mixer(scomp, index, swidget, comp.core,
+					    tw, &reply);
 		break;
 	case snd_soc_dapm_pga:
-		ret = sof_widget_load_pga(scomp, index, swidget, tw, &reply);
+		ret = sof_widget_load_pga(scomp, index, swidget, comp.core,
+					  tw, &reply);
 		/* Find scontrol for this pga and set readback offset*/
 		list_for_each_entry(scontrol, &sdev->kcontrol_list, list) {
 			if (scontrol->comp_id == swidget->comp_id) {
@@ -2337,36 +2352,41 @@ static int sof_widget_ready(struct snd_soc_component *scomp, int index,
 		}
 		break;
 	case snd_soc_dapm_buffer:
-		ret = sof_widget_load_buffer(scomp, index, swidget, tw, &reply);
+		ret = sof_widget_load_buffer(scomp, index, swidget, comp.core,
+					     tw, &reply);
 		break;
 	case snd_soc_dapm_scheduler:
-		ret = sof_widget_load_pipeline(scomp, index, swidget, tw,
-					       &reply);
+		ret = sof_widget_load_pipeline(scomp, index, swidget,
+					       tw, &reply);
 		break;
 	case snd_soc_dapm_aif_out:
-		ret = sof_widget_load_pcm(scomp, index, swidget,
+		ret = sof_widget_load_pcm(scomp, index, swidget, comp.core,
 					  SOF_IPC_STREAM_CAPTURE, tw, &reply);
 		break;
 	case snd_soc_dapm_aif_in:
-		ret = sof_widget_load_pcm(scomp, index, swidget,
+		ret = sof_widget_load_pcm(scomp, index, swidget, comp.core,
 					  SOF_IPC_STREAM_PLAYBACK, tw, &reply);
 		break;
 	case snd_soc_dapm_src:
-		ret = sof_widget_load_src(scomp, index, swidget, tw, &reply);
+		ret = sof_widget_load_src(scomp, index, swidget, comp.core,
+					  tw, &reply);
 		break;
 	case snd_soc_dapm_asrc:
-		ret = sof_widget_load_asrc(scomp, index, swidget, tw, &reply);
+		ret = sof_widget_load_asrc(scomp, index, swidget, comp.core,
+					   tw, &reply);
 		break;
 	case snd_soc_dapm_siggen:
-		ret = sof_widget_load_siggen(scomp, index, swidget, tw, &reply);
+		ret = sof_widget_load_siggen(scomp, index, swidget, comp.core,
+					     tw, &reply);
 		break;
 	case snd_soc_dapm_effect:
-		ret = sof_widget_load_process(scomp, index, swidget, tw,
-					      &reply);
+		ret = sof_widget_load_process(scomp, index, swidget, comp.core,
+					      tw, &reply);
 		break;
 	case snd_soc_dapm_mux:
 	case snd_soc_dapm_demux:
-		ret = sof_widget_load_mux(scomp, index, swidget, tw, &reply);
+		ret = sof_widget_load_mux(scomp, index, swidget, comp.core,
+					  tw, &reply);
 		break;
 	case snd_soc_dapm_switch:
 	case snd_soc_dapm_dai_link:
-- 
2.27.0

