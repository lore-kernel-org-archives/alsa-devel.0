Return-Path: <SRS0=M4Y+=24=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18196C33C8C
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:10:42 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9484C2073D
	for <alsa-devel@archiver.kernel.org>; Tue,  7 Jan 2020 16:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="AcDd0EJb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9484C2073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 654701839;
	Tue,  7 Jan 2020 17:09:48 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 654701839
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1578413438;
	bh=wZRBQtqeQDlwiqyTmEBZwEmFZyyAV0TV0xtvdWuy2dM=;
	h=From:To:Date:In-Reply-To:References:Cc:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AcDd0EJb81nL5zTSnUGZbiDLlobKv7i7Wm+QjetS1OpAgFiXHVPD9PCeXYKxjOaOY
	 GWqqYdaL0A3QREAekzyhrqN3cluc3g7YPRieC4Lvxa4Pv2M6grVMW4g2myJe8Xoeki
	 mC/1R2T9cSEu2ueC9djsR97lwE90kEikyEGZXUJk=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id E1AE8F80213;
	Tue,  7 Jan 2020 17:08:55 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 88386F801F5; Tue,  7 Jan 2020 17:08:54 +0100 (CET)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id D9BC5F8010B
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2020 17:08:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz D9BC5F8010B
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 07 Jan 2020 08:08:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,406,1571727600"; d="scan'208";a="222617618"
Received: from jeruiz1-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.252.199.205])
 by orsmga006.jf.intel.com with ESMTP; 07 Jan 2020 08:08:46 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Date: Tue,  7 Jan 2020 10:08:39 -0600
Message-Id: <20200107160840.1524-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200107160840.1524-1-pierre-louis.bossart@linux.intel.com>
References: <20200107160840.1524-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Cc: tiwai@suse.de, broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [alsa-devel] [PATCH 1/2] ASoC: SOF: pci: change the default
	firmware path when the community key is used
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

Since ApolloLake, Intel platforms require signed firmware. On all
Windows platforms the default is to require the Intel production key
be used. But some platforms allow for a community key to be used,
which allows developers to compile/build their own firmware.

In the linux-firmware tree, the default intel/sof path is used for
firmwares signed for the production key, and files signed with the
community key are located in intel/sof/community.

Since we don't have an API to query which key is used on what
platforms, we have to rely on DMI-based quirks.

Developers can bypass this mechanism by setting a kernel 'fw_path'
module parameter. Additional dynamic debug traces are provided to help
debug cases where the wrong file might be used.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/sof-pci-dev.c | 44 +++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index da7b17e5177b..9993be36d105 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -9,6 +9,7 @@
 //
 
 #include <linux/firmware.h>
+#include <linux/dmi.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/pm_runtime.h>
@@ -36,6 +37,23 @@ MODULE_PARM_DESC(sof_pci_debug, "SOF PCI debug options (0x0 all off)");
 
 #define SOF_PCI_DISABLE_PM_RUNTIME BIT(0)
 
+static const struct dmi_system_id community_key_platforms[] = {
+	{
+		.ident = "Up Squared",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "AAEON"),
+			DMI_MATCH(DMI_BOARD_NAME, "UP-APL01"),
+		}
+	},
+	{
+		.ident = "Google Chromebooks",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Google"),
+		}
+	},
+	{},
+};
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_APOLLOLAKE)
 static const struct sof_dev_desc bxt_desc = {
 	.machines		= snd_soc_acpi_intel_bxt_machines,
@@ -290,12 +308,34 @@ static int sof_pci_probe(struct pci_dev *pci,
 	sof_pdata->dev = dev;
 	sof_pdata->fw_filename = desc->default_fw_filename;
 
+	/*
+	 * for platforms using the SOF community key, change the
+	 * default path automatically to pick the right files from the
+	 * linux-firmware tree. This can be overridden with the
+	 * fw_path kernel parameter, e.g. for developers.
+	 */
+
 	/* alternate fw and tplg filenames ? */
-	if (fw_path)
+	if (fw_path) {
 		sof_pdata->fw_filename_prefix = fw_path;
-	else
+
+		dev_dbg(dev,
+			"Module parameter used, changed fw path to %s\n",
+			sof_pdata->fw_filename_prefix);
+
+	} else if (dmi_check_system(community_key_platforms)) {
+		sof_pdata->fw_filename_prefix =
+			devm_kasprintf(dev, GFP_KERNEL, "%s/%s",
+				       sof_pdata->desc->default_fw_path,
+				       "community");
+
+		dev_dbg(dev,
+			"Platform uses community key, changed fw path to %s\n",
+			sof_pdata->fw_filename_prefix);
+	} else {
 		sof_pdata->fw_filename_prefix =
 			sof_pdata->desc->default_fw_path;
+	}
 
 	if (tplg_path)
 		sof_pdata->tplg_filename_prefix = tplg_path;
-- 
2.20.1

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
