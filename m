Return-Path: <SRS0=OXo6=44=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D76C0044D
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:46:51 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15A5920734
	for <alsa-devel@archiver.kernel.org>; Wed, 11 Mar 2020 17:46:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XBbOJjky"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15A5920734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B9C591655;
	Wed, 11 Mar 2020 18:45:58 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B9C591655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1583948808;
	bh=XC0ISTlGcVCFciYOXMigPmUA3YH+kFqHaUkzCMimb08=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XBbOJjkyrM0R51SM/Dem/MHKrpbAj7O4iXEMPSjs4HszJ6LTGj99QGtDfqieXtEX+
	 kCXRlG8ZAGu9VI7R0bb28GBs8ZRf2Ej0Sy9ILN+LtVgZVvntGkTFzr/+n+qTizFYoq
	 BIHIl/PxCVLFX7Z/aqqWRuEcRe0//1EOwf5Kp7xM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 52866F801A3;
	Wed, 11 Mar 2020 18:45:58 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 2FCB1F801EB; Wed, 11 Mar 2020 18:45:56 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EC358F800BE
 for <alsa-devel@alsa-project.org>; Wed, 11 Mar 2020 18:45:49 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EC358F800BE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Mar 2020 10:45:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; d="scan'208";a="242756548"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by orsmga003.jf.intel.com with ESMTP; 11 Mar 2020 10:45:44 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH] MAINTAINERS: add entry for Sound Open Firmware drivers
Date: Wed, 11 Mar 2020 19:45:37 +0200
Message-Id: <20200311174537.24497-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: liam.r.girdwood@linux.intel.com, daniel.baluta@nxp.com,
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

Sound Open Firmware (SOF) is an open source audio DSP firwmare
instrastructure and SDK. The kernel drivers for SOF are part of
the ALSA subsystem.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Acked-by: Daniel Baluta <daniel.baluta@nxp.com>
Acked-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Acked-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d87507d53ca5..0b022b26bfa9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15618,6 +15618,17 @@ F:	sound/soc/
 F:	include/dt-bindings/sound/
 F:	include/sound/soc*
 
+SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS
+M:	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
+M:	Liam Girdwood <lgirdwood@gmail.com>
+M:	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
+M:	Kai Vehmanen <kai.vehmanen@linux.intel.com>
+M:	Daniel Baluta <daniel.baluta@nxp.com>
+L:	sound-open-firmware@alsa-project.org (moderated for non-subscribers)
+W:	https://github.com/thesofproject/linux/
+S:	Supported
+F:	sound/soc/sof/
+
 SOUNDWIRE SUBSYSTEM
 M:	Vinod Koul <vkoul@kernel.org>
 M:	Sanyog Kale <sanyog.r.kale@intel.com>
-- 
2.17.1

