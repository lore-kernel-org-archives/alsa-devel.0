Return-Path: <SRS0=/2j+=HM=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74CEC433DB
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 11:17:47 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 255C764E32
	for <alsa-devel@archiver.kernel.org>; Wed, 10 Feb 2021 11:17:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 255C764E32
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1107716CE;
	Wed, 10 Feb 2021 12:16:54 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1107716CE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612955864;
	bh=upzE0haZDPgU2kVrnp2imat+dpEn5SWNkPUCuDT/Pc0=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=fNu5cAYoujre7S0WeylABNlNHUJcdSOllKVaWKWJUrYshKZQHBZt6TKa0At2C3xY+
	 PqQslUkDLgWfTm/p9DMexDvifAGXIBX7inAX6lf3qpFhoVwOq9MALcdkHSSuozK22m
	 LIHeWefLLX3roi0+c842sKacaeD5xADwTAsKjieM=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9114DF80169;
	Wed, 10 Feb 2021 12:16:53 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5F7D3F8022B; Wed, 10 Feb 2021 12:16:52 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id B094EF80165
 for <alsa-devel@alsa-project.org>; Wed, 10 Feb 2021 12:16:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz B094EF80165
IronPort-SDR: ruCGZnawclYXc7nUtUDOq7rBgS4NJ54JKE9jyYEKV+ug3ehJdo8N2J5oq652qKtZ758AkiL7w+
 I7FYIbOnBMgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9890"; a="243545676"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; d="scan'208";a="243545676"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Feb 2021 03:16:37 -0800
IronPort-SDR: fA0USBW3sJBtJj9NciIQOmff9MbKXWXoslurslo6XyxTfe612fzQ2c4fCNzP6R9g/iGAWC+TVH
 k6vFZWCijefg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; d="scan'208";a="421012810"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga002.fm.intel.com with ESMTP; 10 Feb 2021 03:16:35 -0800
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	tiwai@suse.de
Subject: [PATCH] ALSA: hda: intel-dsp-config: add Alder Lake support
Date: Wed, 10 Feb 2021 13:13:10 +0200
Message-Id: <20210210111310.2227417-1-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Xiuli Pan <xiuli.pan@intel.com>, broonie@kernel.org,
 pierre-louis.bossart@linux.intel.com, kai.vehmanen@linux.intel.com,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

Add rules to select SOF driver for Alder Lake systems if a digital
microphone or SoundWire codecs are present in the system. This is
following same rules as for older Tiger Lake systems.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Xiuli Pan <xiuli.pan@intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/hda/intel-dsp-config.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

NOTES:
 - PCI id 0x51c8 is not yet in tiwai/master, but it's in Mark's 
   tree added with patch "ASoC: SOF: Intel: initial support to AlderLake-P"

diff --git a/sound/hda/intel-dsp-config.c b/sound/hda/intel-dsp-config.c
index 68bb977c6a37..d1eb9d34993a 100644
--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -321,6 +321,18 @@ static const struct config_entry config_table[] = {
 	},
 #endif
 
+/* Alder Lake */
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_ALDERLAKE)
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = 0x7ad0,
+	},
+	{
+		.flags = FLAG_SOF | FLAG_SOF_ONLY_IF_DMIC_OR_SOUNDWIRE,
+		.device = 0x51c8,
+	},
+#endif
+
 };
 
 static const struct config_entry *snd_intel_dsp_find_config

base-commit: fbd0a1d723513f82c9521c363e93967618517bb8
-- 
2.29.2

