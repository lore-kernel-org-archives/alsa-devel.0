Return-Path: <SRS0=G6+L=HV=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66380C433DB
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:10:35 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1195F64EAF
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Feb 2021 23:10:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1195F64EAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0B9C165D;
	Sat, 20 Feb 2021 00:09:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0B9C165D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1613776231;
	bh=Y5pUqL1KJzs01MQUF/9qMJppCkjP1xKx7ExrRzdsR/8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dhjJsmLPbYUEWXS/o1SHy3CSQ3srYnD1N89KCJzpBN7n6T8YBAc9h5JqFYXkMd0qI
	 EfE0VbrL/JJZZm/lQ0IAplHP6FCiuOIegI/10N6uUOh65heKD1yrQ+g2967kB5hHA/
	 ZtPg0yc0Yn+n2Qh4rlwQJupC14APTtKyjYQm7zxI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 30F2DF8026B;
	Sat, 20 Feb 2021 00:09:41 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 51CC8F800C7; Sat, 20 Feb 2021 00:09:39 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 369BEF800C7
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2021 00:09:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 369BEF800C7
IronPort-SDR: q/fw5tncXz8KeGKKSeVT+ppjvVjBHvY3mNISzGntjJ2IZtkHJdIojENvdZ8xxj/jd1XW8nzGlw
 XhFiNtuS0rGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9900"; a="163139050"
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="163139050"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:09:28 -0800
IronPort-SDR: GC61K1VU1Z8RVoUrPVdV/FVGyJ1nnZ5ejNYVVTZuDUbSowzw21tmQp8fFTgR0WvvWCPo3dsl+/
 DmsISDG+pkGQ==
X-IronPort-AV: E=Sophos;i="5.81,191,1610438400"; d="scan'208";a="365362844"
Received: from lkwerake-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.251.153.34])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Feb 2021 15:09:27 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/6] ASoC: samsung: remove cppcheck warnings
Date: Fri, 19 Feb 2021 17:09:12 -0600
Message-Id: <20210219230918.5058-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
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

No functional changes except for patch 2 and 3 where missing error
checks were added for consistency.

Pierre-Louis Bossart (6):
  ASoC: samsung: i2s: remove unassigned variable
  ASoC: samsung: s3c24xx_simtec: add missing error check
  ASoC: samsung: smdk_wm8994: add missing return
  ASoC: samsung: snow: remove useless test
  ASoC: samsung: tm2_wm5110: check of_parse return value
  ASoC: samsung: tm2_wm5510: remove shadowing variable

 sound/soc/samsung/i2s.c            | 3 +--
 sound/soc/samsung/s3c24xx_simtec.c | 5 +++++
 sound/soc/samsung/smdk_wm8994.c    | 1 +
 sound/soc/samsung/snow.c           | 5 +----
 sound/soc/samsung/tm2_wm5110.c     | 3 +--
 5 files changed, 9 insertions(+), 8 deletions(-)

-- 
2.25.1

