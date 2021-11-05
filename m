Return-Path: <SRS0=XtK2=PY=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B53C433F5
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Nov 2021 02:29:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C88D6112E
	for <alsa-devel@archiver.kernel.org>; Fri,  5 Nov 2021 02:29:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8C88D6112E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 04472168D;
	Fri,  5 Nov 2021 03:28:07 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 04472168D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1636079338;
	bh=vImfvdFxv/zaBiukdXaJ9NlFxZW6ewv3CYiAPmgVTug=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hDF4QejRON2kkzZWknnghk8pMPq2gf8q58kyFYa1Unv2Ohm+q3dMiTr6cYD13AECf
	 ppLCy7CCXcsKef/ngBg90stomRflOBugpaiHIUQtcZdIhqAd9brEU7Di9cd1tqm8DX
	 1ZFIUAiRTlizNl0rrv3xExMlSB+iOmMyIdzyQpto=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id BF16BF804C3;
	Fri,  5 Nov 2021 03:27:23 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 8AACAF804E7; Fri,  5 Nov 2021 03:27:19 +0100 (CET)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 5110CF8026A
 for <alsa-devel@alsa-project.org>; Fri,  5 Nov 2021 03:27:11 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 5110CF8026A
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="231678125"
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; d="scan'208";a="231678125"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2021 19:27:07 -0700
X-IronPort-AV: E=Sophos;i="5.87,210,1631602800"; d="scan'208";a="501786452"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
 by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2021 19:27:05 -0700
From: Bard Liao <yung-chuan.liao@linux.intel.com>
To: broonie@kernel.org,
	tiwai@suse.de
Subject: [PATCH 2/9] ASoC: Intel: soc-acpi: add SKU 0AF3 SoundWire
 configuration
Date: Fri,  5 Nov 2021 10:26:39 +0800
Message-Id: <20211105022646.26305-3-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211105022646.26305-1-yung-chuan.liao@linux.intel.com>
References: <20211105022646.26305-1-yung-chuan.liao@linux.intel.com>
Cc: alsa-devel@alsa-project.org, pierre-louis.bossart@linux.intel.com,
 bard.liao@intel.com
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

From: Gongjun Song <gongjun.song@intel.com>

New product audio hardware configuration is rt714 on link0,
two rt1316s on link1 and link2

Signed-off-by: Gongjun Song <gongjun.song@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-adl-match.c   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index 06f503452aa5..d8ae94d39d57 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -209,6 +209,25 @@ static const struct snd_soc_acpi_link_adr adl_sdca_3_in_1[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_link_adr adl_sdw_rt1316_link12_rt714_link0[] = {
+	{
+		.mask = BIT(1),
+		.num_adr = ARRAY_SIZE(rt1316_1_group1_adr),
+		.adr_d = rt1316_1_group1_adr,
+	},
+	{
+		.mask = BIT(2),
+		.num_adr = ARRAY_SIZE(rt1316_2_group1_adr),
+		.adr_d = rt1316_2_group1_adr,
+	},
+	{
+		.mask = BIT(0),
+		.num_adr = ARRAY_SIZE(rt714_0_adr),
+		.adr_d = rt714_0_adr,
+	},
+	{}
+};
+
 static const struct snd_soc_acpi_link_adr adl_sdw_rt1316_link2_rt714_link0[] = {
 	{
 		.mask = BIT(2),
@@ -339,6 +358,13 @@ struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_sdw_machines[] = {
 		.drv_name = "sof_sdw",
 		.sof_tplg_filename = "sof-adl-rt711-l0-rt1316-l13-rt714-l2.tplg",
 	},
+	{
+		.link_mask = 0x7, /* rt714 on link0 & two rt1316s on link1 and link2 */
+		.links = adl_sdw_rt1316_link12_rt714_link0,
+		.drv_name = "sof_sdw",
+		.sof_fw_filename = "sof-adl.ri",
+		.sof_tplg_filename = "sof-adl-rt1316-l12-rt714-l0.tplg",
+	},
 	{
 		.link_mask = 0x5, /* 2 active links required */
 		.links = adl_sdw_rt1316_link2_rt714_link0,
-- 
2.17.1

