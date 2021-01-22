Return-Path: <SRS0=81m9=GZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D7E1C433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 07:09:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80ED62376F
	for <alsa-devel@archiver.kernel.org>; Fri, 22 Jan 2021 07:09:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80ED62376F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id ADB301AA0;
	Fri, 22 Jan 2021 08:08:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz ADB301AA0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611299377;
	bh=jVDr8fLhWq8DVW81JyycY3mpY0LWpghv3/pBrF+8Hos=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=upIZJu2Ia5e/YzF/broZHbPee8xUivog+ZFbpUwK1UBoJka/Bz7Ekqr+pY4L0XW/k
	 +IozpfawvGxKalwRwSzfDdMIa2rwyA0MWKQzMaFhG22Kg19SxWsg3rTeqvWrUy7Pep
	 5lmKo7BAJSGNoShTwzWCMiPKI+ZVxtYeL2UJPGzE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BAFEBF804E6;
	Fri, 22 Jan 2021 08:07:03 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B5D09F804E4; Fri, 22 Jan 2021 08:06:59 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0D5E3F80164
 for <alsa-devel@alsa-project.org>; Fri, 22 Jan 2021 08:06:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0D5E3F80164
IronPort-SDR: 1+e/Z1Cn6G5Rwk5BmItDog/KGNqUwp3Fypuk7i6vdDGYrYtnHCaQ+pCGUH0ej0eR/6M0GZyv5g
 r6D/BPCOf5bw==
X-IronPort-AV: E=McAfee;i="6000,8403,9871"; a="158581067"
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; d="scan'208";a="158581067"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2021 23:06:54 -0800
IronPort-SDR: Oeh/QRjA2eDPsg2muUAmtHWmp9PQVsDibK4/sgcscq85QyGlW+CoDr4jfHkYHzM7eV0FsvytD7
 zxLn7XSlb0GQ==
X-IronPort-AV: E=Sophos;i="5.79,366,1602572400"; d="scan'208";a="427863709"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Jan 2021 23:06:51 -0800
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [RESEND PATCH v2 6/9] regmap: sdw: use no_pm routines for SoundWire
 1.2 MBQ
Date: Fri, 22 Jan 2021 15:06:31 +0800
Message-Id: <20210122070634.12825-7-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
References: <20210122070634.12825-1-yung-chuan.liao@linux.intel.com>
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, sanyog.r.kale@intel.com,
 rander.wang@linux.intel.com, bard.liao@intel.com
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

Use no_pm versions for write and read.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
---
 drivers/base/regmap/regmap-sdw-mbq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/regmap/regmap-sdw-mbq.c b/drivers/base/regmap/regmap-sdw-mbq.c
index 8ce30650b97c..6675c3a4b829 100644
--- a/drivers/base/regmap/regmap-sdw-mbq.c
+++ b/drivers/base/regmap/regmap-sdw-mbq.c
@@ -15,11 +15,11 @@ static int regmap_sdw_mbq_write(void *context, unsigned int reg, unsigned int va
 	struct sdw_slave *slave = dev_to_sdw_dev(dev);
 	int ret;
 
-	ret = sdw_write(slave, SDW_SDCA_MBQ_CTL(reg), (val >> 8) & 0xff);
+	ret = sdw_write_no_pm(slave, SDW_SDCA_MBQ_CTL(reg), (val >> 8) & 0xff);
 	if (ret < 0)
 		return ret;
 
-	return sdw_write(slave, reg, val & 0xff);
+	return sdw_write_no_pm(slave, reg, val & 0xff);
 }
 
 static int regmap_sdw_mbq_read(void *context, unsigned int reg, unsigned int *val)
@@ -29,11 +29,11 @@ static int regmap_sdw_mbq_read(void *context, unsigned int reg, unsigned int *va
 	int read0;
 	int read1;
 
-	read0 = sdw_read(slave, reg);
+	read0 = sdw_read_no_pm(slave, reg);
 	if (read0 < 0)
 		return read0;
 
-	read1 = sdw_read(slave, SDW_SDCA_MBQ_CTL(reg));
+	read1 = sdw_read_no_pm(slave, SDW_SDCA_MBQ_CTL(reg));
 	if (read1 < 0)
 		return read1;
 
-- 
2.17.1

