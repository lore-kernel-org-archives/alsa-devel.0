Return-Path: <SRS0=v/9x=ND=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BA4C4338F
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Aug 2021 23:21:05 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EE7A6103E
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Aug 2021 23:21:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6EE7A6103E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 113C418E7;
	Fri, 13 Aug 2021 01:20:11 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 113C418E7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1628810461;
	bh=qS7QMSCqthYlH9rdfYbWfb3/EBoDijx9TB2RuS9J7uk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=faCQC+A8vjK53854DjYkJqMMkdZQnApryWPMZUJmULCIpmKI6QYwxQvH507aAuNWf
	 H/qfINmr7jUfjhG2KI02fgDcMriP47L6YMZeiV0ubn0pvqeB2v8yEIEOD525yZxhko
	 J3zZUv7pS+vPQ7CUJF4N9Or/wqdcVDVdNwvu5j0E=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id A2F51F800AF;
	Fri, 13 Aug 2021 01:20:10 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 428B9F800AF; Fri, 13 Aug 2021 01:20:08 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 0BCB9F800AF
 for <alsa-devel@alsa-project.org>; Fri, 13 Aug 2021 01:20:02 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 0BCB9F800AF
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="202629467"
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; d="scan'208";a="202629467"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2021 16:19:57 -0700
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; d="scan'208";a="507949883"
Received: from evanklei-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.77.110])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2021 16:19:56 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/4] ASoC: SOF: Intel: DMI L1 power optimization for
 HDaudio platforms
Date: Thu, 12 Aug 2021 18:19:36 -0500
Message-Id: <20210812231940.172547-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This patchset provides an optimization that result in significant power
savings on Intel HDAudio platforms using SOF (Sound Open Firmware).

We previously prevented the Intel DSP from enabling the DMI_L1
capability to work-around issues with pause on capture streams. It
turns out that this also prevented the platform from entering high C
states in full-duplex usages such as videoconferencing - a rather
basic use case since the start of the pandemic.

The support for pause_push/release was already a bit controversial for
Intel platforms, in theory platforms should only enable PAUSE if they
can resume on the same sample, which is not the case on any Intel
platform.

With this patchset, when the user enables DMI L1 via a kernel
parameter, the PAUSE support is disabled for capture streams. A kernel
parameter is far from ideal but it's a placeholder until we have an
API to negotiate capabilities between applications and driver, and
it's far less confusing than a Kconfig option.

Changes since v1:
Removal of SPIB support since it may conflict with Takashi's memalloc
changes. These SPIB changes will be provided after rebase.
Addition of one cleanup for cppcheck warning
Move all changes to intel/ directory, no changes in shared code
Flipped the logic: the selection of DMI L1 disables PAUSE

Pierre-Louis Bossart (4):
  ASoC: SOF: Intel: Kconfig: clarify DMI L1 option description
  ASoC: SOF: Intel: hda-stream: remove always true condition
  ASoC: SOF: Intel: simplify logic for DMI_L1 handling
  ASoC: SOF: Intel: make DMI L1 selection more robust

 sound/soc/sof/intel/Kconfig      | 10 ----------
 sound/soc/sof/intel/hda-pcm.c    | 16 ++++++++++++++--
 sound/soc/sof/intel/hda-stream.c | 11 +++++------
 3 files changed, 19 insertions(+), 18 deletions(-)

-- 
2.25.1

