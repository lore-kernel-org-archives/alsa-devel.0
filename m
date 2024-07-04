Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0545CC30653
	for <alsa-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:00:55 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id E3BF814F2;
	Thu,  4 Jul 2024 11:00:42 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz E3BF814F2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1720083652;
	bh=tOZ91IT2s8wpY7yLumZ5kw412vfzz4MXb5MVorwZxpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Archive:List-Help:List-Owner:List-Post:List-Subscribe:
	 List-Unsubscribe:From;
	b=Ldx0Gw9qhDEBtjjem9giUyb0NaM/PwZ2QBaT8MWfS1gjyed77IpzaWrWA0+w6qVwS
	 CeEvWuLnbdV0yjUwv5Fq23tZPD/IWnw7BPhne03cqbFVBrMy8CvrowZnBj4JPBN0Gk
	 2pH4m3CHWpqIV57SMMAmfB8Z8wgajowiDalIlR3E=
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id 00DE5F806CD; Thu,  4 Jul 2024 10:59:05 +0200 (CEST)
Received: from mailman-core.alsa-project.org (mailman-core.alsa-project.org [10.254.200.10])
	by alsa1.perex.cz (Postfix) with ESMTP id E7AA4F80680;
	Thu,  4 Jul 2024 10:59:04 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
	id E3EC4F8025E; Thu,  4 Jul 2024 10:56:15 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by alsa1.perex.cz (Postfix) with ESMTPS id 4FD1DF80272
	for <alsa-devel@alsa-project.org>; Thu,  4 Jul 2024 10:54:00 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 4FD1DF80272
Authentication-Results: alsa1.perex.cz;
	dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=Q5kzhe5f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720083243; x=1751619243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tOZ91IT2s8wpY7yLumZ5kw412vfzz4MXb5MVorwZxpY=;
  b=Q5kzhe5fqYyBGYm8f7DibuWJlOibZRyVEkSEjVxxn/zZ9Q1Id1ld/nQM
   I+hoFoSTREl+6x1877t2FlLO7cLZ6sUQM+movjC2g1jiOF562gra73klQ
   u97lu4Lui84hKisNmDF/4PpBnCDkOeGR9wWiagLIhPDXqD+KD8azsSbxx
   C3xkQimEuI5uoGuB4GlkRlHxLxljeJv4VdY3t0iSU4ndlQyetgaEqO90S
   PmqIH+QSAnI7mM0FgRwZbxLqkHsTWp4qK3C1RVbo+dtRbdFpFGgauIQk6
   zOK33itvg4OG0cx3w9vhbzKLiGl/sNqe4PP1Z0e5sX2w4s2tLMLuEdlsG
   Q==;
X-CSE-ConnectionGUID: vJaPJvyCQweOehgxWA3RTQ==
X-CSE-MsgGUID: BanUyHRcSm+vNlymdMhSrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11122"; a="17300618"
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800";
   d="scan'208";a="17300618"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 01:54:00 -0700
X-CSE-ConnectionGUID: feaz4qYQTZSFUs4KYcU5Eg==
X-CSE-MsgGUID: eo2k59IXTn+ivr9a3pStTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,183,1716274800";
   d="scan'208";a="51708576"
Received: from bergbenj-mobl1.ger.corp.intel.com (HELO
 pbossart-mobl6.intel.com) ([10.245.246.90])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jul 2024 01:53:54 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: linux-sound@vger.kernel.org
Cc: alsa-devel@alsa-project.org,
	tiwai@suse.de,
	broonie@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	=?UTF-8?q?P=C3=A9ter=20Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 4/6] ASoC: Intel: soc-acpi-intel-ptl-match: add rt711-sdca
 table
Date: Thu,  4 Jul 2024 10:53:28 +0200
Message-ID: <20240704085330.371332-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704085330.371332-1-pierre-louis.bossart@linux.intel.com>
References: <20240704085330.371332-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Message-ID-Hash: F6KLFOHDRVTYNYPK7RUVTVBUKT3M5OTZ
X-Message-ID-Hash: F6KLFOHDRVTYNYPK7RUVTVBUKT3M5OTZ
X-MailFrom: pierre-louis.bossart@linux.intel.com
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
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/message/F6KLFOHDRVTYNYPK7RUVTVBUKT3M5OTZ/>
List-Archive: 
 <https://mailman.alsa-project.org/hyperkitty/list/alsa-devel@alsa-project.org/>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>

From: Bard Liao <yung-chuan.liao@linux.intel.com>

Add rt711-sdca on sdw link0.

Reviewed-by: Péter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-ptl-match.c   | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
index dba45fa7a453..ce4234fd3895 100644
--- a/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-ptl-match.c
@@ -15,6 +15,31 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_machines[] = {
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_ptl_machines);
 
+static const struct snd_soc_acpi_endpoint single_endpoint = {
+	.num = 0,
+	.aggregated = 0,
+	.group_position = 0,
+	.group_id = 0,
+};
+
+static const struct snd_soc_acpi_adr_device rt711_sdca_0_adr[] = {
+	{
+		.adr = 0x000030025D071101ull,
+		.num_endpoints = 1,
+		.endpoints = &single_endpoint,
+		.name_prefix = "rt711"
+	}
+};
+
+static const struct snd_soc_acpi_link_adr ptl_rvp[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt711_sdca_0_adr),
+		.adr_d = rt711_sdca_0_adr,
+	},
+	{}
+};
+
 /* this table is used when there is no I2S codec present */
 struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_sdw_machines[] = {
 	/* mockup tests need to be first */
@@ -36,6 +61,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_ptl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-ptl-rt715-rt711-rt1308-mono.tplg",
 	},
+	{
+		.link_mask = BIT(0),
+		.links = ptl_rvp,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-ptl-rt711.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_ptl_sdw_machines);
-- 
2.43.0

