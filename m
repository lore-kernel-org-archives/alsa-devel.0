Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FC3CD54AB
	for <alsa-devel@archiver.kernel.org>; Tue, 19 Sep 2023 09:27:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3A0D1E73;
	Tue, 19 Sep 2023 11:26:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3A0D1E73
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1695115614;
	bh=qCmU/fEeCWJHaMj/8W3mSGZlsDcBowDFwai2tzIJ1Lc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=ssTuYFihwc1Vbk8V3MGJU+ZPw9psYedP+tgliZG+9D31/KGZOl9aEpbOl8od/nFhD
	 pKBYlY4i0f92+lG75Px2yxtxHYCg4CjGlZCPnTPjF8MRHw8yxIXOQo02/FfK6xk/0F
	 t/dtWOLpA5PA4O6T/vSAtyY4zEoxygo2H8NGaVPA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 342C8F805B4; Tue, 19 Sep 2023 11:24:37 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 785E3F805AA;
	Tue, 19 Sep 2023 11:24:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A1631F8059F; Tue, 19 Sep 2023 11:24:30 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 3D3F6F801F5
	for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2023 11:24:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3D3F6F801F5
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=LKu7Mxiz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695115461; x=1726651461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qCmU/fEeCWJHaMj/8W3mSGZlsDcBowDFwai2tzIJ1Lc=;
  b=LKu7Mxiz0LYtiy5blYZ0fA6QEleraEa0oGSUGeL1jQonCtGODwnKIXje
   X+xrq/+oc27f6UwBrWS++043thZDvzQ4GYdm/ubYYvZeBDjnqN2Y1CJxV
   ncuTDtS1Nl8t1yfe2VBoAVPAP5q16neman2OzhsOn+yycL97qtVIG9OWM
   OmC3MxD33TNySHrS5NyAf5557T2EQEUSyxNvjlFah4EWppAcrIRU5mKoD
   7EmxYt0IfPJMsTdI12oM57hdKTxoxi9MWMY7/BJC4GxfMzZTDMRKY/xZx
   ZQVp2h8W73ENgF5+dQilpvxg8x9N3qlflUQzKvHWMZbIu2u+ML2R7HxUO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="377205191"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000";
   d="scan'208";a="377205191"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 02:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="861460225"
X-IronPort-AV: E=Sophos;i="6.02,159,1688454000";
   d="scan'208";a="861460225"
Received: from pzsolt-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.47.169])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Sep 2023 02:24:15 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	rander.wang@intel.com,
	guennadi.liakhovetski@linux.intel.com
Subject: [PATCH 3/9] ASoC: SOF: ipc4: add a helper function to search debug
 slot
Date: Tue, 19 Sep 2023 12:24:10 +0300
Message-ID: <20230919092416.4137-4-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230919092416.4137-1-peter.ujfalusi@linux.intel.com>
References: <20230919092416.4137-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: K4DEGYP4FJYQOCED4MDTI4K5O5S5CJM6
X-Message-ID-Hash: K4DEGYP4FJYQOCED4MDTI4K5O5S5CJM6
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/K4DEGYP4FJYQOCED4MDTI4K5O5S5CJM6/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Rander Wang <rander.wang@intel.com>

Currently IPC4 supports GDB slot, telemetry slot and
debug slot. This helper function will be used to get
the slot offset in debug windows for further processing.

Signed-off-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/sof/ipc4-priv.h |  3 +++
 sound/soc/sof/ipc4.c      | 23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/sound/soc/sof/ipc4-priv.h b/sound/soc/sof/ipc4-priv.h
index a5d0b2eae464..9e69b7c29117 100644
--- a/sound/soc/sof/ipc4-priv.h
+++ b/sound/soc/sof/ipc4-priv.h
@@ -120,4 +120,7 @@ void sof_ipc4_update_cpc_from_manifest(struct snd_sof_dev *sdev,
 				       struct sof_ipc4_fw_module *fw_module,
 				       struct sof_ipc4_base_module_cfg *basecfg);
 
+size_t sof_ipc4_find_debug_slot_offset_by_type(struct snd_sof_dev *sdev,
+					       u32 slot_type);
+
 #endif
diff --git a/sound/soc/sof/ipc4.c b/sound/soc/sof/ipc4.c
index 6c33ee5af32b..4673c53f6c03 100644
--- a/sound/soc/sof/ipc4.c
+++ b/sound/soc/sof/ipc4.c
@@ -547,6 +547,29 @@ static int sof_ipc4_init_msg_memory(struct snd_sof_dev *sdev)
 	return 0;
 }
 
+size_t sof_ipc4_find_debug_slot_offset_by_type(struct snd_sof_dev *sdev,
+					       u32 slot_type)
+{
+	size_t slot_desc_type_offset;
+	u32 type;
+	int i;
+
+	/* The type is the second u32 in the slot descriptor */
+	slot_desc_type_offset = sdev->debug_box.offset + sizeof(u32);
+	for (i = 0; i < SOF_IPC4_MAX_DEBUG_SLOTS; i++) {
+		sof_mailbox_read(sdev, slot_desc_type_offset, &type, sizeof(type));
+
+		if (type == slot_type)
+			return sdev->debug_box.offset + (i + 1) * SOF_IPC4_DEBUG_SLOT_SIZE;
+
+		slot_desc_type_offset += SOF_IPC4_DEBUG_DESCRIPTOR_SIZE;
+	}
+
+	dev_dbg(sdev->dev, "Slot type %#x is not available in debug window\n", slot_type);
+	return 0;
+}
+EXPORT_SYMBOL(sof_ipc4_find_debug_slot_offset_by_type);
+
 static int ipc4_fw_ready(struct snd_sof_dev *sdev, struct sof_ipc4_msg *ipc4_msg)
 {
 	int inbox_offset, inbox_size, outbox_offset, outbox_size;
-- 
2.42.0

