Return-Path: <SRS0=q21C=4W=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2A3C3F2D1
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:07:29 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CA9A2072A
	for <alsa-devel@archiver.kernel.org>; Thu,  5 Mar 2020 13:07:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="BaEbVOvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CA9A2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BA3241616;
	Thu,  5 Mar 2020 14:06:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BA3241616
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583413647;
	bh=gcFtvA6WmcKMu1SOsogaQvg0CWe8Is8XKFGfUMuQYEs=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BaEbVOvgiz8LEm5aVD9CBDugJwnjWIX8FsdQG0J168AQHVe8Nv4lC/CqK/irezi6t
	 8htxZG15boOQm9DHYzQxQTfrDk2a65n0IMxnWMgE7DLF+vVm7o75So0FMa69Y+cW1n
	 wDe9mTHb7iQdX66sAoxC8a2x0cuuWdUlptrtfgf0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8674CF8025F;
	Thu,  5 Mar 2020 14:06:35 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D8A37F800D8; Thu,  5 Mar 2020 14:06:33 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B805CF800D8
 for <alsa-devel@alsa-project.org>; Thu,  5 Mar 2020 14:06:29 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B805CF800D8
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 05 Mar 2020 05:06:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,518,1574150400"; d="scan'208";a="287659379"
Received: from virbhadx-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.184.168])
 by FMSMGA003.fm.intel.com with ESMTP; 05 Mar 2020 05:06:26 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [RFC PATCH 0/3] ASoC: add dailink .exit() callback
Date: Thu,  5 Mar 2020 07:06:13 -0600
Message-Id: <20200305130616.28658-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
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

While looking at reboot issues and module load/unload tests, I found
out some resources allocated in the dailink .init() callback are not
properly released - there is no existing mechanism in the soc-core to
do so.

I experimented with different solutions and the simplest seems to add
an .exit() callback. However things are not fully balanced and I could
use feedback on the approach.

This patchset includes two examples where this solution is useful, but
we have additional ones identified by Ranjani.

Pierre-Louis Bossart (3):
  ASoC: soc-core: introduce exit() callback for dailinks
  ASoC: Intel: bdw-rt5677: fix module load/unload issues
  ASoC: Intel: kbl-rt5660: use .exit() dailink callback to release gpiod

 include/sound/soc.h                 |  3 +++
 sound/soc/intel/boards/bdw-rt5677.c | 14 ++++++++++++--
 sound/soc/intel/boards/kbl_rt5660.c | 13 +++++++++++--
 sound/soc/soc-core.c                |  8 +++++++-
 4 files changed, 33 insertions(+), 5 deletions(-)

-- 
2.20.1

