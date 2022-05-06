Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE49C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  6 May 2022 13:28:27 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 990A717F2;
	Fri,  6 May 2022 15:27:35 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 990A717F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651843705;
	bh=/n5ueKTd1X5snYFEwBDmgkQQR2X8QmPCGLPArljBqA8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ZY2fl4f6NIuW50HR30bN7CjlpiB+LficGzCVYc9kEeEOwJdIayYYd79CcXemuLR3g
	 o+4eSzc5T0nnA83sYZA6aEX92kukYDHamLa8dPnJT5AUJBPpNG47C+Ibcl0QUnjwk0
	 Hfzcb4omQwUKU6gEB7prw4Ub0gIbuak+LNSiDv5U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id ECAEAF80508;
	Fri,  6 May 2022 15:26:49 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 28A7CF800F0; Fri,  6 May 2022 15:26:48 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8357FF801D5
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2022 15:26:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8357FF801D5
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="OyiEIwkX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651843602; x=1683379602;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/n5ueKTd1X5snYFEwBDmgkQQR2X8QmPCGLPArljBqA8=;
 b=OyiEIwkXI+Gfaudr4sJvS9iVwR6qiyKsxYSPgM+/+cBEzrsHs44lGGbR
 Z/8Xv/d0FjhZaiy0k/39o4AM9YaBCMKQhy4nhSmuyHNSVJekm/rioPLBq
 xh7wfWjUnepZ95hiTZLRGKqsopFzdBBLNtLS1xgnKpDcsuv6FZo/wljfM
 i4BYppInZ+igV44Fa+CD+jD7d2OADilqy5umBsNnNx+DNy8oMmGk4rHG0
 DrCtkDAZ1erdQBiWB9qn42KQD04hhgJf4+/nVr+kGBodx0PfFKkc7UqrH
 GEOIO3F8rt2Gg1ENC0IVOZS8mchu6ZltvSxjuf363PnfvN5eylGlVvlJp w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="293672814"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293672814"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2022 06:26:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="585971597"
Received: from oelagadx-mobl2.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.61.230])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2022 06:26:36 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, yung-chuan.liao@linux.intel.com,
 rander.wang@intel.com
Subject: [PATCH 4/8] ASoC: SOF: sof-client: Add API to get the ipc_type
Date: Fri,  6 May 2022 16:26:43 +0300
Message-Id: <20220506132647.18690-5-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220506132647.18690-1-peter.ujfalusi@linux.intel.com>
References: <20220506132647.18690-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, daniel.baluta@nxp.com,
 ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com
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

Provide a way for the client drivers to query the ipc_type used by the
firmware.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/sof/sof-client.c | 8 ++++++++
 sound/soc/sof/sof-client.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/sound/soc/sof/sof-client.c b/sound/soc/sof/sof-client.c
index 18839a8a03c3..ce002815aa44 100644
--- a/sound/soc/sof/sof-client.c
+++ b/sound/soc/sof/sof-client.c
@@ -327,6 +327,14 @@ size_t sof_client_get_ipc_max_payload_size(struct sof_client_dev *cdev)
 }
 EXPORT_SYMBOL_NS_GPL(sof_client_get_ipc_max_payload_size, SND_SOC_SOF_CLIENT);
 
+enum sof_ipc_type sof_client_get_ipc_type(struct sof_client_dev *cdev)
+{
+	struct snd_sof_dev *sdev = sof_client_dev_to_sof_dev(cdev);
+
+	return sdev->pdata->ipc_type;
+}
+EXPORT_SYMBOL_NS_GPL(sof_client_get_ipc_type, SND_SOC_SOF_CLIENT);
+
 /* module refcount management of SOF core */
 int sof_client_core_module_get(struct sof_client_dev *cdev)
 {
diff --git a/sound/soc/sof/sof-client.h b/sound/soc/sof/sof-client.h
index 4b5787156775..46b215d9200f 100644
--- a/sound/soc/sof/sof-client.h
+++ b/sound/soc/sof/sof-client.h
@@ -42,6 +42,7 @@ struct dentry *sof_client_get_debugfs_root(struct sof_client_dev *cdev);
 struct device *sof_client_get_dma_dev(struct sof_client_dev *cdev);
 const struct sof_ipc_fw_version *sof_client_get_fw_version(struct sof_client_dev *cdev);
 size_t sof_client_get_ipc_max_payload_size(struct sof_client_dev *cdev);
+enum sof_ipc_type sof_client_get_ipc_type(struct sof_client_dev *cdev);
 
 /* module refcount management of SOF core */
 int sof_client_core_module_get(struct sof_client_dev *cdev);
-- 
2.36.0

