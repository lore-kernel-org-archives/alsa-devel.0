Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A5EFC77B75
	for <alsa-devel@archiver.kernel.org>; Fri, 19 May 2023 12:17:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id D2485204;
	Fri, 19 May 2023 14:16:33 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz D2485204
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1684498643;
	bh=Iai1OfRmrVp7IIXY9Gxe7CSQi5jqnxuD/YtgpnyUqNw=;
	h=From:To:Cc:Subject:Date:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=haG5MjbzdO1VY3p/q0VcK8sTPWuQB6sC0m0AxYMdfdCduaPX8kjlVg50OmXH/UZ7o
	 i5bsEjSNV+D8rPAmu0x5Ip4wPK0KL3qLa33qE57/KEOzuMdxnCzi9dsLNFhOrExhAP
	 vv1C6AHnnregeKgcJ5GfvZj4EuMUoFs4lXlh325s=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 4CD89F80557; Fri, 19 May 2023 14:16:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 9DC23F80548;
	Fri, 19 May 2023 14:16:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 0EEB5F80087; Fri, 19 May 2023 14:16:01 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id BC48CF80087
	for <alsa-devel@alsa-project.org>; Fri, 19 May 2023 14:15:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BC48CF80087
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=mytY+ihq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684498559; x=1716034559;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Iai1OfRmrVp7IIXY9Gxe7CSQi5jqnxuD/YtgpnyUqNw=;
  b=mytY+ihqT5oXVO574rmDQFLzA/zAG2UOA28n1vOhGiS/bdRHtQ5++I6H
   AWdwaOXqFKTHLnU1RTA9i3L3xbWE7H5D8qblsyLKyrdG00mTdyM8oLLwD
   cE3Zx8edYO2sqF+nrzfa6L9LAZxGlHADIQAher5A5HUXjpdj6D0dKEhEF
   Nfc7LrI8U91k972SdzFLksW8HJjlKKI3/5cCd/o/c7ASoGuknHbg3pG0j
   GlAGS7iUa6oEehhZEmgnzUIvsncQULWPGzb3fUFRR7bVSQtweGLwKAdZY
   MWb1qiyxk8c4d4sAO/xIMnR6qNYdYer0E6WmEZ0BU0Bu8hDtaubN3pORr
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="355584393"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400";
   d="scan'208";a="355584393"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2023 05:15:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10714"; a="733283649"
X-IronPort-AV: E=Sophos;i="6.00,176,1681196400";
   d="scan'208";a="733283649"
Received: from dev2 (HELO DEV2.igk.intel.com) ([10.237.148.94])
  by orsmga008.jf.intel.com with ESMTP; 19 May 2023 05:15:51 -0700
From: =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
Subject: [PATCH 0/7] ASoC: Intel: Fixes
Date: Fri, 19 May 2023 22:17:04 +0200
Message-Id: <20230519201711.4073845-1-amadeuszx.slawinski@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: ZRYQXXF6WGMELUJZR76MBXU3T73TYLQL
X-Message-ID-Hash: ZRYQXXF6WGMELUJZR76MBXU3T73TYLQL
X-MailFrom: amadeuszx.slawinski@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/ZRYQXXF6WGMELUJZR76MBXU3T73TYLQL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

Series of fixes for issues found during development and testing,
primarly for avs driver.

Amadeusz Sławiński (4):
  ASoC: Intel: avs: Fix module lookup
  ASoC: Intel: avs: Access path components under lock
  ASoC: Intel: avs: Fix avs_path_module::instance_id size
  ASoC: Intel: avs: Add missing checks on FE startup

Cezary Rojewski (3):
  ASoC: Intel: Skylake: Fix declaration of enum skl_ch_cfg
  ASoC: Intel: avs: Fix declaration of enum avs_channel_config
  ASoC: Intel: avs: Account for UID of ACPI device

 include/sound/soc-acpi.h                |  1 +
 include/uapi/sound/skl-tplg-interface.h |  3 ++-
 sound/soc/intel/avs/apl.c               |  6 +++++-
 sound/soc/intel/avs/avs.h               |  4 ++--
 sound/soc/intel/avs/board_selection.c   |  2 +-
 sound/soc/intel/avs/control.c           | 22 +++++++++++++++-------
 sound/soc/intel/avs/dsp.c               |  4 ++--
 sound/soc/intel/avs/messages.h          |  2 +-
 sound/soc/intel/avs/path.h              |  2 +-
 sound/soc/intel/avs/pcm.c               | 23 ++++++++++++++++++-----
 sound/soc/intel/avs/probes.c            |  2 +-
 11 files changed, 49 insertions(+), 22 deletions(-)

-- 
2.34.1

