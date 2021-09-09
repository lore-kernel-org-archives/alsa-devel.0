Return-Path: <SRS0=Rqaf=N7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54791C433FE
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 11:47:08 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDC26187C
	for <alsa-devel@archiver.kernel.org>; Thu,  9 Sep 2021 11:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CDDC26187C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 25E3616B5;
	Thu,  9 Sep 2021 13:46:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 25E3616B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1631188026;
	bh=9foygNpkQDwOr2qCWW90C35W1j1hFTBdaVPZhzHL2Es=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=fPS5jPGMoCKtl+yvJaeIuoduOfv+YTbJRYadHPVQwDEmjwEWmxR3XEgE5og8vx4d2
	 eFkkKJcaFFXH/drEAjNd6fl9YvL8Q8pN1nO56GDoEFdrpuLiwTjjwpHnMZcrUYSx4p
	 5uuinidtZbYquHNcoiGt6Rd6Vz5tv9746bTv8vkw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6AFCDF804F2;
	Thu,  9 Sep 2021 13:45:39 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 16379F804E6; Thu,  9 Sep 2021 13:45:36 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E148BF80166
 for <alsa-devel@alsa-project.org>; Thu,  9 Sep 2021 13:45:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E148BF80166
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.b="QOAUrWWn"
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8111613AB;
 Thu,  9 Sep 2021 11:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631187928;
 bh=9foygNpkQDwOr2qCWW90C35W1j1hFTBdaVPZhzHL2Es=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=QOAUrWWn4wp3bpgrybbgUKkgAP9bCjYqwemN9l3srp5BRhc2lj+U+h8qjJrKihXiA
 uTm9xu5NLfr5LyQknNVew2frLVps3QD9x7T2jOzEoJwSTe/Yljwtv4HLJ2XLFMgO8w
 F7PX31DMcmQBdakM9SJXnzssxtxndCms36bm25I16+AHiZY7TaAaUwrea6HavZx3Y8
 aYjJTYdYZvCeZXaKf7kgkVZ7BQeyVvwbM435FSDhyVDfpnh9SqO/4IfFEeYZcVjRpz
 TZmeHYmv8w9r2ePb/SKLOz3SWW6NoqLG4vYg99X/2D35UUoWImqI9FJm7DTuUGUo+D
 GOACj5aAz06vg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.14 201/252] ASoC: Intel: Skylake: Fix passing
 loadable flag for module
Date: Thu,  9 Sep 2021 07:40:15 -0400
Message-Id: <20210909114106.141462-201-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210909114106.141462-1-sashal@kernel.org>
References: <20210909114106.141462-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Cc: Sasha Levin <sashal@kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, Lukasz Majczak <lma@semihalf.com>
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

From: Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>

[ Upstream commit c5ed9c547cba1dc1238c6e8a0c290fd62ee6e127 ]

skl_get_module_info() tries to set mconfig->module->loadable before
mconfig->module has been assigned thus flag was always set to false
and driver did not try to load module binaries.

Signed-off-by: Gustaw Lewandowski <gustaw.lewandowski@linux.intel.com>
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Tested-by: Lukasz Majczak <lma@semihalf.com>
Link: https://lore.kernel.org/r/20210818075742.1515155-7-cezary.rojewski@intel.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/intel/skylake/skl-pcm.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index b1ca64d2f7ea..031d5dc7e660 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -1317,21 +1317,6 @@ static int skl_get_module_info(struct skl_dev *skl,
 		return -EIO;
 	}
 
-	list_for_each_entry(module, &skl->uuid_list, list) {
-		if (guid_equal(uuid_mod, &module->uuid)) {
-			mconfig->id.module_id = module->id;
-			if (mconfig->module)
-				mconfig->module->loadable = module->is_loadable;
-			ret = 0;
-			break;
-		}
-	}
-
-	if (ret)
-		return ret;
-
-	uuid_mod = &module->uuid;
-	ret = -EIO;
 	for (i = 0; i < skl->nr_modules; i++) {
 		skl_module = skl->modules[i];
 		uuid_tplg = &skl_module->uuid;
@@ -1341,10 +1326,18 @@ static int skl_get_module_info(struct skl_dev *skl,
 			break;
 		}
 	}
+
 	if (skl->nr_modules && ret)
 		return ret;
 
+	ret = -EIO;
 	list_for_each_entry(module, &skl->uuid_list, list) {
+		if (guid_equal(uuid_mod, &module->uuid)) {
+			mconfig->id.module_id = module->id;
+			mconfig->module->loadable = module->is_loadable;
+			ret = 0;
+		}
+
 		for (i = 0; i < MAX_IN_QUEUE; i++) {
 			pin_id = &mconfig->m_in_pin[i].id;
 			if (guid_equal(&pin_id->mod_uuid, &module->uuid))
@@ -1358,7 +1351,7 @@ static int skl_get_module_info(struct skl_dev *skl,
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 static int skl_populate_modules(struct skl_dev *skl)
-- 
2.30.2

