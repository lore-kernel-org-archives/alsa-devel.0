Return-Path: <SRS0=8vjL=HK=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D629C433E0
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:26:57 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8245560C3F
	for <alsa-devel@archiver.kernel.org>; Mon,  8 Feb 2021 23:26:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8245560C3F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id B224D16A3;
	Tue,  9 Feb 2021 00:26:04 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz B224D16A3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1612826814;
	bh=S3pRv5LwDEfY2Qt+KYpa0ouTiDhZCO81E2UKRd5yH04=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MXkQw5lpDDnsYKS2Kg3OyUVCTGSFECouMJ3WcYXH4KN3aTalN9SyZLCMP2TPMSGYh
	 3+VTeiaJwE0Z5qsXna5WTyQWMExmrvboe3JCHaml+0D1BPVWwZH9PU+CNRMhYUnggO
	 Pt2I3Tj6HDwFe0sgmIk/43dhuQGUtcdw5+CYhVIU=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 57322F802DF;
	Tue,  9 Feb 2021 00:23:56 +0100 (CET)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 33289F80290; Tue,  9 Feb 2021 00:23:53 +0100 (CET)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2C115F80264
 for <alsa-devel@alsa-project.org>; Tue,  9 Feb 2021 00:23:40 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2C115F80264
IronPort-SDR: wUkIXpqMtc1QA5vToFn6LWwfXNc0XVeCdhzDeYME2W16wr+XBx7rR9kWwEFtPqRi03ERsmbmBZ
 fCMSG0R+asUw==
X-IronPort-AV: E=McAfee;i="6000,8403,9889"; a="243295596"
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="243295596"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:22:17 -0800
IronPort-SDR: d8i5SPbqpTcsUcA1Cw6WL8gIFKEJhNppkgt5EVcyGYPRXb+1NGc+go/40biiaRe0dYqe+J81iW
 F69JjjH+v0Xw==
X-IronPort-AV: E=Sophos;i="5.81,163,1610438400"; d="scan'208";a="585854679"
Received: from pmane-mobl.amr.corp.intel.com (HELO pbossart-mobl3.intel.com)
 ([10.209.145.183])
 by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 15:22:16 -0800
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 3/5] ASoC: SOF: remove unused functions
Date: Mon,  8 Feb 2021 17:21:47 -0600
Message-Id: <20210208232149.58899-4-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210208232149.58899-1-pierre-louis.bossart@linux.intel.com>
References: <20210208232149.58899-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
 tiwai@suse.de, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 broonie@kernel.org
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

From: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>

hda_dsp_dump_skl() is never used and hda_dsp_get_status_skl() is
only called from that function. Remove both functions.

Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Keyon Jie <yang.jie@intel.com>
Signed-off-by: Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 50 ---------------------------------------
 sound/soc/sof/intel/hda.h |  1 -
 2 files changed, 51 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 447163494b05..57853ef89cd1 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -317,26 +317,6 @@ static const struct hda_dsp_msg_code hda_dsp_rom_msg[] = {
 	{HDA_DSP_ROM_NULL_FW_ENTRY,	"error: null FW entry point"},
 };
 
-static void hda_dsp_get_status_skl(struct snd_sof_dev *sdev)
-{
-	u32 status;
-	int i;
-
-	status = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
-				  HDA_ADSP_FW_STATUS_SKL);
-
-	for (i = 0; i < ARRAY_SIZE(hda_dsp_rom_msg); i++) {
-		if (status == hda_dsp_rom_msg[i].code) {
-			dev_err(sdev->dev, "%s - code %8.8x\n",
-				hda_dsp_rom_msg[i].msg, status);
-			return;
-		}
-	}
-
-	/* not for us, must be generic sof message */
-	dev_dbg(sdev->dev, "unknown ROM status value %8.8x\n", status);
-}
-
 static void hda_dsp_get_status(struct snd_sof_dev *sdev)
 {
 	u32 status;
@@ -385,36 +365,6 @@ static void hda_dsp_get_registers(struct snd_sof_dev *sdev,
 		       stack_words * sizeof(u32));
 }
 
-void hda_dsp_dump_skl(struct snd_sof_dev *sdev, u32 flags)
-{
-	struct sof_ipc_dsp_oops_xtensa xoops;
-	struct sof_ipc_panic_info panic_info;
-	u32 stack[HDA_DSP_STACK_DUMP_SIZE];
-	u32 status, panic;
-
-	/* try APL specific status message types first */
-	hda_dsp_get_status_skl(sdev);
-
-	/* now try generic SOF status messages */
-	status = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
-				  HDA_ADSP_ERROR_CODE_SKL);
-
-	/*TODO: Check: there is no define in spec, but it is used in the code*/
-	panic = snd_sof_dsp_read(sdev, HDA_DSP_BAR,
-				 HDA_ADSP_ERROR_CODE_SKL + 0x4);
-
-	if (sdev->fw_state == SOF_FW_BOOT_COMPLETE) {
-		hda_dsp_get_registers(sdev, &xoops, &panic_info, stack,
-				      HDA_DSP_STACK_DUMP_SIZE);
-		snd_sof_get_status(sdev, status, panic, &xoops, &panic_info,
-				   stack, HDA_DSP_STACK_DUMP_SIZE);
-	} else {
-		dev_err(sdev->dev, "error: status = 0x%8.8x panic = 0x%8.8x\n",
-			status, panic);
-		hda_dsp_get_status_skl(sdev);
-	}
-}
-
 /* dump the first 8 dwords representing the extended ROM status */
 static void hda_dsp_dump_ext_rom_status(struct snd_sof_dev *sdev, u32 flags)
 {
diff --git a/sound/soc/sof/intel/hda.h b/sound/soc/sof/intel/hda.h
index 488c0ace4d28..d1c38c37bc9d 100644
--- a/sound/soc/sof/intel/hda.h
+++ b/sound/soc/sof/intel/hda.h
@@ -518,7 +518,6 @@ int hda_dsp_runtime_suspend(struct snd_sof_dev *sdev);
 int hda_dsp_runtime_resume(struct snd_sof_dev *sdev);
 int hda_dsp_runtime_idle(struct snd_sof_dev *sdev);
 int hda_dsp_set_hw_params_upon_resume(struct snd_sof_dev *sdev);
-void hda_dsp_dump_skl(struct snd_sof_dev *sdev, u32 flags);
 void hda_dsp_dump(struct snd_sof_dev *sdev, u32 flags);
 void hda_ipc_dump(struct snd_sof_dev *sdev);
 void hda_ipc_irq_dump(struct snd_sof_dev *sdev);
-- 
2.25.1

