Return-Path: <SRS0=vE6Q=M3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32785C4338F
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Aug 2021 19:26:17 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0140A61002
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Aug 2021 19:26:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0140A61002
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 988D91688;
	Wed,  4 Aug 2021 21:25:23 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 988D91688
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628105173;
	bh=jwmDyiyLkcJ7hjVrVkdtT1GMaK0z4HJuT1UmgGPq20Y=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=gbmbXDSSEB4fWMKa5DZneQaLCtrA+RyXaKcGktH+oObTWgCFnD3/neE+mmTmu4K6c
	 L0hQYznvP/9gC1akVJkErxXM3wiUa36dljS+xhMU2WQZCOGIAMKKiwQNJMy9ArAvnB
	 WQfnCR4agCnNrdoWb+nRmnN5xjNZxoCJ1Ujcy7yg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 271EEF8026A;
	Wed,  4 Aug 2021 21:25:23 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 599F5F8025F; Wed,  4 Aug 2021 21:25:20 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 85E05F8010A
 for <alsa-devel@alsa-project.org>; Wed,  4 Aug 2021 21:25:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 85E05F8010A
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="235952801"
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; d="scan'208";a="235952801"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2021 12:25:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,295,1620716400"; d="scan'208";a="569142444"
Received: from ccho-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.189.253])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2021 12:25:09 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/3] ASoC: codecs: cppcheck warnings
Date: Wed,  4 Aug 2021 14:24:53 -0500
Message-Id: <20210804192456.278702-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
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

Two minor corrections for return values, and one more important one
for max98090 where duplicate reads don't seem necessary.

Pierre-Louis Bossart (3):
  ASoC: max98090: remove duplicate status reads and useless assignmment
  ASoC: mt6359-accdet.c: remove useless assignments
  ASoC: wcd938x: simplify return value

 sound/soc/codecs/max98090.c      | 4 +---
 sound/soc/codecs/mt6359-accdet.c | 8 ++++----
 sound/soc/codecs/wcd938x.c       | 2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

-- 
2.25.1

