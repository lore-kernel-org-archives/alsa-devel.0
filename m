Return-Path: <SRS0=4tTe=BK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B78EC433E0
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 12:31:46 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB3FB206FA
	for <alsa-devel@archiver.kernel.org>; Fri, 31 Jul 2020 12:31:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="sDZpRZlh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3FB206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3882D16A1;
	Fri, 31 Jul 2020 14:30:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3882D16A1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1596198704;
	bh=0ONGwapvZIm3cTARr6KU9vQhG9U9mBGNOAsAHyQZ00s=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sDZpRZlhF+NNFy8Fsz1VHCP5T7hJTaBB31WwD1AC/E45PMiqHQYgSCWfC0zBHfWkB
	 0D/EMtU53BtMa5SFb/HZhWywoAizU9+flWYWSJZ9zd52orMo0s+2i4ftGo4mUVgu6C
	 netXDgibD4+Wp0TFv0mWTjw0wltg9FWESStAQed4=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4D77DF801D9;
	Fri, 31 Jul 2020 14:30:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 315A0F801EB; Fri, 31 Jul 2020 14:30:51 +0200 (CEST)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AD479F80161
 for <alsa-devel@alsa-project.org>; Fri, 31 Jul 2020 14:30:39 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AD479F80161
IronPort-SDR: yo4W/D2I3qPuezfkw/lBJQOIIoCEukX4npFcFu78UiUqR7e2tqqCDeHla2dKlHxQyvMUMb7aTH
 K7mci5YiEj4A==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="236630430"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; d="scan'208";a="236630430"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2020 05:30:37 -0700
IronPort-SDR: sX08mrnWSa8zWJRRR0sQWabTwfdl6QPDe7BNgwczv9dgtKx8nIawNWaHg0kD/HBT4Vaauwirv1
 p2sElXqEMG8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; d="scan'208";a="365483154"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
 by orsmga001.jf.intel.com with ESMTP; 31 Jul 2020 05:30:33 -0700
From: Brent Lu <brent.lu@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v3 0/2] Add period size constraint for Atom Chromebook
Date: Fri, 31 Jul 2020 20:26:03 +0800
Message-Id: <1596198365-10105-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
References: <1596020585-11517-1-git-send-email-brent.lu@intel.com>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Sam McNally <sammc@chromium.org>, Mark Brown <broonie@kernel.org>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Yu-Hsuan Hsu <yuhsuan@chromium.org>, Daniel Stuart <daniel.stuart14@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Brent Lu <brent.lu@intel.com>, Damian van Soelen <dj.vsoelen@gmail.com>
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

Two different constraints are implemented: one is in platform's CPU
DAI to enforce the period to be multiple of 1ms to align with firmware
design. The other is in Atom Chromebook's machine driver to use 240 as
period size which is selected by google.


Changes since v1:
-Add comma at the end of media_period_size array declaration.

Changes since v2:
-Use snd_pcm_hw_constraint_step to enforce the 1ms period.


Brent Lu (1):
  ASoC: intel: atom: Add period size constraint

Yu-Hsuan Hsu (1):
  ASoC: Intel: Add period size constraint on strago board

 sound/soc/intel/atom/sst-mfld-platform-pcm.c | 11 +++++++++++
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 14 +++++++++++++-
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 14 +++++++++++++-
 3 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.7.4

