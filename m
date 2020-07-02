Return-Path: <SRS0=znNF=AN=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA1EC433E0
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:22:54 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 652CE20780
	for <alsa-devel@archiver.kernel.org>; Thu,  2 Jul 2020 19:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hjD13wsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 652CE20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E682D16CB;
	Thu,  2 Jul 2020 21:22:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E682D16CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593717773;
	bh=xqL6nqxBiiqP1MqfhqUDCMLGQTKSto4ASteck2q4MOI=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hjD13wsUGiKMRNd0xj6hAg7IIyb3rTQDVar+V2O8rWV7aYOJ747nWAZLCM25czvts
	 e9PZgU5j1uCJ/Rffn0bAYIYhG53mu74fe0YW9mFrDikC+oQIMuVPU9sDFR857psaaj
	 NwaVfwWkO5/zcryyAhtsIPR/dzFt2AGgccEjkpMg=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 5E4AFF8022D;
	Thu,  2 Jul 2020 21:22:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 3A500F80134; Thu,  2 Jul 2020 21:22:01 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 01445F80134
 for <alsa-devel@alsa-project.org>; Thu,  2 Jul 2020 21:21:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 01445F80134
IronPort-SDR: VIewkbD4xwB23wgTPCPK+n+sD4UNt3UUm19F8DecDq09KIUoxLjTXQq48iMI4xmvvKcvBZSpPE
 +COpXJANLfLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="165059422"
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="165059422"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:21:52 -0700
IronPort-SDR: p8HwCWMO7jTvnVzsH4ZCm1GevgpaXqePFvbd2FlMTPjwtW+F6qfU32tyP8CWKTtJZFPMQMQsgn
 piWk7ban/Qpg==
X-IronPort-AV: E=Sophos;i="5.75,305,1589266800"; d="scan'208";a="304345249"
Received: from dhprice-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.75.219])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 12:21:50 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/6] ASoC: fsl: fix kernel-doc
Date: Thu,  2 Jul 2020 14:21:35 -0500
Message-Id: <20200702192141.168018-1-pierre-louis.bossart@linux.intel.com>
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

This cleanup patchset is only about kernel-doc, mostly trivial edits
and format correction.

v2: added Nicolin Chen's Acked-by tags and included the three
suggested edits.

Pierre-Louis Bossart (6):
  ASoC: fsl: fsl_ssi_dbg: remove spurious kernel-doc comment start
  ASoC: fsl: fsl_ssi: fix kernel-doc
  ASoC: fsl: fsl-asoc-card: fix kernel-doc
  ASoC: fsl: fsl_spdif: fix kernel-doc
  ASoC: fsl: fsl_asrc: fix kernel-doc
  ASoC: fsl: fsl_esai: fix kernel-doc

 sound/soc/fsl/fsl-asoc-card.c | 21 +++++------
 sound/soc/fsl/fsl_asrc.c      | 57 +++++++++++++++++++---------
 sound/soc/fsl/fsl_esai.c      | 32 +++++++++-------
 sound/soc/fsl/fsl_spdif.c     |  5 ++-
 sound/soc/fsl/fsl_ssi.c       | 70 ++++++++++++++++++++++-------------
 sound/soc/fsl/fsl_ssi_dbg.c   |  4 +-
 6 files changed, 115 insertions(+), 74 deletions(-)

-- 
2.25.1

