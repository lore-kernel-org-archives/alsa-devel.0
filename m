Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2619C433EF
	for <alsa-devel@archiver.kernel.org>; Mon, 13 Jun 2022 09:10:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3CCCD1853;
	Mon, 13 Jun 2022 11:09:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3CCCD1853
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655111435;
	bh=tr2wDNaVTECHOpRl79AxM8ibRU8M5ELTWdbmaXWe8nM=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=OjqgjNPHY+bEvPxUWsU/QqFFKwoPcK31/BZ65jKY4rxNJBWkLeWBnNtrbymP6dCxl
	 /W4wPFkjn/5AYakalTs1z+VHInk9qe2gja1rRTM5r+ZZPwjXbH/+2vwS1rYIn+Ofte
	 xhndjXg+zeWcR0r0BZRNNkJXukm58yJOYpy4jsqA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9E4B5F805A8;
	Mon, 13 Jun 2022 11:06:22 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 513EDF805B0; Mon, 13 Jun 2022 11:06:18 +0200 (CEST)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 39577F8057B
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2022 11:06:09 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 39577F8057B
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="LFf0HLyg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655111170; x=1686647170;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tr2wDNaVTECHOpRl79AxM8ibRU8M5ELTWdbmaXWe8nM=;
 b=LFf0HLygbQQx+sjH0qdeD7BSv6plnTtJQKwrB2No3xs049vFWyMRW9w2
 c+fP89mP/FPJmxhlGBzePnK9j18WAYyWy5jNNXS+SZ/JtJHf+Oso4RHRL
 bAZNlsEIZIOYoIVkxf8Cg9EHJmq8HD66YfHBaIKFTHWq20swjXB8eDR1f
 VXJA7TyCJZEQfyrjx+aTXZ6xob4sNk9dpTNM1WbFau53zCBBPaEc7bBox
 eiWGG/cdWZ3sPAy/zDW2m1jaDbpiGhWzqNxlUjAwxD79pR7825EpfVUFF
 s9jAj+DC9xtw7Mh4SGpGGE4WJ2DA++uHsFaMZQHDGONTdDfbWf5mRkNaj g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10376"; a="275753955"
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; d="scan'208";a="275753955"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jun 2022 02:05:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,296,1647327600"; d="scan'208";a="639626224"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga008.fm.intel.com with ESMTP; 13 Jun 2022 02:05:55 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH v2 14/17] ASoC: Intel: bdw_rt286: Improve hw_params()
 debug-ability
Date: Mon, 13 Jun 2022 11:15:43 +0200
Message-Id: <20220613091546.1565167-15-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613091546.1565167-1-cezary.rojewski@intel.com>
References: <20220613091546.1565167-1-cezary.rojewski@intel.com>
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
index 5e86f477114a..c21f71b477d5 100644
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

