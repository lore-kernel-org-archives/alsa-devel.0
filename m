Return-Path: <SRS0=iKRb=DH=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D785AC4363D
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:53:33 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 104AA20719
	for <alsa-devel@archiver.kernel.org>; Wed, 30 Sep 2020 22:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="JCwPnpFj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 104AA20719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1B30717AE;
	Thu,  1 Oct 2020 00:52:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1B30717AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601506411;
	bh=tc4HYKqrdVc9n+T9+OaDo7SRBlaCCD9wQdXrVMID5K0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=JCwPnpFjDcJ5YpHn2t4wcM/+nROplzZ909EuvpPi2pio1DLcnH/kSozQIz00zpvRW
	 NVqNyjhY1dMzltiFhr7OkKd5nzKsMqESniw7Y/5lQRdyR8I9DLU+2ksHSkNmqgerxj
	 SkACjVRm15EAadnFubO7cZX7bCe7VAMl6tML6CWo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2D92CF802C4;
	Thu,  1 Oct 2020 00:51:51 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 4569DF80228; Thu,  1 Oct 2020 00:51:46 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 7804BF800AB
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2020 00:51:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 7804BF800AB
IronPort-SDR: kyttn4blU5h4sJzM7lyqqwraRgKmR6dei3AdsIz7Y0AIOk+zdLzA2nQGZDqCCD/XesBEyzU8tI
 H2aZAspKGHYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="161811145"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="161811145"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2020 15:51:33 -0700
IronPort-SDR: IeEEyQbK5a0GXuWQp7WAUEg46TVOzjS/lEjiAsjcTYalv227nc/+iDhP8NAYuEQ8gAixlCQ+r8
 Hx68EFmZPnrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; d="scan'208";a="350838149"
Received: from dmert-dev.jf.intel.com ([10.166.241.5])
 by FMSMGA003.fm.intel.com with ESMTP; 30 Sep 2020 15:51:33 -0700
From: Dave Ertman <david.m.ertman@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/6] ASoC: SOF: ops: Add ops for client registration
Date: Wed, 30 Sep 2020 15:50:49 -0700
Message-Id: <20200930225051.889607-5-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930225051.889607-1-david.m.ertman@intel.com>
References: <20200930225051.889607-1-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, gregkh@linuxfoundation.org, ranjani.sridharan@intel.com,
 pierre-louis.bossart@linux.intel.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org,
 parav@nvidia.com, jgg@nvidia.com
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

Add new ops for registering/unregistering clients based
on DSP capabilities and/or DT information.

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
---
 sound/soc/sof/core.c     | 10 ++++++++++
 sound/soc/sof/ops.h      | 14 ++++++++++++++
 sound/soc/sof/sof-priv.h |  4 ++++
 3 files changed, 28 insertions(+)

diff --git a/sound/soc/sof/core.c b/sound/soc/sof/core.c
index 72a97219395f..ddb9a12d5aac 100644
--- a/sound/soc/sof/core.c
+++ b/sound/soc/sof/core.c
@@ -246,8 +246,17 @@ static int sof_probe_continue(struct snd_sof_dev *sdev)
 	if (plat_data->sof_probe_complete)
 		plat_data->sof_probe_complete(sdev->dev);
 
+	/* If registering certain clients fails, unregister the previously registered clients. */
+	ret = snd_sof_register_clients(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: failed to register clients %d\n", ret);
+		goto client_reg_err;
+	}
+
 	return 0;
 
+client_reg_err:
+	snd_sof_unregister_clients(sdev);
 fw_trace_err:
 	snd_sof_free_trace(sdev);
 fw_run_err:
@@ -356,6 +365,7 @@ int snd_sof_device_remove(struct device *dev)
 			dev_warn(dev, "error: %d failed to prepare DSP for device removal",
 				 ret);
 
+		snd_sof_unregister_clients(sdev);
 		snd_sof_fw_unload(sdev);
 		snd_sof_ipc_free(sdev);
 		snd_sof_free_debug(sdev);
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index b21632f5511a..0e5660d7a2fd 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -470,6 +470,20 @@ snd_sof_set_mach_params(const struct snd_soc_acpi_mach *mach,
 		sof_ops(sdev)->set_mach_params(mach, dev);
 }
 
+static inline int snd_sof_register_clients(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev) && sof_ops(sdev)->register_clients)
+		return sof_ops(sdev)->register_clients(sdev);
+
+	return 0;
+}
+
+static inline void snd_sof_unregister_clients(struct snd_sof_dev *sdev)
+{
+	if (sof_ops(sdev) && sof_ops(sdev)->unregister_clients)
+		return sof_ops(sdev)->unregister_clients(sdev);
+}
+
 static inline const struct snd_sof_dsp_ops
 *sof_get_ops(const struct sof_dev_desc *d,
 	     const struct sof_ops_table mach_ops[], int asize)
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 043fcec5a288..151614224f47 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -249,6 +249,10 @@ struct snd_sof_dsp_ops {
 	void (*set_mach_params)(const struct snd_soc_acpi_mach *mach,
 				struct device *dev); /* optional */
 
+	/* client ops */
+	int (*register_clients)(struct snd_sof_dev *sdev); /* optional */
+	void (*unregister_clients)(struct snd_sof_dev *sdev); /* optional */
+
 	/* DAI ops */
 	struct snd_soc_dai_driver *drv;
 	int num_drv;
-- 
2.26.2

