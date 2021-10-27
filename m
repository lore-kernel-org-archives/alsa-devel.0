Return-Path: <SRS0=Z19R=PP=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52625C433F5
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 02:20:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97CDA60F90
	for <alsa-devel@archiver.kernel.org>; Wed, 27 Oct 2021 02:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97CDA60F90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DAB2E16D7;
	Wed, 27 Oct 2021 04:19:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DAB2E16D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1635301236;
	bh=2SSVGlonMseDnczzQXz8nP1HtBVDKFgHx8UyCPP3M6g=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ji4gbqKxFxgCvrDjcEnPRurdO7UIkAwoRAEls2kmOREXiTiveKJH4UvdWe3IjFB1a
	 brPzc6Vfy8L5XGCs3zQngyfZiDtxV3PdmCQwI3J7umBbAAl889LtbwGjP/cP1BNM6y
	 Vh8FZFh5FqEbXvBUwSc1ffeukdOxLlzOqoDRWuqA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id B16B8F8025E;
	Wed, 27 Oct 2021 04:19:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 029F2F8049C; Wed, 27 Oct 2021 04:18:51 +0200 (CEST)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C573FF8010A
 for <alsa-devel@alsa-project.org>; Wed, 27 Oct 2021 04:18:44 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C573FF8010A
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="217229385"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; d="scan'208";a="217229385"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 19:18:40 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; d="scan'208";a="486446260"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Oct 2021 19:18:37 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH 01/10] ASoC: intel: sof_sdw: return the original error number
Date: Wed, 27 Oct 2021 10:18:15 +0800
Message-Id: <20211027021824.24776-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211027021824.24776-1-yung-chuan.liao@linux.intel.com>
References: <20211027021824.24776-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 bard.liao@intel.com
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

We don't want to convert create_sdw_dailink()'s return value to -ENOMEM.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index f10496206cee..a1fb41136cf0 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -1134,7 +1134,7 @@ static int sof_card_dai_links_create(struct device *dev,
 					 &ignore_pch_dmic);
 		if (ret < 0) {
 			dev_err(dev, "failed to create dai link %d", be_id);
-			return -ENOMEM;
+			return ret;
 		}
 	}
 
-- 
2.17.1

