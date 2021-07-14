Return-Path: <SRS0=PPjj=MG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A266C07E95
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 03:25:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8881B613AA
	for <alsa-devel@archiver.kernel.org>; Wed, 14 Jul 2021 03:25:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8881B613AA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 1A3A216A5;
	Wed, 14 Jul 2021 05:24:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 1A3A216A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1626233147;
	bh=7VcW85F1U1l4VW/2405A1JBzi2YLIbH1KQCkZfD+kIs=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=tMKlftKGZ3FjOpen0IOA+1tnx1P0eigj9mwgg+pEha/I2Xq00m0PzSN4VFa65/f5j
	 WRvNzpfRTj/J34z65ISpw6XHRU0dk+rKuYNoo3F25dKFrPgeDLm5HxEdfwT1JFW6LF
	 2yh97XXpK8fBPto5BOKgKlAw9RJz2VbsnBDr/DEE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E5462F804EC;
	Wed, 14 Jul 2021 05:22:47 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id C3C4BF804E0; Wed, 14 Jul 2021 05:22:43 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 31DF5F8025B
 for <alsa-devel@alsa-project.org>; Wed, 14 Jul 2021 05:22:36 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 31DF5F8025B
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="232086423"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; d="scan'208";a="232086423"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2021 20:22:33 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; d="scan'208";a="459818155"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2021 20:22:31 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: alsa-devel@alsa-project.org,
	vkoul@kernel.org
Subject: [PATCH 04/10] ASoC: Intel: boards: sof_sdw: add SoundWire mockup
 codecs for tests
Date: Wed, 14 Jul 2021 11:22:03 +0800
Message-Id: <20210714032209.11284-5-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
References: <20210714032209.11284-1-yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, tiwai@suse.de, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, pierre-louis.bossart@linux.intel.com,
 broonie@kernel.org, sanyog.r.kale@intel.com, bard.liao@intel.com
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add support for SoundWire mockup devices. The configurations assume the
same topology as the CML SoundWire devices and can be used to test the
SOF firmware on a development board (RVP, UpExtreme) without any
hardware connected.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/Kconfig   |  1 +
 sound/soc/intel/boards/sof_sdw.c | 41 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index 7e29b0d911e2..046955bf717c 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -602,6 +602,7 @@ config SND_SOC_INTEL_SOUNDWIRE_SOF_MACH
 	select SND_SOC_DMIC
 	select SND_SOC_INTEL_HDA_DSP_COMMON
 	select SND_SOC_INTEL_SOF_MAXIM_COMMON
+	select SND_SOC_SDW_MOCKUP
 	help
 	  Add support for Intel SoundWire-based platforms connected to
 	  MAX98373, RT700, RT711, RT1308 and RT715
diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 1a867c73a48e..82d909ef7a97 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -328,6 +328,19 @@ static const struct snd_soc_ops sdw_ops = {
 	.shutdown = sdw_shutdown,
 };
 
+static int sof_sdw_mic_codec_mockup_init(const struct snd_soc_acpi_link_adr *link,
+					 struct snd_soc_dai_link *dai_links,
+					 struct sof_sdw_codec_info *info,
+					 bool playback)
+{
+	/*
+	 * force DAI link to use same ID as RT715 and DMIC
+	 * to reuse topologies
+	 */
+	dai_links->id = SDW_DMIC_DAI_ID;
+	return 0;
+}
+
 static struct sof_sdw_codec_info codec_info_list[] = {
 	{
 		.part_id = 0x700,
@@ -410,6 +423,34 @@ static struct sof_sdw_codec_info codec_info_list[] = {
 		.dai_name = "rt5682-sdw",
 		.init = sof_sdw_rt5682_init,
 	},
+	{
+		.part_id = 0xaaaa, /* generic codec mockup */
+		.version_id = 0,
+		.direction = {true, true},
+		.dai_name = "sdw-mockup-aif1",
+		.init = NULL,
+	},
+	{
+		.part_id = 0xaa55, /* headset codec mockup */
+		.version_id = 0,
+		.direction = {true, true},
+		.dai_name = "sdw-mockup-aif1",
+		.init = NULL,
+	},
+	{
+		.part_id = 0x55aa, /* amplifier mockup */
+		.version_id = 0,
+		.direction = {true, false},
+		.dai_name = "sdw-mockup-aif1",
+		.init = NULL,
+	},
+	{
+		.part_id = 0x5555,
+		.version_id = 0,
+		.direction = {false, true},
+		.dai_name = "sdw-mockup-aif1",
+		.init = sof_sdw_mic_codec_mockup_init,
+	},
 };
 
 static inline int find_codec_info_part(u64 adr)
-- 
2.17.1

