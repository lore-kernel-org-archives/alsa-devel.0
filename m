Return-Path: <SRS0=7OoL=EF=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C07C00A89
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:19:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D67172083B
	for <alsa-devel@archiver.kernel.org>; Fri, 30 Oct 2020 17:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="oyLgXCC1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D67172083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 21E5B1663;
	Fri, 30 Oct 2020 18:18:08 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 21E5B1663
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1604078338;
	bh=PoxswvhHn5xOV4gcbHvYMA420DBiT0mALEIcLoI733k=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oyLgXCC1Q9Cwq+2fYkIPO2qURa/DhhImgWMCeFETIdtJGbXQuu6CM30IQoHfBXCOw
	 bS1DG73xUvNMJZuiC/OeTLEVQObxoeOgfiOgXJUyQRcNNhHnl1sI6k+FKl5bmexJPw
	 2RQuRqdH4b542S2ZZuhxiyE3tasgmnmjQnC7P96s=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 64B24F8027C;
	Fri, 30 Oct 2020 18:17:24 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2438BF8028B; Fri, 30 Oct 2020 18:17:22 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9F8EBF8027C
 for <alsa-devel@alsa-project.org>; Fri, 30 Oct 2020 18:17:14 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9F8EBF8027C
IronPort-SDR: pvW9hIjh6T+Mqw0fkUNKPvgOEGORhAu/vDJ9i7aRby20RmexzvJKOBuPbG6yUq3i1YIf5RjcF7
 mbdxM4Pu4YwA==
X-IronPort-AV: E=McAfee;i="6000,8403,9790"; a="155614094"
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; d="scan'208";a="155614094"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Oct 2020 10:17:11 -0700
IronPort-SDR: 1kklI0b9O1wKMbbpvK/ZW2KDzAGwZBabH/P6SCpUgvKOB81gxahNsi0TinDJ1ft+YdwxAcZKWJ
 c3fhczMXsJaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,434,1596524400"; d="scan'208";a="469584718"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
 by orsmga004.jf.intel.com with ESMTP; 30 Oct 2020 10:17:08 -0700
From: Brent Lu <brent.lu@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 2/2] ASoC: intel: sof_rt5682: Add quirk for Dooly
Date: Sat, 31 Oct 2020 01:05:59 +0800
Message-Id: <20201030170559.20370-3-brent.lu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201030170559.20370-1-brent.lu@intel.com>
References: <20201030170559.20370-1-brent.lu@intel.com>
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Cezary Rojewski <cezary.rojewski@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jason Yan <yanaijie@huawei.com>,
 linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
 Jie Yang <yang.jie@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 Fred Oh <fred.oh@linux.intel.com>, Rander Wang <rander.wang@intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>, Brent Lu <brent.lu@intel.com>,
 Yong Zhi <yong.zhi@intel.com>
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

This DMI product family string of this board is "Google_Hatch" so the
DMI quirk will take place. However, this board is using rt1015 speaker
amp instead of max98357a specified in the quirk. Therefore, we need an
new DMI quirk for this board.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 7701957e0eb7..e7d9a82ca70d 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -100,6 +100,24 @@ static const struct dmi_system_id sof_rt5682_quirk_table[] = {
 					SOF_RT5682_MCLK_24MHZ |
 					SOF_RT5682_SSP_CODEC(1)),
 	},
+	{
+		/*
+		 * Dooly is hatch family but using rt1015 amp so it
+		 * requires a quirk before "Google_Hatch".
+		 */
+		.callback = sof_rt5682_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Dooly"),
+		},
+		.driver_data = (void *)(SOF_RT5682_MCLK_EN |
+					SOF_RT5682_MCLK_24MHZ |
+					SOF_RT5682_SSP_CODEC(0) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_RT1015_SPEAKER_AMP_PRESENT |
+					SOF_RT1015_SPEAKER_AMP_100FS |
+					SOF_RT5682_SSP_AMP(1)),
+	},
 	{
 		.callback = sof_rt5682_quirk_cb,
 		.matches = {
-- 
2.17.1

