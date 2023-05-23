Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2F6DC7EE26
	for <alsa-devel@archiver.kernel.org>; Tue, 23 May 2023 10:35:12 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 6710D820;
	Tue, 23 May 2023 12:34:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 6710D820
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684838110;
	bh=vSPN9jQ33fX+3MFvPWXcfWPHPvRiplw21/tSgG4k9b8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=S6MF3S7KihctmyL5O3e5PW6885jseN9siYUwjqTN69B+mWOXeyrMXnnxnfYtXsodq
	 zrOX+6XAht+MkRIcae8BTWnGy8dB9hORzWaFAjls/saUICMRPTTu44m325q2Tnbf6q
	 MphMsOPIuMJPLItiohULq6Sdi8bZafQCn9S4WP0Q=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 17A40F80552; Tue, 23 May 2023 12:33:30 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id BC297F80557;
	Tue, 23 May 2023 12:33:29 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id BF6CBF80249; Tue, 23 May 2023 12:33:25 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4CA84F80249
	for <alsa-devel@alsa-project.org>; Tue, 23 May 2023 12:33:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4CA84F80249
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Z0Zjor2y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684838000; x=1716374000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vSPN9jQ33fX+3MFvPWXcfWPHPvRiplw21/tSgG4k9b8=;
  b=Z0Zjor2yudEGphpm2HeQ+/2dBtE+mUjNGMZnrO5JDL7qSidXWrl2fqVP
   tvrZLe7tnLgkab/3eqGJZ+CDlOwuZavN25POwC9laoPwcyRXvlO16rXtj
   hYZpA6fHX7H9FYeu6V9gDIUW+XxGvgCX5b9NI5Xmi4Gve1PiUto/qX/R9
   eyRm6uQ46n4oq2OZEAP7OFg6V/2c4t161SevEjM6YU1gy05oVLOw39OL6
   IiQy3SL7xrDlwb+brKf2XcQGgpf+TG0gYPoM/nd0QqJo+NQU3ptb5RmeZ
   SkIzH7S1QsqEoM+vGrFtPgJG5mGgMEYWM+zWICV39BWAjBw6HQGLfpiCu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="333562960"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400";
   d="scan'208";a="333562960"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2023 03:31:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10718"; a="681333522"
X-IronPort-AV: E=Sophos;i="6.00,185,1681196400";
   d="scan'208";a="681333522"
Received: from nmkenne1-mobl2.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.53.154])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 May 2023 03:31:23 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	rander.wang@intel.com
Subject: [PATCH 2/3] ASoC: SOF: Intel: mtl: add core_get & put support on
 MeterLake platforms
Date: Tue, 23 May 2023 13:32:16 +0300
Message-Id: <20230523103217.20412-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230523103217.20412-1-peter.ujfalusi@linux.intel.com>
References: <20230523103217.20412-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: RT4CLKKH5ATJIMPDTCTN4ZQTBK5JMRSC
X-Message-ID-Hash: RT4CLKKH5ATJIMPDTCTN4ZQTBK5JMRSC
X-MailFrom: peter.ujfalusi@linux.intel.com
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
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/RT4CLKKH5ATJIMPDTCTN4ZQTBK5JMRSC/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Rander Wang <rander.wang@intel.com>

In core_get case, driver can power up primary core and don't need to send
ipc message to fw. Non-primary core should be powered up by fw with ipc
message.

In core_put case, driver should first send ipc message to fw to disable dsp
core then power down primary core if the target is primary core.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/intel/mtl.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/mtl.c b/sound/soc/sof/intel/mtl.c
index 4788ba3b25aa..a847ae3ed4e9 100644
--- a/sound/soc/sof/intel/mtl.c
+++ b/sound/soc/sof/intel/mtl.c
@@ -624,6 +624,36 @@ static u64 mtl_dsp_get_stream_hda_link_position(struct snd_sof_dev *sdev,
 	return ((u64)llp_u << 32) | llp_l;
 }
 
+static int mtl_dsp_core_get(struct snd_sof_dev *sdev, int core)
+{
+	const struct sof_ipc_pm_ops *pm_ops = sdev->ipc->ops->pm;
+
+	if (core == SOF_DSP_PRIMARY_CORE)
+		return mtl_dsp_core_power_up(sdev, SOF_DSP_PRIMARY_CORE);
+
+	if (pm_ops->set_core_state)
+		return pm_ops->set_core_state(sdev, core, true);
+
+	return 0;
+}
+
+static int mtl_dsp_core_put(struct snd_sof_dev *sdev, int core)
+{
+	const struct sof_ipc_pm_ops *pm_ops = sdev->ipc->ops->pm;
+	int ret;
+
+	if (pm_ops->set_core_state) {
+		ret = pm_ops->set_core_state(sdev, core, false);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (core == SOF_DSP_PRIMARY_CORE)
+		return mtl_dsp_core_power_down(sdev, SOF_DSP_PRIMARY_CORE);
+
+	return 0;
+}
+
 /* Meteorlake ops */
 struct snd_sof_dsp_ops sof_mtl_ops;
 EXPORT_SYMBOL_NS(sof_mtl_ops, SND_SOC_SOF_INTEL_HDA_COMMON);
@@ -660,7 +690,8 @@ int sof_mtl_ops_init(struct snd_sof_dev *sdev)
 	sof_mtl_ops.parse_platform_ext_manifest = NULL;
 
 	/* dsp core get/put */
-	/* TODO: add core_get and core_put */
+	sof_mtl_ops.core_get = mtl_dsp_core_get;
+	sof_mtl_ops.core_put = mtl_dsp_core_put;
 
 	sof_mtl_ops.get_stream_position = mtl_dsp_get_stream_hda_link_position;
 
-- 
2.40.1

