Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFFFC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 10:34:12 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 730F46120E
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 10:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 730F46120E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D5D78187D;
	Thu, 16 Sep 2021 12:33:19 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D5D78187D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631788450;
	bh=NzPdlODD8mNPVym2fgIHY6RnBBbAZqnJI+lVHx671CQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=que1UoKfEf7WAHVYBjEOPaZCU4Tphv9WpnJQm/FIFliyy4zl/pCr7vcgzy6KAfmqY
	 tRM0rdKJ6yPLFKF6i6IspG4rlVGjk6Qblvxjk2Hf7Owr2vjmzw/IJBlytcyWq5FGyq
	 9YmZFQw1Umips4+lQGzVgquSZrpbUJudV9mhuTpU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4C107F804E5;
	Thu, 16 Sep 2021 12:32:33 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2600EF804E2; Thu, 16 Sep 2021 12:32:31 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2F2A1F8025A
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 12:32:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2F2A1F8025A
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="202031859"
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; d="scan'208";a="202031859"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 03:32:21 -0700
X-IronPort-AV: E=Sophos;i="5.85,298,1624345200"; d="scan'208";a="545473530"
Received: from gkapusti-mobl.ccr.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.35.152])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 03:32:19 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH 3/6] ASoC: SOF: compress: move and export sof_probe_compr_ops
Date: Thu, 16 Sep 2021 13:32:08 +0300
Message-Id: <20210916103211.1573-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210916103211.1573-1-peter.ujfalusi@linux.intel.com>
References: <20210916103211.1573-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, daniel.baluta@nxp.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
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

sof_probe_compr_ops are not platform-specific. So move
it to common compress code and export the symbol. The
compilation of the common compress code is already dependent
on the selection of CONFIG_SND_SOC_SOF_DEBUG_PROBES, so no
need to check the Kconfig section for defining sof_probe_compr_ops
again.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/compress.c      | 53 +++++++++++++++++++----------------
 sound/soc/sof/compress.h      | 15 +---------
 sound/soc/sof/intel/hda-dai.c | 16 +++--------
 3 files changed, 34 insertions(+), 50 deletions(-)

diff --git a/sound/soc/sof/compress.c b/sound/soc/sof/compress.c
index 57d5bf0a171e..3d12851dc6b3 100644
--- a/sound/soc/sof/compress.c
+++ b/sound/soc/sof/compress.c
@@ -13,13 +13,8 @@
 #include "ops.h"
 #include "probe.h"
 
