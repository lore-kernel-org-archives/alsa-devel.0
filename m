Return-Path: <SRS0=We8V=6G=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD05C55189
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:06:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6786D20780
	for <alsa-devel@archiver.kernel.org>; Wed, 22 Apr 2020 12:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="LhEgv5nI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6786D20780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF14B16CB;
	Wed, 22 Apr 2020 14:05:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF14B16CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1587557199;
	bh=gIA92fLVrFZd/wPgHAFH3OuoyqnJwS1daqaWc2Evc4U=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=LhEgv5nIww3nlU3FFAHNLhKslxq0/luH2rhrwq38YzaaSY32CpEtSQjn2I4/Dz0JQ
	 fpdKeOWmUhQ/u7uMkUUdjnnI/CqdOIYhYoEZdqkHNQq3czjb5vS1ayk3XNBRGMgfI6
	 ZqamEDYKMYYTU16cciyKHii4Rfxk5o4Nxvwkvmoo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id D6BBFF80279;
	Wed, 22 Apr 2020 14:04:27 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2E064F8028B; Wed, 22 Apr 2020 14:04:25 +0200 (CEST)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 816D5F8023F
 for <alsa-devel@alsa-project.org>; Wed, 22 Apr 2020 14:04:21 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 816D5F8023F
IronPort-SDR: qYok+d8sG+1qgJFqEmE1IkT+gPIE4H3UdLoIo7poc5MfCxzAmgrnnc9kUaivYAsmw+c4CGbf5c
 2wsL+5F+GV7g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Apr 2020 05:04:20 -0700
IronPort-SDR: DF21QpDRDMJH5XwL++cWQP4To+v58lvE7rGi0b2TNsFHIDn7KNse6IXY7LT6gu5stxWd+uBWSM
 bSYUmZPPmtuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; d="scan'208";a="255617769"
Received: from mgorski-all-series.igk.intel.com ([10.237.149.201])
 by orsmga003.jf.intel.com with ESMTP; 22 Apr 2020 05:04:18 -0700
From: Mateusz Gorski <mateusz.gorski@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/3] Add support for different DMIC configurations
Date: Wed, 22 Apr 2020 14:05:29 +0200
Message-Id: <20200422120532.31492-1-mateusz.gorski@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: cezary.rojewski@intel.com, Mateusz Gorski <mateusz.gorski@linux.intel.com>,
 tiwai@suse.com
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

Set of patches to enable DMIC capture on different hardware
configurations.
Information about supported DMIC configuration is read from NHLT and
correct pipeline configuration is selected automatically.
Also, adding additional option for topology binary name which is
based on used machine driver.

Mateusz Gorski (3):
  ASoC: Intel: Skylake: Add alternative topology binary name
  ASoC: Intel: Multiple I/O PCM format support for pipe
  ASoC: Intel: Skylake: Automatic DMIC format configuration according to
    information from NHLT

Changes in v2:
- removed patch 1/4 swapping machine device and platform device
  registration order
- alt_tplg_name creation now uses different field to read machine driver
  name
- including of <sound/soc-acpi.h> moved to different patch

 include/uapi/sound/skl-tplg-interface.h |   2 +
 sound/soc/intel/skylake/skl-topology.c  | 189 +++++++++++++++++++++++-
 sound/soc/intel/skylake/skl-topology.h  |   1 +
 3 files changed, 187 insertions(+), 5 deletions(-)

-- 
2.17.1

