Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD335C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Jun 2022 08:16:56 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EC45118C9;
	Mon, 20 Jun 2022 10:16:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EC45118C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655713015;
	bh=pAoRV9qZAV0vIHCKPW5NwP8uZjCziWDwJzbXGyXGaQk=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XgfuH5OMhTyCE7OOPV+miSMTd12Gc9I+mpXafjDBHxkn53H/Mgre63lDOEdOVR99w
	 cYvYSIdCaricLE78leqWa0bBy0mONhgys4Ubi/7CNSicsmkCXZ4fpMHH7dkFhvyDTG
	 6pY7AZDxJ8R1sQfi96RBBeqy/yTSxlBSfyK6aBx0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0B599F80571;
	Mon, 20 Jun 2022 10:12:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7EAF4F8057D; Mon, 20 Jun 2022 10:12:49 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 571FBF80566
 for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2022 10:12:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 571FBF80566
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="msQ7GVo8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655712767; x=1687248767;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=pAoRV9qZAV0vIHCKPW5NwP8uZjCziWDwJzbXGyXGaQk=;
 b=msQ7GVo8xsO8LpTHQI32V/7qPFmgJ/xq4YQ2Kb2ee/JinfiOe+6W3HAV
 2FAD32Ku9c5jwx2nqft+GqarpeRG6fJ1ziCwRO7/MMg4xTN1L1UVvp8O/
 ufrAqffpc0TlhpVOV8vGF5BO5yNSL0QqxVW6LAHD7NNEDhU5Pzwd2OCx9
 f4bZOGIs0HGpIdNDnUNarSzJy5OPCfNWTowR9c3waoNITUvKOZBi7v36z
 XsL5mZGqXLzBhYKoX0ZtR61W6piPTywVqsUZXQr5VB62X4sDmHXzbAr3a
 gIBDX9YHp+HlC+lY/BQN2j90qk5Kh7Mld5xx0Tw0rLmVinrgqr8XbMgqK g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="305270942"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="305270942"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jun 2022 01:12:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="591067451"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga007.fm.intel.com with ESMTP; 20 Jun 2022 01:12:44 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH v3 14/17] ASoC: Intel: bdw_rt286: Improve hw_params()
 debug-ability
Date: Mon, 20 Jun 2022 10:22:23 +0200
Message-Id: <20220620082226.2489357-15-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220620082226.2489357-1-cezary.rojewski@intel.com>
References: <20220620082226.2489357-1-cezary.rojewski@intel.com>
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

Print status if setting sysclk fails.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
---
 sound/soc/intel/boards/bdw_rt286.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/bdw_rt286.c b/sound/soc/intel/boards/bdw_rt286.c
index 8624e52b4def..16bddf4c6dcd 100644
--- a/sound/soc/intel/boards/bdw_rt286.c
+++ b/sound/soc/intel/boards/bdw_rt286.c
@@ -98,7 +98,7 @@ static int codec_link_hw_params(struct snd_pcm_substream *substream,
 
 	ret = snd_soc_dai_set_sysclk(codec_dai, RT286_SCLK_S_PLL, 24000000, SND_SOC_CLOCK_IN);
 	if (ret < 0) {
-		dev_err(rtd->dev, "can't set codec sysclk configuration\n");
+		dev_err(rtd->dev, "set codec sysclk failed: %d\n", ret);
 		return ret;
 	}
 
-- 
2.25.1

