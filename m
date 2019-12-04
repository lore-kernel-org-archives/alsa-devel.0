Return-Path: <SRS0=elh7=Z2=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDD5C43603
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 21:25:48 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88A0B206DF
	for <alsa-devel@archiver.kernel.org>; Wed,  4 Dec 2019 21:25:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="cLILfo1G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88A0B206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DD6001682;
	Wed,  4 Dec 2019 22:24:55 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DD6001682
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1575494746;
	bh=5YbrCNx+annh6yPhtGyvvYSQ8ys5V7tS8HNPBnUfqG8=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cLILfo1GrgF1O8u1aYbHWtj+GsCDFNdl5brnk7NGchkYVahZ2rvyNo2R7m2/VDy0e
	 TN9YtLEkocxEG82ao1yjTedha3Q2fgU5mscOO4SGOLDpVquGnUVHjOE9V7TbI8QQR6
	 k7s175PKqPP/QzodCPI8xn4ES3HS9O6CLDjN3qa0=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 4CA6EF802E0;
	Wed,  4 Dec 2019 22:17:20 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7BD97F801EC; Wed,  4 Dec 2019 22:17:14 +0100 (CET)
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3171CF801EC
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2019 22:16:20 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3171CF801EC
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Dec 2019 13:16:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,278,1571727600"; d="scan'208";a="223378607"
Received: from rgolani-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.251.153.236])
 by orsmga002.jf.intel.com with ESMTP; 04 Dec 2019 13:16:16 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Wed,  4 Dec 2019 15:15:50 -0600
Message-Id: <20191204211556.12671-8-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191204211556.12671-1-pierre-louis.bossart@linux.intel.com>
References: <20191204211556.12671-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH v2 07/13] ASoC: SOF: Introduce
	default_fw_filename member in sof_dev_desc
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Currently the FW filename is obtained from the ACPI matching
table when determining which machine driver to use. In
preparation for making the machine driver ACPI match optional
for Device Tree platforms and moving the machine driver selection
out of the SOF core, this patch introduces the default_fw_filename
member in struct sof_dev_desc.

Once the machine driver selection is moved out of SOF core,
the nocodec_fw_filename will become obsolete and will be removed.

Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/sof.h          | 3 +++
 sound/soc/sof/sof-acpi-dev.c | 5 +++++
 sound/soc/sof/sof-of-dev.c   | 1 +
 sound/soc/sof/sof-pci-dev.c  | 9 +++++++++
 4 files changed, 18 insertions(+)

diff --git a/include/sound/sof.h b/include/sound/sof.h
index 479101736ee0..1723478db4a2 100644
--- a/include/sound/sof.h
+++ b/include/sound/sof.h
@@ -91,6 +91,9 @@ struct sof_dev_desc {
 	const char *default_fw_path;
 	const char *default_tplg_path;
 
+	/* default firmware name */
+	const char *default_fw_filename;
+
 	const struct snd_sof_dsp_ops *ops;
 	const struct sof_arch_ops *arch_ops;
 };
