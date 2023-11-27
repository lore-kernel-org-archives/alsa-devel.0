Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16781C4167B
	for <alsa-devel@archiver.kernel.org>; Mon, 27 Nov 2023 13:37:53 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 7C647828;
	Mon, 27 Nov 2023 14:37:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 7C647828
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1701092271;
	bh=BGzewobdHkUYUwtk4CbkDkwikBpcXtX0cr9sjQzOXO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Tg20E6Yr5CU+3AGhWUfkW1iovFMBiMGbLEK0uVm1wGtnBD4nDdbzHgNCaNsyw3wEs
	 x+5Z+avajILqJTtladw11Y2jQzQp2TAXIa6rdhnTYmSqMEMY6+mhcrW+9Ox0FcXncJ
	 7gRXy0W7LPePDjgwX1pJf50xMIu3VkN0APwiv1Do=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id AADFDF8063A; Mon, 27 Nov 2023 14:36:21 +0100 (CET)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id 7A13DF80637;
	Mon, 27 Nov 2023 14:36:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 52C29F805B0; Mon, 27 Nov 2023 14:36:12 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 70088F8025A
	for <alsa-devel@alsa-project.org>; Mon, 27 Nov 2023 14:36:01 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 70088F8025A
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=P3E87hoI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701092163; x=1732628163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BGzewobdHkUYUwtk4CbkDkwikBpcXtX0cr9sjQzOXO0=;
  b=P3E87hoIiBZUB2A2tSNrTeHCIEkUXsnpdOL58BtXjVflKFWCx7RJ90L3
   Uk8oP7dgZxvg3fEGrkKeskkb2Ojhb0jdQd9/4h9gRQ2ZIausV4c+/krvP
   w2Vs6iqZ9qeEgtvpWY4JWBIcZyNBwh0MyTfEAB9iQXQ/3WqWNqv1AMBbN
   DaFDt3Ys3Uignz3J/vUtQG2Q4uRkCJro0YPNUFAyvAQlHiWgzVOaPj/bc
   Mtf8nzGcrXACJXM08B6mE3Z4MSBD6bbfQbHjDB8ftIYZetjjguuZuwDFZ
   gO6C9pxc5EfrqcpLOayyehqXWTlR4rx4zMAS/78Por4zMWN0z7eQPhL3A
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="391578573"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600";
   d="scan'208";a="391578573"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 05:34:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="891743776"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600";
   d="scan'208";a="891743776"
Received: from acornagl-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.58.144])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2023 05:34:31 -0800
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Cc: alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	ranjani.sridharan@linux.intel.com,
	cezary.rojewski@intel.com,
	yung-chuan.liao@linux.intel.com,
	ckeepax@opensource.cirrus.com,
	yong.zhi@intel.com,
	chao.song@linux.intel.com
Subject: [PATCH 5/7] ASoC: Intel: soc-acpi: add Gen4.1 SDCA board support for
 LNL RVP
Date: Mon, 27 Nov 2023 15:34:46 +0200
Message-ID: <20231127133448.18449-6-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231127133448.18449-1-peter.ujfalusi@linux.intel.com>
References: <20231127133448.18449-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-ID-Hash: UWUTTFCIQOKRFUKRUMRGK3FEY5YSKEZA
X-Message-ID-Hash: UWUTTFCIQOKRFUKRUMRGK3FEY5YSKEZA
X-MailFrom: peter.ujfalusi@linux.intel.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation;
 header-match-alsa-devel.alsa-project.org-0;
 header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
 administrivia; implicit-dest; max-recipients; max-size; news-moderation;
 no-subject; digests; suspicious-header
X-Mailman-Version: 3.3.9
Precedence: list
List-Id: "Alsa-devel mailing list for ALSA developers -
 http://www.alsa-project.org" <alsa-devel.alsa-project.org>
Archived-At: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/UWUTTFCIQOKRFUKRUMRGK3FEY5YSKEZA/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Chao Song <chao.song@linux.intel.com>

This patch adds support for LNL RVP with Realtek
Gen4.1 SDCA codec board, the codec layout is:
  SDW0: RT711 Headphone
  SDW1: RT714 DMIC
  SDW2: RT1316 Speaker
  SDW3: RT1316 Speaker

Signed-off-by: Chao Song <chao.song@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-lnl-match.c   | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-lnl-match.c b/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
index 9f35b77deb11..5897bb6b28b8 100644
--- a/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-lnl-match.c
@@ -22,6 +22,20 @@ static const struct snd_soc_acpi_endpoint single_endpoint = {
 	.group_id = 0,
 };
 
+static const struct snd_soc_acpi_endpoint spk_l_endpoint = {
+	.num = 0,
+	.aggregated = 1,
+	.group_position = 0,
+	.group_id = 1,
+};
+
+static const struct snd_soc_acpi_endpoint spk_r_endpoint = {
+	.num = 0,
+	.aggregated = 1,
+	.group_position = 1,
+	.group_id = 1,
+};
+
 static const struct snd_soc_acpi_adr_device rt711_sdca_0_adr[] = {
 	{
 		.adr = 0x000030025D071101ull,
@@ -31,6 +45,33 @@ static const struct snd_soc_acpi_adr_device rt711_sdca_0_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_adr_device rt1316_2_group1_adr[] = {
+	{
+		.adr = 0x000230025D131601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_l_endpoint,
+		.name_prefix = "rt1316-1"
+	}
+};
+
+static const struct snd_soc_acpi_adr_device rt1316_3_group1_adr[] = {
+	{
+		.adr = 0x000331025D131601ull,
+		.num_endpoints = 1,
+		.endpoints = &spk_r_endpoint,
+		.name_prefix = "rt1316-2"
+	}
+};
+
+static const struct snd_soc_acpi_adr_device rt714_1_adr[] = {
+	{
+		.adr = 0x000130025D071401ull,
+		.num_endpoints = 1,
+		.endpoints = &single_endpoint,
+		.name_prefix = "rt714"
+	}
+};
+
 static const struct snd_soc_acpi_link_adr lnl_rvp[] = {
 	{
 		.mask = BIT(0),
@@ -40,6 +81,30 @@ static const struct snd_soc_acpi_link_adr lnl_rvp[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr lnl_3_in_1_sdca[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt711_sdca_0_adr),
+		.adr_d = rt711_sdca_0_adr,
+	},
+	{
+		.mask = BIT(2),
+		.num_adr = ARRAY_SIZE(rt1316_2_group1_adr),
+		.adr_d = rt1316_2_group1_adr,
+	},
+	{
+		.mask = BIT(3),
+		.num_adr = ARRAY_SIZE(rt1316_3_group1_adr),
+		.adr_d = rt1316_3_group1_adr,
+	},
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(rt714_1_adr),
+		.adr_d = rt714_1_adr,
+	},
+	{}
+};
+
 /* this table is used when there is no I2S codec present */
 struct snd_soc_acpi_mach snd_soc_acpi_intel_lnl_sdw_machines[] = {
 	/* mockup tests need to be first */
@@ -61,6 +126,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_lnl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-lnl-rt715-rt711-rt1308-mono.tplg",
 	},
+	{
+		.link_mask = GENMASK(3, 0),
+		.links = lnl_3_in_1_sdca,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-lnl-rt711-l0-rt1316-l23-rt714-l1.tplg",
+	},
 	{
 		.link_mask = BIT(0),
 		.links = lnl_rvp,
-- 
2.43.0

