Return-Path: <SRS0=oBF5=OG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDE2C433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 08:54:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D51AE61164
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Sep 2021 08:54:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D51AE61164
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3501F16BF;
	Thu, 16 Sep 2021 10:54:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3501F16BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631782491;
	bh=UiDz0MNzOo/7q3iob1rg/PJOuTddNWSLJKbSMFITP8A=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NGoRMcs025Rc8CyR2D4A1cOB1c23NhZl0JhzM6mHa52P/lmQOM165RiMmdNx5nHbT
	 AOlHOj1KvQptfr19A8YmuWxdBVHItH/dY/7ITsczLrsTIdwE7Dtt66GFXy82ZeM4KQ
	 p11Seov6WfA8w9PA8sfgErS9oQ9wX5oQwh0NXMM4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B9781F8025A;
	Thu, 16 Sep 2021 10:54:00 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6E590F80113; Thu, 16 Sep 2021 10:53:59 +0200 (CEST)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 89736F80113
 for <alsa-devel@alsa-project.org>; Thu, 16 Sep 2021 10:53:50 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 89736F80113
X-IronPort-AV: E=McAfee;i="6200,9189,10108"; a="202017681"
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; d="scan'208";a="202017681"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 01:53:46 -0700
X-IronPort-AV: E=Sophos;i="5.85,297,1624345200"; d="scan'208";a="472701002"
Received: from gkapusti-mobl.ccr.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.249.35.152])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2021 01:53:43 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com
Subject: [PATCH] ASoC: SOF: loader: Re-phrase the missing firmware error to
 avoid duplication
Date: Thu, 16 Sep 2021 11:53:42 +0300
Message-Id: <20210916085342.29993-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.33.0
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

In case the firmware is missing we will have the following in the kernel
log:

1 | Direct firmware load for intel/sof/sof-tgl-h.ri failed with error -2
2 | error: request firmware intel/sof/sof-tgl-h.ri failed err: -2
3 | you may need to download the firmware from https://github.com/thesofproject/sof-bin/
4 | error: failed to load DSP firmware -2
5 | error: sof_probe_work failed err: -2

The first line is the standard, request_firmware() warning.
The second and third line is printed in snd_sof_load_firmware_raw()
Note that the first and second line is mostly identical.

With this patch the log will be changed to:
1 | Direct firmware load for intel/sof/sof-tgl-h.ri failed with error -2
2 | error: sof firmware file is missing, you might need to
3 |        download it from https://github.com/thesofproject/sof-bin/
4 | error: failed to load DSP firmware -2
5 | error: sof_probe_work failed err: -2

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/loader.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/sof/loader.c b/sound/soc/sof/loader.c
index 2b38a77cd594..46f3900487ee 100644
--- a/sound/soc/sof/loader.c
+++ b/sound/soc/sof/loader.c
@@ -729,10 +729,10 @@ int snd_sof_load_firmware_raw(struct snd_sof_dev *sdev)
 	ret = request_firmware(&plat_data->fw, fw_filename, sdev->dev);
 
 	if (ret < 0) {
-		dev_err(sdev->dev, "error: request firmware %s failed err: %d\n",
-			fw_filename, ret);
 		dev_err(sdev->dev,
-			"you may need to download the firmware from https://github.com/thesofproject/sof-bin/\n");
+			"error: sof firmware file is missing, you might need to\n");
+		dev_err(sdev->dev,
+			"       download it from https://github.com/thesofproject/sof-bin/\n");
 		goto err;
 	} else {
 		dev_dbg(sdev->dev, "request_firmware %s successful\n",
-- 
2.33.0

