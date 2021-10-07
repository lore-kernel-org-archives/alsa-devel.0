Return-Path: <SRS0=Vpzd=O3=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B80C433EF
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 16:48:41 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D9A6103B
	for <alsa-devel@archiver.kernel.org>; Thu,  7 Oct 2021 16:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 69D9A6103B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AEC1B1664;
	Thu,  7 Oct 2021 18:47:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AEC1B1664
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1633625318;
	bh=veqtLgFSwTPk0VpO0TpcfUCapHEbt3tWeteptcWF3Gk=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=jyuyaAyBJJr7OrHGR7aHfdU9JB6j17KfjFEyVaJKay2CPKRlHFkYemX0c4pMDmgBI
	 vKAITbBnmHUu3oLZMgFO1XpXeA6s4xCrDLQPuXvYi039wp0zZXDahiXVjWNBPWrVhX
	 RYbhS4m86ZCjC2/OzoRZQLKcduI0s7237/e4Ge/U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id AC535F802A0;
	Thu,  7 Oct 2021 18:47:12 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BC273F804BB; Thu,  7 Oct 2021 18:47:11 +0200 (CEST)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5497BF80259
 for <alsa-devel@alsa-project.org>; Thu,  7 Oct 2021 18:47:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5497BF80259
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="213254553"
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; d="scan'208";a="213254553"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Oct 2021 09:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,355,1624345200"; d="scan'208";a="524733189"
Received: from black.fi.intel.com ([10.237.72.28])
 by fmsmga008.fm.intel.com with ESMTP; 07 Oct 2021 09:45:22 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
 id 98BFB159; Thu,  7 Oct 2021 19:45:29 +0300 (EEST)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/4] ASoC: Intel: bytcht_es8316: few cleanups
Date: Thu,  7 Oct 2021 19:45:19 +0300
Message-Id: <20211007164523.27094-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Jie Yang <yang.jie@linux.intel.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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

The small set of cleanups against bytcht_es8316 board file.

In v4:
- fixed Pierre's email (Pierre)
- added Hans to the Cc list

In v3:
- actually added a Pierre's tag (Mark)

In v2:
- added tag (Pierre)
- added commit message to the patch 2 (Joe)

Andy Shevchenko (4):
  ASoC: Intel: bytcht_es8316: Get platform data via dev_get_platdata()
  ASoC: Intel: bytcht_es8316: Use temporary variable for struct device
  ASoC: Intel: bytcht_es8316: Switch to use gpiod_get_optional()
  ASoC: Intel: bytcht_es8316: Utilize dev_err_probe() to avoid log
    saturation

 sound/soc/intel/boards/bytcht_es8316.c | 37 +++++++++-----------------
 1 file changed, 12 insertions(+), 25 deletions(-)

-- 
2.33.0

