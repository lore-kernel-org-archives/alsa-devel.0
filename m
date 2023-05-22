Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31401C77B75
	for <alsa-devel@archiver.kernel.org>; Mon, 22 May 2023 10:14:42 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 17C89851;
	Mon, 22 May 2023 12:13:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 17C89851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684750480;
	bh=GmkaTEQpIv58O/3zOsFQU/hrb0qqKH6PeHggopJSexQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Mtgs+kCDZsITmLwthT6k9nSQreH/3iAnAdWRvWtULfAR30tT1hyNOPAF9sNkZ5jkS
	 ZW+Vak/Uf/bwgP+Wq/ZQmWwKym4XzpI3caxez799vPu+6F58+4FKvh4mwtSe+n3Amp
	 REYQxrbwvUL7ui2GHCogZ9bHjpLZEzhgaKFMUfTo=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4D681F80589; Mon, 22 May 2023 12:12:43 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 8C43FF8057E;
	Mon, 22 May 2023 12:12:42 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0F13DF80557; Mon, 22 May 2023 12:12:36 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 9693EF8016A
	for <alsa-devel@alsa-project.org>; Mon, 22 May 2023 12:12:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9693EF8016A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MwxNBVeh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684750344; x=1716286344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GmkaTEQpIv58O/3zOsFQU/hrb0qqKH6PeHggopJSexQ=;
  b=MwxNBVehI8ussootaulrPJFY8XUP+6oEqI2xt9FYpm2NJQZXSYKDWGPF
   CRROcphRidspCGTNyQbGI825VC+DY61MhdrPRX4u+5BpDJDvO9PrRXAzl
   KfahaRSiYV00Z4/MaQvc1paFxMYQaL1tZOl4UUflsmtgKh1ZeZ/H7m7sA
   B4a+VJntMTFgo1JBfAr+NwHNTmTBGojrbyQv8pc+H1jK4H6UL6SN4GxTx
   ZKQDt2jxm3bmW2H9vu6iD/4+1W5IK6cX6hgzZx2iMPBBr7cSM12015q+5
   6r85RQLDdz6nt6If+RwSl2cPKS5msD4UezZjffFFP7vJ/GWPoVVzEjjBL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="350390661"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400";
   d="scan'208";a="350390661"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2023 03:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="736365227"
X-IronPort-AV: E=Sophos;i="6.00,184,1681196400";
   d="scan'208";a="736365227"
Received: from bbattach-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.220.157])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2023 03:12:19 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	pierre-louis.bossart@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	kai.vehmanen@linux.intel.com
Subject: [PATCH 2/5] ASoC: SOF: ipc4-loader: Save a pointer to fm_config in
 sof_ipc4_fw_module
Date: Mon, 22 May 2023 13:13:10 +0300
Message-Id: <20230522101313.12519-3-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522101313.12519-1-peter.ujfalusi@linux.intel.com>
References: <20230522101313.12519-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: 6DSVZQRAJUJOI6HKWMKYAQPPZRV4SZBD
X-Message-ID-Hash: 6DSVZQRAJUJOI6HKWMKYAQPPZRV4SZBD
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/6DSVZQRAJUJOI6HKWMKYAQPPZRV4SZBD/>
List-Archive: <>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Save a pointer to the firmware module configuration area in
sof_ipc4_fw_module struct for later use.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/ipc4-loader.c | 1 +
 sound/soc/sof/ipc4-priv.h   | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/sound/soc/sof/ipc4-loader.c b/sound/soc/sof/ipc4-loader.c
index bb215d33d455..3860d3455960 100644
--- a/sound/soc/sof/ipc4-loader.c
+++ b/sound/soc/sof/ipc4-loader.c
@@ -112,6 +112,7 @@ static ssize_t sof_ipc4_fw_parse_ext_man(struct snd_sof_dev *sdev,
 				return -EINVAL;
 			}
 
+			fw_module->fw_mod_cfg = &fm_config[fm_entry->cfg_offset];
 
 			dev_dbg(sdev->dev,
 				"module %s: UUID %pUL cfg_count: %u, bss_size: %#x\n",
diff --git a/sound/soc/sof/ipc4-priv.h b/sound/soc/sof/ipc4-priv.h
index 546e52746276..4b3495dc455d 100644
--- a/sound/soc/sof/ipc4-priv.h
+++ b/sound/soc/sof/ipc4-priv.h
@@ -28,11 +28,13 @@ enum sof_ipc4_mtrace_type {
 /**
  * struct sof_ipc4_fw_module - IPC4 module info
  * @sof_man4_module: Module info
+ * @fw_mod_cfg: Pointer to the module config start of the module
  * @m_ida: Module instance identifier
  * @private: Module private data
  */
 struct sof_ipc4_fw_module {
 	struct sof_man4_module man4_module_entry;
+	const struct sof_man4_module_config *fw_mod_cfg;
 	struct ida m_ida;
 	void *private;
 };
-- 
2.40.1

