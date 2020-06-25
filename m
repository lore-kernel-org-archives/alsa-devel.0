Return-Path: <SRS0=XzTt=AG=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDF9C433E0
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:16:49 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA37A2065D
	for <alsa-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="XlfrdBeL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA37A2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 713291AA4;
	Thu, 25 Jun 2020 21:15:57 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 713291AA4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1593112607;
	bh=RzKWzdubXTwYyGtOrU+2Z072QP1j39TnRL+tNwmUYZc=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=XlfrdBeLISoceDVey7Iytnmr96+OiN7wwu3VFF4Cr8AQTMPLxeQv9nqJEvV/nTLEQ
	 S4/ABZ9c2UKuxgGQUZtZEeVqID3/NbQKaVxmcJCOLwyniK8upldgUiH7wyoZ5W55oX
	 Ihdpp1SSWLyilONoTzJhGfl8uyI2RzwGL8qCb2ck=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 58A3FF802DB;
	Thu, 25 Jun 2020 21:13:57 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 7F643F80277; Thu, 25 Jun 2020 21:13:51 +0200 (CEST)
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 841CEF802A1
 for <alsa-devel@alsa-project.org>; Thu, 25 Jun 2020 21:13:41 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 841CEF802A1
IronPort-SDR: f3MURBRatfAGzhdfy8kamTZawzcabS4rOtMSOzRPplauSvbK+1w/cq36dB3zei6wjF/oe8zVxd
 UPhTd8f76Bcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9663"; a="144120821"
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; d="scan'208";a="144120821"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 12:13:36 -0700
IronPort-SDR: C428yekoXaXgShdu+a+pdI3LOZ80ovuX6PcavIjIl9qdrKs2lBPqt9SUx0Etafn3USKXXN7Nn0
 afebbttIaBdg==
X-IronPort-AV: E=Sophos;i="5.75,280,1589266800"; d="scan'208";a="354559488"
Received: from zeqimao-mobl.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.254.109.39])
 by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jun 2020 12:13:35 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 05/17] ASoC: Intel: sof_sdw: add quirk override with kernel
 parameter
Date: Thu, 25 Jun 2020 14:12:56 -0500
Message-Id: <20200625191308.3322-6-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200625191308.3322-1-pierre-louis.bossart@linux.intel.com>
References: <20200625191308.3322-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, broonie@kernel.org,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>
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

During the bring-up of new platforms, or to take care of specific
hardware reworks, it's useful to add a kernel parameter to override
the default DMI-based quirks.

For example, adding the following line in a .conf file in
/etc/modprobe.d/ will change the default quirk and log the changes if
dynamic debug is enabled.

options snd_soc_sof_sdw quirk=0x802

[  735.025785] sof_sdw sof_sdw: Overriding quirk 0x10 => 0x802
[  735.025787] sof_sdw sof_sdw: quirk realtek,jack-detect-source 2
[  735.025790] sof_sdw sof_sdw: quirk SOF_RT715_DAI_ID_FIX enabled

Tested on ICL RVP with add-on board instead of default codec.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Reviewed-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index 1bfd9613449e..70ee79a6b8ab 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -15,9 +15,32 @@
 #include "sof_sdw_common.h"
 
 unsigned long sof_sdw_quirk = SOF_RT711_JD_SRC_JD1;
+static int quirk_override = -1;
+module_param_named(quirk, quirk_override, int, 0444);
+MODULE_PARM_DESC(quirk, "Board-specific quirk override");
 
 #define INC_ID(BE, CPU, LINK)	do { (BE)++; (CPU)++; (LINK)++; } while (0)
 
+static void log_quirks(struct device *dev)
+{
+	if (SOF_RT711_JDSRC(sof_sdw_quirk))
+		dev_dbg(dev, "quirk realtek,jack-detect-source %ld\n",
+			SOF_RT711_JDSRC(sof_sdw_quirk));
+	if (sof_sdw_quirk & SOF_SDW_FOUR_SPK)
+		dev_dbg(dev, "quirk SOF_SDW_FOUR_SPK enabled\n");
+	if (sof_sdw_quirk & SOF_SDW_TGL_HDMI)
+		dev_dbg(dev, "quirk SOF_SDW_TGL_HDMI enabled\n");
+	if (sof_sdw_quirk & SOF_SDW_PCH_DMIC)
+		dev_dbg(dev, "quirk SOF_SDW_PCH_DMIC enabled\n");
+	if (SOF_SSP_GET_PORT(sof_sdw_quirk))
+		dev_dbg(dev, "SSP port %ld\n",
+			SOF_SSP_GET_PORT(sof_sdw_quirk));
+	if (sof_sdw_quirk & SOF_RT715_DAI_ID_FIX)
+		dev_dbg(dev, "quirk SOF_RT715_DAI_ID_FIX enabled\n");
+	if (sof_sdw_quirk & SOF_SDW_NO_AGGREGATION)
+		dev_dbg(dev, "quirk SOF_SDW_NO_AGGREGATION enabled\n");
+}
+
 static int sof_sdw_quirk_cb(const struct dmi_system_id *id)
 {
 	sof_sdw_quirk = (unsigned long)id->driver_data;
@@ -915,6 +938,13 @@ static int mc_probe(struct platform_device *pdev)
 
 	dmi_check_system(sof_sdw_quirk_table);
 
+	if (quirk_override != -1) {
+		dev_info(&pdev->dev, "Overriding quirk 0x%lx => 0x%x\n",
+			 sof_sdw_quirk, quirk_override);
+		sof_sdw_quirk = quirk_override;
+	}
+	log_quirks(&pdev->dev);
+
 	INIT_LIST_HEAD(&ctx->hdmi_pcm_list);
 
 	card->dev = &pdev->dev;
-- 
2.20.1

