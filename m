Return-Path: <SRS0=/b47=CC=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EC5C433E3
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:15:23 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E500A206BE
	for <alsa-devel@archiver.kernel.org>; Mon, 24 Aug 2020 20:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="E7v1lAFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E500A206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 489211682;
	Mon, 24 Aug 2020 22:14:31 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 489211682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1598300121;
	bh=xzztEClDbdR949gDErMsz71e4yIXGzV49DKIfHCHWq8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E7v1lAFDsT63tbKBopbpZIKPUzLeRdXsilRVs4plRq0CYIOh5FTWccIEUfd50m7rP
	 vOGr9v9vavm3jenw7lnqcWBB05KWhTpCmQmKYu6A33Ay7x/0nNpIShFHBA5/IDLKUU
	 KKl2jaQl/YTXSJ3s+7UF77C7ZuU/gVogT+xpN8QI=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id DCB42F80303;
	Mon, 24 Aug 2020 22:09:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id E137BF802E3; Mon, 24 Aug 2020 22:09:44 +0200 (CEST)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BFE53F8020C
 for <alsa-devel@alsa-project.org>; Mon, 24 Aug 2020 22:09:32 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz BFE53F8020C
IronPort-SDR: gbiWK+fboHetKpxSUoxi5eITS6V7dVuEV1o5yk2qwCWncXAA6f010H8zKLK6GnDFeE5iO6ouLc
 uG3v7Anp4ALQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="157033737"
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; d="scan'208";a="157033737"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2020 13:09:28 -0700
IronPort-SDR: OVeznGlXtABBDFb0USs51f/5sHpq7N5jmBsYrbJsWojjgfSuhbrym7hCWuOnmDM1D60C9UsYiU
 3adcvSfWXE+Q==
X-IronPort-AV: E=Sophos;i="5.76,349,1592895600"; d="scan'208";a="443351218"
Received: from dentoneb-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.223.13])
 by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Aug 2020 13:09:27 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 8/8] ASoC: Intel: use consistent HDAudio spelling in
 comments/docs
Date: Mon, 24 Aug 2020 15:09:12 -0500
Message-Id: <20200824200912.46852-9-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824200912.46852-1-pierre-louis.bossart@linux.intel.com>
References: <20200824200912.46852-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de,
 Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 broonie@kernel.org, Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
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

We use HDaudio and HDAudio, pick one to make searches easier.
No functionality change

Reported-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/soc-acpi.h      | 2 +-
 sound/soc/intel/Kconfig       | 2 +-
 sound/soc/intel/skylake/skl.c | 6 +++---
 sound/soc/sof/Kconfig         | 2 +-
 sound/soc/sof/intel/Kconfig   | 2 +-
 sound/soc/sof/pcm.c           | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/sound/soc-acpi.h b/include/sound/soc-acpi.h
index d2e9e3b4d7ea..b77b05c413a3 100644
--- a/include/sound/soc-acpi.h
+++ b/include/sound/soc-acpi.h
@@ -58,7 +58,7 @@ static inline struct snd_soc_acpi_mach *snd_soc_acpi_codec_list(void *arg)
  * snd_soc_acpi_mach_params: interface for machine driver configuration
  *
  * @acpi_ipc_irq_index: used for BYT-CR detection
- * @platform: string used for HDaudio codec support
+ * @platform: string used for HDAudio codec support
  * @codec_mask: used for HDAudio support
  * @common_hdmi_codec_drv: use commom HDAudio HDMI codec driver
  * @link_mask: links enabled on the board
diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
index 82805a8681e5..0e48c4f532ce 100644
--- a/sound/soc/intel/Kconfig
+++ b/sound/soc/intel/Kconfig
@@ -209,7 +209,7 @@ config SND_SOC_INTEL_SKYLAKE_SSP_CLK
 config SND_SOC_INTEL_SKYLAKE_HDAUDIO_CODEC
 	bool "HDAudio codec support"
 	help
-	  If you have Intel Skylake or Kabylake with HDaudio codec
+	  If you have Intel Skylake or Kabylake with HDAudio codec
 	  and DMIC present then enable this option by saying Y.
 
 config SND_SOC_INTEL_SKYLAKE_COMMON
