Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C32ECAAA1
	for <alsa-devel@archiver.kernel.org>; Mon, 31 Oct 2022 15:52:08 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 060D21666;
	Mon, 31 Oct 2022 16:51:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 060D21666
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1667231527;
	bh=kttBWUxr4l7KQq1LsUTjPVeB2x9oemA7VkNv07U5rJ0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XSQeffk+1wcx/ARXNLPkB8HUUxPFCcYXWWA6juzYn37Alb71pzd1KueZj2AP0Sh5N
	 7cGf4y8h3KS9IESTYTOViifKbjNDo1GS9Chvc6lUgWzTkeI+ewylBTM5xMsUv4Rv0C
	 dy38zkLVwwdyngRVzjT9CeS96k4hgrDSuPnr1p3M=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 90349F80578;
	Mon, 31 Oct 2022 16:50:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 09222F8055B; Mon, 31 Oct 2022 16:50:00 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 6E78BF802E8
 for <alsa-devel@alsa-project.org>; Mon, 31 Oct 2022 16:49:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 6E78BF802E8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="gFMjcdk9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1667231391; x=1698767391;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=kttBWUxr4l7KQq1LsUTjPVeB2x9oemA7VkNv07U5rJ0=;
 b=gFMjcdk9bwmHbrXMbKnHE1wBm92vLXIcd5io5bGAK99fbHjQ1WjRxwFA
 1J8sPx9zpH1VMJMYD7zhbZd0qHjMwf12EfRGRwAd8pOrvTpbG2wZ1WR5J
 wiJhVjjW4tK/iQLzgIfDH1A1W8GiX6qaSh5RjmhKDkq7f0xOotUpGZsBS
 3R+g1NJeJD7p3xfVH4FfCmPJj/cm7Nc9fsAvSvlauM9UbkECcuMqwS8Ax
 WKnU+A1KCJxwIRdd9ILc/Zv/RdyVynp54aCR4LfEiHM2GmfccfBsne47c
 T+09jsFOS4EyZe0uCU7P7wx9LWuA6hVokhexvxe88AXkMoLVAVRhoUFoG w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="308929940"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; d="scan'208";a="308929940"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Oct 2022 08:49:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="776178914"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; d="scan'208";a="776178914"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga001.fm.intel.com with ESMTP; 31 Oct 2022 08:49:45 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 4/7] ASoC: rockchip: Drop da7219_aad_jack_det() usage
Date: Mon, 31 Oct 2022 17:02:24 +0100
Message-Id: <20221031160227.2352630-5-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221031160227.2352630-1-cezary.rojewski@intel.com>
References: <20221031160227.2352630-1-cezary.rojewski@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, Vijendar.Mukunda@amd.com,
 heiko@sntech.de, AjitKumar.Pandey@amd.com, linux-rockchip@lists.infradead.org,
 tiwai@suse.com, pierre-louis.bossart@linux.intel.com, jiaxin.yu@mediatek.com,
 lgirdwood@gmail.com, hdegoede@redhat.com, Syed.SabaKareem@amd.com,
 amadeuszx.slawinski@linux.intel.com, trevor.wu@mediatek.com
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

Do not access the internal function directly, do so through
component->set_jack() instead.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/rockchip/rk3399_gru_sound.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/rockchip/rk3399_gru_sound.c b/sound/soc/rockchip/rk3399_gru_sound.c
index 2540b9ba37c8..5e52e9d60d44 100644
--- a/sound/soc/rockchip/rk3399_gru_sound.c
+++ b/sound/soc/rockchip/rk3399_gru_sound.c
@@ -21,7 +21,6 @@
 #include <sound/soc.h>
 #include "rockchip_i2s.h"
 #include "../codecs/da7219.h"
-#include "../codecs/da7219-aad.h"
 #include "../codecs/rt5514.h"
 
 #define DRV_NAME "rk3399-gru-sound"
@@ -226,7 +225,7 @@ static int rockchip_sound_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	snd_jack_set_key(
 		rockchip_sound_jack.jack, SND_JACK_BTN_3, KEY_VOICECOMMAND);
 
-	da7219_aad_jack_det(component, &rockchip_sound_jack);
+	snd_soc_component_set_jack(component, &rockchip_sound_jack, NULL);
 
 	return 0;
 }
-- 
2.25.1

