Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F27FDC433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  6 May 2022 13:30:01 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2A85A1705;
	Fri,  6 May 2022 15:29:10 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2A85A1705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1651843800;
	bh=WelG1cOSLJCohTRvLqWmqQGxEOibZNxF4DfVwNmPjTg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RMBK9JnbCR0hF34wAKVpMvkgoJV0C8GvPzJJbKOoAUL5kn5CnlUi9Xymes1IP1Kcm
	 97xuBfmoDSQ+25Em76PJMzWyfCP8SML0q2Xphj+s8b1fNZSYCr7p2YEAphUou7yOSI
	 L5EkN87qbCNoqcPXkZMa7taZmrjneHwsmoxkNfrg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4F474F80543;
	Fri,  6 May 2022 15:27:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6503CF80529; Fri,  6 May 2022 15:26:59 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5FDA9F8053B
 for <alsa-devel@alsa-project.org>; Fri,  6 May 2022 15:26:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5FDA9F8053B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ZH2noUHg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1651843615; x=1683379615;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WelG1cOSLJCohTRvLqWmqQGxEOibZNxF4DfVwNmPjTg=;
 b=ZH2noUHgGgBf8dVIEVAHCHANcCUZ+SGxvMi+nITNnWh4spd03aRgEcql
 F0y9IBSeQ5auwl2rC4j18I8a6UG3LjX6JUEFhQ/uAahLmWS+XucrMLXi/
 W9w6jEnLhpYVfGS5uBA3fVVm83a70ghIt3Nkly+gtXFT37KzS4A1j61oy
 EQ888ITdSit7iov6ePc23wnFwUxE6+pxGq2DyIUN/UKze2REJLD5WCz+G
 SUhr0s5FUjKIynXM8NK6JKC6ECFaUCoalkojv3dBOodw+ymcdxFks8g2a
 vbrwIeQ9TamWMeoFJ1CuBIBf/8U9QjpRn4p42laVVuLZRtZT7rcqgXwyU Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="293672844"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="293672844"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2022 06:26:51 -0700
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; d="scan'208";a="585971631"
Received: from oelagadx-mobl2.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.61.230])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2022 06:26:48 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, yung-chuan.liao@linux.intel.com,
 rander.wang@intel.com
Subject: [PATCH 8/8] ASoC: SOF: sof-client: IPC flood test can only work with
 SOF_IPC
Date: Fri,  6 May 2022 16:26:47 +0300
Message-Id: <20220506132647.18690-9-peter.ujfalusi@linux.intel.com>
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

Currently the ipc flood test is only supported with SOF_IPC.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/sof-client.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/sof/sof-client.c b/sound/soc/sof/sof-client.c
index a664e0eb81fe..16cca666bb85 100644
--- a/sound/soc/sof/sof-client.c
+++ b/sound/soc/sof/sof-client.c
@@ -73,6 +73,9 @@ static int sof_register_ipc_flood_test(struct snd_sof_dev *sdev)
 	int ret = 0;
 	int i;
 
+	if (sdev->pdata->ipc_type != SOF_IPC)
+		return 0;
+
 	for (i = 0; i < CONFIG_SND_SOC_SOF_DEBUG_IPC_FLOOD_TEST_NUM; i++) {
 		ret = sof_client_dev_register(sdev, "ipc_flood", i, NULL, 0);
 		if (ret < 0)
-- 
2.36.0

