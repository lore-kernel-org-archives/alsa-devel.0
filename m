Return-Path: <SRS0=nFZf=IA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE42C433E0
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 00:35:04 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4066864D90
	for <alsa-devel@archiver.kernel.org>; Tue,  2 Mar 2021 00:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4066864D90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 27F84168B;
	Tue,  2 Mar 2021 01:34:12 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 27F84168B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614645302;
	bh=iU1Dqou1SX3gMImOvPmTOLh+wtZtc0S9YsA0wVpI9yQ=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=N8veT3ZyJIbkCFN20+FW8ZtBg+rwL7rlpG1Bvg12lxR6C2VFswXR8Fre4Bqaz7gNx
	 w6Fm79dbTpsqgbKO3st486bmRFMzO4QRdH1+IM31aFgKkb9LZK+Clt4APXlV1qu9s8
	 tKeHwD3360TCgp/YX6v/tooHIaS3Uajd5Yio/7rM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 93084F804AB;
	Tue,  2 Mar 2021 01:31:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C6951F80475; Tue,  2 Mar 2021 01:31:55 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 585D1F802DF
 for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2021 01:31:46 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 585D1F802DF
IronPort-SDR: t0YIoF+Y20AnVYvznhiZAMGk7/8lZ2nkXlUiMJ9YygmF8Ipjj+Pl3MzZdEguxW8/XJ6BE8lKaW
 MT9YJZsrQ3qA==
X-IronPort-AV: E=McAfee;i="6000,8403,9910"; a="248048794"
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="248048794"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 16:31:46 -0800
IronPort-SDR: OQU2On855c9zhPJzAGdj0qCqRXeRRjuIaW05Lvee4wNQM0dGBCsMUviRBXm9zxOBq0IFGfulsf
 oqink6orrrQQ==
X-IronPort-AV: E=Sophos;i="5.81,216,1610438400"; d="scan'208";a="444512592"
Received: from josemrod-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.215.233])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Mar 2021 16:31:44 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 5/7] ASoC: SOF: Intel: SoundWire: simplify Kconfig
Date: Mon,  1 Mar 2021 18:31:23 -0600
Message-Id: <20210302003125.1178419-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210302003125.1178419-1-pierre-louis.bossart@linux.intel.com>
References: <20210302003125.1178419-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, arnd@arndb.de, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, vkoul@kernel.org,
 broonie@kernel.org, Bard Liao <bard.liao@intel.com>
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

The Kconfig file is way too convoluted. Track platforms where
SoundWire is supported, and add simpler conditions to make sure there
is no module/built-in issue.

The use of 'depends on' is less intuitive if a required 'depend' is
missing, but that's a small price to pay for clarity and simplicity.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
---
 sound/soc/sof/intel/Kconfig | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 7dcb61ba5763..21e24a3c64fb 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -276,29 +276,21 @@ config SND_SOC_SOF_HDA
 	  This option is not user-selectable but automagically handled by
 	  'select' statements at a higher level.
 
-config SND_SOC_SOF_INTEL_SOUNDWIRE_LINK
-	bool "SOF support for SoundWire"
-	depends on ACPI
-	help
-	  This adds support for SoundWire with Sound Open Firmware
-	  for Intel(R) platforms.
-	  Say Y if you want to enable SoundWire links with SOF.
-	  If unsure select "N".
-
 config SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
 	tristate
-	select SND_SOC_SOF_INTEL_SOUNDWIRE if SND_SOC_SOF_INTEL_SOUNDWIRE_LINK
-	help
-	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level.
 
 config SND_SOC_SOF_INTEL_SOUNDWIRE
-	tristate
-	select SOUNDWIRE
+	tristate "SOF support for SoundWire"
+	default SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
+	depends on SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
+	depends on ACPI && SOUNDWIRE
+	depends on !(SOUNDWIRE=m && SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=y)
 	select SOUNDWIRE_INTEL
 	help
-	  This option is not user-selectable but automagically handled by
-	  'select' statements at a higher level.
+	  This adds support for SoundWire with Sound Open Firmware
+	  for Intel(R) platforms.
+	  Say Y if you want to enable SoundWire links with SOF.
+	  If unsure select "N".
 
 endif ## SND_SOC_SOF_INTEL_PCI
 
-- 
2.25.1

