Return-Path: <alsa-devel-bounces@alsa-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C41CCC433FE
	for <alsa-devel@archiver.kernel.org>; Thu, 20 Oct 2022 12:16:26 +0000 (UTC)
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id DE6CC5847;
	Thu, 20 Oct 2022 14:15:34 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz DE6CC5847
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1666268184;
	bh=lbDTuFhXq1Beu2IjeSfbGmZ4RLHgB7pjKsxHsWK6g9Q=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BcV8Qyx/6+akZZgwvxuhk+s5F/GOMGcj0agqgdb9+3QkliQVBS+sPuH3KiAfwfVCz
	 7gnuSp1JLFHUEX3njNsB6CJLjyYqZBG7OLm5CkF2/DPqniU+NQgf0McfmAhB6mW7jh
	 ma+DOEozkgfv/ZZr+2nbjyCN9T73iCbbk0Kypnl8=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 8D0C9F805A8;
	Thu, 20 Oct 2022 14:12:56 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5E25FF805BE; Thu, 20 Oct 2022 14:12:55 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CD92AF805A8
 for <alsa-devel@alsa-project.org>; Thu, 20 Oct 2022 14:12:48 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz CD92AF805A8
Authentication-Results: alsa1.perex.cz;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.b="ic9MbXg9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1666267970; x=1697803970;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=lbDTuFhXq1Beu2IjeSfbGmZ4RLHgB7pjKsxHsWK6g9Q=;
 b=ic9MbXg9FZtTbxfuqSWAMDfQXbKTquMshUd4FedqjHxYSJnD2fRUKZeK
 M18XALMIfDakz9pAa3woopgX/QZ+Uw6Rix1TcffRFGzfile8DYpBe5WsE
 UsFbyWJs5L6HqYUB92pHyEjjQlYbqB8YMFq4FmQbEbEigmN/VnI307saH
 OHx7Qtd3d90Q70X34lsTVXzbtl3ZBKXCLr+JIIJqSv7k9VhhzieuH++oZ
 5WHfX26hDyPJBOuYcnRvbkzNIPE2OUXaS8EShWaOaHgJxzstJmQwfPvuh
 UqAy7L354iixSwvPND2dqkTPYXJpvOK6ptekrrl4F0IFjLmugc3hkKIcY w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="333256381"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; d="scan'208";a="333256381"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2022 05:12:47 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10505"; a="663010053"
X-IronPort-AV: E=Sophos;i="5.95,198,1661842800"; d="scan'208";a="663010053"
Received: from awrynn-mobl.ger.corp.intel.com (HELO
 pujfalus-desk.ger.corp.intel.com) ([10.252.12.86])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2022 05:12:45 -0700
From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org
Subject: [PATCH v2 11/19] ASoC: SOF: Add path definition for external firmware
 libraries
Date: Thu, 20 Oct 2022 15:12:30 +0300
Message-Id: <20221020121238.18339-12-peter.ujfalusi@linux.intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221020121238.18339-1-peter.ujfalusi@linux.intel.com>
References: <20221020121238.18339-1-peter.ujfalusi@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: alsa-devel@alsa-project.org, kai.vehmanen@linux.intel.com,
 cezary.rojewski@intel.com, pierre-louis.bossart@linux.intel.com,
 ranjani.sridharan@linux.intel.com, amadeuszx.slawinski@linux.intel.com,
 chao.song@intel.com
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

IPC4 based firmware supports dynamically loaded external libraries.
The libraries will be not stored alongside of the firmware or tplg files.

For intel platforms the default path will be:
intel/avs-lib|sof-ipc4-lib/<platform>/ if a community key is used on the
given machine then the libraries will be under 'community' directory, like
it is done for the firmware itself.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Chao Song <chao.song@intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 include/sound/sof.h           |  6 +++++-
 sound/soc/sof/intel/pci-tgl.c |  3 +++
 sound/soc/sof/sof-pci-dev.c   | 26 ++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/include/sound/sof.h b/include/sound/sof.h
index e1f2f02666a7..266e66318f9c 100644
--- a/include/sound/sof.h
+++ b/include/sound/sof.h
@@ -82,6 +82,9 @@ struct snd_sof_pdata {
 	const char *tplg_filename_prefix;
 	const char *tplg_filename;
 
+	/* loadable external libraries available under this directory */
+	const char *fw_lib_prefix;
+
 	/* machine */
 	struct platform_device *pdev_mach;
 	const struct snd_soc_acpi_mach *machine;
@@ -127,8 +130,9 @@ struct sof_dev_desc {
 	unsigned int ipc_supported_mask;
 	enum sof_ipc_type ipc_default;
 
-	/* defaults paths for firmware and topology files */
+	/* defaults paths for firmware, library and topology files */
 	const char *default_fw_path[SOF_IPC_TYPE_COUNT];
+	const char *default_lib_path[SOF_IPC_TYPE_COUNT];
 	const char *default_tplg_path[SOF_IPC_TYPE_COUNT];
 
 	/* default firmware name */
diff --git a/sound/soc/sof/intel/pci-tgl.c b/sound/soc/sof/intel/pci-tgl.c
index 4cfe4f242fc5..757a7c6bb770 100644
--- a/sound/soc/sof/intel/pci-tgl.c
+++ b/sound/soc/sof/intel/pci-tgl.c
@@ -174,6 +174,9 @@ static const struct sof_dev_desc adl_n_desc = {
 		[SOF_IPC] = "intel/sof",
 		[SOF_INTEL_IPC4] = "intel/avs/adl-n",
 	},
+	.default_lib_path = {
+		[SOF_INTEL_IPC4] = "intel/avs-lib/adl-n",
+	},
 	.default_tplg_path = {
 		[SOF_IPC] = "intel/sof-tplg",
 		[SOF_INTEL_IPC4] = "intel/avs-tplg",
diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index 643fd1036d60..f5ece43d0ec2 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -28,6 +28,10 @@ static char *fw_filename;
 module_param(fw_filename, charp, 0444);
 MODULE_PARM_DESC(fw_filename, "alternate filename for SOF firmware.");
 
+static char *lib_path;
+module_param(lib_path, charp, 0444);
+MODULE_PARM_DESC(lib_path, "alternate path for SOF firmware libraries.");
+
 static char *tplg_path;
 module_param(tplg_path, charp, 0444);
 MODULE_PARM_DESC(tplg_path, "alternate path for SOF topology.");
@@ -272,6 +276,28 @@ int sof_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 			sof_pdata->desc->default_fw_path[sof_pdata->ipc_type];
 	}
 
+	if (lib_path) {
+		sof_pdata->fw_lib_prefix = lib_path;
+
+		dev_dbg(dev, "Module parameter used, changed fw_lib path to %s\n",
+			sof_pdata->fw_lib_prefix);
+
+	} else if (sof_pdata->desc->default_lib_path[sof_pdata->ipc_type]) {
+		if (dmi_check_system(community_key_platforms) && sof_dmi_use_community_key) {
+			sof_pdata->fw_lib_prefix =
+				devm_kasprintf(dev, GFP_KERNEL, "%s/%s",
+					sof_pdata->desc->default_lib_path[sof_pdata->ipc_type],
+					"community");
+
+			dev_dbg(dev,
+				"Platform uses community key, changed fw_lib path to %s\n",
+				sof_pdata->fw_lib_prefix);
+		} else {
+			sof_pdata->fw_lib_prefix =
+				sof_pdata->desc->default_lib_path[sof_pdata->ipc_type];
+		}
+	}
+
 	if (tplg_path)
 		sof_pdata->tplg_filename_prefix = tplg_path;
 	else
-- 
2.38.1

