Return-Path: <SRS0=qZmY=BX=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8D5C433DF
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:59:53 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472952078D
	for <alsa-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:59:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Fnqnlgc3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472952078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BAF5910E;
	Thu, 13 Aug 2020 19:59:01 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BAF5910E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597341591;
	bh=w87R2jDciF/7Lqd3pqmY9hGHepUizlK37hTLx52Z8T4=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Fnqnlgc3kEv1k1Ze1PM/NRfMnemU+s1EBGr18JswJMKYSAwPU/BL/GWLsUGilTjcy
	 IhIDbvGG4N6RjulrBnfGwxgdxH1BVZo/bsXYM6UQSZn487YGf3Al7N3jsL6sEdTGHo
	 nsSSzy/7X3a35tC+crrX6g/GGjXS7wfVV+dYPdC4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 2C4BFF8014C;
	Thu, 13 Aug 2020 19:59:01 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5714DF80162; Thu, 13 Aug 2020 19:58:59 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8764BF800D3
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2020 19:58:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8764BF800D3
IronPort-SDR: SXFfqYb24a/V+GdpTaPicq7qbW+eIi41m6KAEu54ORDV8tIcGj/Tv30NouNWiFcfq3XzirbJEH
 sJMNOvK2Jy0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9712"; a="239124807"
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="239124807"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 10:58:54 -0700
IronPort-SDR: 5qP2Hheb42ysEnYSpkgM/lfvkmQidaVBYYafTiO949F1OgM7sXHmLNa+BmiJQ2oe9m3I4XVW2Z
 CklLdQ2Rk4Lg==
X-IronPort-AV: E=Sophos;i="5.76,309,1592895600"; d="scan'208";a="295510732"
Received: from jctorres-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.137.200])
 by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2020 10:58:53 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/5] ASoC: SOF/Intel: fix cppcheck warnings
Date: Thu, 13 Aug 2020 12:58:34 -0500
Message-Id: <20200813175839.59422-1-pierre-louis.bossart@linux.intel.com>
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

A small set of fixes to reduce the number of warnings.

Pierre-Louis Bossart (5):
  ASOC: SOF: Intel: hda-codec: move unused label to correct position
  ASoC: SOF: Intel: hda-codec: move variable used conditionally
  ASoC: Intel: rename shadowed variable for all broadwell boards
  ASoC: Intel: bytcht_cx2072x: simplify return handling
  ASoC: Intel: sof_sdw: clarify operator precedence

 sound/soc/intel/boards/bdw-rt5650.c     | 10 +++++-----
 sound/soc/intel/boards/bdw-rt5677.c     |  8 ++++----
 sound/soc/intel/boards/broadwell.c      |  8 ++++----
 sound/soc/intel/boards/bytcht_cx2072x.c |  2 +-
 sound/soc/intel/boards/sof_sdw.c        |  2 +-
 sound/soc/sof/intel/hda-codec.c         |  7 ++++++-
 6 files changed, 21 insertions(+), 16 deletions(-)

-- 
2.25.1

