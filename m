Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B580C433F5
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Jan 2022 05:42:14 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E44832EFC;
	Thu, 20 Jan 2022 06:41:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E44832EFC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1642657332;
	bh=n2chdbr+BdcpZ2Ap4JnU+Yn5y2Tg0DWqA8Cjh1BJA5Q=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fmM6Uc9Yh9JBlPd7RUxGrYPwYxd/kqnN/utv+JlrfAjwAIPrjgUdEnCWQIt3bv5/8
	 /lQVM4tOidqOgt5FwG6gx5gGFex1qw5Z+xn02ymVUUbasivu1jlyZjJVb/gcAsKFUq
	 qNlTAj5Lr5P+xeIVcn3d0QRYm/Yx6ynsRjJ5ZDAw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 71280F80128;
	Thu, 20 Jan 2022 06:41:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D7CD2F8012E; Thu, 20 Jan 2022 06:41:19 +0100 (CET)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BD4EBF800F8
 for <alsa-devel@alsa-project.org>; Thu, 20 Jan 2022 06:41:13 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BD4EBF800F8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="AwU5Dsh3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1642657276; x=1674193276;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=n2chdbr+BdcpZ2Ap4JnU+Yn5y2Tg0DWqA8Cjh1BJA5Q=;
 b=AwU5Dsh3TGJvSOoKP0C8EVr5iy+84/cH9275Bq9OQ3BueqcZod8kCf/A
 WB4NpcpILcnV/oWo3/z3h/lqcXzo7WlQx1EIXQBXUkvHFVTnUzM4vfnwq
 EyIdJ3htAGEFZwXmRy4SauHeWD+oFJIW4Amd1HgxvGwMowEbI+OO4rYBU
 hKqlszqivIDxvRC2mL8aOGDOrgtH5qK6+oAL7vf1RhMv6GNuKTVtq2gYc
 CuEMxnUwYU4qY1+yKB+fupNKeRmJyS1+5Y+781tCTGKOHmNL9J6iXml+H
 d3lTMr0bohsqN/piksvCeHgLA4+h/YWjixsQE9bxGTJxmabLUYjbH2RGi g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="245473661"
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; d="scan'208";a="245473661"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jan 2022 21:41:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; d="scan'208";a="626169920"
Received: from macchian-builder.itwn.intel.com ([10.5.253.188])
 by orsmga004.jf.intel.com with ESMTP; 19 Jan 2022 21:41:07 -0800
From: Mac Chiang <mac.chiang@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ASoC: Intel: sof_rt5682: add 512FS MCLK clock configuration
Date: Thu, 20 Jan 2022 00:40:12 -0500
Message-Id: <20220120054012.15849-1-mac.chiang@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: guennadi.liakhovetski@linux.intel.com, kai.vehmanen@linux.intel.com,
 pierre-louis.bossart@linux.intel.com, liam.r.girdwood@linux.intel.com,
 mac.chiang@intel.com, broonie@kernel.org, shumingf@realtek.com,
 brent.lu@intel.com
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

codec system clock source support 512FS MCLK synchronous directly, so
no need to set PLL configuration when MCLK 24.576MHz.

Suggested-by: Shuming Fan <shumingf@realtek.com>
Signed-off-by: Mac Chiang <mac.chiang@intel.com>
---
Changelog:

v2:
  - apply mclk configuration to both rt5682vd and rt5682vs
  - Thanks to Brent by suggesting pll_in condition if MCLK or
    PLL requires.
---
 sound/soc/intel/boards/sof_rt5682.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index bd6d2e7dea53..f4e833cbffe1 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -369,11 +369,16 @@ static int sof_rt5682_hw_params(struct snd_pcm_substream *substream,
 
 	pll_out = params_rate(params) * 512;
 
-	/* Configure pll for codec */
-	ret = snd_soc_dai_set_pll(codec_dai, pll_id, pll_source, pll_in,
-				  pll_out);
-	if (ret < 0)
-		dev_err(rtd->dev, "snd_soc_dai_set_pll err = %d\n", ret);
+	/* when MCLK is 512FS, no need to set PLL configuration additionally. */
+	if (pll_in == pll_out)
+		clk_id = RT5682S_SCLK_S_MCLK;
+	else {
+		/* Configure pll for codec */
+		ret = snd_soc_dai_set_pll(codec_dai, pll_id, pll_source, pll_in,
+					  pll_out);
+		if (ret < 0)
+			dev_err(rtd->dev, "snd_soc_dai_set_pll err = %d\n", ret);
+	}
 
 	/* Configure sysclk for codec */
 	ret = snd_soc_dai_set_sysclk(codec_dai, clk_id,
-- 
2.20.1

