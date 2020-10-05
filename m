Return-Path: <SRS0=eLx3=DM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4BC9C4363A
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:33:31 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13D80208C3
	for <alsa-devel@archiver.kernel.org>; Mon,  5 Oct 2020 19:33:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AcNexBpO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13D80208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2AF881700;
	Mon,  5 Oct 2020 21:32:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2AF881700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1601926409;
	bh=vHVzRbFwQheUxVwzA8qUR2O36vzYUZHg7NbzqxB74X0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AcNexBpOeWpjMTGW3GlDsClb2j1T4AQgqQmqrDPCFODgkDCygTJ+ePEQLuCXsix4+
	 HCeZc0Pbq1hCS0zsYjsjX59w6dS7Ywu/6d2LOgcM/kVet7yARB8VvkbUwZOy5LauV1
	 kP3E+xfGYv2Xgs3bpAvtIj8e3msHNN1ZOP+Bp7ac=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9BA6FF8025A;
	Mon,  5 Oct 2020 21:32:38 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 42D5CF80121; Mon,  5 Oct 2020 21:32:37 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CFC5EF80121
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2020 21:32:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CFC5EF80121
IronPort-SDR: qRqPCA7OBbqz+5pb89pVGtOlV+dzpWVdhoR1UrVgjnlQ42aONecdaYy9uwIK9cQ09IdQrc/5HI
 ZI/xZPMg02zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9765"; a="225493066"
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; d="scan'208";a="225493066"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2020 12:19:40 -0700
IronPort-SDR: HpPhnBGwCSMWFIueGE7ceFBpnpG0/3JGXVDeDc9cBhQu+YQt6KRvFkXJq/P+dOoq2dMQiaesux
 0guoQDcpo3SQ==
X-IronPort-AV: E=Sophos;i="5.77,340,1596524400"; d="scan'208";a="341302774"
Received: from dmert-dev.jf.intel.com ([10.166.241.5])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Oct 2020 11:27:18 -0700
From: Dave Ertman <david.m.ertman@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 4/6] ASoC: SOF: ops: Add ops for client registration
Date: Mon,  5 Oct 2020 11:24:44 -0700
Message-Id: <20201005182446.977325-5-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201005182446.977325-1-david.m.ertman@intel.com>
References: <20201005182446.977325-1-david.m.ertman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: parav@mellanox.com, tiwai@suse.de, netdev@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, pierre-louis.bossart@linux.intel.com,
 fred.oh@linux.intel.com, linux-rdma@vger.kernel.org, dledford@redhat.com,
 broonie@kernel.org, jgg@nvidia.com, gregkh@linuxfoundation.org,
 kuba@kernel.org, dan.j.williams@intel.com, shiraz.saleem@intel.com,
 davem@davemloft.net, kiran.patil@intel.com
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
index b21632f5511a..00370f8bcd75 100644
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
+		sof_ops(sdev)->unregister_clients(sdev);
+}
+
 static inline const struct snd_sof_dsp_ops
 *sof_get_ops(const struct sof_dev_desc *d,
 	     const struct sof_ops_table mach_ops[], int asize)
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index 8603924e56e3..1c29199132c5 100644
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

