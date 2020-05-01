Return-Path: <SRS0=J9ZO=6P=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B609C47256
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 23:45:40 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A563421835
	for <alsa-devel@archiver.kernel.org>; Fri,  1 May 2020 23:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="NJvEbFpK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A563421835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBA0D16AB;
	Sat,  2 May 2020 01:44:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBA0D16AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588376738;
	bh=XgROWD3iJAjCiyXnfTTw3hBCm7Q6t0uhvrgQZbpU0xs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=NJvEbFpKiZbRBrf56xJjOMTOd1pBfqzSvMFU5HUEG1QEGmdzfSAN/A8J9bOtuVgPD
	 +1wCuumSyJMF2CzVrSfRdxXdj2+pan5Qa5dDFOjePXAXdLXwzZiql4y5IHnJ9dDVE9
	 3+UWUgHzdBLvzpVTFRgEGnan86VMI+UXc2SIr4sQ=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 619DEF80217;
	Sat,  2 May 2020 01:44:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id B9D67F8022B; Sat,  2 May 2020 01:44:44 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6C505F800B9
 for <alsa-devel@alsa-project.org>; Sat,  2 May 2020 01:44:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6C505F800B9
IronPort-SDR: r+m+U/qrQaiCeJuxtOy5o/NnQwXxfGWx1gB0regwzFhl2rCHoWXEWLoJDnRAujLUWgiSTADWtf
 p0W0X9aTpM4g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 May 2020 16:44:32 -0700
IronPort-SDR: OcdzdGaXwWBDIufava1jq7XtC1gJcQEHN8SEDdua+PupagMtBWSAg19wuOd0wrTJuFDPpx8px5
 YOywxjywsHUw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,342,1583222400"; d="scan'208";a="368571867"
Received: from aberkov1-mobl.amr.corp.intel.com (HELO
 yzhi-desktop.amr.corp.intel.com) ([10.255.228.218])
 by fmsmga001.fm.intel.com with ESMTP; 01 May 2020 16:44:31 -0700
From: Yong Zhi <yong.zhi@intel.com>
To: broonie@kernel.org,
	pierre-louis.bossart@linux.intel.com
Subject: [PATCH] ASoC: max98373: reorder max98373_reset() in resume
Date: Fri,  1 May 2020 18:44:21 -0500
Message-Id: <1588376661-29799-1-git-send-email-yong.zhi@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: alsa-devel@alsa-project.org, Yong Zhi <yong.zhi@intel.com>
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

During S3 test, the following error was observed:

[ 726.174237] i2c_designware i2c_designware.0: platform_pm_resume+0x0/0x3d returned 0 after 0 usecs
[ 726.184187] max98373 i2c-MX98373:00: calling max98373_resume+0x0/0x30 [snd_soc_max98373] @ 12698, parent: i2c-11
[ 726.195589] max98373 i2c-MX98373:00: Reset command failed. (ret:-16)

When calling regmap_update_bits(), since map->reg_update_bits is NULL,
_regmap_read() is entered with the following logic:

	if (!map->cache_bypass) {
		ret = regcache_read(map, reg, val);
		if (ret == 0)
			return 0;
	}

	if (map->cache_only)
		return -EBUSY;

regcache_read() hits -EINVAL because MAX98373_R2000_SW_RESET is volatile,
as map->cache_only is set by codec suspend, thus -EBUSY is returned.
Fix by moving max98373_reset() after cache_only set to false in max98373_resume().

Signed-off-by: Yong Zhi <yong.zhi@intel.com>
---
 sound/soc/codecs/max98373.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98373.c b/sound/soc/codecs/max98373.c
index cae1def8902d..96718e3a1ad0 100644
--- a/sound/soc/codecs/max98373.c
+++ b/sound/soc/codecs/max98373.c
@@ -850,8 +850,8 @@ static int max98373_resume(struct device *dev)
 {
 	struct max98373_priv *max98373 = dev_get_drvdata(dev);
 
-	max98373_reset(max98373, dev);
 	regcache_cache_only(max98373->regmap, false);
+	max98373_reset(max98373, dev);
 	regcache_sync(max98373->regmap);
 	return 0;
 }
-- 
2.7.4

