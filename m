Return-Path: <SRS0=zNzy=JG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F023C433B4
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 22:04:01 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99981610CF
	for <alsa-devel@archiver.kernel.org>; Fri,  9 Apr 2021 22:04:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99981610CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id EBE501694;
	Sat, 10 Apr 2021 00:03:08 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz EBE501694
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1618005839;
	bh=wFirM4FCTNolF1QVetF9b3zGBiumFy4+eU2wfJX+gRI=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Us9oF5/EjzO0n7yXsZgD8m0LaVfcIrY4pn9dn83jU8vtKImjy5//0xuk8ypwEwShN
	 JBs5eIMG4SSCl1Oh3XmDtvCVkESaueYtd/QYCjJOEKYkHxau4w50WODg4axt8RdT6O
	 uUgnHbwWA2E8IzNoZjwcCmqywQHHkErs1VuRsaQw=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 32480F80260;
	Sat, 10 Apr 2021 00:01:53 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id D2B64F80431; Sat, 10 Apr 2021 00:01:50 +0200 (CEST)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id EE288F80162
 for <alsa-devel@alsa-project.org>; Sat, 10 Apr 2021 00:01:40 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz EE288F80162
IronPort-SDR: ogjBV2ATX2ozYEKBJKXae1zMu+o5B7hVeYMo9VFdbUqOYaxvhtzY3ZLCQuJjyIbKzVtOSkyXEX
 a7491gNjmbig==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="214284730"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="214284730"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 15:01:37 -0700
IronPort-SDR: oTEMVFqbH0lsalEd4AqA7SL0rMXvxLk22Wpfy9/yxnqyXGytxEZMx6IdpkgWXSyHlQycWFcR9B
 6cQL8F7MdiZQ==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; d="scan'208";a="599290630"
Received: from ukorat-mobl2.amr.corp.intel.com (HELO rsridh-mobl1.localdomain)
 ([10.212.104.152])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Apr 2021 15:01:36 -0700
From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/6] ASoC: SOF: change signature of set_mach_params() callback
Date: Fri,  9 Apr 2021 15:01:18 -0700
Message-Id: <20210409220121.1542362-4-ranjani.sridharan@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210409220121.1542362-1-ranjani.sridharan@linux.intel.com>
References: <20210409220121.1542362-1-ranjani.sridharan@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Daniel Baluta <daniel.baluta@gmail.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, tiwai@suse.de,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>, broonie@kernel.org
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

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

To set additional parameters, we need to have access to sdev, not the
plain vanilla struct device pointer.

No functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Daniel Baluta <daniel.baluta@gmail.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
---
 sound/soc/sof/intel/bdw.c |  4 ++--
 sound/soc/sof/intel/byt.c | 18 +++++++++---------
 sound/soc/sof/intel/hda.c |  4 ++--
 sound/soc/sof/intel/hda.h |  2 +-
 sound/soc/sof/ops.h       |  6 ++----
 sound/soc/sof/sof-audio.c |  4 ++--
 sound/soc/sof/sof-priv.h  |  2 +-
 7 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/sound/soc/sof/intel/bdw.c b/sound/soc/sof/intel/bdw.c
index fd5ae628732d..28e049ac9c5e 100644
--- a/sound/soc/sof/intel/bdw.c
+++ b/sound/soc/sof/intel/bdw.c
@@ -559,12 +559,12 @@ static void bdw_machine_select(struct snd_sof_dev *sdev)
 }
 
 static void bdw_set_mach_params(const struct snd_soc_acpi_mach *mach,
-				struct device *dev)
+				struct snd_sof_dev *sdev)
 {
 	struct snd_soc_acpi_mach_params *mach_params;
 
 	mach_params = (struct snd_soc_acpi_mach_params *)&mach->mach_params;
-	mach_params->platform = dev_name(dev);
+	mach_params->platform = dev_name(sdev->dev);
 }
 
 /* Broadwell DAIs */
diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 2846fdec9d95..bed26d96dc50 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -427,15 +427,6 @@ static void byt_machine_select(struct snd_sof_dev *sdev)
 	sof_pdata->machine = mach;
 }
 
