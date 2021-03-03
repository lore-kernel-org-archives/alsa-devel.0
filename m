Return-Path: <SRS0=LSvA=IB=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D01C433E0
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 18:18:03 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BF5A64EF1
	for <alsa-devel@archiver.kernel.org>; Wed,  3 Mar 2021 18:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BF5A64EF1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id AD35318C9;
	Wed,  3 Mar 2021 19:17:09 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz AD35318C9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1614795479;
	bh=IEOp8MBsY3d/G1Cyh9oualCfbRpIzIkEhqu9NObE60g=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uYkDGK7eUl8ZwuuurBqDHKMiXWQtu8HIWPjhGl2FxzNTTvzrJJjB3SgHfUf3SUr6P
	 HSfKEUT3fnXsoGuXiaahtoHG5i2cPs2Co3AmMJjnME0PDQ0gkPdxK5EBk41Jkqru1A
	 lUI/fxGdfoU5JrCSkoWO5sgWTRjA8jRn6QreH9yw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 161A4F80257;
	Wed,  3 Mar 2021 19:17:09 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 868F0F8025E; Wed,  3 Mar 2021 19:17:06 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 55036F800B2
 for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2021 19:16:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 55036F800B2
IronPort-SDR: oajL/lIfQOcKCKISjdjltWcjsgo/biE8oWVzbYCv+fUQL+UIVMBywiOxRdEtsR9CoEY4+KRDAB
 KFbwf1Rkd3nw==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="174370807"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="174370807"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 10:16:45 -0800
IronPort-SDR: cOf90AQyb9De2CTaWbzX0NfwnXuXktIRnt8+Nr1Q+EB628w5i/FkaYPRsvoCju00ybGGSos2oD
 LIOIk4NXiLAA==
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; d="scan'208";a="384088299"
Received: from usathe-mobl.gar.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.255.229.75])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Mar 2021 10:16:44 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: SOF: Intel: broadwell: fix mutual exclusion with catpt
 driver
Date: Wed,  3 Mar 2021 12:16:16 -0600
Message-Id: <20210303181616.16751-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 David Ward <david.ward@ll.mit.edu>, broonie@kernel.org, stable@kernel.org
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

In v5.10, the "haswell" driver was replaced by the "catpt" driver, but
the mutual exclusion with the SOF driver was not updated. This leads
to errors with card names and UCM profiles not being loaded by
PulseAudio.

This fix should only be applied on v5.10-stable, the mutual exclusion
was removed in 5.11.

Reported-by: David Ward <david.ward@ll.mit.edu>
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=211985
Fixes: 6cbfa11d2694 ("ASoC: Intel: Select catpt and deprecate haswell")
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
Cc: <stable@kernel.org>
---
 sound/soc/sof/intel/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index de7ff2d097ab..6708a2c5a838 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -84,7 +84,7 @@ config SND_SOC_SOF_BAYTRAIL
 
 config SND_SOC_SOF_BROADWELL_SUPPORT
 	bool "SOF support for Broadwell"
-	depends on SND_SOC_INTEL_HASWELL=n
+	depends on SND_SOC_INTEL_CATPT=n
 	help
 	  This adds support for Sound Open Firmware for Intel(R) platforms
 	  using the Broadwell processors.
-- 
2.25.1

