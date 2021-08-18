Return-Path: <SRS0=kMQ4=NJ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814A2C43214
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 07:57:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0269560ED5
	for <alsa-devel@archiver.kernel.org>; Wed, 18 Aug 2021 07:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0269560ED5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9A7471676;
	Wed, 18 Aug 2021 09:56:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9A7471676
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1629273421;
	bh=m28kiWPYX71XwZSJJbIWDMN6sjiqOwXJW0u0OJXjsdk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tDcVvqZYdS9XOv/AjoGVHV1C+DqR4OV17H+1NgNLXNpwNjR/KUWtGN615CGSF2vvc
	 U84lhC1yT5X1T7a5UAsEqXT4h6Jr1zdKplWLTyRkjYy/X5+cUM0r42mxJolLFWZOI2
	 1OwAtyZbmQUbYd6tE+0A0lX4ykQ4mjMOPds9SWD4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1BC58F804E5;
	Wed, 18 Aug 2021 09:55:17 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 0B805F804E6; Wed, 18 Aug 2021 09:55:16 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 033AEF802BE
 for <alsa-devel@alsa-project.org>; Wed, 18 Aug 2021 09:55:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 033AEF802BE
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="195855498"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="195855498"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2021 00:55:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; d="scan'208";a="676974758"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga006.fm.intel.com with ESMTP; 18 Aug 2021 00:55:02 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 03/11] ASoC: Intel: Skylake: Select proper format for NHLT blob
Date: Wed, 18 Aug 2021 09:57:34 +0200
Message-Id: <20210818075742.1515155-4-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210818075742.1515155-1-cezary.rojewski@intel.com>
References: <20210818075742.1515155-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, jairaj.arava@intel.com,
 upstream@semihalf.com, Lewandowski@alsa-project.org, harshapriya.n@intel.com,
 cujomalainey@google.com, tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
 Gustaw <gustaw.lewandowski@linux.intel.com>, hdegoede@redhat.com,
 broonie@kernel.org, jenny.tc@intel.com,
 Piotr Maziarz <piotrx.maziarz@linux.intel.com>, lma@semihalf.com,
 vamshi.krishna.gopal@intel.com
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

From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>

Use actual pipeline format, not PCM format for blob selection. Otherwise
selected blobs are not correct in pipelines with format conversion
e.g.: SRC module.

Signed-off-by: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
Signed-off-by: Lewandowski, Gustaw <gustaw.lewandowski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/skylake/skl-topology.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-topology.c b/sound/soc/intel/skylake/skl-topology.c
index 45b1521e6189..054c080b7289 100644
--- a/sound/soc/intel/skylake/skl-topology.c
+++ b/sound/soc/intel/skylake/skl-topology.c
@@ -1821,7 +1821,7 @@ static u8 skl_tplg_be_link_type(int dev_type)
  * Fill the BE gateway parameters
  * The BE gateway expects a blob of parameters which are kept in the ACPI
  * NHLT blob, so query the blob for interface type (i2s/pdm) and instance.
- * The port can have multiple settings so pick based on the PCM
+ * The port can have multiple settings so pick based on the pipeline
  * parameters
  */
 static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
@@ -1829,6 +1829,8 @@ static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
 				struct skl_pipe_params *params)
 {
 	struct nhlt_specific_cfg *cfg;
+	struct skl_pipe *pipe = mconfig->pipe;
+	struct skl_pipe_fmt *pipe_fmt;
 	struct skl_dev *skl = get_skl_ctx(dai->dev);
 	int link_type = skl_tplg_be_link_type(mconfig->dev_type);
 	u8 dev_type = skl_tplg_be_dev_type(mconfig->dev_type);
@@ -1838,20 +1840,23 @@ static int skl_tplg_be_fill_pipe_params(struct snd_soc_dai *dai,
 	if (link_type == NHLT_LINK_HDA)
 		return 0;
 
+	if (pipe->direction == SNDRV_PCM_STREAM_PLAYBACK)
+		pipe_fmt = &pipe->configs[pipe->pipe_config_idx].out_fmt;
+	else
+		pipe_fmt = &pipe->configs[pipe->pipe_config_idx].in_fmt;
+
 	/* update the blob based on virtual bus_id*/
 	cfg = skl_get_ep_blob(skl, mconfig->vbus_id, link_type,
-					params->s_fmt, params->ch,
-					params->s_freq, params->stream,
+					pipe_fmt->bps, pipe_fmt->channels,
+					pipe_fmt->freq, pipe->direction,
 					dev_type);
 	if (cfg) {
 		mconfig->formats_config.caps_size = cfg->size;
 		mconfig->formats_config.caps = (u32 *) &cfg->caps;
 	} else {
-		dev_err(dai->dev, "Blob NULL for id %x type %d dirn %d\n",
-					mconfig->vbus_id, link_type,
-					params->stream);
-		dev_err(dai->dev, "PCM: ch %d, freq %d, fmt %d\n",
-				 params->ch, params->s_freq, params->s_fmt);
+		dev_err(dai->dev, "Blob NULL for id:%d type:%d dirn:%d ch:%d, freq:%d, fmt:%d\n",
+			mconfig->vbus_id, link_type, params->stream,
+			params->ch, params->s_freq, params->s_fmt);
 		return -EINVAL;
 	}
 
-- 
2.25.1

