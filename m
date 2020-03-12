Return-Path: <SRS0=Zr1M=45=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 675D7C10DCE
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:52:58 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBFDB20637
	for <alsa-devel@archiver.kernel.org>; Thu, 12 Mar 2020 19:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="FKEa9q2Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFDB20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 52A581759;
	Thu, 12 Mar 2020 20:52:06 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 52A581759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1584042776;
	bh=LVabuym36BsCnSfkXSyjS9wfCbfBnN2MUnPh30NVyrs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FKEa9q2Z0zxES7/6ief2SerVvYe5iKXMRFWcwwsDfTcEClGoFW+lAqH04o827FnWH
	 ACy9q72JTu+BRv6LSyLhbaKvs6BJaxmnegaQWMK9vWqMDXyx0K0pDZ63ZuCrYEvOIm
	 1v3qCAiJQwSTq/fKdWh9nykCokI4Pp3EdRCs+bdY=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 9F3DEF802A2;
	Thu, 12 Mar 2020 20:49:51 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id DF2EAF802A0; Thu, 12 Mar 2020 20:49:46 +0100 (CET)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id AAD8CF800BE
 for <alsa-devel@alsa-project.org>; Thu, 12 Mar 2020 20:49:38 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz AAD8CF800BE
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Mar 2020 12:49:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,545,1574150400"; d="scan'208";a="416058386"
Received: from unknown (HELO pbossart-mobl3.amr.corp.intel.com)
 ([10.251.241.169])
 by orsmga005.jf.intel.com with ESMTP; 12 Mar 2020 12:49:20 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 04/10] ASoC: SOF: Intel: hda: remove
 SND_SOC_SOF_HDA_COMMON_HDMI_CODEC
Date: Thu, 12 Mar 2020 14:48:53 -0500
Message-Id: <20200312194859.4051-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200312194859.4051-1-pierre-louis.bossart@linux.intel.com>
References: <20200312194859.4051-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

From: Kai Vehmanen <kai.vehmanen@linux.intel.com>

To help user-space with HDMI codec driver transition, both
a kernel module parameter and a kernel option were initially
provided to configure default behaviour of SOF on Intel hardware
with commit 139c7febad1a ("ASoC: SOF: Intel: add support for
snd-hda-codec-hdmi").

As hdac-hdmi is already now lagging in features compared to
snd-hda-codec-hdmi, move ahead with the transition and remove
the build option to select between the two, and instead default
to snd-hda-codec-hdmi if it is enabled in kernel build.

The old behaviour of using hdac-hdmi driver can still be forced
via the kernel module parameter.

Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/Kconfig | 11 -----------
 sound/soc/sof/intel/hda.c   |  3 +--
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index 3bc64dee7c39..c9a2bee4b55c 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -324,17 +324,6 @@ config SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1
 	  Say Y if you want to enable DMI Link L1
 	  If unsure, select "N".
 
-config SND_SOC_SOF_HDA_COMMON_HDMI_CODEC
-	bool "SOF common HDA HDMI codec driver"
-	depends on SND_SOC_SOF_HDA_LINK
-	depends on SND_HDA_CODEC_HDMI
-	default SND_HDA_CODEC_HDMI
-	help
-	  This adds support for HDMI audio by using the common HDA
-	  HDMI/DisplayPort codec driver.
-	  Say Y if you want to use the common codec driver with SOF.
-	  If unsure select "Y".
-
 endif ## SND_SOC_SOF_HDA_COMMON
 
 config SND_SOC_SOF_HDA_LINK_BASELINE
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 7ca887041a34..1de750a1dd19 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -54,8 +54,7 @@ static int hda_dmic_num = -1;
 module_param_named(dmic_num, hda_dmic_num, int, 0444);
 MODULE_PARM_DESC(dmic_num, "SOF HDA DMIC number");
 
-static bool hda_codec_use_common_hdmi =
-	IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_COMMON_HDMI_CODEC);
+static bool hda_codec_use_common_hdmi = IS_ENABLED(CONFIG_SND_HDA_CODEC_HDMI);
 module_param_named(use_common_hdmi, hda_codec_use_common_hdmi, bool, 0444);
 MODULE_PARM_DESC(use_common_hdmi, "SOF HDA use common HDMI codec driver");
 #endif
-- 
2.20.1

