Return-Path: <SRS0=F1iH=ME=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3F3C07E99
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 20:17:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E486461248
	for <alsa-devel@archiver.kernel.org>; Mon, 12 Jul 2021 20:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E486461248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9E773169D;
	Mon, 12 Jul 2021 22:16:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9E773169D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626121062;
	bh=ZbljK3WmsrWP3Y61Owhekzy1wkFSh834LTu/tUhpnEk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=a+F5HjIMh0m2Dq4mkiFc69JfP+bM3+TN0jMNYYXE9HDQg/4YhycmWkvLAiklbOTkO
	 2lCY2UHnnxGxHKt7uczjeU9L9h9tTWhzsju6yAJYZqmYVOWKJW5eacnP/sM88yMPwM
	 sWGfWRmlGJ9OERAq4GEjldJrbuuy4rClZDfH+Uq8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 33937F8020C;
	Mon, 12 Jul 2021 22:16:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 72EB2F80254; Mon, 12 Jul 2021 22:16:50 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B5544F8020C
 for <alsa-devel@alsa-project.org>; Mon, 12 Jul 2021 22:16:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B5544F8020C
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="190430051"
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; d="scan'208";a="190430051"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2021 13:16:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,234,1620716400"; d="scan'208";a="412702117"
Received: from yangbosh-mobl3.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.95.167])
 by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2021 13:16:34 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: Intel: Update ADL descriptor to use ACPI power
 states
Date: Mon, 12 Jul 2021 15:16:20 -0500
Message-Id: <20210712201620.44311-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Sathya Prakash M R <sathya.prakash.m.r@intel.com>,
 broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

From: Sathya Prakash M R <sathya.prakash.m.r@intel.com>

The ADL descriptor was missing an ACPI power setting, causing the DSP
to enter D3 even with a D0i1-compatible wake-on-voice/hotwording
capture stream.

Fixes: 4ad03f894b3c ('ASoC: SOF: Intel: Update ADL P to use its own descriptor')
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Sathya Prakash M R <sathya.prakash.m.r@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/pci-tgl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/intel/pci-tgl.c b/sound/soc/sof/intel/pci-tgl.c
index a00262184efa..d04ce84fe7cc 100644
--- a/sound/soc/sof/intel/pci-tgl.c
+++ b/sound/soc/sof/intel/pci-tgl.c
@@ -89,6 +89,7 @@ static const struct sof_dev_desc adls_desc = {
 static const struct sof_dev_desc adl_desc = {
 	.machines               = snd_soc_acpi_intel_adl_machines,
 	.alt_machines           = snd_soc_acpi_intel_adl_sdw_machines,
+	.use_acpi_target_states = true,
 	.resindex_lpe_base      = 0,
 	.resindex_pcicfg_base   = -1,
 	.resindex_imr_base      = -1,
-- 
2.25.1