diff --git a/sound/soc/sof/sof-acpi-dev.c b/sound/soc/sof/sof-acpi-dev.c
index df318f50dd0b..22e13ef09811 100644
--- a/sound/soc/sof/sof-acpi-dev.c
+++ b/sound/soc/sof/sof-acpi-dev.c
@@ -45,6 +45,7 @@ static const struct sof_dev_desc sof_acpi_haswell_desc = {
 	.chip_info = &hsw_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
+	.default_fw_filename = "sof-hsw.ri",
 	.nocodec_fw_filename = "sof-hsw.ri",
 	.nocodec_tplg_filename = "sof-hsw-nocodec.tplg",
 	.ops = &sof_hsw_ops,
@@ -62,6 +63,7 @@ static const struct sof_dev_desc sof_acpi_broadwell_desc = {
 	.chip_info = &bdw_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
+	.default_fw_filename = "sof-bdw.ri",
 	.nocodec_fw_filename = "sof-bdw.ri",
 	.nocodec_tplg_filename = "sof-bdw-nocodec.tplg",
 	.ops = &sof_bdw_ops,
@@ -81,6 +83,7 @@ static const struct sof_dev_desc sof_acpi_baytrailcr_desc = {
 	.chip_info = &byt_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
+	.default_fw_filename = "sof-byt.ri",
 	.nocodec_fw_filename = "sof-byt.ri",
 	.nocodec_tplg_filename = "sof-byt-nocodec.tplg",
 	.ops = &sof_byt_ops,
@@ -96,6 +99,7 @@ static const struct sof_dev_desc sof_acpi_baytrail_desc = {
 	.chip_info = &byt_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
+	.default_fw_filename = "sof-byt.ri",
 	.nocodec_fw_filename = "sof-byt.ri",
 	.nocodec_tplg_filename = "sof-byt-nocodec.tplg",
 	.ops = &sof_byt_ops,
@@ -111,6 +115,7 @@ static const struct sof_dev_desc sof_acpi_cherrytrail_desc = {
 	.chip_info = &cht_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
+	.default_fw_filename = "sof-cht.ri",
 	.nocodec_fw_filename = "sof-cht.ri",
 	.nocodec_tplg_filename = "sof-cht-nocodec.tplg",
 	.ops = &sof_cht_ops,
diff --git a/sound/soc/sof/sof-of-dev.c b/sound/soc/sof/sof-of-dev.c
index 28a9692974e5..81deb5582d77 100644
--- a/sound/soc/sof/sof-of-dev.c
+++ b/sound/soc/sof/sof-of-dev.c
@@ -19,6 +19,7 @@ extern struct snd_sof_dsp_ops sof_imx8_ops;
 static struct sof_dev_desc sof_of_imx8qxp_desc = {
 	.default_fw_path = "imx/sof",
 	.default_tplg_path = "imx/sof-tplg",
+	.default_fw_filename = "sof-imx8.ri",
 	.nocodec_fw_filename = "sof-imx8.ri",
 	.nocodec_tplg_filename = "sof-imx8-nocodec.tplg",
 	.ops = &sof_imx8_ops,
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index bbeffd932de7..046bd57657ca 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -47,6 +47,7 @@ static const struct sof_dev_desc bxt_desc = {
 	.chip_info = &apl_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
+	.default_fw_filename = "sof-apl.ri",
 	.nocodec_fw_filename = "sof-apl.ri",
 	.nocodec_tplg_filename = "sof-apl-nocodec.tplg",
 	.ops = &sof_apl_ops,
@@ -65,6 +66,7 @@ static const struct sof_dev_desc glk_desc = {
 	.chip_info = &apl_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
+	.default_fw_filename = "sof-glk.ri",
 	.nocodec_fw_filename = "sof-glk.ri",
 	.nocodec_tplg_filename = "sof-glk-nocodec.tplg",
 	.ops = &sof_apl_ops,
@@ -93,6 +95,7 @@ static const struct sof_dev_desc tng_desc = {
 	.chip_info = &tng_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
+	.default_fw_filename = "sof-byt.ri",
 	.nocodec_fw_filename = "sof-byt.ri",
 	.nocodec_tplg_filename = "sof-byt.tplg",
 	.ops = &sof_tng_ops,
@@ -111,6 +114,7 @@ static const struct sof_dev_desc cnl_desc = {
 	.chip_info = &cnl_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
+	.default_fw_filename = "sof-cnl.ri",
 	.nocodec_fw_filename = "sof-cnl.ri",
 	.nocodec_tplg_filename = "sof-cnl-nocodec.tplg",
 	.ops = &sof_cnl_ops,
@@ -129,6 +133,7 @@ static const struct sof_dev_desc cfl_desc = {
 	.chip_info = &cnl_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
+	.default_fw_filename = "sof-cfl.ri",
 	.nocodec_fw_filename = "sof-cfl.ri",
 	.nocodec_tplg_filename = "sof-cnl-nocodec.tplg",
 	.ops = &sof_cnl_ops,
@@ -149,6 +154,7 @@ static const struct sof_dev_desc cml_desc = {
 	.chip_info = &cnl_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
+	.default_fw_filename = "sof-cml.ri",
 	.nocodec_fw_filename = "sof-cml.ri",
 	.nocodec_tplg_filename = "sof-cnl-nocodec.tplg",
 	.ops = &sof_cnl_ops,
@@ -167,6 +173,7 @@ static const struct sof_dev_desc icl_desc = {
 	.chip_info = &icl_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
+	.default_fw_filename = "sof-icl.ri",
 	.nocodec_fw_filename = "sof-icl.ri",
 	.nocodec_tplg_filename = "sof-icl-nocodec.tplg",
 	.ops = &sof_cnl_ops,
@@ -185,6 +192,7 @@ static const struct sof_dev_desc tgl_desc = {
 	.chip_info = &tgl_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
+	.default_fw_filename = "sof-tgl.ri",
 	.nocodec_fw_filename = "sof-tgl.ri",
 	.nocodec_tplg_filename = "sof-tgl-nocodec.tplg",
 	.ops = &sof_cnl_ops,
@@ -203,6 +211,7 @@ static const struct sof_dev_desc ehl_desc = {
 	.chip_info = &ehl_chip_info,
 	.default_fw_path = "intel/sof",
 	.default_tplg_path = "intel/sof-tplg",
+	.default_fw_filename = "sof-ehl.ri",
 	.nocodec_fw_filename = "sof-ehl.ri",
 	.nocodec_tplg_filename = "sof-ehl-nocodec.tplg",
 	.ops = &sof_cnl_ops,
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
