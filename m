Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7CB8C001B0
	for <alsa-devel@archiver.kernel.org>; Mon,  7 Aug 2023 21:15:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 40242839;
	Mon,  7 Aug 2023 23:14:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 40242839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1691442926;
	bh=sn78JSdaGACNIV67x0OUXPzr5j9MbVIUFQkvqvSkte0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Kmo8Cce8L6b59W9bmQoY7yws6nve4m7sZXFcWI9rHErNkVA3zV72O1+tc3N/wC1YT
	 KF+hN3XNzRDQkz0BUwUfSmWVgJybCdt0VvDeGGzuUALzWzRHwOkJuyJ/tR4xw2JMKD
	 KTiF2FHvBihm1xhiP7opb//zPLbhG0Uw0fROa3BE=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 77AEDF80616; Mon,  7 Aug 2023 23:11:04 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id C3664F80609;
	Mon,  7 Aug 2023 23:11:03 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 95340F80087; Mon,  7 Aug 2023 23:10:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id B8FD9F80087
	for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2023 23:10:25 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8FD9F80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=PX8Ofuj0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691442626; x=1722978626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sn78JSdaGACNIV67x0OUXPzr5j9MbVIUFQkvqvSkte0=;
  b=PX8Ofuj0FM++GzdukSACUiMt5W0ocJ50g47qmg3IKRG4+0MaDxaaNtlQ
   UnK9x8SKbLC+05+mwYE3dlkxoYfPyUZdb7XkNkP63DaM5HN1ysdudd02K
   +C26FEKzjQUHGJc6mzdHTsifkEVzFl6+DU5aYoZaxT0r1bAbKe6a7Ec1y
   N+pHXxtI9garElrrx5vGIjFPIvOJINZl3epeEOo3SMVDdFwXsleIPaWTv
   QZEpt6o7oxGjVly+DxreeaPslTgYfvJcHfHK0YZRh4jnRdaC3SzU+JgGP
   /UrN12Y2X3BZmeUXnWEnUeLIHWI1ttPLD0uPbXXiOJQiFI5rj0gPLK+oF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="350244377"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200";
   d="scan'208";a="350244377"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 14:10:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="796465250"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200";
   d="scan'208";a="796465250"
Received: from hweelee-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.181.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Aug 2023 14:10:17 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de,
	broonie@kernel.org,
	vkoul@kernel.org,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Rander Wang <rander.wang@intel.com>
Subject: [PATCH 15/20] ASoC: SOF: Intel: hda: add hw_params/free/trigger
 callbacks
Date: Mon,  7 Aug 2023 16:09:54 -0500
Message-Id: <20230807210959.506849-16-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230807210959.506849-1-pierre-louis.bossart@linux.intel.com>
References: <20230807210959.506849-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: GOJBF2O7SPGU6XGQMPDKHL5SKZIPQXSO
X-Message-ID-Hash: GOJBF2O7SPGU6XGQMPDKHL5SKZIPQXSO
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

These callbacks are just wrappers to keep the code relatively clean.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 sound/soc/sof/intel/hda.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 6074b0ca13aa..67b2e00baf4e 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -112,6 +112,34 @@ struct sdw_intel_ops sdw_callback = {
 	.params_stream = sdw_params_stream,
 };
 
+static int sdw_ace2x_params_stream(struct device *dev,
+				   struct sdw_intel_stream_params_data *params_data)
+{
+	return sdw_hda_dai_hw_params(params_data->substream,
+				     params_data->hw_params,
+				     params_data->dai,
+				     params_data->link_id);
+}
+
+static int sdw_ace2x_free_stream(struct device *dev,
+				 struct sdw_intel_stream_free_data *free_data)
+{
+	return sdw_hda_dai_hw_free(free_data->substream,
+				   free_data->dai,
+				   free_data->link_id);
+}
+
+static int sdw_ace2x_trigger(struct snd_pcm_substream *substream, int cmd, struct snd_soc_dai *dai)
+{
+	return sdw_hda_dai_trigger(substream, cmd, dai);
+}
+
+static struct sdw_intel_ops sdw_ace2x_callback = {
+	.params_stream = sdw_ace2x_params_stream,
+	.free_stream = sdw_ace2x_free_stream,
+	.trigger = sdw_ace2x_trigger,
+};
+
 void hda_common_enable_sdw_irq(struct snd_sof_dev *sdev, bool enable)
 {
 	struct sof_intel_hda_dev *hdev;
@@ -179,6 +207,7 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 		res.shim_base = hdev->desc->sdw_shim_base;
 		res.alh_base = hdev->desc->sdw_alh_base;
 		res.ext = false;
+		res.ops = &sdw_callback;
 	} else {
 		/*
 		 * retrieve eml_lock needed to protect shared registers
@@ -196,11 +225,13 @@ static int hda_sdw_probe(struct snd_sof_dev *sdev)
 		 */
 		res.hw_ops = &sdw_intel_lnl_hw_ops;
 		res.ext = true;
+		res.ops = &sdw_ace2x_callback;
+
 	}
 	res.irq = sdev->ipc_irq;
 	res.handle = hdev->info.handle;
 	res.parent = sdev->dev;
-	res.ops = &sdw_callback;
+
 	res.dev = sdev->dev;
 	res.clock_stop_quirks = sdw_clock_stop_quirks;
 	res.hbus = sof_to_bus(sdev);
-- 
2.39.2

