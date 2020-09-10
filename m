Return-Path: <SRS0=ofM/=CT=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B737C43461
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:29:50 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0261720C09
	for <alsa-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="G8/+YTRf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0261720C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A0941169C;
	Thu, 10 Sep 2020 18:28:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A0941169C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1599755386;
	bh=32Hks31+zGzCBa1zku+DMR8mnb04ap2/hFl9LVNqpW8=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=G8/+YTRf08umO2XwAec9azI8yhjctD6aegfCXw3y5Z8a0/K9G0awx04A2i8U5lSv2
	 SgZ8Prr0tXR08sI7MkQcfqnMniXa8HXZaZWuGFntSRIJVraEtHXEYTd1JHfTAjjqQw
	 AJjUD1x4V3WmXVVT/nuqSEzMgI24aUsxAtRAGXDo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 00A88F801F2;
	Thu, 10 Sep 2020 18:28:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 77480F80264; Thu, 10 Sep 2020 18:28:52 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3A9E3F800E9
 for <alsa-devel@alsa-project.org>; Thu, 10 Sep 2020 18:28:38 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3A9E3F800E9
IronPort-SDR: t2muNBBvThZBwbQxA9XAEIpMXbsxFzeUoMiMrROcBfnwSHfsa63DuGCuB2wroCZg/og7LKyuTL
 gSgOB0pC8ykg==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="159526886"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="159526886"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2020 09:28:35 -0700
IronPort-SDR: tjZhGsiTDXcRr/oU3I+9esIF1DOhR+Z8Z+yKJKX2YBhMQPH+aozoG5/n2vPylAwUgF5Xvsfee5
 71hsPzNL308g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; d="scan'208";a="300607147"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga003.jf.intel.com with ESMTP; 10 Sep 2020 09:28:33 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH] ASoC: SOF: Intel: Use DMI oem string search for
 tgl_max98373_rt5682
Date: Thu, 10 Sep 2020 19:27:05 +0300
Message-Id: <20200910162705.2026036-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: lgirdwood@gmail.com,
 Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 ranjani.sridharan@linux.intel.com
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

From: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>

DMI product name is used to support system variants based out of
tgl_max98373_rt5682 in current implementation. Replace this DMI search with
DMI_OEM_STRING. Coreboot(BIOS used in these systems) is
setting the needed DMI_OEM_STRING field to uniquely identify these
systems.

Signed-off-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c | 2 +-
 sound/soc/sof/sof-pci-dev.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 9a6f10ede427..ddbb9fe7cc06 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -123,7 +123,7 @@ static const struct dmi_system_id sof_rt5682_quirk_table[] = {
 		.callback = sof_rt5682_quirk_cb,
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Volteer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Terrador"),
+			DMI_MATCH(DMI_OEM_STRING, "AUDIO-MAX98373_ALC5682I_I2S_UP4"),
 		},
 		.driver_data = (void *)(SOF_RT5682_MCLK_EN |
 					SOF_RT5682_SSP_CODEC(0) |
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index ec62d9337d68..3ec380945466 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -50,7 +50,7 @@ static const struct dmi_system_id sof_tplg_table[] = {
 		.callback = sof_tplg_cb,
 		.matches = {
 			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Volteer"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "Terrador"),
+			DMI_MATCH(DMI_OEM_STRING, "AUDIO-MAX98373_ALC5682I_I2S_UP4"),
 		},
 		.driver_data = "sof-tgl-rt5682-ssp0-max98373-ssp2.tplg",
 	},
-- 
2.27.0

