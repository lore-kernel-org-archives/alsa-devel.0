Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F33B7C433FE
	for <alsa-devel@archiver.kernel.org>; Mon, 10 Oct 2022 12:05:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F19C12964;
	Mon, 10 Oct 2022 14:04:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F19C12964
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1665403535;
	bh=WITP0r5AgZxlVo1fQXrFXmw6o2iVJQ0gaMwaR+xtqFY=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=U3yYpWp357+yqDTBGyQhkeh4DV9b8YXHvWuiKbY9DB63skOi7j/40gu0R6bfCEDir
	 XlDGGGLbq6qJSLsFDE/9SwDxuqmL0iohyKBKBxH/yGmyx7Ha3N/x8eEpRRsrgjPM2L
	 k3Wt7W+OH7Vzby0VkeV2NoJFbvSA0F3hx3+Z/hTk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E44F4F8053C;
	Mon, 10 Oct 2022 14:04:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7E5A2F80155; Mon, 10 Oct 2022 14:03:59 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A8ECF80155
 for <alsa-devel@alsa-project.org>; Mon, 10 Oct 2022 14:03:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A8ECF80155
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ARhGHXK0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1665403434; x=1696939434;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WITP0r5AgZxlVo1fQXrFXmw6o2iVJQ0gaMwaR+xtqFY=;
 b=ARhGHXK0DwjZ0uo9GcNj+khbR8A0PHuRahtvKsJxxO/MPeMc0fYULWZR
 1sE3YtRsI8+LJ0LWktmlLRkyH4MJv+3f+soX8Evu00v5x0WO/0x7VVC+g
 siorGqQg0t6tFCk8V/QBu7Q6sVDsTkSQbLcsdAZpRKlspZyVOKEjvQE2X
 boUOXbWkNbFt+264a6XyTiIB2U0ZCJmI+WiEMZhx36AXEJdxPDgph9quC
 O7vyggWWSvQgSXaOGAHtRaTt82PYmTa/lfGUURbubEIDOFDHX3l+RACRK
 mGDLB0haMd1ZXcIBO4/P5kUalXQSM+h/2NubpCam7jXIXYWUMyFYHVdfL g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="368346067"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; d="scan'208";a="368346067"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Oct 2022 05:03:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="871078870"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; d="scan'208";a="871078870"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga006.fm.intel.com with ESMTP; 10 Oct 2022 05:03:50 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH v2 02/15] ASoC: Intel: avs: Fix potential RX buffer overflow
Date: Mon, 10 Oct 2022 14:19:42 +0200
Message-Id: <20221010121955.718168-3-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221010121955.718168-1-cezary.rojewski@intel.com>
References: <20221010121955.718168-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 CoolStar <coolstarorganization@gmail.com>,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com
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

If an event caused firmware to return invalid RX size for
LARGE_CONFIG_GET, memcpy_fromio() could end up copying too many bytes.
Fix by utilizing min_t().

Reported-by: CoolStar <coolstarorganization@gmail.com>
Fixes: f14a1c5a9f83 ("ASoC: Intel: avs: Add module management requests")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/avs/ipc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/ipc.c b/sound/soc/intel/avs/ipc.c
index 020d85c7520d..77da206f7dbb 100644
--- a/sound/soc/intel/avs/ipc.c
+++ b/sound/soc/intel/avs/ipc.c
@@ -192,7 +192,8 @@ static void avs_dsp_receive_rx(struct avs_dev *adev, u64 header)
 		/* update size in case of LARGE_CONFIG_GET */
 		if (msg.msg_target == AVS_MOD_MSG &&
 		    msg.global_msg_type == AVS_MOD_LARGE_CONFIG_GET)
-			ipc->rx.size = msg.ext.large_config.data_off_size;
+			ipc->rx.size = min_t(u32, AVS_MAILBOX_SIZE,
+					     msg.ext.large_config.data_off_size);
 
 		memcpy_fromio(ipc->rx.data, avs_uplink_addr(adev), ipc->rx.size);
 		trace_avs_msg_payload(ipc->rx.data, ipc->rx.size);
-- 
2.25.1

