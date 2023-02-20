Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4249AC05027
	for <alsa-devel@archiver.kernel.org>; Mon, 20 Feb 2023 08:08:02 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 9F28FEA9;
	Mon, 20 Feb 2023 09:07:10 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 9F28FEA9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1676880480;
	bh=QeVkUaonPmp3Bbsc0IXZe0HfrCEUVqR1uNdlaFyjeNc=;
	h=From:To:Subject:Date:CC:List-Id:List-Archive:List-Help:List-Owner:
	 List-Post:List-Subscribe:List-Unsubscribe:From;
	b=rJY3GXsf2lPGNJ73/pRIe9cyGZ0KJNQzeVkjS9rJB0q2d+1kaeaHBe4xwO4ixr1QA
	 dCSKmyNn/52E2ZElZOm5fP3Ynwda1Dx5w5/cv0ugJ4GafkIPScvNKXGfh5xTAD/2EB
	 5ua5mItOBLGwY+uY6tIQeZ+W39yvm+k2VDo4GIiY=
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 88E40F80266;
	Mon, 20 Feb 2023 09:06:52 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id A0A95F80266; Mon, 20 Feb 2023 09:06:48 +0100 (CET)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 8315FF800B6
	for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2023 09:06:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8315FF800B6
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=INXYZEWd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676880403; x=1708416403;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QeVkUaonPmp3Bbsc0IXZe0HfrCEUVqR1uNdlaFyjeNc=;
  b=INXYZEWd2zesAFlbsVXgZhXnHNCRK4qYmNqg1LcBVxpWfZ+ZRCojDvtR
   NIEt2s0s0WZeYwfS3++xOlMtC4SwJdKrL4OGq5RSK3/j6RcuJ03oHCfFt
   1D5R+4kIO7FI6PRTDtAOTc6FuFkTJ8KMAJ87mVPaUpJ1MOCDFBaZq/XdV
   ubW4ZgZKughei15sUKXZlDVO4zZLCksf3/eKEXP6t88mZdpQmIoWm0S69
   6A4+7cx0sqePEQDbeN3zjo/r3WEhxmjEuILM9xobQuFQRu8w0IR7CBedq
   vdvOIVngwFSAFvKKUxHzubA9NnBlCnatFGClkCIHAWhCeSdfNxHu6HaUS
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="316061773"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000";
   d="scan'208";a="316061773"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2023 00:06:40 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10626"; a="1000183578"
X-IronPort-AV: E=Sophos;i="5.97,311,1669104000";
   d="scan'208";a="1000183578"
Received: from mmocanu-mobl1.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.251.214.33])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Feb 2023 00:06:37 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH] ASoC: Intel: sof_rt5682: Add quirk for Rex board with
 mx98360a amplifier
Date: Mon, 20 Feb 2023 10:06:52 +0200
Message-Id: <20230220080652.23136-1-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: VNH2EN5JU5SDJQUELOXSMUJOMSEKMQRL
X-Message-ID-Hash: VNH2EN5JU5SDJQUELOXSMUJOMSEKMQRL
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
CC: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, dharageswari.r@intel.com,
 kai.vehmanen@linux.intel.com, tiwai@suse.com
X-Mailman-Version: 3.3.8
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/VNH2EN5JU5SDJQUELOXSMUJOMSEKMQRL/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: "Dharageswari.R" <dharageswari.r@intel.com>

Add mtl_mx98360a_rt5682 driver data for Chrome Rex board support.

Signed-off-by: Dharageswari.R <dharageswari.r@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 sound/soc/intel/boards/sof_rt5682.c           | 23 +++++++++++++++++++
 .../intel/common/soc-acpi-intel-mtl-match.c   | 12 ++++++++++
 2 files changed, 35 insertions(+)

diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
index 71a11d747622..4fe448295a90 100644
--- a/sound/soc/intel/boards/sof_rt5682.c
+++ b/sound/soc/intel/boards/sof_rt5682.c
@@ -223,6 +223,20 @@ static const struct dmi_system_id sof_rt5682_quirk_table[] = {
 					SOF_RT5682_SSP_AMP(2) |
 					SOF_RT5682_NUM_HDMIDEV(4)),
 	},
+	{
+		.callback = sof_rt5682_quirk_cb,
+		.matches = {
+			DMI_MATCH(DMI_PRODUCT_FAMILY, "Google_Rex"),
+			DMI_MATCH(DMI_OEM_STRING, "AUDIO-MAX98360_ALC5682I_I2S"),
+		},
+		.driver_data = (void *)(SOF_RT5682_MCLK_EN |
+					SOF_RT5682_SSP_CODEC(2) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
+					SOF_RT5682_SSP_AMP(0) |
+					SOF_RT5682_NUM_HDMIDEV(4)
+					),
+	},
 	{
 		.callback = sof_rt5682_quirk_cb,
 		.matches = {
@@ -1105,6 +1119,15 @@ static const struct platform_device_id board_ids[] = {
 					SOF_RT5682_SSP_AMP(1) |
 					SOF_RT5682_NUM_HDMIDEV(4)),
 	},
+	{
+		.name = "mtl_mx98360_rt5682",
+		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
+					SOF_RT5682_SSP_CODEC(0) |
+					SOF_SPEAKER_AMP_PRESENT |
+					SOF_MAX98360A_SPEAKER_AMP_PRESENT |
+					SOF_RT5682_SSP_AMP(1) |
+					SOF_RT5682_NUM_HDMIDEV(4)),
+	},
 	{
 		.name = "jsl_rt5682",
 		.driver_data = (kernel_ulong_t)(SOF_RT5682_MCLK_EN |
diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
index b1a66a0f6818..7911c3af8071 100644
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -15,6 +15,11 @@ static const struct snd_soc_acpi_codecs mtl_max98357a_amp = {
 	.codecs = {"MX98357A"}
 };
 
+static const struct snd_soc_acpi_codecs mtl_max98360a_amp = {
+	.num_codecs = 1,
+	.codecs = {"MX98360A"}
+};
+
 static const struct snd_soc_acpi_codecs mtl_rt5682_rt5682s_hp = {
 	.num_codecs = 2,
 	.codecs = {"10EC5682", "RTL5682"},
@@ -28,6 +33,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_mtl_machines[] = {
 		.quirk_data = &mtl_max98357a_amp,
 		.sof_tplg_filename = "sof-mtl-max98357a-rt5682.tplg",
 	},
+	{
+		.comp_ids = &mtl_rt5682_rt5682s_hp,
+		.drv_name = "mtl_mx98360_rt5682",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &mtl_max98360a_amp,
+		.sof_tplg_filename = "sof-mtl-max98360a-rt5682.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_mtl_machines);
-- 
2.39.2