-static void byt_set_mach_params(const struct snd_soc_acpi_mach *mach,
-				struct device *dev)
-{
-	struct snd_soc_acpi_mach_params *mach_params;
-
-	mach_params = (struct snd_soc_acpi_mach_params *)&mach->mach_params;
-	mach_params->platform = dev_name(dev);
-}
-
 /* Baytrail DAIs */
 static struct snd_soc_dai_driver byt_dai[] = {
 {
@@ -506,6 +497,15 @@ static struct snd_soc_dai_driver byt_dai[] = {
 },
 };
 
+static void byt_set_mach_params(const struct snd_soc_acpi_mach *mach,
+				struct snd_sof_dev *sdev)
+{
+	struct snd_soc_acpi_mach_params *mach_params;
+
+	mach_params = (struct snd_soc_acpi_mach_params *)&mach->mach_params;
+	mach_params->platform = dev_name(sdev->dev);
+}
+
 /*
  * Probe and remove.
  */
diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 5317dfa4a4bf..065b85285450 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -1213,12 +1213,12 @@ static int hda_sdw_machine_select(struct snd_sof_dev *sdev)
 #endif
 
 void hda_set_mach_params(const struct snd_soc_acpi_mach *mach,
-			 struct device *dev)
+			 struct snd_sof_dev *sdev)
 {
 	struct snd_soc_acpi_mach_params *mach_params;
 
 	mach_params = (struct snd_soc_acpi_mach_params *)&mach->mach_params;
-	mach_params->platform = dev_name(dev);
+	mach_params->platform = dev_name(sdev->dev);
 }
 
 void hda_machine_select(struct snd_sof_dev *sdev)
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index ae80725b0e33..4d44f8910393 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -763,7 +763,7 @@ extern const struct sof_intel_dsp_desc adls_chip_info;
 /* machine driver select */
 void hda_machine_select(struct snd_sof_dev *sdev);
 void hda_set_mach_params(const struct snd_soc_acpi_mach *mach,
-			 struct device *dev);
+			 struct snd_sof_dev *sdev);
 
 /* PCI driver selection and probe */
 int hda_pci_intel_probe(struct pci_dev *pci, const struct pci_device_id *pci_id);
diff --git a/sound/soc/sof/ops.h b/sound/soc/sof/ops.h
index 5099ad03df72..323a0b3f561b 100644
--- a/sound/soc/sof/ops.h
+++ b/sound/soc/sof/ops.h
@@ -497,12 +497,10 @@ snd_sof_machine_select(struct snd_sof_dev *sdev)
 
 static inline void
 snd_sof_set_mach_params(const struct snd_soc_acpi_mach *mach,
-			struct device *dev)
+			struct snd_sof_dev *sdev)
 {
-	struct snd_sof_dev *sdev = dev_get_drvdata(dev);
-
 	if (sof_ops(sdev) && sof_ops(sdev)->set_mach_params)
-		sof_ops(sdev)->set_mach_params(mach, dev);
+		sof_ops(sdev)->set_mach_params(mach, sdev);
 }
 
 static inline const struct snd_sof_dsp_ops
diff --git a/sound/soc/sof/sof-audio.c b/sound/soc/sof/sof-audio.c
index 928d7a46d820..5d13bafd4736 100644
--- a/sound/soc/sof/sof-audio.c
+++ b/sound/soc/sof/sof-audio.c
@@ -475,7 +475,7 @@ int sof_machine_check(struct snd_sof_dev *sdev)
 	/* find machine */
 	snd_sof_machine_select(sdev);
 	if (sof_pdata->machine) {
-		snd_sof_set_mach_params(sof_pdata->machine, sdev->dev);
+		snd_sof_set_mach_params(sof_pdata->machine, sdev);
 		return 0;
 	}
 
@@ -500,7 +500,7 @@ int sof_machine_check(struct snd_sof_dev *sdev)
 		return ret;
 
 	sof_pdata->machine = mach;
-	snd_sof_set_mach_params(sof_pdata->machine, sdev->dev);
+	snd_sof_set_mach_params(sof_pdata->machine, sdev);
 
 	return 0;
 }
diff --git a/sound/soc/sof/sof-priv.h b/sound/soc/sof/sof-priv.h
index ad0d7ba2708c..fd8423172d8f 100644
--- a/sound/soc/sof/sof-priv.h
+++ b/sound/soc/sof/sof-priv.h
@@ -259,7 +259,7 @@ struct snd_sof_dsp_ops {
 				   void *pdata); /* optional */
 	void (*machine_select)(struct snd_sof_dev *sdev); /* optional */
 	void (*set_mach_params)(const struct snd_soc_acpi_mach *mach,
-				struct device *dev); /* optional */
+				struct snd_sof_dev *sdev); /* optional */
 
 	/* DAI ops */
 	struct snd_soc_dai_driver *drv;
-- 
2.25.1

