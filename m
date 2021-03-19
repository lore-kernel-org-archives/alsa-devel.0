Return-Path: <SRS0=UTIM=IR=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B326C433E6
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 12:55:11 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A54364F6B
	for <alsa-devel@archiver.kernel.org>; Fri, 19 Mar 2021 12:55:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A54364F6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 4FBEF1672;
	Fri, 19 Mar 2021 13:54:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 4FBEF1672
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1616158507;
	bh=VPjKr+IwUPCtNpbEe98uPyshtFbeqQlrR7Lb8Ts9T/c=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=G93BFZUmB8kQAxfq6GqWuItGFGhtG/4geIjtzAL+7KZc+ba11Mm0FiHcZdQy/OSci
	 dZOrop96tN+3O5VPRyWHb410k2V3CAELxdUBAAY1s4FF4yy9PaRmq6uKyq029E4Woj
	 1XA6Ik6XU4mwpW5obDMrd7G4bZ+lHbZgqRpxAjVI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C2098F80124;
	Fri, 19 Mar 2021 13:54:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 182BEF8023C; Fri, 19 Mar 2021 13:54:15 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 43039F800BB
 for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2021 13:54:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 43039F800BB
IronPort-SDR: HVutJuLTbR+XvamNIBwqBMmKorSd9lG+B2aBOC+ziBpEQI4jJMeNBNl0apw43tHL5VOoTjPtpJ
 XEfuzPlqhFsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="186540314"
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; d="scan'208";a="186540314"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Mar 2021 05:54:00 -0700
IronPort-SDR: FiLC00qKu7QSIuFFPRS3AVT9cc95Xb+/a46WYrxrp4taJs+a4BI3dYT7g0cB7wWmdi90A3Uno/
 4dGojRyBvcGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,261,1610438400"; d="scan'208";a="441307084"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by FMSMGA003.fm.intel.com with ESMTP; 19 Mar 2021 05:53:57 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 2/2] ASoC: intel: sof_rt5682: use the topology mclk
Date: Fri, 19 Mar 2021 14:49:50 +0200
Message-Id: <20210319124950.3853994-2-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210319124950.3853994-1-kai.vehmanen@linux.intel.com>
References: <20210319124950.3853994-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 cezary.rojewski@intel.com, kai.vehmanen@linux.intel.com, lgirdwood@gmail.com,
 yung-chuan.liao@linux.intel.com, Keyon Jie <yang.jie@linux.intel.com>,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 Daniel Baluta <daniel.baluta@gmail.com>, daniel.baluta@nxp.com
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

From: Keyon Jie <yang.jie@linux.intel.com>

We should use the topology configured mclk if it existed, which can make
sure we are aligned with the FW side about the mclk usage.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index f4b898c1719f..58548ea0d915 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -16,6 +16,7 @@
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
 #include <sound/soc.h>
+#include <sound/sof.h>
 #include <sound/rt5682.h>
 #include <sound/soc-acpi.h>
 #include "../../codecs/rt1015.h"
@@ -268,10 +269,21 @@ static int sof_rt5682_hw_params(struct snd_pcm_substream *substream,
 		}
 
 		clk_id = RT5682_PLL1_S_MCLK;
-		if (sof_rt5682_quirk & SOF_RT5682_MCLK_24MHZ)
+
+		/* get the tplg configured mclk. */
+		clk_freq = sof_dai_get_mclk(rtd);
+
+		/* mclk from the quirk is the first choice */
+		if (sof_rt5682_quirk & SOF_RT5682_MCLK_24MHZ) {
+			if (clk_freq != 24000000)
+				dev_warn(rtd->dev, "configure wrong mclk in tplg, please use 24MHz.\n");
 			clk_freq = 24000000;
-		else
+		} else if (clk_freq == 0) {
+			/* use default mclk if not specified correct in topology */
 			clk_freq = 19200000;
+		} else if (clk_freq < 0) {
+			return clk_freq;
+		}
 	} else {
 		clk_id = RT5682_PLL1_S_BCLK1;
 		clk_freq = params_rate(params) * 50;
-- 
2.29.2

