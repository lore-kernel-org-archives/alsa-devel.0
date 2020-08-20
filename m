Return-Path: <SRS0=Ooul=B7=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6E4C433DF
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 06:21:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5207720738
	for <alsa-devel@archiver.kernel.org>; Fri, 21 Aug 2020 06:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="WHH/NDTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5207720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id C5EBA1678;
	Fri, 21 Aug 2020 08:20:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz C5EBA1678
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1597990897;
	bh=lyddSoY6qGaBqqeTzAAtnt7c5dIPM1qAVax6ZYBGyjY=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=WHH/NDTgVxjw8XBWAZwrm4hYtmxKMNFaPyF/3UMgJT2eqU9LTUq7HRZZ/tvxORDRD
	 mfc7ESIaG7R48gG0OReCAZ3KmLFD4B031QFx8koa66aiRWia0JAT85VL1URaPVEVaH
	 TXLiOH76GXw7UpGEs8X/Gv5TN7JbLEbL/TZHZdiI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 22E86F80253;
	Fri, 21 Aug 2020 08:20:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D67BEF80255; Fri, 21 Aug 2020 08:20:41 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4A2DCF800D2
 for <alsa-devel@alsa-project.org>; Fri, 21 Aug 2020 08:20:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4A2DCF800D2
IronPort-SDR: AL2Tf2z4/Fh0Gv4qMrWtKEjs+i8ZZqLljIfVzuXeXrlGsQ6b0Gk40zp2ZSDCTw3Iyv8oWdbv63
 X9uhQMmTQyaw==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="153075476"
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="153075476"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2020 23:20:25 -0700
IronPort-SDR: U0DBVFQZ8l4s4pVTM75D/8kaWBPPPnt00N/YpaEif6AORZeTGCWbMaV3TD66HkonUx7ICsWSwB
 49NxDK21S+GQ==
X-IronPort-AV: E=Sophos;i="5.76,335,1592895600"; d="scan'208";a="498427098"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2020 23:20:21 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH v2 0/3] soundwire: fix port_ready[] dynamic allocation
Date: Fri, 21 Aug 2020 02:26:36 +0800
Message-Id: <20200820182639.11572-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: pierre-louis.bossart@linux.intel.com, vinod.koul@linaro.org, tiwai@suse.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 ranjani.sridharan@linux.intel.com, hui.wang@canonical.com, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, jank@cadence.com, mengdong.lin@intel.com,
 sanyog.r.kale@intel.com, rander.wang@linux.intel.com, bard.liao@intel.com
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

The existing code allocates memory for the total number of ports.
This only works if the ports are contiguous, but will break if e.g. a
Devices uses port0, 1, and 14. The port_ready[] array would contain 3
elements, which would lead to an out-of-bounds access. Conversely in
other cases, the wrong port index would be used leading to timeouts on
prepare.

This can be fixed by allocating for the worst-case of 15
ports (DP0..DP14). In addition since the number is now fixed, we can
use an array instead of a dynamic allocation.

Changes in v2:
- Split patches into sdw and asoc patches. Please note that "soundwire:
  fix port_ready[] dynamic allocation in mipi_disco" and "ASoC: codecs:
  fix port_ready[] dynamic allocation in ASoC codecs" should be merged
  at the same time.

Pierre-Louis Bossart (3):
  soundwire: add definition for maximum number of ports
  soundwire: fix port_ready[] dynamic allocation in mipi_disco
  ASoC: codecs: fix port_ready[] dynamic allocation in ASoC codecs

 drivers/soundwire/mipi_disco.c  | 18 +-----------------
 drivers/soundwire/slave.c       |  4 ++++
 include/linux/soundwire/sdw.h   |  5 +++--
 sound/soc/codecs/max98373-sdw.c | 15 +--------------
 sound/soc/codecs/rt1308-sdw.c   | 14 +-------------
 sound/soc/codecs/rt5682-sdw.c   | 15 +--------------
 sound/soc/codecs/rt700-sdw.c    | 15 +--------------
 sound/soc/codecs/rt711-sdw.c    | 15 +--------------
 sound/soc/codecs/rt715-sdw.c    | 33 +--------------------------------
 9 files changed, 14 insertions(+), 120 deletions(-)

-- 
2.17.1