diff --git a/sound/soc/intel/skylake/skl.c b/sound/soc/intel/skylake/skl.c
index 63182bfd7941..ea00cf61d1a8 100644
--- a/sound/soc/intel/skylake/skl.c
+++ b/sound/soc/intel/skylake/skl.c
@@ -925,7 +925,7 @@ static int skl_first_init(struct hdac_bus *bus)
 
 	/* check if PPCAP exists */
 	if (!bus->ppcap) {
-		dev_err(bus->dev, "bus ppcap not set, HDaudio or DSP not present?\n");
+		dev_err(bus->dev, "bus ppcap not set, HDAudio or DSP not present?\n");
 		return -ENODEV;
 	}
 
@@ -986,7 +986,7 @@ static int skl_probe(struct pci_dev *pci,
 			return -ENODEV;
 		break;
 	case SND_SKL_PCI_BIND_LEGACY:
-		dev_info(&pci->dev, "Module parameter forced binding with HDaudio legacy, aborting probe\n");
+		dev_info(&pci->dev, "Module parameter forced binding with HDAudio legacy, aborting probe\n");
 		return -ENODEV;
 	case SND_SKL_PCI_BIND_ASOC:
 		dev_info(&pci->dev, "Module parameter forced binding with SKL driver, bypassed detection logic\n");
@@ -1021,7 +1021,7 @@ static int skl_probe(struct pci_dev *pci,
 		err = -ENODEV;
 		goto out_free;
 #else
-		dev_warn(bus->dev, "no nhlt info found, continuing to try to enable HDaudio codec\n");
+		dev_warn(bus->dev, "no nhlt info found, continuing to try to enable HDAudio codec\n");
 #endif
 	} else {
 
diff --git a/sound/soc/sof/Kconfig b/sound/soc/sof/Kconfig
index 4dda4b62509f..8c1f0829de40 100644
--- a/sound/soc/sof/Kconfig
+++ b/sound/soc/sof/Kconfig
@@ -73,7 +73,7 @@ config SND_SOC_SOF_NOCODEC_SUPPORT
 	  option if no known codec is detected. This is typically only
 	  enabled for developers or devices where the sound card is
 	  controlled externally
-	  This option is mutually exclusive with the Intel HDaudio support,
+	  This option is mutually exclusive with the Intel HDAudio support,
 	  selecting it may have negative impacts and prevent e.g. microphone
 	  functionality from being enabled on Intel CoffeeLake and later
 	  platforms.
diff --git a/sound/soc/sof/intel/Kconfig b/sound/soc/sof/intel/Kconfig
index f644010cc568..a066e08860cb 100644
--- a/sound/soc/sof/intel/Kconfig
+++ b/sound/soc/sof/intel/Kconfig
@@ -311,7 +311,7 @@ config SND_SOC_SOF_HDA_ALWAYS_ENABLE_DMI_L1
 	bool "SOF enable DMI Link L1"
 	help
 	  This option enables DMI L1 for both playback and capture
-	  and disables known workarounds for specific HDaudio platforms.
+	  and disables known workarounds for specific HDAudio platforms.
 	  Only use to look into power optimizations on platforms not
 	  affected by DMI L1 issues. This option is not recommended.
 	  Say Y if you want to enable DMI Link L1
diff --git a/sound/soc/sof/pcm.c b/sound/soc/sof/pcm.c
index 30e667daffe4..4c5082b7eea9 100644
--- a/sound/soc/sof/pcm.c
+++ b/sound/soc/sof/pcm.c
@@ -704,7 +704,7 @@ static int sof_pcm_dai_link_fixup(struct snd_soc_pcm_runtime *rtd,
 		break;
 	case SOF_DAI_INTEL_HDA:
 		/*
-		 * HDaudio does not follow the default trigger
+		 * HDAudio does not follow the default trigger
 		 * sequence due to firmware implementation
 		 */
 		for_each_dpcm_fe(rtd, SNDRV_PCM_STREAM_PLAYBACK, dpcm) {
-- 
2.25.1

