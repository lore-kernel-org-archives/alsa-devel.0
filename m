Return-Path: <SRS0=Pn0z=6U=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834B0C38A24
	for <alsa-devel@archiver.kernel.org>; Wed,  6 May 2020 20:59:55 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D82522075E
	for <alsa-devel@archiver.kernel.org>; Wed,  6 May 2020 20:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="hZf7UgMX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D82522075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 3ABE117BA;
	Wed,  6 May 2020 22:59:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 3ABE117BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1588798793;
	bh=Dwt9pW9+CnT2FLsqVbuiP+42hxgsF32z343Wb78O6S0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hZf7UgMX++Un2vP6Ojl/EeIW2v8DjtMKbZZFC07HUnkOdX3wZExaYlDlnt+30dRfI
	 5gU5ItgJTLBHCsMjQqux8gDXJWAOJuJTDkjzj+VxzGX2mB/5LADCaqmzMqZWTuvvmn
	 fQtLKwd3VWAr/wL3YQ7CnseTZzDjNDuPGRrvdec8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C7F8CF80234;
	Wed,  6 May 2020 22:59:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id F03B5F80249; Wed,  6 May 2020 22:59:00 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 70ED2F800DF
 for <alsa-devel@alsa-project.org>; Wed,  6 May 2020 22:58:49 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70ED2F800DF
IronPort-SDR: jxwm49MaZw3H1TVD8cb3YgvXrxXvtPoR1VcvYsrr4voFYNYDHD5hmgRUQII9ZtrJfIW+e1en3I
 LVvt+wgtYWWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2020 13:58:47 -0700
IronPort-SDR: u94ftD5Pqj/3sSamWN7Yw67FntZjVDYsdNz2i8g3UKibwkdbZAvJPi0q2Vz+lyc0ZSQNU0uc4m
 uM9z/R9mGFSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,360,1583222400"; d="scan'208";a="284755719"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga004.fm.intel.com with ESMTP; 06 May 2020 13:58:45 -0700
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2] ASoC: Intel: Skylake: Update description for HDaudio
 kconfig
Date: Wed,  6 May 2020 22:58:39 +0200
Message-Id: <20200506205839.8028-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, broonie@kernel.org,
 tiwai@suse.com, pierre-louis.bossart@linux.intel.com
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

With 'ASoC: Intel: Skylake: Fix HDaudio and Dmic' series applied,
warning is no longer true. Remove it and update the description.

Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---

Changes in v2:
- no functional changes, removed 'or m' from description as this is a
  'bool' option

 sound/soc/intel/Kconfig | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index c8de0bb5bed9..e24ac896af19 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -209,12 +209,8 @@ config SND_SOC_INTEL_SKYLAKE_SSP_CLK
 config SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
 	bool "HDAudio codec support"
 	help
-	  This option broke audio on Linus' Skylake laptop in December 2018
-	  and the race conditions during the probe were not fixed since.
-	  This option is DEPRECATED, all HDaudio codec support needs
-	  to be handled by the SOF driver.
-	  Distributions should not enable this option and there are no known
-	  users of this capability.
+	  If you have Intel Skylake or Kabylake with HDaudio codec
+	  then enable this option by saying Y.
 
 config SND_SOC_INTEL_SKYLAKE_COMMON
 	tristate
-- 
2.17.1

