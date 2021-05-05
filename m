Return-Path: <SRS0=SRJ/=KA=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7788CC433ED
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:47:39 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C53C613FC
	for <alsa-devel@archiver.kernel.org>; Wed,  5 May 2021 16:47:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C53C613FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id CDA021767;
	Wed,  5 May 2021 18:46:46 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz CDA021767
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1620233257;
	bh=AsaRI9L0g5w0cCYfN9robNPe5WBDCJhNf9UjgV6xWK8=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=E6sOVxw0jMFPUfNmeNjhRc+zLg1dhJy7dvdrT1tlEar77TKGF6buSNDKnfxw98E+J
	 ZzCgOSi7FZkp8x7JIuXsp8V9fJY0GlyHfnmE0rOS8KRIGUBQs5h4hX7TEpXNTp+WBf
	 QYLHDhVoNr8zB2/eaPcQYc1BF66enmtFCImX6M4A=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 21B4CF805B5;
	Wed,  5 May 2021 18:37:36 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id BD12DF805BA; Wed,  5 May 2021 18:37:34 +0200 (CEST)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id F37F7F8058C
 for <alsa-devel@alsa-project.org>; Wed,  5 May 2021 18:37:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz F37F7F8058C
IronPort-SDR: vClc0j+9Svljewmr3tGsq+BIMAIiZUGezDYa5xvOE7Lf8CwOscQJRjFnO7JmP31NjMNZyIf/L5
 wLQwPl9zEkfQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9975"; a="196219160"
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; d="scan'208";a="196219160"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2021 09:37:19 -0700
IronPort-SDR: oHxsZzKpTivlhB0kFHXIeVZqW5GA5Ci4+M5AhuIv8UMx4POCagrHbwSu4Ci4p3MgPgT5N6GXDL
 A0IbfI2+4L0Q==
X-IronPort-AV: E=Sophos;i="5.82,276,1613462400"; d="scan'208";a="458800007"
Received: from rtsagpan-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.intel.com) ([10.212.51.38])
 by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2021 09:37:18 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 02/13] ASoC: Intel: soc-acpi: add entries for i2s machines in
 ADL match table
Date: Wed,  5 May 2021 11:36:54 -0500
Message-Id: <20210505163705.305616-3-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210505163705.305616-1-pierre-louis.bossart@linux.intel.com>
References: <20210505163705.305616-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org, Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>,
 Bard Liao <bard.liao@intel.com>
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

From: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>

There are currently 2 customer boards of ADL
Board 1 : RT5682 + MAX98373
Board 2 : RT5682 + MAX98357A

Reviewed-by: Bard Liao <bard.liao@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../intel/common/soc-acpi-intel-adl-match.c   | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/intel/common/soc-acpi-intel-adl-match.c b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
index 692c4c479ed8..39ac6d52106f 100644
--- a/sound/soc/intel/common/soc-acpi-intel-adl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-adl-match.c
@@ -232,7 +232,33 @@ static const struct snd_soc_acpi_link_adr adl_rvp[] = {
 	{}
 };
 
+static const struct snd_soc_acpi_codecs adl_max98373_amp = {
+	.num_codecs = 1,
+	.codecs = {"MX98373"}
+};
+
+static const struct snd_soc_acpi_codecs adl_max98357a_amp = {
+	.num_codecs = 1,
+	.codecs = {"MX98357A"}
+};
+
 struct snd_soc_acpi_mach snd_soc_acpi_intel_adl_machines[] = {
+	{
+		.id = "10EC5682",
+		.drv_name = "adl_max98373_rt5682",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &adl_max98373_amp,
+		.sof_fw_filename = "sof-adl.ri",
+		.sof_tplg_filename = "sof-adl-max98373-rt5682.tplg",
+	},
+	{
+		.id = "10EC5682",
+		.drv_name = "adl_max98357a_rt5682",
+		.machine_quirk = snd_soc_acpi_codec_list,
+		.quirk_data = &adl_max98357a_amp,
+		.sof_fw_filename = "sof-adl.ri",
+		.sof_tplg_filename = "sof-adl-max98357a-rt5682.tplg",
+	},
 	{},
 };
 EXPORT_SYMBOL_GPL(snd_soc_acpi_intel_adl_machines);
-- 
2.25.1

