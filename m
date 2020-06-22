Return-Path: <SRS0=6Zlx=AD=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA8C5C433DF
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:43:52 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36AC02073E
	for <alsa-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:43:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="kSI6zPjN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AC02073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B091116F8;
	Mon, 22 Jun 2020 17:43:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B091116F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1592840630;
	bh=+2aiXP5l3hx8TmkEO6XVwBpc+NkRdCofQo8xelwxxEQ=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=kSI6zPjNHfDijP1FIc/Bzm9E0nkA74VEpuVXHvQCwLuTV/WdLhP6+eZVT5tlcNUUn
	 UdLHSunElO3m+XV2+NDKCWsO8HFUgT/dbYUJ45c73BfHabLabOQ/meM3C2BbefM6lh
	 ex6qfvXX2WuOgL7q6NUMedvDNunAfBwdvWllq2Sk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 36CB7F80246;
	Mon, 22 Jun 2020 17:42:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A232BF8028A; Mon, 22 Jun 2020 17:42:57 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 1A84FF8010D
 for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2020 17:42:47 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 1A84FF8010D
IronPort-SDR: 5tWXZD5XWLDe4XH479W51hVrASB3MEU2JJlfcuHtOQk5pCnTmZUK7sd/jyoAmV9JWuYFoHGeaT
 apXt1RGBoz6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9659"; a="141300410"
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; d="scan'208";a="141300410"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jun 2020 08:42:45 -0700
IronPort-SDR: 0kVMMxdeVLHePwc7rK2CHCigPFiYmIx33WwIoS+WamMlRjEYO9fGYutqhY5hDWXZI1QUv6v4pf
 fRFOr++5Ia2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,267,1589266800"; d="scan'208";a="478425136"
Received: from somsubhr-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.74.194])
 by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2020 08:42:44 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 0/5] ASoC: add dailink .exit() callback
Date: Mon, 22 Jun 2020 10:42:36 -0500
Message-Id: <20200622154241.29053-1-pierre-louis.bossart@linux.intel.com>
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

The addition of a dailink .exit() callback seems to be the simplest
solution overall. It can be argued that the existing machine platform
device .remove() callback can also perform the necessary cleanups,
however as shown in the last two examples this might require a loop to
identify components whereas the dailink .exit() already has all the
necessary information to revert the actions done in the .init() step.

Changes since RFC:
Better commit messages and explanations
rt5682 cases with snd_soc_component_set_jack() called in the .exit()

Fred Oh (2):
  ASoC: intel: sof_rt5682: move disabling jack to dai link's exit()
  ASoC: intel: cml_rt1011_rt5682: disable jack in dailink .exit()

Pierre-Louis Bossart (3):
  ASoC: soc-link: introduce exit() callback
  ASoC: Intel: bdw-rt5677: fix module load/unload issues
  ASoC: Intel: kbl-rt5660: use .exit() dailink callback to release gpiod

 include/sound/soc-link.h                   |  1 +
 include/sound/soc.h                        |  3 +++
 sound/soc/intel/boards/bdw-rt5677.c        | 18 ++++++++++++++--
 sound/soc/intel/boards/cml_rt1011_rt5682.c |  8 ++++++++
 sound/soc/intel/boards/kbl_rt5660.c        | 17 +++++++++++++--
 sound/soc/intel/boards/sof_rt5682.c        | 24 ++++++++--------------
 sound/soc/soc-core.c                       |  3 +++
 sound/soc/soc-link.c                       |  6 ++++++
 8 files changed, 60 insertions(+), 20 deletions(-)


base-commit: 39853b1438bf9b07349c8c44b48f6c2eda6f8840
-- 
2.20.1

