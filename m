Return-Path: <SRS0=cfk+=QG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83EF5C433EF
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Nov 2021 19:37:13 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 148CD61221
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Nov 2021 19:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 148CD61221
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1FD571797;
	Fri, 19 Nov 2021 20:36:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1FD571797
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1637350631;
	bh=a47/N6IqhSgSeGBQGIKPzQp0tmOOOwvWqY/rIaMm/JU=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Gkdnr0K9m5yT6pVUqmEVXuEZC9kgirr9XOvTUP5teT5I/y1HnapFPDsPMu7t0h44B
	 Nwa+OAZnS3jmfETbEIu6FLc57qKqYbwMyfffQT16CjE7EL1p3xpVV9uAeTJo7Tax4q
	 TfKl1LOR60yyrxIF3Bs3GzyMxFRGAp/7FIE0EK8c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E26FDF80508;
	Fri, 19 Nov 2021 20:34:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 27C87F80217; Fri, 19 Nov 2021 20:34:26 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 28231F80272
 for <alsa-devel@alsa-project.org>; Fri, 19 Nov 2021 20:34:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 28231F80272
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="215192470"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; d="scan'208";a="215192470"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2021 11:34:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; d="scan'208";a="473651161"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga002.jf.intel.com with ESMTP; 19 Nov 2021 11:34:09 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 03/10] ASoC: SOF: Add ops for core_get and core_put
Date: Fri, 19 Nov 2021 21:26:14 +0200
Message-Id: <20211119192621.4096077-4-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211119192621.4096077-1-kai.vehmanen@linux.intel.com>
References: <20211119192621.4096077-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
 lgirdwood@gmail.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, daniel.baluta@nxp.com
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

Add ops to get/put a core that will be used to power
up/down a core along with incrementing/decrementing
its ref_count.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/ops.h      | 63 ++++++++++++++++++++++++++++++++++++++++
 sound/soc/sof/sof-priv.h |  2 ++
 2 files changed, 65 insertions(+)

diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 09bf38fdfb8a..61dc2768b000 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -103,6 +103,69 @@ static inline int snd_sof_dsp_core_power_down(struct snd_sof_dev *sdev,
 	return ret;
 }
 
+static inline int snd_sof_dsp_core_get(struct snd_sof_dev *sdev, int core)
+{
+	if (core > sdev->num_cores - 1) {
+		dev_err(sdev->dev, "invalid core id: %d for num_cores: %d\n", core,
+			sdev->num_cores);
+		return -EINVAL;
+	}
+
+	if (sof_ops(sdev)->core_get) {
+		int ret;
+
+		/* if current ref_count is > 0, increment it and return */
+		if (sdev->dsp_core_ref_count[core] > 0) {
+			sdev->dsp_core_ref_count[core]++;
+			return 0;
+		}
+
+		/* power up the core */
+		ret = sof_ops(sdev)->core_get(sdev, core);
+		if (ret < 0)
+			return ret;
+
+		/* increment ref_count */
+		sdev->dsp_core_ref_count[core]++;
+
+		/* and update enabled_cores_mask */
+		sdev->enabled_cores_mask |= BIT(core);
+
+		dev_dbg(sdev->dev, "Core %d powered up\n", core);
+	}
+
+	return 0;
+}
+
+static inline int snd_sof_dsp_core_put(struct snd_sof_dev *sdev, int core)
+{
+	if (core > sdev->num_cores - 1) {
+		dev_err(sdev->dev, "invalid core id: %d for num_cores: %d\n", core,
+			sdev->num_cores);
+		return -EINVAL;
+	}
+
+	if (sof_ops(sdev)->core_put) {
+		int ret;
+
+		/* decrement ref_count and return if it is > 0 */
+		if (--(sdev->dsp_core_ref_count[core]) > 0)
+			return 0;
+
+		/* power down the core */
+		ret = sof_ops(sdev)->core_put(sdev, core);
+		if (ret < 0)
+			return ret;
+
+		/* and update enabled_cores_mask */
+		sdev->enabled_cores_mask &= ~BIT(core);
+
+		dev_dbg(sdev->dev, "Core %d powered down\n", core);
+	}
+
+	return 0;
+}
+
 /* pre/post fw load */
 static inline int snd_sof_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 {
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index a56f3c8b483f..f7c86a72ac10 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -134,6 +134,8 @@ struct snd_sof_dsp_ops {
 			     unsigned int core_mask); /* optional */
 	int (*core_power_down)(struct snd_sof_dev *sof_dev,
 			       unsigned int core_mask); /* optional */
+	int (*core_get)(struct snd_sof_dev *sof_dev, int core); /* optional */
+	int (*core_put)(struct snd_sof_dev *sof_dev, int core); /* optional */
 
 	/*
 	 * Register IO: only used by respective drivers themselves,
-- 
2.33.0

