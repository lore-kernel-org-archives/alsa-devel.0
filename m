Return-Path: <SRS0=LtCP=G4=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA7DBC433DB
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 11:56:15 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC0422D50
	for <alsa-devel@archiver.kernel.org>; Mon, 25 Jan 2021 11:56:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC0422D50
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B5C94181A;
	Mon, 25 Jan 2021 12:55:21 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B5C94181A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1611575771;
	bh=r9XUCXv9zxPQuVhZmkYwLVgjdrSk4dnLUqJSv3z3VTg=;
	h=From:To:Subject:Date:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=XlJrhbeqR4yGUWYt+K+E+efquFhSmivef7q2PTLDgx67IpE9pLbru6+OWAHBu4v4e
	 UAOTXkPEn8m/YUfrHspDTE3/IYG8mPPN3TYIS5dmxVIynUgifjT16WJcpkyVFCybEr
	 hKnqucOBPwAxUCSgqxToMy22ufzzsqmv4HSMVdlo=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 10391F80218;
	Mon, 25 Jan 2021 12:55:21 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id ED67BF80259; Mon, 25 Jan 2021 12:55:19 +0100 (CET)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 74251F80130
 for <alsa-devel@alsa-project.org>; Mon, 25 Jan 2021 12:55:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 74251F80130
IronPort-SDR: R42hPXSPhkQNWWkRJu88MJXnXMK6IkE0H1deMq9t7VI8hiAcJFsM76YFZbc/k1QgxmIhP9wC6y
 LOv79nIVKxgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9874"; a="176200984"
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; d="scan'208";a="176200984"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jan 2021 03:55:09 -0800
IronPort-SDR: dEwaccKEo31pfsASzxvn6B7tfQU8EiQPC8hZkvkX7AfVmvHtarVy0+JmZvzwwX/fJO6fliISkh
 5cMmsezZanBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,373,1602572400"; d="scan'208";a="350246098"
Received: from crojewsk-ctrl.igk.intel.com ([10.102.9.28])
 by fmsmga007.fm.intel.com with ESMTP; 25 Jan 2021 03:55:07 -0800
From: Cezary Rojewski <cezary.rojewski@intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH] ASoC: Intel: Skylake: Compile when any configuration is
 selected
Date: Mon, 25 Jan 2021 12:54:41 +0100
Message-Id: <20210125115441.10383-1-cezary.rojewski@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: kai.heng.feng@canonical.com, pierre-louis.bossart@linux.intel.com,
 Cezary Rojewski <cezary.rojewski@intel.com>, tiwai@suse.com,
 lgirdwood@gmail.com, hdegoede@redhat.com, broonie@kernel.org,
 amadeuszx.slawinski@linux.intel.com
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

Skylake is dependent on SND_SOC_INTEL_SKYLAKE (aka "all SST platforms")
whereas selecting specific configuration such as KBL-only will not
cause driver code to compile. Switch to SND_SOC_INTEL_SKYLAKE_COMMON
dependency so selecting any configuration causes the driver to be built.

Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Suggested-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>
Fixes: 35bc99aaa1a3 ("ASoC: Intel: Skylake: Add more platform granularity")
Signed-off-by: Cezary Rojewski <cezary.rojewski@intel.com>
---
 sound/soc/intel/Makefile         | 2 +-
 sound/soc/intel/skylake/Makefile | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/Makefile b/sound/soc/intel/Makefile
index 4e0248d2accc..7c5038803be7 100644
--- a/sound/soc/intel/Makefile
+++ b/sound/soc/intel/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_SND_SOC) += common/
 # Platform Support
 obj-$(CONFIG_SND_SST_ATOM_HIFI2_PLATFORM) += atom/
 obj-$(CONFIG_SND_SOC_INTEL_CATPT) += catpt/
-obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += skylake/
+obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON) += skylake/
 obj-$(CONFIG_SND_SOC_INTEL_KEEMBAY) += keembay/
 
 # Machine support
diff --git a/sound/soc/intel/skylake/Makefile b/sound/soc/intel/skylake/Makefile
index dd39149b89b1..1c4649bccec5 100644
--- a/sound/soc/intel/skylake/Makefile
+++ b/sound/soc/intel/skylake/Makefile
@@ -7,7 +7,7 @@ ifdef CONFIG_DEBUG_FS
   snd-soc-skl-objs += skl-debug.o
 endif
 
-obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE) += snd-soc-skl.o
+obj-$(CONFIG_SND_SOC_INTEL_SKYLAKE_COMMON) += snd-soc-skl.o
 
 #Skylake Clock device support
 snd-soc-skl-ssp-clk-objs := skl-ssp-clk.o
-- 
2.17.1

