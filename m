Return-Path: <SRS0=Ss6N=AZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269D3C433E1
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:27:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A903E2245A
	for <alsa-devel@archiver.kernel.org>; Tue, 14 Jul 2020 12:27:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="o001EMTq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A903E2245A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 2974384D;
	Tue, 14 Jul 2020 14:26:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 2974384D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1594729665;
	bh=CE8VhXRHkp1lN6nkUhlGcSPKfjYgKI9YnFxV9CZZq6M=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=o001EMTq4Jyptlycw5c7lzhVGZtMN9NOSz9MtXJVVo2v9L2ceC5EHa18RfcGhaQDf
	 gBSjsLVvCNeWBWXA8ZUvRLFIBhwwaoKjpsg+34UQwqEOsb4/M5JPm07VSOIOJ4ijZE
	 hVA7eMb+L4qSUwI1WWgWw6YrwWs0AWG3rkUiNz5c=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9830EF8016F;
	Tue, 14 Jul 2020 14:26:54 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 80BACF8014E; Tue, 14 Jul 2020 14:26:34 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 42F70F8014E
 for <alsa-devel@alsa-project.org>; Tue, 14 Jul 2020 14:26:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 42F70F8014E
IronPort-SDR: ma8p9r0t2/kBUscD4xeruXCvDPfXrf8Y+jpyfEYGKwHF46mBIJbPbiIa2tPE5dDwX0BVyZK/pc
 wmbiZbijuLRw==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="166981775"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="166981775"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 05:26:24 -0700
IronPort-SDR: 4B65ZMJirXF1wd+bMih48DTi3KZaThuiK+HjQc5ipNAOLj9Z3ZIh1ga3syggAGdRITxYM/317z
 n8lMiVhFi0Gg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="485860382"
Received: from test-hp-compaq-8100-elite-cmt-pc.igk.intel.com ([10.237.149.93])
 by fmsmga005.fm.intel.com with ESMTP; 14 Jul 2020 05:26:23 -0700
From: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 00/10] topology: decode: Various fixes
Date: Tue, 14 Jul 2020 13:25:01 +0200
Message-Id: <1594725911-14308-1-git-send-email-piotrx.maziarz@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Cc: cezary.rojewski@intel.com, amadeuszx.slawinski@intel.com
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

This series fixes various problems with topology decoding mechanism.
Some of the problems were critical like improper memory management or
infinite loops that were causing undefined behaviour or program crashes,
while other resulted in losing some data during conversion.

Bugs found while testing with Intel SST topologies.

Changelog:
v2:
  -Divide into more patches, critical fixes are in separate patches now
  -More specific descriptions
  -Fix a typo UML to UCM
  -Add error reporting in topology: decode: fix channel map memory
   allocation
  -Remove goto again in topology: Make buffer for saving dynamic size
   for better readability

v3:
  -No functional changes
  -Changed UCM to more descriptive standard ALSA configuration files
  -removed Gerrit's Change-Id
  -Added missing signed-offs

Piotr Maziarz (10):
  topology: decode: Fix channel map memory allocation
  topology: decode: Fix infinite loop in decoding enum control
  topology: decode: Remove decoding  values for enum control
  topology: decode: Add enum control texts as separate element
  topology: decode: Fix printing texts section
  topology: decode: Change declaration of enum decoding function
  topology: decode: Fix decoding PCM formats and rates
  topology: decode: Print sig_bits field in PCM capabilities section
  topology: decode: Add DAI name printing
  topology: Make buffer for saving dynamic size

 src/topology/ctl.c        | 51 ++++++++++++++++++++++-------------------------
 src/topology/dapm.c       |  3 +--
 src/topology/pcm.c        | 11 +++++++---
 src/topology/save.c       | 34 ++++++++++++++++++++++++++-----
 src/topology/text.c       |  2 +-
 src/topology/tplg_local.h |  2 +-
 6 files changed, 64 insertions(+), 39 deletions(-)

-- 
2.7.4

