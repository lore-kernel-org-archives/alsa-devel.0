Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32D5EC433EF
	for <alsa-devel@archiver.kernel.org>; Thu, 16 Jun 2022 22:06:37 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3B38B1B1C;
	Fri, 17 Jun 2022 00:05:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3B38B1B1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1655417195;
	bh=SBkbKyAS6K43AKtjdQ9J3OQe/d/Pnk74N8+Pm9fPK3w=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Oz2c1idQBakqlcxquoBTbaNQXT07zMeQF/vlS4cAYGkn5Sf+vIQr5OV4KdFCE8yKW
	 EZSgdzmGUKqqKfrQleN+YkopN6uSS3bynbcDuIfgaSRZ5j1QxNt3FkOiXPwjP6fzB/
	 /bFog5QAug3zUykZkudbJnHwu3rS5Y5NMnVKMxcA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E85A1F80535;
	Fri, 17 Jun 2022 00:04:52 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5A889F8012A; Fri, 17 Jun 2022 00:04:51 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 4D480F8012A
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2022 00:04:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4D480F8012A
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="G+K+8oj6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1655417088; x=1686953088;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=SBkbKyAS6K43AKtjdQ9J3OQe/d/Pnk74N8+Pm9fPK3w=;
 b=G+K+8oj69Qr+hQsSijM0G+kCt6BO1DYR/2PfcZEAyaUPQ3nHApfhDZe2
 UO2h9PoqDO8GMpKVUuHqdqiYvoamXm29Z6WcmCpG+y3vFg3ntfzd17RG0
 AawRueBYkrXlkwT2qHrLh7VZ9puZmcsppM2c7O9rCvvakYr21o7ls6dge
 vwjJsrwhjWmMDUbo+Bb8ArcjI0a7NQ8aJo9AhnHMQc4yxWPqaS1dDrkAC
 cc2OoERZyUYvMFldXjQCq9b/1b38t2zYbOXdj/rpmTWVIwyU7AePmVb1z
 1eBGQf9225Bd4pRXaIUfALypyQyeBohNpc8t0AhHrTRb7dekqneLeF05b A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="304810942"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="304810942"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2022 15:04:46 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; d="scan'208";a="728085004"
Received: from buckkenx-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.52.70])
 by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2022 15:04:45 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 06/11] ASoC: rockchip: i2s_tdm: use pm_runtime_resume_and_get()
Date: Thu, 16 Jun 2022 17:04:22 -0500
Message-Id: <20220616220427.136036-7-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
References: <20220616220427.136036-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Heiko Stuebner <heiko@sntech.de>, Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Liam Girdwood <lgirdwood@gmail.com>, tiwai@suse.de,
 open list <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
 "open list:ROCKCHIP I2S TDM DRIVER" <linux-rockchip@lists.infradead.org>,
 broonie@kernel.org, =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>
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

simplify the flow. No functionality change, except that on -EACCESS
the reference count will be decreased.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/rockchip/rockchip_i2s_tdm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s_tdm.c b/sound/soc/rockchip/rockchip_i2s_tdm.c
index 48b3ecfa58b46..70542a402477e 100644
--- a/sound/soc/rockchip/rockchip_i2s_tdm.c
+++ b/sound/soc/rockchip/rockchip_i2s_tdm.c
@@ -404,11 +404,9 @@ static int rockchip_i2s_tdm_set_fmt(struct snd_soc_dai *cpu_dai,
 	int ret;
 	bool is_tdm = i2s_tdm->tdm_mode;
 
-	ret = pm_runtime_get_sync(cpu_dai->dev);
-	if (ret < 0 && ret != -EACCES) {
-		pm_runtime_put_noidle(cpu_dai->dev);
+	ret = pm_runtime_resume_and_get(cpu_dai->dev);
+	if (ret < 0 && ret != -EACCES)
 		return ret;
-	}
 
 	mask = I2S_CKR_MSS_MASK;
 	switch (fmt & SND_SOC_DAIFMT_CLOCK_PROVIDER_MASK) {
-- 
2.34.1

