Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63C5CC433EF
	for <alsa-devel@archiver.kernel.org>; Tue,  5 Jul 2022 16:12:24 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3708D9F6;
	Tue,  5 Jul 2022 18:11:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3708D9F6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657037542;
	bh=yoKSCm0Wqcpnljjt7Wuswbh2I5IXv4zoZfRChOAk8MQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XT0tRJzPwX+RODj0EU9KjX7jHrLCOwM6OvSjXHSMH3sXnCK4RQayf64Dz/jGQ5ULL
	 TcnOCXEGUDTffyaooxkjUCojC0JBU45UtW+f4zIoHfeaOrz9R1ApZ233JzaDVqJP8Y
	 YtSYottvEqINM1jSpeDo6YIaP9yTulX7IkRx30lw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C5745F800CB;
	Tue,  5 Jul 2022 18:11:31 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C4D40F80212; Tue,  5 Jul 2022 18:11:30 +0200 (CEST)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B3A15F800CB;
 Tue,  5 Jul 2022 18:11:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B3A15F800CB
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="fOOo1mwN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657037485; x=1688573485;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=yoKSCm0Wqcpnljjt7Wuswbh2I5IXv4zoZfRChOAk8MQ=;
 b=fOOo1mwN5Qe6VddHHXy6WI5TjCP+X9qf0pGHtcFa6rVBIm/qf2r42wbs
 5Vj38R7qj7yA/aRsdQkgabf3r2tcwI8LuR/7qX9tm8LurRW8sq5M8IXyl
 i4Txv+ZFzHzXsJ0BDoNxTOKm4UXehzrKssN5l4E99HJOanN8mrxEwlmBo
 HOqEtc8vf92VEeEHI0+WdmKezYROwAIxK5GryLq+UP34cQFfqA9IsfaKU
 NX75GwHQb7LBeBVHodC7qwEpFsEpHhbfagsUYb5R6mrzK5zaDjmW5Bwob
 dfcDr1RsNBp2/5UMuMzCxz90kpTqafC2D0OkHGNhMCGmIAHA81nFG3az2 w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="347375735"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; d="scan'208";a="347375735"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jul 2022 09:11:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; d="scan'208";a="919774183"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga005.fm.intel.com with ESMTP; 05 Jul 2022 09:11:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 1A9AC1A0; Tue,  5 Jul 2022 19:11:07 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] ASoC: SOF: Intel: bdw: remove duplicating driver data
 retrieval
Date: Tue,  5 Jul 2022 19:11:01 +0300
Message-Id: <20220705161102.76250-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
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

device_get_match_data() in ACPI case calls similar to acpi_match_device().
Hence there is no need to duplicate the call. Just assign what is in
the id->driver_data.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: moved desc assignment closer to its user (Péter)
 sound/soc/sof/intel/bdw.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index 26df780c702e..a446154f2803 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -681,11 +681,8 @@ static int sof_broadwell_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	desc = device_get_match_data(dev);
-	if (!desc)
-		return -ENODEV;
-
-	return sof_acpi_probe(pdev, device_get_match_data(dev));
+	desc = (const struct sof_dev_desc *)id->driver_data;
+	return sof_acpi_probe(pdev, desc);
 }
 
 /* acpi_driver definition */
-- 
2.35.1

