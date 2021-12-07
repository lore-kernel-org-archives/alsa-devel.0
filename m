Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04093C433F5
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Dec 2021 19:24:36 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3E544236E;
	Tue,  7 Dec 2021 20:23:44 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3E544236E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638905074;
	bh=Rmp88aXSrCFqpK9cVmOwX1k8uKU5naXuEGcZ2zcGcNA=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=CALdHW8TAZ33KsbNscyZIkKiqsqjJf6JSbwvOL4NEzGw/HPGtZmXlw4BWX1v7z9mB
	 UZQ0wdrhxRQEXltYBHqPjZdY8t3mmoEbixv3oUc+b4ZMId/OzAvJlYnrAeRlC4BOE1
	 K6vMyUpd4Kc+5x53B2HlnVZXCHudhmGb92fhZmLY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C054BF80253;
	Tue,  7 Dec 2021 20:23:43 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2A7FFF8028D; Tue,  7 Dec 2021 20:23:41 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 97B3AF80253
 for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2021 20:23:33 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 97B3AF80253
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="235180201"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; d="scan'208";a="235180201"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2021 11:23:28 -0800
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; d="scan'208";a="611800049"
Received: from nthiag2-mobl2.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.74.17])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Dec 2021 11:23:27 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: AMD: acp-config: fix missing dependency on SND_SOC_ACPI
Date: Tue,  7 Dec 2021 13:23:09 -0600
Message-Id: <20211207192309.43883-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, kernel test robot <lkp@intel.com>
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

With a custom .config, the following error is thrown:

ERROR: modpost: "snd_soc_acpi_codec_list"
[sound/soc/amd/snd-acp-config.ko] undefined!

Fix by adding a clear dependency on SND_SOC_ACPI

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/amd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/amd/Kconfig b/sound/soc/amd/Kconfig
index 8961b8fd23eb..bcfeb3fc2592 100644
--- a/sound/soc/amd/Kconfig
+++ b/sound/soc/amd/Kconfig
@@ -98,6 +98,7 @@ config SND_SOC_AMD_YC_MACH
 
 config SND_AMD_ACP_CONFIG
 	tristate "AMD ACP configuration selection"
+	depends on SND_SOC_ACPI
 	help
 	 This option adds an auto detection to determine which ACP
 	 driver modules to use
-- 
2.25.1