-const struct snd_compress_ops sof_probe_compressed_ops = {
-	.copy		= sof_probe_compr_copy,
-};
-EXPORT_SYMBOL(sof_probe_compressed_ops);
-
-int sof_probe_compr_open(struct snd_compr_stream *cstream,
-		struct snd_soc_dai *dai)
+static int sof_probe_compr_open(struct snd_compr_stream *cstream,
+				struct snd_soc_dai *dai)
 {
 	struct snd_sof_dev *sdev =
 				snd_soc_component_get_drvdata(dai->component);
@@ -34,10 +29,9 @@ int sof_probe_compr_open(struct snd_compr_stream *cstream,
 	sdev->extractor_stream_tag = ret;
 	return 0;
 }
-EXPORT_SYMBOL(sof_probe_compr_open);
 
-int sof_probe_compr_free(struct snd_compr_stream *cstream,
-		struct snd_soc_dai *dai)
+static int sof_probe_compr_free(struct snd_compr_stream *cstream,
+				struct snd_soc_dai *dai)
 {
 	struct snd_sof_dev *sdev =
 				snd_soc_component_get_drvdata(dai->component);
@@ -66,10 +60,10 @@ int sof_probe_compr_free(struct snd_compr_stream *cstream,
 
 	return snd_sof_probe_compr_free(sdev, cstream, dai);
 }
-EXPORT_SYMBOL(sof_probe_compr_free);
 
-int sof_probe_compr_set_params(struct snd_compr_stream *cstream,
-		struct snd_compr_params *params, struct snd_soc_dai *dai)
+static int sof_probe_compr_set_params(struct snd_compr_stream *cstream,
+				      struct snd_compr_params *params,
+				      struct snd_soc_dai *dai)
 {
 	struct snd_compr_runtime *rtd = cstream->runtime;
 	struct snd_sof_dev *sdev =
@@ -95,31 +89,38 @@ int sof_probe_compr_set_params(struct snd_compr_stream *cstream,
 
 	return 0;
 }
-EXPORT_SYMBOL(sof_probe_compr_set_params);
 
-int sof_probe_compr_trigger(struct snd_compr_stream *cstream, int cmd,
-		struct snd_soc_dai *dai)
+static int sof_probe_compr_trigger(struct snd_compr_stream *cstream, int cmd,
+				   struct snd_soc_dai *dai)
 {
 	struct snd_sof_dev *sdev =
 				snd_soc_component_get_drvdata(dai->component);
 
 	return snd_sof_probe_compr_trigger(sdev, cstream, cmd, dai);
 }
-EXPORT_SYMBOL(sof_probe_compr_trigger);
 
-int sof_probe_compr_pointer(struct snd_compr_stream *cstream,
-		struct snd_compr_tstamp *tstamp, struct snd_soc_dai *dai)
+static int sof_probe_compr_pointer(struct snd_compr_stream *cstream,
+				   struct snd_compr_tstamp *tstamp,
+				   struct snd_soc_dai *dai)
 {
 	struct snd_sof_dev *sdev =
 				snd_soc_component_get_drvdata(dai->component);
 
 	return snd_sof_probe_compr_pointer(sdev, cstream, tstamp, dai);
 }
-EXPORT_SYMBOL(sof_probe_compr_pointer);
 
-int sof_probe_compr_copy(struct snd_soc_component *component,
-			 struct snd_compr_stream *cstream,
-			 char __user *buf, size_t count)
+struct snd_soc_cdai_ops sof_probe_compr_ops = {
+	.startup	= sof_probe_compr_open,
+	.shutdown	= sof_probe_compr_free,
+	.set_params	= sof_probe_compr_set_params,
+	.trigger	= sof_probe_compr_trigger,
+	.pointer	= sof_probe_compr_pointer,
+};
+EXPORT_SYMBOL(sof_probe_compr_ops);
+
+static int sof_probe_compr_copy(struct snd_soc_component *component,
+				struct snd_compr_stream *cstream,
+				char __user *buf, size_t count)
 {
 	struct snd_compr_runtime *rtd = cstream->runtime;
 	unsigned int offset, n;
@@ -144,4 +145,8 @@ int sof_probe_compr_copy(struct snd_soc_component *component,
 		return count - ret;
 	return count;
 }
-EXPORT_SYMBOL(sof_probe_compr_copy);
+
+const struct snd_compress_ops sof_probe_compressed_ops = {
+	.copy		= sof_probe_compr_copy,
+};
+EXPORT_SYMBOL(sof_probe_compressed_ops);
diff --git a/sound/soc/sof/compress.h b/sound/soc/sof/compress.h
index 4448c799e14b..f49b3ddb4403 100644
--- a/sound/soc/sof/compress.h
+++ b/sound/soc/sof/compress.h
@@ -13,20 +13,7 @@
 
 #include <sound/compress_driver.h>
 
+extern struct snd_soc_cdai_ops sof_probe_compr_ops;
 extern const struct snd_compress_ops sof_probe_compressed_ops;
 
-int sof_probe_compr_open(struct snd_compr_stream *cstream,
-		struct snd_soc_dai *dai);
-int sof_probe_compr_free(struct snd_compr_stream *cstream,
-		struct snd_soc_dai *dai);
-int sof_probe_compr_set_params(struct snd_compr_stream *cstream,
-		struct snd_compr_params *params, struct snd_soc_dai *dai);
-int sof_probe_compr_trigger(struct snd_compr_stream *cstream, int cmd,
-		struct snd_soc_dai *dai);
-int sof_probe_compr_pointer(struct snd_compr_stream *cstream,
-		struct snd_compr_tstamp *tstamp, struct snd_soc_dai *dai);
-int sof_probe_compr_copy(struct snd_soc_component *component,
-			 struct snd_compr_stream *cstream,
-			 char __user *buf, size_t count);
-
 #endif
diff --git a/sound/soc/sof/intel/hda-dai.c b/sound/soc/sof/intel/hda-dai.c
index c1f9f0f58464..46fb8add237e 100644
--- a/sound/soc/sof/intel/hda-dai.c
+++ b/sound/soc/sof/intel/hda-dai.c
@@ -16,6 +16,10 @@
 
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA)
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG_PROBES)
+#include "../compress.h"
+#endif
+
 struct hda_pipe_params {
 	u8 host_dma_id;
 	u8 link_dma_id;
@@ -400,18 +404,6 @@ static const struct snd_soc_dai_ops hda_link_dai_ops = {
 	.prepare = hda_link_pcm_prepare,
 };
 
-#if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_PROBES)
-#include "../compress.h"
-
-static struct snd_soc_cdai_ops sof_probe_compr_ops = {
-	.startup	= sof_probe_compr_open,
-	.shutdown	= sof_probe_compr_free,
-	.set_params	= sof_probe_compr_set_params,
-	.trigger	= sof_probe_compr_trigger,
-	.pointer	= sof_probe_compr_pointer,
-};
-
-#endif
 #endif
 
 static int ssp_dai_hw_params(struct snd_pcm_substream *substream,
-- 
2.33.0

