Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CA2C4332F
	for <alsa-devel@archiver.kernel.org>; Fri, 25 Nov 2022 18:24:30 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id BF737171D;
	Fri, 25 Nov 2022 19:23:37 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz BF737171D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1669400667;
	bh=4ETvz6xBhR+SkAc+xMCk2HE9pt8MkY6CDQtnf38Bs3c=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uZ0gaSTV7aLaDLT44ki9DryTQ34bZNjzB7ibnwQDfnLDB+Y/uQlxsffbpvZJomRW5
	 ZJ6NQGiyFKJwCYtOIPwT5OBJ7skL82Xf/sLaAJRvCorzQjCLruu6GpskeCdPnYPuON
	 fWiEV+BryXsCtAbBv80AJJq7WY9Z9RhCAI7ddZZI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57775F8014E;
	Fri, 25 Nov 2022 19:23:37 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2BA71F8047C; Fri, 25 Nov 2022 19:23:36 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 52700F8014E
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2022 19:23:32 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 52700F8014E
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="cBeWcCkN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1669400614; x=1700936614;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=4ETvz6xBhR+SkAc+xMCk2HE9pt8MkY6CDQtnf38Bs3c=;
 b=cBeWcCkNpkjZWb0fXLj7KDsxEjRTnnlhsWESQU+7dADZ9yvvDtbRHBc/
 0jOKiTHGm2CW97BeSUOEIaOBlt8zYP7sxDEPAMZdiNUmDJVQLuGvV520E
 4nPcEtl1mptiGma8+dgjX9pGG/yKFzlzSj6VSNaS/7BcYlpv2l98cBrmY
 KrrspJv+TMV8Jbg/XLy5iI0Lewwx/qegA0OF4g0FSN+9F+T9sseQZO0X7
 AQr522QFr/321ciZRHmTj+Ta8i8FkBbLVQkWmYjY2KmeOuRTvLt5R6JtU
 j8+TOuHJn0qJ5yUtvy938RonqkJfMH5qPI/QEQQkTkZl2vBzcZdXjaaYS g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="294909209"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; d="scan'208";a="294909209"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2022 10:23:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10542"; a="785005511"
X-IronPort-AV: E=Sophos;i="5.96,194,1665471600"; d="scan'208";a="785005511"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga001.fm.intel.com with ESMTP; 25 Nov 2022 10:23:26 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 00/11] ASoC: Intel: avs: Refactor jack handling
Date: Fri, 25 Nov 2022 19:40:21 +0100
Message-Id: <20221125184032.2565979-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 pierre-louis.bossart@linux.intel.com, tiwai@suse.com, hdegoede@redhat.com,
 amadeuszx.slawinski@linux.intel.com
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

For all the boards included in this patchset, a similar set of changes
is proposed:

1) Move jack unassignment from platform_device->remove() to
   dai_link->exit(). This is done to make jack init and deinit flows
   symmetric
2) Remove platform_device->remove() function
3) Simplify card->suspend_pre() and card->resume_post() by making use of
   snd_soc_card_get_codec_dai() helper

While bdw_rt286 board - which is utilized by the catpt-driver - is
definitely not part of "avs", same treatment applies. And thus decided
to make it part of this series instead of sending it separately.

Amadeusz Sławiński (10):
  ASoC: Intel: avs: da7219: Refactor jack handling
  ASoC: Intel: avs: nau8825: Refactor jack handling
  ASoC: Intel: avs: rt274: Refer to DAI name through a constant
  ASoC: Intel: avs: rt274: Refactor jack handling
  ASoC: Intel: avs: rt286: Add define for codec DAI name
  ASoC: Intel: avs: rt286: Refactor jack handling
  ASoC: Intel: avs: rt298: Add define for codec DAI name
  ASoC: Intel: avs: rt298: Refactor jack handling
  ASoC: Intel: avs: rt5682: Add define for codec DAI name
  ASoC: Intel: avs: rt5682: Refactor jack handling

Cezary Rojewski (1):
  ASoC: Intel: bdw_rt286: Refactor jack handling

 sound/soc/intel/avs/boards/da7219.c  | 34 +++++++----------
 sound/soc/intel/avs/boards/nau8825.c | 35 ++++++------------
 sound/soc/intel/avs/boards/rt274.c   | 30 ++++++---------
 sound/soc/intel/avs/boards/rt286.c   | 37 ++++++++-----------
 sound/soc/intel/avs/boards/rt298.c   | 37 ++++++++-----------
 sound/soc/intel/avs/boards/rt5682.c  | 31 +++++++---------
 sound/soc/intel/boards/bdw_rt286.c   | 55 ++++++++--------------------
 7 files changed, 95 insertions(+), 164 deletions(-)

-- 
2.25.1

