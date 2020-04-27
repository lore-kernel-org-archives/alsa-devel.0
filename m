Return-Path: <SRS0=y76W=6L=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39880C4CECC
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 17:49:22 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF34A2087E
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Apr 2020 17:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="fPlOvuwZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF34A2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A4CD167E;
	Mon, 27 Apr 2020 19:48:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A4CD167E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588009760;
	bh=t+RGM9iDzBTdnt2bN/GEb/rfuNjjVAgFC+ZWaqVJ+Kk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fPlOvuwZP6bJZW1nfK5knSWGj6tK4Ay7rWRZa7Wt+O8SxKRokwHqSG5Ltx5+ZmHSh
	 OBai7lFy/UA5sQCTvryJh1R/ElqFGbM55s2HskaZqOX3cxA7dhSgRY2UMXQy1oc+yj
	 b27LXsGcbevFZk8pjth49KLe0cKcI+Tij/S3npBI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DB44EF80232;
	Mon, 27 Apr 2020 19:19:59 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A8AC7F8022B; Mon, 27 Apr 2020 19:19:49 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id E3079F80113
 for <alsa-devel@alsa-project.org>; Mon, 27 Apr 2020 19:19:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz E3079F80113
IronPort-SDR: 2oQPc9fLVMpIj+pE+wxo23nZajTPVl0w7CFRhym1lhfhNZ0Mu6C2PCNIq/omARgIhcSwSyGh29
 M709W0agX/vA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 10:19:37 -0700
IronPort-SDR: jD3RywuxRGpJyIx//YURsX+NblkmEcMB1+ljm2BF1Z5scQR8yCB5T79BYSoFVDEuNJz98JclyA
 gXsgZd/Zaj9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; d="scan'208";a="458932248"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
 by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2020 10:19:34 -0700
From: Brent Lu <brent.lu@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 0/3] add channel constraint for BDW machine drivers
Date: Tue, 28 Apr 2020 01:13:31 +0800
Message-Id: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Ben Zhang <benzh@chromium.org>, Mac Chiang <mac.chiang@intel.com>,
 Mark Brown <broonie@kernel.org>, Brent Lu <brent.lu@intel.com>
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

The machine driver bdw-rt5650 (for Google buddy) supports 2 or 4-channel
recording while other two drivers support only 2-channel recording. HW
constraints are implemented to reflect the hardware limitation on BDW
platform.

Changes since v1:
- Change the patch title.
- Remove the DUAL_CHANNEL and QUAD_CHANNEL macros which are too obvious.
- Follow the naming convertion, using 'bdw_rt5650_' and 'bdw_rt5677_' to
  name startup functions.
- Refine the comments in startup functions.
- Redesign the bdw_rt5650_fe_startup() function for readability.
- Add an assignment to initialize runtime->hw.channels_max variable.

Brent Lu (3):
  ASoC: bdw-rt5677: add channel constraint
  ASoC: bdw-rt5650: add channel constraint
  ASoC: broadwell: add channel constraint

 sound/soc/intel/boards/bdw-rt5650.c | 29 +++++++++++++++++++++++++++++
 sound/soc/intel/boards/bdw-rt5677.c | 26 ++++++++++++++++++++++++++
 sound/soc/intel/boards/broadwell.c  | 26 ++++++++++++++++++++++++++
 3 files changed, 81 insertions(+)

-- 
2.7.4

