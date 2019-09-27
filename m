Return-Path: <SRS0=P2CN=XW=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB7CC4360C
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:16:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F9420665
	for <alsa-devel@archiver.kernel.org>; Fri, 27 Sep 2019 20:16:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="MdK6IgMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F9420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 36125166C;
	Fri, 27 Sep 2019 22:15:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 36125166C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1569615401;
	bh=r3BBa/RAOwaZwDR2HFaoeoVIwZEvcoKzBHd6eWRjtbU=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=MdK6IgMyFGnzem7Ale1ft1uxJgvs6foDISd4JwiadTbP/9ZvCH8o+q7eNzw3Ni2KN
	 kDspkpr3BGCezlPawHqfCholBddUVacRwxyMFipGzrs0LIjHnF2EjnUi4sVP3OPdVp
	 RcSI5oYPNkAmK+rOP55X4gppnotO3Nos3R6A5mlw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 725A2F800B3;
	Fri, 27 Sep 2019 22:14:20 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1E8D3F804CA; Fri, 27 Sep 2019 22:14:18 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A71BCF80140
 for <alsa-devel@alsa-project.org>; Fri, 27 Sep 2019 22:14:13 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A71BCF80140
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 Sep 2019 13:14:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,556,1559545200"; d="scan'208";a="202144616"
Received: from wcui-mobl1.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.251.146.136])
 by orsmga002.jf.intel.com with ESMTP; 27 Sep 2019 13:14:11 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Fri, 27 Sep 2019 15:14:04 -0500
Message-Id: <20190927201408.925-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/4] ASoC: Intel: boards: improvements for
	RT5651/82-based platforms
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

RT5651/RT5682 boards are used for SOF validation. This patchset
corrects problems identified during module load/reload tests and an
error for DMIC support in some configurations.

These fixes are not critical and can be queued for v5.5

Bard Liao (1):
  ASoC: intel: sof_rt5682: use separate route map for dmic

Jaska Uimonen (3):
  ASoC: intel: bytcr_rt5651: add null check to support_button_press
  ASoC: rt5682: add NULL handler to set_jack function
  ASoC: intel: sof_rt5682: add remove function to disable jack

 sound/soc/codecs/rt5651.c           |  3 ++
 sound/soc/codecs/rt5682.c           | 12 +++++--
 sound/soc/intel/boards/sof_rt5682.c | 51 ++++++++++++++++++++++++++---
 3 files changed, 60 insertions(+), 6 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
