Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A78BC433E1
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:13:10 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC0EE20675
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 20:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jsSf7XY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC0EE20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4DE45169F;
	Thu, 13 Aug 2020 22:12:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4DE45169F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597349588;
	bh=tDKbOglIJ17pQD+ylT/U1x73+/vYJAkildFMvYUg8H0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=jsSf7XY7mYCOwJq2adX6sFWVFF4rzIccbIAevR23+P48YYMGTgedSLcCsTPK7rcyr
	 9kHhswzDve2xQ3oPT8PCB8JIBWzeCZ9EzNqG34EoLefZCzr32L6LqCNkT23ie22TVQ
	 /UVfobsnoIXYlFIurxUUCNEfxob51JRccUU5z+IY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 1F33FF8034F;
	Thu, 13 Aug 2020 22:02:46 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E966F80323; Thu, 13 Aug 2020 22:02:36 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9D0B9F802E1
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 22:02:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9D0B9F802E1
IronPort-SDR: YiKcT1iVZLU930Vdt65MNw0x/QxlIxLdIZ3bjR56igmlehjSU80itK73xxj9DV9BwsRd5vsNgE
 cq/ap2zgIKtQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="155430383"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="155430383"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:06 -0700
IronPort-SDR: auu3EK9r611htrPHty3rV/3GTeSkCesUuc/62cifmol3xcAfU4/lO4ye1b7rhRMh8duEVGlMRD
 crdvwZV1x6ZQ==
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="495506305"
Received: from jctorres-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.137.200])
 by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 13:02:04 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 10/21] ASoC: Intel: Atom: sst_pvt: simplify return handling
Date: Thu, 13 Aug 2020 15:01:36 -0500
Message-Id: <20200813200147.61990-11-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200813200147.61990-1-pierre-louis.bossart@linux.intel.com>
References: <20200813200147.61990-1-pierre-louis.bossart@linux.intel.com>
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

Fix cppcheck warning:

sound/soc/intel/atom/sst/sst_pvt.c:201:9: warning: Identical condition
and return expression 'retval', return value is always 0
[identicalConditionAfterEarlyExit]
 return retval;
        ^

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst/sst_pvt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_pvt.c b/sound/soc/intel/atom/sst/sst_pvt.c
index 3bd1bd3e43d6..c099f7df6168 100644
--- a/sound/soc/intel/atom/sst/sst_pvt.c
+++ b/sound/soc/intel/atom/sst/sst_pvt.c
@@ -198,7 +198,7 @@ int sst_create_block_and_ipc_msg(struct ipc_post **arg, bool large,
 		kfree(*arg);
 		return -ENOMEM;
 	}
-	return retval;
+	return 0;
 }
 
 /*
-- 
2.25.1

