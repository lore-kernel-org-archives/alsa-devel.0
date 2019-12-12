Return-Path: <SRS0=r47B=2C=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56D50C43603
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:50:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6F1A22B48
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cDHIxWH8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6F1A22B48
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0EE031691;
	Thu, 12 Dec 2019 02:49:39 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0EE031691
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1576115429;
	bh=1shKl8ID/63tJQbwMtk7bMsFdVMtbEHTxXyqhyJ5v4g=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cDHIxWH8TB6MbGKgd9VcsuBjTvnKRvd51OcG0/ZsGiXm0gjMmG+Sz3WYj1NXdyuE8
	 LI0lbYJg07wxbfPeL99LQJuSPUTGe6OQbbhc1C5A72Y4rW/gCHQP3A1D/IEMPWVt6n
	 tayf5m5dEBrtj2inZtx0sruHmV24gaMOAojoNdus=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2B325F80277;
	Thu, 12 Dec 2019 02:45:40 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D1B7FF80259; Thu, 12 Dec 2019 02:45:29 +0100 (CET)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0CFA7F801F4
 for <alsa-devel@alsa-project.org>; Thu, 12 Dec 2019 02:45:23 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0CFA7F801F4
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Dec 2019 17:45:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,303,1571727600"; d="scan'208";a="296446098"
Received: from gjang-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.252.207.37])
 by orsmga001.jf.intel.com with ESMTP; 11 Dec 2019 17:45:21 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed, 11 Dec 2019 19:45:02 -0600
Message-Id: <20191212014507.28050-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191212014507.28050-1-pierre-louis.bossart@linux.intel.com>
References: <20191212014507.28050-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, srinivas.kandagatla@linaro.org, jank@cadence.com,
 slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
 Bard liao <yung-chuan.liao@linux.intel.com>,
 Rander Wang <rander.wang@linux.intel.com>
Subject: [alsa-devel] [PATCH v5 06/11] soundwire: intel: update stream
	callbacks for hwparams/free stream operations
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Rander Wang <rander.wang@linux.intel.com>

The SoundWire DAIs for Intel platform are created in
drivers/soundwire/intel.c, while the communication with the Intel DSP
is all controlled in soc/sof/intel

When the DAI status changes, a callback is used to bridge the gap
between the two subsystems.

The naming of the existing 'config_stream' callback does not map well
with any of ALSA/ASoC concepts. This patch renames it as
'params_stream' to be more self-explanatory.

A new 'free_stream' callback is added in case any resources allocated
in the 'params_stream' stage need to be released. In the SOF
implementation, this is used in the hw_free case to release the DMA
channels over IPC.

These two callbacks now rely on structures which expose the link_id
and alh_stream_id (required by the firmware IPC), instead of a list of
parameters. The 'void *' definitions are changed to use explicit
types, as suggested on alsa-devel during earlier reviews.

Signed-off-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/intel.c           | 20 ++++++++++++------
 drivers/soundwire/intel.h           |  4 ++--
 drivers/soundwire/intel_init.c      |  1 +
 include/linux/soundwire/sdw_intel.h | 32 +++++++++++++++++++++++++----
 4 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 99dc61021211..0371d3d5501a 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -529,17 +529,24 @@ intel_pdi_alh_configure(struct sdw_intel *sdw, struct sdw_cdns_pdi *pdi)
 	intel_writel(alh, SDW_ALH_STRMZCFG(pdi->intel_alh_id), conf);
 }
 
