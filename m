Return-Path: <SRS0=ybvW=5K=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B57C43331
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 22:10:32 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCC82073E
	for <alsa-devel@archiver.kernel.org>; Wed, 25 Mar 2020 22:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="as4kw3U9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCC82073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 8E1D11673;
	Wed, 25 Mar 2020 23:09:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 8E1D11673
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1585174230;
	bh=Rp7h3mOYkUYXzQTO/v27B8S92BnE2F04E86Oz12BJc0=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=as4kw3U92RomJIUTduD8kaynNsOkoHQAU5LM/d0mz7EKFonHmtM7pHi+YlPH/DKRH
	 tXxvGluHREAMlgJhrHrx7Qr5fF2rAoXF6FwpobqbxTRQoA/mer9uKCd1HvlFIZl9Di
	 F6XqXjrOu4D0ekgyurZQj/tPARr35jvEK+FQzp2U=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id F1DEFF80273;
	Wed, 25 Mar 2020 23:08:04 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CC4A5F8015A; Wed, 25 Mar 2020 23:08:00 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 21A45F8015A
 for <alsa-devel@alsa-project.org>; Wed, 25 Mar 2020 23:07:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 21A45F8015A
IronPort-SDR: xkoSF/P03y1LAsKI67CRzY9EH/ygf7f0EZpQkT1mhazZavs+u42X/b7Vc3Wj9tXvX1nglsZXd3
 sRSpq/eQ9PEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Mar 2020 15:07:52 -0700
IronPort-SDR: jzIJiGwM4kTPXYehJ5l04yRXUva3j/YLdkg/rsxrkmi1S/O1Rvz96Jr78DnMGUK/9FT4MaLzM+
 2D1rg38JF0nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,306,1580803200"; d="scan'208";a="238634748"
Received: from abeljans.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.233.195])
 by fmsmga007.fm.intel.com with ESMTP; 25 Mar 2020 15:07:51 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/4] ASoC: Intel: common: add match table for TGL RT5682
 SoundWire driver
Date: Wed, 25 Mar 2020 17:07:45 -0500
Message-Id: <20200325220746.29601-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200325220746.29601-1-pierre-louis.bossart@linux.intel.com>
References: <20200325220746.29601-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Naveen Manohar <naveen.m@intel.com>, broonie@kernel.org,
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

From: Naveen Manohar <naveen.m@intel.com>

RT5682 is in SoundWire mode on link0.

Signed-off-by: Naveen Manohar <naveen.m@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-tgl-match.c   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
index db360c9a8e5b..449d9d2286ae 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -56,6 +56,14 @@ static const struct snd_soc_acpi_adr_device rt1308_1_adr[] = {
 	}
 };
 
+static const struct snd_soc_acpi_adr_device rt5682_0_adr[] = {
+	{
+		.adr = 0x000021025D568200,
+		.num_endpoints = 1,
+		.endpoints = &single_endpoint,
+	}
+};
+
 static const struct snd_soc_acpi_link_adr tgl_i2s_rt1308[] = {
 	{
 		.mask = BIT(0),
@@ -79,6 +87,15 @@ static const struct snd_soc_acpi_link_adr tgl_rvp[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr tgl_chromebook_base[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt5682_0_adr),
+		.adr_d = rt5682_0_adr,
+	},
+	{}
+};
+
 static struct snd_soc_acpi_codecs tgl_max98373_amp = {
 	.num_codecs = 1,
 	.codecs = {"MX98373"}
@@ -122,6 +139,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_sdw_machines[] = {
 		.sof_fw_filename = "sof-tgl.ri",
 		.sof_tplg_filename = "sof-tgl-rt711-rt1308.tplg",
 	},
+	{
+		.link_mask = 0x1, /* this will only enable rt5682 for now */
+		.links = tgl_chromebook_base,
+		.drv_name = "sof_sdw",
+		.sof_fw_filename = "sof-tgl.ri",
+		.sof_tplg_filename = "sof-tgl-rt5682.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_tgl_sdw_machines);
-- 
2.20.1

