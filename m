Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DE1C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:37:26 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 322C464E7B
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 322C464E7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A6C2D1694;
	Tue,  9 Feb 2021 00:36:34 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A6C2D1694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612827444;
	bh=Ay5SpFHd9jKD5GWfpbrfANRTeKHYzNU1O9Q7od8f0mI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KqRGXEG6+mHRG0j2Idmi443lY/14ZffrtsPd0sR0ndG9hz7K0+wtrLvUOCfM7/Q7S
	 7UHUX5VCHkLqqreZimXBQdjaVhsy5gfe0/SClyOWkglOnYunhssRn4JV9BOFWFIRlZ
	 n8Ma8Lu7quAum7HV27Sgg4x8bmRrqXNYP5YCCiac=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 67408F8027B;
	Tue,  9 Feb 2021 00:34:17 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id A9064F802E3; Tue,  9 Feb 2021 00:34:13 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8E805F80264
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 00:33:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 8E805F80264
IronPort-SDR: IjLNOJGDIgt5/dmEWo4afp2zzeL0UkOoIPS+NPhHtI3nF0S0P9ok3++7iKZsAr39X3W0z+ulg9
 BR6XcN0Kthuw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="168923508"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="168923508"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:33:56 -0800
IronPort-SDR: /1KdULsNbc3a1rYxJiOaFLdHN8e059c8ar/7dqldNc4FUYDqDXsNszF+PvJQ4BSlUSX6CPn47V
 8gQm7K6+lszQ==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="374741345"
Received: from pmane-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.145.183])
 by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:33:55 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH v2 07/11] ASoC: Intel: soc-acpi: add ACPI matching table for
 HP Spectre x360
Date: Mon,  8 Feb 2021 17:33:32 -0600
Message-Id: <20210208233336.59449-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208233336.59449-1-pierre-louis.bossart@linux.intel.com>
References: <20210208233336.59449-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>,
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Bard Liao <bard.liao@intel.com>
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

This device only has a single amplifier on link1, so we need a
dedicated entry to find a match.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
---
 .../intel/common/soc-acpi-intel-tgl-match.c   | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
index e3ddbf05bf72..40f31c8a3aba 100644
--- a/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-tgl-match.c
@@ -205,6 +205,20 @@ static const struct snd_soc_acpi_link_adr tgl_rvp[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr tgl_hp[] = {
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt711_0_adr),
+		.adr_d = rt711_0_adr,
+	},
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(rt1308_1_single_adr),
+		.adr_d = rt1308_1_single_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_link_adr tgl_chromebook_base[] = {
 	{
 		.mask = BIT(0),
@@ -383,6 +397,12 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_tgl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-tgl-rt711-rt1316-rt714.tplg",
 	},
+	{
+		.link_mask = 0x3, /* rt711 on link 0 and 1 rt1308 on link 1 */
+		.links = tgl_hp,
+		.drv_name = "sof_sdw",
+		.sof_tplg_filename = "sof-tgl-rt711-rt1308.tplg",
+	},
 	{
 		.link_mask = 0x3, /* rt711 on link 0 and 2 rt1308s on link 1 */
 		.links = tgl_rvp,
-- 
2.25.1

