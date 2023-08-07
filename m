Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D84C001B0
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Aug 2023 21:15:06 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EDDBB886;
	Mon,  7 Aug 2023 23:14:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EDDBB886
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691442904;
	bh=7vAUbVt9p8S5MR1KprBy4KddpQvMW6IIwqM+gpUxSeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=I+EEaTgt2tMYyvyYs8pmIosoNBd1pKQjxtquXEcpb9aRM+TaGwlRfx0OvC5XF5P6f
	 UUJQIpCiiVqsHkkMjG//d/9hyMqwdV3cRCCn0NMuULI3HdQVbUOdyQ/m8ZuJPBrZYs
	 +E7iyEhttQGrshSJsvwARSqQVPTWFVDyst3sm8HA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DB5F1F805FE; Mon,  7 Aug 2023 23:11:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 3F26AF80570;
	Mon,  7 Aug 2023 23:11:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id DFE5FF805BF; Mon,  7 Aug 2023 23:10:40 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 96CC1F80544
	for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2023 23:10:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 96CC1F80544
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cHOslh72
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691442621; x=1722978621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7vAUbVt9p8S5MR1KprBy4KddpQvMW6IIwqM+gpUxSeE=;
  b=cHOslh72927jvz1vYpjMSknbRRfEjvY6qiN7zygfVIXdtVeoCcQcJz7K
   uNeqK4b8dWD4osljXAUFT9+IQ2dATg7cGP/nxjXQQaPbHjQA5gIpB8IGM
   qAaOal7oXBMVuAwVDzSFmnc61XRbhy52IetJkHzmO/D40j7ikZ1zXHcmC
   L7qbiY99qBCdg0UZ43s7FsGpApXTkcVYsMljcjfgw2tBxtVek+DIhyY7k
   cbopvNKCqyhxJpGxGV+ZqHbsom7nRwxNzMj7jWqGsOKTmnOt6tKJ9pbSB
   NgdNi/lwgWRdMQWyQbDmNlnAHISTqMGNQ9vHS98s92tH2vGUZASPIAbF+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350244342"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200";
   d="scan'208";a="350244342"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 14:10:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="796465200"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200";
   d="scan'208";a="796465200"
Received: from hweelee-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.181.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 14:10:13 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	vkoul@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [PATCH 08/20] ASoC: SOF: Intel: LNL: enable DMIC/SSP offload in
 probe/resume
Date: Mon,  7 Aug 2023 16:09:47 -0500
Message-Id: <20230807210959.506849-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807210959.506849-1-pierre-louis.bossart@linux.intel.com>
References: <20230807210959.506849-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: TMXIW4J3A7VUPNX2LTTWMOHFF7QGR2O2
X-Message-ID-Hash: TMXIW4J3A7VUPNX2LTTWMOHFF7QGR2O2
X-MailFrom: pierre-louis.bossart@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: <>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

In the LunarLake hardware, the default IP ownership changed to the
host driver, instead of the firmware in previous generation.

In the absence of any capability negotiation, we need to assume a
fixed partitioning between host driver and firmware. The OFLEN bit
needs to be set as early as possible for resources handled by the
firmware, since we can't control when the firmware might try to access
the resources.

For now DMIC and SSP are handled by the DSP firmware. SoundWire is a
separate case, the OFLEN bit can be set when starting-up and resuming
the aux device for each link.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/intel/lnl.c | 56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/sound/soc/sof/intel/lnl.c b/sound/soc/sof/intel/lnl.c
index 65a78d9511e9..3d919b0b6891 100644
--- a/sound/soc/sof/intel/lnl.c
+++ b/sound/soc/sof/intel/lnl.c
@@ -29,6 +29,55 @@ static const struct snd_sof_debugfs_map lnl_dsp_debugfs[] = {
 	{"dsp", HDA_DSP_BAR,  0, 0x10000, SOF_DEBUGFS_ACCESS_ALWAYS},
 };
 
+/* this helps allows the DSP to setup DMIC/SSP */
+static int hdac_bus_offload_dmic_ssp(struct hdac_bus *bus)
+{
+	int ret;
+
+	ret = hdac_bus_eml_enable_offload(bus, true,  AZX_REG_ML_LEPTR_ID_INTEL_SSP, true);
+	if (ret < 0)
+		return ret;
+
+	ret = hdac_bus_eml_enable_offload(bus, true,  AZX_REG_ML_LEPTR_ID_INTEL_DMIC, true);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int lnl_hda_dsp_probe(struct snd_sof_dev *sdev)
+{
+	int ret;
+
+	ret = hda_dsp_probe(sdev);
+	if (ret < 0)
+		return ret;
+
+	return hdac_bus_offload_dmic_ssp(sof_to_bus(sdev));
+}
+
+static int lnl_hda_dsp_resume(struct snd_sof_dev *sdev)
+{
+	int ret;
+
+	ret = hda_dsp_resume(sdev);
+	if (ret < 0)
+		return ret;
+
+	return hdac_bus_offload_dmic_ssp(sof_to_bus(sdev));
+}
+
+static int lnl_hda_dsp_runtime_resume(struct snd_sof_dev *sdev)
+{
+	int ret;
+
+	ret = hda_dsp_runtime_resume(sdev);
+	if (ret < 0)
+		return ret;
+
+	return hdac_bus_offload_dmic_ssp(sof_to_bus(sdev));
+}
+
 int sof_lnl_ops_init(struct snd_sof_dev *sdev)
 {
 	struct sof_ipc4_fw_data *ipc4_data;
@@ -36,6 +85,9 @@ int sof_lnl_ops_init(struct snd_sof_dev *sdev)
 	/* common defaults */
 	memcpy(&sof_lnl_ops, &sof_hda_common_ops, sizeof(struct snd_sof_dsp_ops));
 
+	/* probe */
+	sof_lnl_ops.probe = lnl_hda_dsp_probe;
+
 	/* shutdown */
 	sof_lnl_ops.shutdown = hda_dsp_shutdown;
 
@@ -63,6 +115,10 @@ int sof_lnl_ops_init(struct snd_sof_dev *sdev)
 	/* dsp core get/put */
 	/* TODO: add core_get and core_put */
 
+	/* PM */
+	sof_lnl_ops.resume			= lnl_hda_dsp_resume;
+	sof_lnl_ops.runtime_resume		= lnl_hda_dsp_runtime_resume;
+
 	sof_lnl_ops.get_stream_position = mtl_dsp_get_stream_hda_link_position;
 
 	sdev->private = devm_kzalloc(sdev->dev, sizeof(struct sof_ipc4_fw_data), GFP_KERNEL);
-- 
2.39.2

