Return-Path: <SRS0=6DhY=7I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90715C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 20:38:43 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5AC207CB
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 20:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="Op7nBWag"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5AC207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 0FE1B1775;
	Tue, 26 May 2020 22:37:51 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 0FE1B1775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590525521;
	bh=59pID7u+TJ440DqeaHqm4DkFHAGqt0+raVHcdGXVTIc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Op7nBWagL5lOLCCf/VHong/H2ZGuZH5NkKu0E+rvv0114+RPtEf6A644UkNA+bcXf
	 /AHY8qk92PMNc/s0DrW7xqc+DjmFpay4+ltyHcWb5jkGfxTbVC8vsLDHkLCvN9AJhO
	 v946VAJ4Antrl/7yBGDodoSGbEVJ0OsTYD5X9zmE=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 09ABDF80100;
	Tue, 26 May 2020 22:37:02 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id CDF1DF80299; Tue, 26 May 2020 22:36:59 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 9A2AAF80131
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2020 22:36:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 9A2AAF80131
IronPort-SDR: 5weGWO9S1gzlWl2gNA6MLxeSn8iC5XEuTL8/iItAOSJJmPaRU2f6l7Wt1Q/ejbCbBRLx142xRu
 s370CTEVKidQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 13:36:48 -0700
IronPort-SDR: 0Abt75TlpTE+P3VBmayFgNqfW/UsYEgSyabscLNsRAz4o0oQ9H8Qw3BrfJiIFEcRYfqwHJjAXV
 iXfhxBu103SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; d="scan'208";a="270208868"
Received: from lfnguyen-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.229.61])
 by orsmga006.jf.intel.com with ESMTP; 26 May 2020 13:36:47 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 1/8] ASoC: SOF: Intel: byt: Add PM callbacks
Date: Tue, 26 May 2020 15:36:33 -0500
Message-Id: <20200526203640.25980-2-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200526203640.25980-1-pierre-louis.bossart@linux.intel.com>
References: <20200526203640.25980-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 broonie@kernel.org, Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
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

From: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>

Add the PM callbacks for BYT/CHT platforms.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Signed-off-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/sof/intel/byt.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/sound/soc/sof/intel/byt.c b/sound/soc/sof/intel/byt.c
index 3747f2c2c28b..457da8fcc6a0 100644
--- a/sound/soc/sof/intel/byt.c
+++ b/sound/soc/sof/intel/byt.c
@@ -428,6 +428,34 @@ static void byt_set_mach_params(const struct snd_soc_acpi_mach *mach,
 	mach_params->platform = dev_name(dev);
 }
 
+static void byt_reset_dsp_disable_int(struct snd_sof_dev *sdev)
+{
+	/* Disable Interrupt from both sides */
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRX, 0x3, 0x3);
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRD, 0x3, 0x3);
+
+	/* Put DSP into reset, set reset vector */
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_CSR,
+				  SHIM_BYT_CSR_RST | SHIM_BYT_CSR_VECTOR_SEL,
+				  SHIM_BYT_CSR_RST | SHIM_BYT_CSR_VECTOR_SEL);
+}
+
+static int byt_suspend(struct snd_sof_dev *sdev, u32 target_state)
+{
+	byt_reset_dsp_disable_int(sdev);
+
+	return 0;
+}
+
+static int byt_resume(struct snd_sof_dev *sdev)
+{
+	/* Enable Interrupt from both sides */
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRX, 0x3, 0x0);
+	snd_sof_dsp_update_bits64(sdev, BYT_DSP_BAR, SHIM_IMRD, 0x3, 0x0);
+
+	return 0;
+}
+
 /* Baytrail DAIs */
 static struct snd_soc_dai_driver byt_dai[] = {
 {
@@ -832,6 +860,10 @@ const struct snd_sof_dsp_ops sof_byt_ops = {
 	/*Firmware loading */
 	.load_firmware	= snd_sof_load_firmware_memcpy,
 
+	/* PM */
+	.suspend = byt_suspend,
+	.resume = byt_resume,
+
 	/* DAI drivers */
 	.drv = byt_dai,
 	.num_drv = 3, /* we have only 3 SSPs on byt*/
@@ -906,6 +938,10 @@ const struct snd_sof_dsp_ops sof_cht_ops = {
 	/*Firmware loading */
 	.load_firmware	= snd_sof_load_firmware_memcpy,
 
+	/* PM */
+	.suspend = byt_suspend,
+	.resume = byt_resume,
+
 	/* DAI drivers */
 	.drv = byt_dai,
 	/* all 6 SSPs may be available for cherrytrail */
-- 
2.20.1

