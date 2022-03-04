Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97E2C433EF
	for <alsa-devel@archiver.kernel.org>; Fri,  4 Mar 2022 14:59:44 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0F0901AA1;
	Fri,  4 Mar 2022 15:58:53 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0F0901AA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1646405983;
	bh=qaTyULVfHaLm3NVsFZ3HMvVFK2rbsy3kPt3ceZY5Hj4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cU4UCDszfwy5us1Jn73VaYFLPXvBB2od+ldR3+Nc8o3SVz/OiwuH5qNiz99RzmI83
	 eu90PZMkJUIzmX0kO9q1jNbwDuuy6O4B4GIKkMQ5SiJ7aJioaektnqSAtGwsjm6wwL
	 Ec9gvNINmUOgpC9ESbJSg5bp0zV3LSAqeEiPslHo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id EFE92F8054A;
	Fri,  4 Mar 2022 15:56:22 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E80B7F80543; Fri,  4 Mar 2022 15:56:20 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D68EF8053C
 for <alsa-devel@alsa-project.org>; Fri,  4 Mar 2022 15:56:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D68EF8053C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="fo5QopW4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1646405776; x=1677941776;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qaTyULVfHaLm3NVsFZ3HMvVFK2rbsy3kPt3ceZY5Hj4=;
 b=fo5QopW4TnmiDOghrzSOzAj2RG6GWboJHJ0Zac6hioR40sJoNYHc2oka
 aEP8vTbpZCD3zjmFBAGQOtUKZ+izTLb+k9eFeo7woADjhjvjxQ+6SdjHR
 eEocWkXJ30aKXDcGtVmSW3Az6BMkTty7UcAJJOxkGiGIBi+QCoWePCZ28
 SFx7WFB2xZCae0Y1cjOHDdMb6yHdumcE/dTjmBWxZa56K8VSI8l/NSBoO
 1FkGNAmO6uVXDZ2/I8K9ZVtKH8ZC6DDwy7+8oG+PJ/UaX4oBwLa59NNMd
 oaoLqVVbgcJcbks74IIndCxy9lJgkC+rJ7IsRJ5XQdAGiUn/vcHJGSX2b Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10276"; a="233949194"
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; d="scan'208";a="233949194"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2022 06:56:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,155,1643702400"; d="scan'208";a="609963500"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga004.fm.intel.com with ESMTP; 04 Mar 2022 06:56:12 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 09/17] ASoC: Intel: avs: Add ROM requests
Date: Fri,  4 Mar 2022 15:57:47 +0100
Message-Id: <20220304145755.2844173-10-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304145755.2844173-1-cezary.rojewski@intel.com>
References: <20220304145755.2844173-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, rad@semihalf.com,
 upstream@semihalf.com, harshapriya.n@intel.com, tiwai@suse.com,
 pierre-louis.bossart@linux.intel.com, hdegoede@redhat.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com, cujomalainey@chromium.org,
 lma@semihalf.com
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

ROM requests are messages initiated by Host to alter firmware early boot
process. They specify whether the next boot should be a fresh start or if
IMR can be used to speed things up.

Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/avs/messages.c | 18 ++++++++++++++++++
 sound/soc/intel/avs/messages.h | 14 ++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/sound/soc/intel/avs/messages.c b/sound/soc/intel/avs/messages.c
index e8f441b28d71..f7d00e541323 100644
--- a/sound/soc/intel/avs/messages.c
+++ b/sound/soc/intel/avs/messages.c
@@ -12,6 +12,24 @@
 
 #define AVS_CL_TIMEOUT_MS	5000
 
+int avs_ipc_set_boot_config(struct avs_dev *adev, u32 dma_id, u32 purge)
+{
+	union avs_global_msg msg = AVS_GLOBAL_REQUEST(ROM_CONTROL);
+	struct avs_ipc_msg request = {{0}};
+	int ret;
+
+	msg.boot_cfg.rom_ctrl_msg_type = AVS_ROM_SET_BOOT_CONFIG;
+	msg.boot_cfg.dma_id = dma_id;
+	msg.boot_cfg.purge_request = purge;
+	request.header = msg.val;
+
+	ret = avs_dsp_send_rom_msg(adev, &request);
+	if (ret)
+		avs_ipc_err(adev, &request, "set boot config", ret);
+
+	return ret;
+}
+
 int avs_ipc_load_modules(struct avs_dev *adev, u16 *mod_ids, u32 num_mod_ids)
 {
 	union avs_global_msg msg = AVS_GLOBAL_REQUEST(LOAD_MULTIPLE_MODULES);
diff --git a/sound/soc/intel/avs/messages.h b/sound/soc/intel/avs/messages.h
index 69920f5e802b..615a61cef4f6 100644
--- a/sound/soc/intel/avs/messages.h
+++ b/sound/soc/intel/avs/messages.h
@@ -24,6 +24,7 @@ enum avs_msg_direction {
 };
 
 enum avs_global_msg_type {
+	AVS_GLB_ROM_CONTROL = 1,
 	AVS_GLB_LOAD_MULTIPLE_MODULES = 15,
 	AVS_GLB_UNLOAD_MULTIPLE_MODULES = 16,
 	AVS_GLB_CREATE_PIPELINE = 17,
@@ -45,6 +46,12 @@ union avs_global_msg {
 				u32 msg_direction:1;
 				u32 msg_target:1;
 			};
+			/* set boot config */
+			struct {
+				u32 rom_ctrl_msg_type:9;
+				u32 dma_id:5;
+				u32 purge_request:1;
+			} boot_cfg;
 			/* module loading */
 			struct {
 				u32 mod_cnt:8;
@@ -255,6 +262,13 @@ struct avs_notify_mod_data {
 	u32 data[];
 } __packed;
 
+/* ROM messages */
+enum avs_rom_control_msg_type {
+	AVS_ROM_SET_BOOT_CONFIG = 0,
+};
+
+int avs_ipc_set_boot_config(struct avs_dev *adev, u32 dma_id, u32 purge);
+
 /* Code loading messages */
 int avs_ipc_load_modules(struct avs_dev *adev, u16 *mod_ids, u32 num_mod_ids);
 int avs_ipc_unload_modules(struct avs_dev *adev, u16 *mod_ids, u32 num_mod_ids);
-- 
2.25.1

