Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F0EC43334
	for <alsa-devel@archiver.kernel.org>; Fri, 15 Jul 2022 14:54:47 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2B94B192D;
	Fri, 15 Jul 2022 16:53:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2B94B192D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1657896886;
	bh=iaVrR2piguo/eMlHWHaMQEe3I0BntK7f3avJT/COjNg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gky6AetoMBCckY5fxRLu0B4BMSrgNav6sleMZC60mHv/gV4T3esLw9oNSVNq52vHC
	 H2FkTyiKqqhwn5NBqLLBeqg64NBxbbETpTltex7yAog2ssV4H+qPcpl+LWhIoRIN+H
	 zLeFbQCgOalP+akZw3K0j5jYoXMA7egIG+pFKE4A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 453D4F804B2;
	Fri, 15 Jul 2022 16:53:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 6EEECF8055A; Fri, 15 Jul 2022 16:53:05 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0A81BF80542
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2022 16:52:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0A81BF80542
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="dO7Lg7ag"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1657896777; x=1689432777;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iaVrR2piguo/eMlHWHaMQEe3I0BntK7f3avJT/COjNg=;
 b=dO7Lg7ag0eTlzpVJ40kzd7hW/1tfyEkEu1VQJkaDFCAN2MTRktdJlXzY
 uHjYhmR8o1u9nOgxCGG2CN3RJyGm1zjlwnQnmAkUr9tYmOkmYs8eZarIB
 aFusgTEnL7NVdKHS16LUQ6jd/AGtyB2zB9uvlTiGCgGhKWex5g1QSDRIk
 XhgtzfLNfSaa/NGLY7MDlPRCkQ6WIc+7wCHkGHb+m84jXQQBR7hj0hXm8
 hnddbxsjvvywxahDOEdB1Ta1X2FLaATXEqfOPyK/838T76ZYN3spBH3Wy
 SlSbmI7Arnu2QsLnhhnaIFFB6ycdPSxrE9gTky/cd06NO6yReKNM3Q0XM Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="311476912"
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; d="scan'208";a="311476912"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2022 07:52:34 -0700
X-IronPort-AV: E=Sophos;i="5.92,274,1650956400"; d="scan'208";a="923533123"
Received: from jmurope-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.212.14.184])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jul 2022 07:52:33 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 06/11] ASoC: SOF: ipc3-loader: Print out the non matching
 ext_man magic number
Date: Fri, 15 Jul 2022 09:52:11 -0500
Message-Id: <20220715145216.277003-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220715145216.277003-1-pierre-louis.bossart@linux.intel.com>
References: <20220715145216.277003-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Print out the found extended manifest magic number in case it is not
matching with the expected one (0x6e614d58) in debug level.
It is fairly unlikely that the firmware does not have ext_man section and
the found value in place of the magic number can help rootcausing boot
related issues.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/ipc3-loader.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/ipc3-loader.c b/sound/soc/sof/ipc3-loader.c
index c573e7593808..bf423ca4e97b 100644
--- a/sound/soc/sof/ipc3-loader.c
+++ b/sound/soc/sof/ipc3-loader.c
@@ -109,7 +109,7 @@ static int ipc3_fw_ext_man_get_config_data(struct snd_sof_dev *sdev,
 	return 0;
 }
 
-static ssize_t ipc3_fw_ext_man_size(const struct firmware *fw)
+static ssize_t ipc3_fw_ext_man_size(struct snd_sof_dev *sdev, const struct firmware *fw)
 {
 	const struct sof_ext_man_header *head;
 
@@ -131,6 +131,8 @@ static ssize_t ipc3_fw_ext_man_size(const struct firmware *fw)
 		return head->full_size;
 
 	/* otherwise given fw don't have an extended manifest */
+	dev_dbg(sdev->dev, "Unexpected extended manifest magic number: %#x\n",
+		head->magic);
 	return 0;
 }
 
@@ -147,7 +149,7 @@ static size_t sof_ipc3_fw_parse_ext_man(struct snd_sof_dev *sdev)
 
 	head = (struct sof_ext_man_header *)fw->data;
 	remaining = head->full_size - head->header_size;
-	ext_man_size = ipc3_fw_ext_man_size(fw);
+	ext_man_size = ipc3_fw_ext_man_size(sdev, fw);
 
 	/* Assert firmware starts with extended manifest */
 	if (ext_man_size <= 0)
-- 
2.34.1

