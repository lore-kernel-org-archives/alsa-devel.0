Return-Path: <SRS0=1ACS=ZD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2893C43331
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:36:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FA62196E
	for <alsa-devel@archiver.kernel.org>; Mon, 11 Nov 2019 22:36:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Ybtb/4zX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FA62196E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 5481B1677;
	Mon, 11 Nov 2019 23:35:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 5481B1677
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1573511790;
	bh=nhtkC43/IZNMcuc4U/xHfMmz/65OOzjiWBjukO1ulUw=;
	h=From:To:Date:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Ybtb/4zXtFGV9YPrCLjN9AIYrIyxAa5b4HltbcH72z4lmkCduVIKoofSwbAp0mf47
	 InWX4lCxwHgedZVS43hubT9xP3ySh8nuqGDFZEzXqpe65/38mGYnJUQvWnH1OSYVNI
	 64utDOpXEbax94GbQP4u2HiGquR2H+sVs+OQXLQ8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 6370BF805F9;
	Mon, 11 Nov 2019 23:34:02 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A02AF805A0; Mon, 11 Nov 2019 23:33:59 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 418E2F80275
 for <alsa-devel@alsa-project.org>; Mon, 11 Nov 2019 23:33:51 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 418E2F80275
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Nov 2019 14:33:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,294,1569308400"; d="scan'208";a="354903219"
Received: from kathyche-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.27.186])
 by orsmga004.jf.intel.com with ESMTP; 11 Nov 2019 14:33:49 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Mon, 11 Nov 2019 16:33:39 -0600
Message-Id: <20191111223343.19986-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 0/4] ASoC: SOF: Intel: only use D0i3 if needed
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

The earlier patches for D0i3/S0ix support went one bridge too far, and
forced the use of D0i3 even when it was not needed, which also had the
side effect of breaking some of our s2idle suspend/resume stress
tests.

Add documentation on supported transitions and only use D0i3 if
necessary.

Keyon Jie (4):
  ASoC: SOF: PM: add state machine to comments
  ASoC: SOF: PM: add check before setting d0_substate
  ASoC: SOF: add helper to check if we should enter d0i3 suspend
  ASoC: SOF: PM: only suspend to D0I3 when needed

 sound/soc/sof/core.c     | 13 +++++++++++++
 sound/soc/sof/pm.c       | 39 +++++++++++++++++++++++++++++++++++++--
 sound/soc/sof/sof-priv.h |  2 ++
 3 files changed, 52 insertions(+), 2 deletions(-)

-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
