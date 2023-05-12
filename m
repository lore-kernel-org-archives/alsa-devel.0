Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC58C77B7C
	for <alsa-devel@archiver.kernel.org>; Fri, 12 May 2023 10:57:16 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 55C971D6;
	Fri, 12 May 2023 12:56:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 55C971D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1683889034;
	bh=GMY+3SSKw5Q8LwG40TVwmH1HK1wtiQEqWHi++O7LOf4=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=msi9w282NcaBi6dyeJIWj2r+Su49eT0gkUeZewIlSzK+DVFcgbRF68ozLLGdP5MH2
	 jOHBzmxZ+cr76YDZpKCAznemnqFjaAJsgQK3WSArmE1v2as802NblMsEH90iNgNmXX
	 u4H3RYijfNnIjPH4CMDl+al4edsMqvldzA9I9ymU=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id D0CD2F80544; Fri, 12 May 2023 12:56:01 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 58240F8052E;
	Fri, 12 May 2023 12:56:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4177FF8052E; Fri, 12 May 2023 12:55:57 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id C9B94F802E8
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2023 12:55:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C9B94F802E8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=YaQ6g5P/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683888955; x=1715424955;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GMY+3SSKw5Q8LwG40TVwmH1HK1wtiQEqWHi++O7LOf4=;
  b=YaQ6g5P/Sw9ec1fGhuX3gZIpaiT5YhDIvheVbFTQCimMmOhWDcb/p7/X
   3qdOQE0bXfTkmmvWO6aHWYtfUUaok6C7McMAll4PK0RUKkCY+T+txmRYf
   hqrDCocNJM6ipG42vu5DPPHZC+8s42GcUTcRcsfO97UntGeOZVeGGsNIW
   JeM0sgriFqMXWXiQ4CwL1yHr7KJmfRf26WaYXgzWfTg69jgazJq+TjikR
   fBBO/4PFD0rakUd1Mn+CqaaFn8vEpjeRUz1L9FIJdEwGgGXQ8ZHNr2WkY
   VeAv+sKbrPOKCgrCAxSc0txUGmUN+LBCyHKidUkzZxj3ON+5Zy3tWedS/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="416394631"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200";
   d="scan'208";a="416394631"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2023 03:55:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730778253"
X-IronPort-AV: E=Sophos;i="5.99,269,1677571200";
   d="scan'208";a="730778253"
Received: from nhanph1x-mobl.amr.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.38.84])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 May 2023 03:55:49 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	yung-chuan.liao@linux.intel.com
Subject: [PATCH] ASoC: SOF: ipc4-topology: Use set_get_data() to send
 LARGE_CONFIG message
Date: Fri, 12 May 2023 13:56:42 +0300
Message-Id: <20230512105642.23437-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: Q4YAXLPO3QYQTPAWJ5VQFBJQ2JNJP3RJ
X-Message-ID-Hash: Q4YAXLPO3QYQTPAWJ5VQFBJQ2JNJP3RJ
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/Q4YAXLPO3QYQTPAWJ5VQFBJQ2JNJP3RJ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Instead of open coding the sending of sink format of the copier with
LARGE_CONFIG_SET message, use the proper function to do so.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/ipc4-topology.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/sound/soc/sof/ipc4-topology.c b/sound/soc/sof/ipc4-topology.c
index 059eebf0a687..73a45437a3a1 100644
--- a/sound/soc/sof/ipc4-topology.c
+++ b/sound/soc/sof/ipc4-topology.c
@@ -2271,11 +2271,11 @@ static int sof_ipc4_set_copier_sink_format(struct snd_sof_dev *sdev,
 					   int sink_id)
 {
 	struct sof_ipc4_copier_config_set_sink_format format;
+	const struct sof_ipc_ops *iops = sdev->ipc->ops;
 	struct sof_ipc4_base_module_cfg *src_config;
 	const struct sof_ipc4_audio_format *pin_fmt;
 	struct sof_ipc4_fw_module *fw_module;
 	struct sof_ipc4_msg msg = {{ 0 }};
-	u32 header, extension;
 
 	dev_dbg(sdev->dev, "%s set copier sink %d format\n",
 		src_widget->widget->name, sink_id);
@@ -2305,22 +2305,15 @@ static int sof_ipc4_set_copier_sink_format(struct snd_sof_dev *sdev,
 	msg.data_size = sizeof(format);
 	msg.data_ptr = &format;
 
-	header = fw_module->man4_module_entry.id;
-	header |= SOF_IPC4_MOD_INSTANCE(src_widget->instance_id);
-	header |= SOF_IPC4_MSG_TYPE_SET(SOF_IPC4_MOD_LARGE_CONFIG_SET);
-	header |= SOF_IPC4_MSG_DIR(SOF_IPC4_MSG_REQUEST);
-	header |= SOF_IPC4_MSG_TARGET(SOF_IPC4_MODULE_MSG);
+	msg.primary = fw_module->man4_module_entry.id;
+	msg.primary |= SOF_IPC4_MOD_INSTANCE(src_widget->instance_id);
+	msg.primary |= SOF_IPC4_MSG_DIR(SOF_IPC4_MSG_REQUEST);
+	msg.primary |= SOF_IPC4_MSG_TARGET(SOF_IPC4_MODULE_MSG);
 
-	extension = SOF_IPC4_MOD_EXT_MSG_SIZE(msg.data_size);
-	extension |=
+	msg.extension =
 		SOF_IPC4_MOD_EXT_MSG_PARAM_ID(SOF_IPC4_COPIER_MODULE_CFG_PARAM_SET_SINK_FORMAT);
-	extension |= SOF_IPC4_MOD_EXT_MSG_LAST_BLOCK(1);
-	extension |= SOF_IPC4_MOD_EXT_MSG_FIRST_BLOCK(1);
-
-	msg.primary = header;
-	msg.extension = extension;
 
-	return sof_ipc_tx_message_no_reply(sdev->ipc, &msg, msg.data_size);
+	return iops->set_get_data(sdev, &msg, msg.data_size, true);
 }
 
 static int sof_ipc4_route_setup(struct snd_sof_dev *sdev, struct snd_sof_route *sroute)
-- 
2.40.1

