Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C778C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  3 Dec 2021 15:56:10 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id F391D2123;
	Fri,  3 Dec 2021 16:55:17 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz F391D2123
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1638546968;
	bh=NzMZtQiL4k67llzKxL723JVsquTZRweSE87meq0FaKU=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=uKb7/2MT9+xRyBQGs+eMTJaUAEV6tyeDCuMRAKfxEVQ9bWeAVefIV4U5bCL0INaS+
	 NVqANwhR/yFZcIc8fbeGW2GXinlmXbQ+zEEgCqq4l1JlO81C3MBfU1H2006A+41RzE
	 wUVVEZnGkK0/Y2i5bwgcLuImyyK4fOEKHuD5tuNc=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id C3737F8015B;
	Fri,  3 Dec 2021 16:55:16 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DBCB1F80246; Fri,  3 Dec 2021 16:55:14 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5B532F800A7
 for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2021 16:55:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5B532F800A7
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="234503077"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; d="scan'208";a="234503077"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Dec 2021 07:55:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; d="scan'208";a="598014398"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2021 07:55:02 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH] ASoC: SOF: Intel: fix build issue related to
 CODEC_PROBE_ENTRIES
Date: Fri,  3 Dec 2021 17:47:21 +0200
Message-Id: <20211203154721.923496-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kernel test robot <lkp@intel.com>, kai.vehmanen@linux.intel.com,
 yung-chuan.liao@linux.intel.com, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 daniel.baluta@nxp.com
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

Fix following error:
sound/soc/sof/intel/hda-codec.c:132:35: error: use of undeclared identifier 'CODEC_PROBE_RETRIES'

Found with config: i386-randconfig-r033-20211202
(https://download.01.org/0day-ci/archive/20211203/202112031943.Twg19fWT-lkp@intel.com/config)

Fixes: 046aede2f847 ("ASoC: SOF: Intel: Retry codec probing if it fails")
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda-codec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 13cd96e6724a..2f3f4a733d9e 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -20,9 +20,10 @@
 #include "../../codecs/hdac_hda.h"
 #endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
 
+#define CODEC_PROBE_RETRIES	3
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
 #define IDISP_VID_INTEL	0x80860000
-#define CODEC_PROBE_RETRIES 3
 
 /* load the legacy HDA codec driver */
 static int request_codec_module(struct hda_codec *codec)

base-commit: 3fc27e9a1f619b50700f020e6cd270c1b74755f0
-- 
2.34.1

