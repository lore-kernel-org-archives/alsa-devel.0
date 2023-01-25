Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3883C54E94
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Jan 2023 11:47:28 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4F3926C1;
	Wed, 25 Jan 2023 12:46:36 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4F3926C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1674647246;
	bh=HrWLH3RkIoLnKwfaYzw8Diqy88ii5s4oWOhs7J/YVrM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=AZ2isnHEWSkspqahbo8fvYZepaoM/bUyz9Csh0gc7V1aJjhgWlWiyeWWK12PQhkqs
	 OC463WdYDSJUzeax2o+gyas5l579z5LtA3DLpSKK3epHbuW5McviX2u5aRBxAUbBTT
	 6Jj/ScQNuAHKfcwBE1xQV4ef8YEjFwBASEAfZy8I=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 39A41F80539;
	Wed, 25 Jan 2023 12:46:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 02C9FF804C2; Wed, 25 Jan 2023 12:46:13 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8496DF800FB
 for <alsa-devel@alsa-project.org>; Wed, 25 Jan 2023 12:46:05 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8496DF800FB
Authentication-Results: alsa1.perex.cz; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=KMwraBU8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1674647166; x=1706183166;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=HrWLH3RkIoLnKwfaYzw8Diqy88ii5s4oWOhs7J/YVrM=;
 b=KMwraBU8WZiKDXn1GIsCpJJB9+eWRRLhFXDEqQlwkloRcqFt02UgGUic
 9q0zOi3LjqUWUDoc32HHvnUB1RKgL7APWU5K4owFRzZgWSON9ap5jMRbQ
 h+JPvcp5bULd1Av3qaaTZp/D98ZIY66RpTLBH2iy7STRCniwnT49mDZmr
 8W2VMKiUD4T8XGrBe+hl0aWrouh6XMENeyLiusxrlRmrm923N2P3QVwvi
 zF8S5HrAsOe6WL/LXFGq7oxx61teJgeVmJItf6FXprAB0DOj+TH79FbVp
 nzIFFlEBiXfqxOGk2T3DhTgiraUokNTvGFEa1EfDssbx8MsCL5P8JkK+2 w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="324234155"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; d="scan'208";a="324234155"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2023 03:46:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="612393924"
X-IronPort-AV: E=Sophos;i="5.97,245,1669104000"; d="scan'208";a="612393924"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
 by orsmga003.jf.intel.com with ESMTP; 25 Jan 2023 03:45:58 -0800
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Subject: [PATCH 01/11] ASoC: topology: Properly access value coming from
 topology file
Date: Wed, 25 Jan 2023 20:46:39 +0100
Message-Id: <20230125194649.3485731-2-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230125194649.3485731-1-amadeuszx.slawinski@linux.intel.com>
References: <20230125194649.3485731-1-amadeuszx.slawinski@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: alsa-devel@alsa-project.org
X-Mailman-Version: 2.1.29
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
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, alsa-devel@alsa-project.org,
 Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

When accessing values coming from topology, le32_to_cpu should be used.
One of recent commits missed that.

Fixes: 86e2d14b6d1a ("ASoC: topology: Add header payload_size verification")
Reviewed-by: Cezary Rojewski <cezary.rojewski@intel.com>
Signed-off-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/soc-topology.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index c3be24b2fac5..b9addbab2b3d 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -2404,7 +2404,7 @@ static int soc_valid_header(struct soc_tplg *tplg,
 		return -EINVAL;
 	}
 
-	if (soc_tplg_get_hdr_offset(tplg) + hdr->payload_size >= tplg->fw->size) {
+	if (soc_tplg_get_hdr_offset(tplg) + le32_to_cpu(hdr->payload_size) >= tplg->fw->size) {
 		dev_err(tplg->dev,
 			"ASoC: invalid header of type %d at offset %ld payload_size %d\n",
 			le32_to_cpu(hdr->type), soc_tplg_get_hdr_offset(tplg),
-- 
2.25.1

