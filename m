Return-Path: <SRS0=GKc0=DA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE453C2D0A8
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 08:08:07 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58F0C2388A
	for <alsa-devel@archiver.kernel.org>; Wed, 23 Sep 2020 08:08:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="jetitzSA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58F0C2388A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 615C316CA;
	Wed, 23 Sep 2020 10:07:14 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 615C316CA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1600848484;
	bh=UfIP8Lto+Bvql2TXuBZx6V5oR8P0xBl94eysK74wK6w=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jetitzSAbfU+4+Zrt0ASGzc4/kHwUQBosBZB4zUxT8aIOK+n5Y38UXjAMuncUIJzs
	 xKhdthm4tUcS8uOUMyRrhLFwiagIYWU3nEhO4gqbavhvAqTYxOlJ6TPvh7B8rqs0Kt
	 uApKUh3meRAih9cZF+ByjY9lWQRq6WQHCdBYS7ss=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C74D4F801EC;
	Wed, 23 Sep 2020 10:07:13 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E9C8AF801EC; Wed, 23 Sep 2020 10:07:11 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B8DB8F8010A
 for <alsa-devel@alsa-project.org>; Wed, 23 Sep 2020 10:07:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B8DB8F8010A
IronPort-SDR: Dw0a5MQBF6TUlB4J6WNOEiJkMNWtyhYRMJzQeo01kw4pAg28Gy0XijDk/cStwBQiQ6b5f9QjOW
 asj8pxkKsp8w==
X-IronPort-AV: E=McAfee;i="6000,8403,9752"; a="158178499"
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="158178499"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2020 01:07:01 -0700
IronPort-SDR: 863exeI+IKosj7/H/ayCB/xu/+mwgSrdO05ZrBhVs7BPl1P1bcmeXSVC+znCJEO3j/DIMOdWXj
 sCu8baS5xQsQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,293,1596524400"; d="scan'208";a="335371179"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga004.fm.intel.com with ESMTP; 23 Sep 2020 01:06:59 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 0/6] ASoC: Intel: sdw machine driver updates for 5.10
Date: Wed, 23 Sep 2020 11:05:08 +0300
Message-Id: <20200923080514.3242858-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: lgirdwood@gmail.com, daniel.baluta@nxp.com,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

Series including fixes and improvements for Intel SoundWire
machine drivers.

Bard Liao (1):
  ASoC: Intel: add support for new SoundWire hardware layout on TGL

Pierre-Louis Bossart (4):
  ASoC: Intel: sof_sdw: remove ternary operator
  ASoC: Intel: add codec name prefix to ACPI machine description
  ASoC: Intel: sof_sdw: remove hard-coded codec_conf table
  ASoC: Intel: sof_sdw_rt700: add codec prefix

Rander Wang (1):
  ASOC: Intel: sof_sdw: restore playback functionality with max98373
    amps

 include/sound/soc-acpi.h                      |   2 +
 sound/soc/intel/boards/sof_sdw.c              | 170 +++++++++---------
 sound/soc/intel/boards/sof_sdw_common.h       |   3 +
 sound/soc/intel/boards/sof_sdw_max98373.c     |  36 +++-
 sound/soc/intel/boards/sof_sdw_rt700.c        |   6 +-
 .../intel/common/soc-acpi-intel-cml-match.c   |  10 ++
 .../intel/common/soc-acpi-intel-cnl-match.c   |   1 +
 .../intel/common/soc-acpi-intel-icl-match.c   |   6 +
 .../intel/common/soc-acpi-intel-tgl-match.c   |  67 +++++++
 9 files changed, 216 insertions(+), 85 deletions(-)

-- 
2.27.0