-static int intel_config_stream(struct sdw_intel *sdw,
+static int intel_params_stream(struct sdw_intel *sdw,
 			       struct snd_pcm_substream *substream,
 			       struct snd_soc_dai *dai,
-			       struct snd_pcm_hw_params *hw_params, int link_id)
+			       struct snd_pcm_hw_params *hw_params,
+			       int link_id, int alh_stream_id)
 {
 	struct sdw_intel_link_res *res = sdw->res;
+	struct sdw_intel_stream_params_data params_data;
 
-	if (res->ops && res->ops->config_stream && res->arg)
-		return res->ops->config_stream(res->arg,
-				substream, dai, hw_params, link_id);
+	params_data.substream = substream;
+	params_data.dai = dai;
+	params_data.hw_params = hw_params;
+	params_data.link_id = link_id;
+	params_data.alh_stream_id = alh_stream_id;
 
+	if (res->ops && res->ops->params_stream && res->dev)
+		return res->ops->params_stream(res->dev,
+					       &params_data);
 	return -EIO;
 }
 
@@ -654,7 +661,8 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 
 
 	/* Inform DSP about PDI stream number */
-	ret = intel_config_stream(sdw, substream, dai, params,
+	ret = intel_params_stream(sdw, substream, dai, params,
+				  sdw->instance,
 				  pdi->intel_alh_id);
 	if (ret)
 		goto error;
diff --git a/drivers/soundwire/intel.h b/drivers/soundwire/intel.h
index e4cc1d3804ff..38b7c125fb10 100644
--- a/drivers/soundwire/intel.h
+++ b/drivers/soundwire/intel.h
@@ -14,7 +14,7 @@
  * @alh: ALH (Audio Link Hub) pointer
  * @irq: Interrupt line
  * @ops: Shim callback ops
- * @arg: Shim callback ops argument
+ * @dev: device implementing hw_params and free callbacks
  */
 struct sdw_intel_link_res {
 	struct platform_device *pdev;
@@ -24,7 +24,7 @@ struct sdw_intel_link_res {
 	void __iomem *alh;
 	int irq;
 	const struct sdw_intel_ops *ops;
-	void *arg;
+	struct device *dev;
 };
 
 #endif /* __SDW_INTEL_LOCAL_H */
diff --git a/drivers/soundwire/intel_init.c b/drivers/soundwire/intel_init.c
index bc739a38916d..4b769409f6f8 100644
--- a/drivers/soundwire/intel_init.c
+++ b/drivers/soundwire/intel_init.c
@@ -119,6 +119,7 @@ static struct sdw_intel_ctx
 		link->alh = res->mmio_base + SDW_ALH_BASE;
 
 		link->ops = res->ops;
+		link->dev = res->dev;
 
 		memset(&pdevinfo, 0, sizeof(pdevinfo));
 
diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index 034eca8df748..3ccb38d48eef 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -4,15 +4,39 @@
 #ifndef __SDW_INTEL_H
 #define __SDW_INTEL_H
 
+/**
+ * struct sdw_intel_stream_params_data: configuration passed during
+ * the @params_stream callback, e.g. for interaction with DSP
+ * firmware.
+ */
+struct sdw_intel_stream_params_data {
+	struct snd_pcm_substream *substream;
+	struct snd_soc_dai *dai;
+	struct snd_pcm_hw_params *hw_params;
+	int link_id;
+	int alh_stream_id;
+};
+
+/**
+ * struct sdw_intel_stream_free_data: configuration passed during
+ * the @free_stream callback, e.g. for interaction with DSP
+ * firmware.
+ */
+struct sdw_intel_stream_free_data {
+	struct snd_pcm_substream *substream;
+	struct snd_soc_dai *dai;
+	int link_id;
+};
+
 /**
  * struct sdw_intel_ops: Intel audio driver callback ops
  *
- * @config_stream: configure the stream with the hw_params
- * the first argument containing the context is mandatory
  */
 struct sdw_intel_ops {
-	int (*config_stream)(void *arg, void *substream,
-			     void *dai, void *hw_params, int stream_num);
+	int (*params_stream)(struct device *dev,
+			     struct sdw_intel_stream_params_data *params_data);
+	int (*free_stream)(struct device *dev,
+			   struct sdw_intel_stream_free_data *free_data);
 };
 
 /**
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
