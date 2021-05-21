Return-Path: <SRS0=n5wC=KQ=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 226D6C433B4
	for <alsa-devel@archiver.kernel.org>; Fri, 21 May 2021 09:37:21 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 791F76135A
	for <alsa-devel@archiver.kernel.org>; Fri, 21 May 2021 09:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 791F76135A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id 00F9116C7;
	Fri, 21 May 2021 11:36:29 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz 00F9116C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1621589839;
	bh=aCGksCZMzrWs8SiWNO8x8q74PYNytQMmT0egNG9SQfg=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qf33VhWbHgLRaY3yV+B352clJlM72uZjrtVJmVrsSpl8HC48Ezpa5J0Jm/hmC4ktp
	 ARJQSNYUANmREL+DVQuK4k6ztszAusUAJlCk/ghORdEQ4G8YbdyCGZzR3a/IJVci+d
	 05abrPIioxrpfk57Lfr0ui/6rCZPoigrj0Ug/t94=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 035D2F804D1;
	Fri, 21 May 2021 11:33:35 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 1A0D7F804D8; Fri, 21 May 2021 11:33:34 +0200 (CEST)
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2872EF80475
 for <alsa-devel@alsa-project.org>; Fri, 21 May 2021 11:33:26 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 2872EF80475
IronPort-SDR: 6Iz2lwAelwj9JQBVacVC8WEzEZZX2NcR8ko4MXA/WgGTblP1j3ptEEOAzthNnylhZVCa/blGG5
 JseRx5oXbSsw==
X-IronPort-AV: E=McAfee;i="6200,9189,9990"; a="262664204"
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="262664204"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 May 2021 02:33:26 -0700
IronPort-SDR: HduTgqXVj7abXYP6uONxio2YsvUx7oSgkfYy9iP7YJsRPDTxidZgTgGTfOLEpj1Jk9buXpTUdc
 1m4Y60PWO+xw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,313,1613462400"; d="scan'208";a="475640897"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
 by fmsmga002.fm.intel.com with ESMTP; 21 May 2021 02:33:24 -0700
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
To: alsa-devel@alsa-project.org,
	broonie@kernel.org
Subject: [PATCH 7/7] ASoC: SOF: Intel: hda: Remove conditions against
 CONFIG_PCI
Date: Fri, 21 May 2021 12:28:04 +0300
Message-Id: <20210521092804.3721324-8-kai.vehmanen@linux.intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210521092804.3721324-1-kai.vehmanen@linux.intel.com>
References: <20210521092804.3721324-1-kai.vehmanen@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: kai.vehmanen@linux.intel.com, yung-chuan.liao@linux.intel.com,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, lgirdwood@gmail.com,
 pierre-louis.bossart@linux.intel.com, ranjani.sridharan@linux.intel.com,
 daniel.baluta@nxp.com
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

From: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

The HDA support can only be compiled when SND_SOC_SOF_PCI is enabled which
depends on CONFIG_PCI.

This makes the IS_ENABLED(CONFIG_PCI) checks redundant in the code, they
will resolve to true all the time.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>
---
 sound/soc/sof/intel/hda.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/intel/hda.c b/sound/soc/sof/intel/hda.c
index 5658e4b6273d..126232a76a10 100644
--- a/sound/soc/sof/intel/hda.c
+++ b/sound/soc/sof/intel/hda.c
@@ -277,10 +277,12 @@ struct hda_dsp_msg_code {
 	const char *msg;
 };
 
-static bool hda_use_msi = IS_ENABLED(CONFIG_PCI);
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_DEBUG)
+static bool hda_use_msi = true;
 module_param_named(use_msi, hda_use_msi, bool, 0444);
 MODULE_PARM_DESC(use_msi, "SOF HDA use PCI MSI mode");
+#else
+#define hda_use_msi	(1)
 #endif
 
 static char *hda_model;
@@ -485,9 +487,7 @@ static int hda_init(struct snd_sof_dev *sdev)
 
 	/* initialise hdac bus */
 	bus->addr = pci_resource_start(pci, 0);
-#if IS_ENABLED(CONFIG_PCI)
 	bus->remap_addr = pci_ioremap_bar(pci, 0);
-#endif
 	if (!bus->remap_addr) {
 		dev_err(bus->dev, "error: ioremap error\n");
 		return -ENXIO;
@@ -799,9 +799,7 @@ int hda_dsp_probe(struct snd_sof_dev *sdev)
 		goto hdac_bus_unmap;
 
 	/* DSP base */
-#if IS_ENABLED(CONFIG_PCI)
 	sdev->bar[HDA_DSP_BAR] = pci_ioremap_bar(pci, HDA_DSP_BAR);
-#endif
 	if (!sdev->bar[HDA_DSP_BAR]) {
 		dev_err(sdev->dev, "error: ioremap error\n");
 		ret = -ENXIO;
-- 
2.31.0

