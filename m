Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAC4C4167B
	for <alsa-devel@archiver.kernel.org>; Wed, 29 Nov 2023 12:55:20 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52C8EE75;
	Wed, 29 Nov 2023 13:55:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52C8EE75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701262519;
	bh=fHREn2IODvN5vXs5e4ohVj9Yrc5o/eFDFzSVB5NMoDs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=bSiB/m8vYPfgEI5lDMwFmmUIJdnznld97gJYc1xwlmz9pajg77b6v1foADsf8OcL7
	 aF+/mZwu7BDSs2YvTW97bTetnWv0dvit/WortcU1KBtBqh045ZrlJa2ZMLSl9zZYJZ
	 ognWHNJ5OGmuJkOfBaD+JcGpH9ib1wRXHXI7L5KA=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id B2497F806B6; Wed, 29 Nov 2023 13:53:30 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 21BDAF8068C;
	Wed, 29 Nov 2023 13:53:29 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 68AB1F80567; Wed, 29 Nov 2023 13:53:19 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4A7D8F805F8
	for <alsa-devel@alsa-project.org>; Wed, 29 Nov 2023 13:53:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A7D8F805F8
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Nhn3UbDi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701262396; x=1732798396;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fHREn2IODvN5vXs5e4ohVj9Yrc5o/eFDFzSVB5NMoDs=;
  b=Nhn3UbDiESz+aGIw+rwJTu1DS+g/LN89BsZPBNXCe6dRinYWMYW4wHU5
   DYsVBhfI/+2AFFy1839gnvuahA1A6rhOE/2/qR9GoCSXLXIL96ZPJE0VO
   MDecXwxJAJXGY+042EVZxlFs36mDHglKaErR/9fqDJHKZf4s3WJ5W97SI
   P00NJrHLx/i7o7uEQ1oiUCsrEeK39+3k8EzOdMlJuDoeQi9mOIkwMotmI
   1nFMi1PwtAv9cCToG2vF4Tkx0KjZ9vZOzXZgY2X2xDrQbaoJKu8L5WLVV
   Yev6g86/Z+vkCAxpVl1T0HiobyLd1Wa9ZfBvUMn8UVgGnJNjfJndDT13j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10908"; a="392022953"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600";
   d="scan'208";a="392022953"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 04:53:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600";
   d="scan'208";a="17174645"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.44.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Nov 2023 04:53:11 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com
Subject: [PATCH 09/13] ASoC: SOF: sof-of-dev: Rely on core to create the file
 paths
Date: Wed, 29 Nov 2023 14:53:23 +0200
Message-ID: <20231129125327.23708-10-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129125327.23708-1-peter.ujfalusi@linux.intel.com>
References: <20231129125327.23708-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: TPDJLLBRTUDMTPJFFTTCBF4OJ2LNU2PX
X-Message-ID-Hash: TPDJLLBRTUDMTPJFFTTCBF4OJ2LNU2PX
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/TPDJLLBRTUDMTPJFFTTCBF4OJ2LNU2PX/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

The core is now using the information from ipc_file_profile_base to create
the paths for the loadable files, no need to set it in here anymore.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/sof-of-dev.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/sound/soc/sof/sof-of-dev.c b/sound/soc/sof/sof-of-dev.c
index 7b58f45790f7..fa92da5ee9b3 100644
--- a/sound/soc/sof/sof-of-dev.c
+++ b/sound/soc/sof/sof-of-dev.c
@@ -87,17 +87,6 @@ int sof_of_probe(struct platform_device *pdev)
 
 	sof_pdata->desc = desc;
 	sof_pdata->dev = &pdev->dev;
-	sof_pdata->fw_filename = desc->default_fw_filename[SOF_IPC_TYPE_3];
-
-	if (fw_path)
-		sof_pdata->fw_filename_prefix = fw_path;
-	else
-		sof_pdata->fw_filename_prefix = desc->default_fw_path[SOF_IPC_TYPE_3];
-
-	if (tplg_path)
-		sof_pdata->tplg_filename_prefix = tplg_path;
-	else
-		sof_pdata->tplg_filename_prefix = desc->default_tplg_path[SOF_IPC_TYPE_3];
 
 	sof_pdata->ipc_file_profile_base.ipc_type = desc->ipc_default;
 	sof_pdata->ipc_file_profile_base.fw_path = fw_path;
-- 
2.43.0

