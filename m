Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEDFCC433F5
	for <alsa-devel@archiver.kernel.org>; Mon,  9 May 2022 18:58:45 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C516A16C8;
	Mon,  9 May 2022 20:57:53 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C516A16C8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1652122723;
	bh=BQmdy4euCVu84oLWGyIOABUrNN0LpGizFTgwvqUNuLA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=SVnQaVXw5Rb5D0OzqSR89MpwkDkfdvGd1NETDyKM0DCe1A8uXrVgl261fv4hi6UQi
	 9wrKD/6a2gtW232WKWx3JY51L8On3/M9CBGf1aUgd+WmeOUaq6fuOiL3kiNuGzlVz3
	 c+0pzcMBCVIWBE/4Q2YS1rgBbVajJF2cqkGK4NTM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5AEF0F80237;
	Mon,  9 May 2022 20:57:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 9E20AF8025D; Mon,  9 May 2022 20:57:51 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0CD5F8011C
 for <alsa-devel@alsa-project.org>; Mon,  9 May 2022 20:57:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A0CD5F8011C
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="fGnrMi7x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1652122665; x=1683658665;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BQmdy4euCVu84oLWGyIOABUrNN0LpGizFTgwvqUNuLA=;
 b=fGnrMi7xJpzYXSo6Hq83BZKZ4TD/LPxF5NOA3BogPxYNKGL97tHl2XN6
 vCL8bmEyyF50DMiuYo0vIQwurVJErLzICQB9pFVNWt9U7cbdGqZX5OaFO
 FgYfRoYc0pqr8/lt1i23TQ8wvjHCVd13WcuNrxlj5gQmUNhvtnQnYVxZX
 9jX/fQCgK1PxSQ1SUkLyhZASDvNBVwR2uX2Q/TIb3/KK6A0E+XUlY+cyD
 G+DMjKcavQdtmDymu86+KlNP5kXaU49LDmvTduE82ZTHy/Mb/AUtqnIB5
 SyDGef42z79UeCApHUyTtaI/Xriux6ZyH/8hMonn4i1ymLPQhpKKnBXsq w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="355569847"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; d="scan'208";a="355569847"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 11:57:39 -0700
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; d="scan'208";a="894493722"
Received: from djmuller-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.212.167.174])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 May 2022 11:57:39 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: codecs: rt715-sdca: remove useless assignment of ops
Date: Mon,  9 May 2022 13:57:29 -0500
Message-Id: <20220509185729.59884-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
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

The ops are already part of the 'struct sdw_driver', it's unclear why
this was copied into the 'slave' structure - no other driver does so.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt715-sdca-sdw.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/rt715-sdca-sdw.c b/sound/soc/codecs/rt715-sdca-sdw.c
index a5c673f43d824..0ecd2948f7aa7 100644
--- a/sound/soc/codecs/rt715-sdca-sdw.c
+++ b/sound/soc/codecs/rt715-sdca-sdw.c
@@ -181,8 +181,6 @@ static int rt715_sdca_sdw_probe(struct sdw_slave *slave,
 {
 	struct regmap *mbq_regmap, *regmap;
 
-	slave->ops = &rt715_sdca_slave_ops;
-
 	/* Regmap Initialization */
 	mbq_regmap = devm_regmap_init_sdw_mbq(slave, &rt715_sdca_mbq_regmap);
 	if (IS_ERR(mbq_regmap))
-- 
2.30.2

