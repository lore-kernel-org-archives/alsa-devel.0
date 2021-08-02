Return-Path: <SRS0=mFEw=MZ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB915C4338F
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 15:17:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5705060FF2
	for <alsa-devel@archiver.kernel.org>; Mon,  2 Aug 2021 15:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5705060FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E77A11732;
	Mon,  2 Aug 2021 17:16:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E77A11732
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1627917466;
	bh=BDIe9daKtKuSn4ban0/GgUvMK+lbJBNqXvGjVfhJm30=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=q8Yzg7OifjvWcmlthqoUBJUTfCpctoYvkFrrrwO8WjpB8CK7ZVGk23bkgDEqVsKnZ
	 yCeuGoDkeC89xOi6ZVD5T/JuK6WpfEHJMqLlJWeHxysmxO2m6Eo5zUgzZcM3EQUXMP
	 qLGlmKr7B4Q5IqhhKne4EmWIvzMz62gM1meJlZEA=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 76DA6F801F7;
	Mon,  2 Aug 2021 17:16:55 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 06C0BF80268; Mon,  2 Aug 2021 17:16:54 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C66B4F80095
 for <alsa-devel@alsa-project.org>; Mon,  2 Aug 2021 17:16:45 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz C66B4F80095
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="211604873"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; d="scan'208";a="211604873"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 08:16:43 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; d="scan'208";a="510257731"
Received: from skarumur-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.72.192])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Aug 2021 08:16:42 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: Intel: Kconfig: fix SoundWire dependencies
Date: Mon,  2 Aug 2021 10:16:28 -0500
Message-Id: <20210802151628.15291-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Arnd Bergmann <arnd@arndb.de>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Rander Wang <rander.wang@intel.com>, vkoul@kernel.org, broonie@kernel.org,
 Bard Liao <bard.liao@intel.com>
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

The previous Kconfig cleanup added simplifications but also introduced
a new one by moving a boolean to a tristate. This leads to randconfig
problems.

This patch moves the select operations in the SOUNDWIRE_LINK_BASELINE
option. The INTEL_SOUNDWIRE config remains a tristate for backwards
compatibility with older configurations but is essentially an on/off
switch.

Fixes: cf5807f5f814f ('ASoC: SOF: Intel: SoundWire: simplify Kconfig')
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
---
 sound/soc/sof/intel/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 4bce89b5ea40..4447f515e8b1 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -278,6 +278,8 @@ config SND_SOC_SOF_HDA
 
 config SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
 	tristate
+	select SOUNDWIRE_INTEL if SND_SOC_SOF_INTEL_SOUNDWIRE
+	select SND_INTEL_SOUNDWIRE_ACPI if SND_SOC_SOF_INTEL_SOUNDWIRE
 
 config SND_SOC_SOF_INTEL_SOUNDWIRE
 	tristate "SOF support for SoundWire"
@@ -285,8 +287,6 @@ config SND_SOC_SOF_INTEL_SOUNDWIRE
 	depends on SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE
 	depends on ACPI && SOUNDWIRE
 	depends on !(SOUNDWIRE=m && SND_SOC_SOF_INTEL_SOUNDWIRE_LINK_BASELINE=y)
-	select SOUNDWIRE_INTEL
-	select SND_INTEL_SOUNDWIRE_ACPI
 	help
 	  This adds support for SoundWire with Sound Open Firmware
 	  for Intel(R) platforms.
-- 
2.25.1

