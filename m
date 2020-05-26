Return-Path: <SRS0=6DhY=7I=alsa-project.org=alsa-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4084C433DF
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 20:39:56 +0000 (UTC)
Received: from alsa0.perex.cz (alsa0.perex.cz [77.48.224.243])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 494B1207CB
	for <alsa-devel@archiver.kernel.org>; Tue, 26 May 2020 20:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alsa-project.org header.i=@alsa-project.org header.b="pbEcTahH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 494B1207CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: from alsa1.perex.cz (alsa1.perex.cz [207.180.221.201])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alsa0.perex.cz (Postfix) with ESMTPS id A58D71759;
	Tue, 26 May 2020 22:39:04 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa0.perex.cz A58D71759
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alsa-project.org;
	s=default; t=1590525594;
	bh=/rD+MCjGukZ/poSfBKWumf2bT6jRqJHgL1fKpIQf5V4=;
	h=From:To:Subject:Date:In-Reply-To:References:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pbEcTahH5i2F19vwoppfL6747nEckEcWWhmjrQoRqni3CMPqqaOyn5S4BrV6NL8Iw
	 l1sA+sjBmaJaJ6kwMiT1tvICoc+KI5lLuNTmcDGw2Nd3ehw+kfXcHpz3tXgX2dIJPm
	 fijxKkA7bnAKB+GQv+dQhbeFM2z0L1YuQcCbs+7o=
Received: from alsa1.perex.cz (localhost.localdomain [127.0.0.1])
	by alsa1.perex.cz (Postfix) with ESMTP id 0495DF8029A;
	Tue, 26 May 2020 22:37:07 +0200 (CEST)
Received: by alsa1.perex.cz (Postfix, from userid 50401)
 id 5F4E6F80291; Tue, 26 May 2020 22:37:03 +0200 (CEST)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A3F34F8015C
 for <alsa-devel@alsa-project.org>; Tue, 26 May 2020 22:36:54 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz A3F34F8015C
IronPort-SDR: To+/troOzF/VtsCmcHT8b1GGs9V8YcV5o9abWhutRrx6lgVAUxg811xdGAhvoyJuybwq5oedoD
 K0ucCvQhJVYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2020 13:36:50 -0700
IronPort-SDR: exctHciOQfTJTPjRB2TpqovvqxYIbpg/8pi1E1JqLvtjGQxvHEDyl/XebEy0uTEU/CZajKsO5Q
 7DajHNv8ThyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,437,1583222400"; d="scan'208";a="270208880"
Received: from lfnguyen-mobl1.amr.corp.intel.com (HELO
 pbossart-mobl3.amr.corp.intel.com) ([10.255.229.61])
 by orsmga006.jf.intel.com with ESMTP; 26 May 2020 13:36:49 -0700
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To: alsa-devel@alsa-project.org
Subject: [PATCH 4/8] ASoC: Intel: byt/cht: add .pm_ops
Date: Tue, 26 May 2020 15:36:36 -0500
Message-Id: <20200526203640.25980-5-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200526203640.25980-1-pierre-louis.bossart@linux.intel.com>
References: <20200526203640.25980-1-pierre-louis.bossart@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc: tiwai@suse.de, Enric Balletbo i Serra <enric.balletbo@collabora.com>,
 broonie@kernel.org,
 Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
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

Add required .pm_ops to support suspend/resume on baytrail/cherrytrail
machines.

This .pm_ops is conditionally-added to avoid impacting the legacy
driver where power management is handled differently.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/boards/bytcht_cx2072x.c      | 3 +++
 sound/soc/intel/boards/bytcht_da7213.c       | 3 +++
 sound/soc/intel/boards/bytcht_es8316.c       | 3 +++
 sound/soc/intel/boards/bytcr_rt5640.c        | 3 +++
 sound/soc/intel/boards/bytcr_rt5651.c        | 3 +++
 sound/soc/intel/boards/cht_bsw_max98090_ti.c | 3 +++
 sound/soc/intel/boards/cht_bsw_nau8824.c     | 3 +++
 sound/soc/intel/boards/cht_bsw_rt5645.c      | 3 +++
 sound/soc/intel/boards/cht_bsw_rt5672.c      | 3 +++
 9 files changed, 27 insertions(+)

diff --git a/sound/soc/intel/boards/bytcht_cx2072x.c b/sound/soc/intel/boards/bytcht_cx2072x.c
index c7f81a93d7c8..fad937610494 100644
--- a/sound/soc/intel/boards/bytcht_cx2072x.c
+++ b/sound/soc/intel/boards/bytcht_cx2072x.c
@@ -261,6 +261,9 @@ static int snd_byt_cht_cx2072x_probe(struct platform_device *pdev)
 static struct platform_driver snd_byt_cht_cx2072x_driver = {
 	.driver = {
 		.name = "bytcht_cx2072x",
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+		.pm = &snd_soc_pm_ops,
+#endif
 	},
 	.probe = snd_byt_cht_cx2072x_probe,
 };
diff --git a/sound/soc/intel/boards/bytcht_da7213.c b/sound/soc/intel/boards/bytcht_da7213.c
index 5e96e7d02733..f3791ff2bad1 100644
--- a/sound/soc/intel/boards/bytcht_da7213.c
+++ b/sound/soc/intel/boards/bytcht_da7213.c
@@ -272,6 +272,9 @@ static int bytcht_da7213_probe(struct platform_device *pdev)
 static struct platform_driver bytcht_da7213_driver = {
 	.driver = {
 		.name = "bytcht_da7213",
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+		.pm = &snd_soc_pm_ops,
+#endif
 	},
 	.probe = bytcht_da7213_probe,
 };
diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
index ddcd070100ef..9e5fc9430628 100644
--- a/sound/soc/intel/boards/bytcht_es8316.c
+++ b/sound/soc/intel/boards/bytcht_es8316.c
@@ -605,6 +605,9 @@ static int snd_byt_cht_es8316_mc_remove(struct platform_device *pdev)
 static struct platform_driver snd_byt_cht_es8316_mc_driver = {
 	.driver = {
 		.name = "bytcht_es8316",
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+		.pm = &snd_soc_pm_ops,
+#endif
 	},
 	.probe = snd_byt_cht_es8316_mc_probe,
 	.remove = snd_byt_cht_es8316_mc_remove,
diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
index d7e42bd9b308..30f70bbdf89c 100644
--- a/sound/soc/intel/boards/bytcr_rt5640.c
+++ b/sound/soc/intel/boards/bytcr_rt5640.c
@@ -1319,6 +1319,9 @@ static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
 static struct platform_driver snd_byt_rt5640_mc_driver = {
 	.driver = {
 		.name = "bytcr_rt5640",
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+		.pm = &snd_soc_pm_ops,
+#endif
 	},
 	.probe = snd_byt_rt5640_mc_probe,
 };
diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
index 0468fc35445f..520e916e329c 100644
--- a/sound/soc/intel/boards/bytcr_rt5651.c
+++ b/sound/soc/intel/boards/bytcr_rt5651.c
@@ -1097,6 +1097,9 @@ static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
 static struct platform_driver snd_byt_rt5651_mc_driver = {
 	.driver = {
 		.name = "bytcr_rt5651",
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+		.pm = &snd_soc_pm_ops,
+#endif
 	},
 	.probe = snd_byt_rt5651_mc_probe,
 };
diff --git a/sound/soc/intel/boards/cht_bsw_max98090_ti.c b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
index 135701738a44..767ac2ae03e2 100644
--- a/sound/soc/intel/boards/cht_bsw_max98090_ti.c
+++ b/sound/soc/intel/boards/cht_bsw_max98090_ti.c
@@ -616,6 +616,9 @@ static int snd_cht_mc_remove(struct platform_device *pdev)
 static struct platform_driver snd_cht_mc_driver = {
 	.driver = {
 		.name = "cht-bsw-max98090",
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+		.pm = &snd_soc_pm_ops,
+#endif
 	},
 	.probe = snd_cht_mc_probe,
 	.remove = snd_cht_mc_remove,
diff --git a/sound/soc/intel/boards/cht_bsw_nau8824.c b/sound/soc/intel/boards/cht_bsw_nau8824.c
index 67b46de2f088..2f7c94d335c1 100644
--- a/sound/soc/intel/boards/cht_bsw_nau8824.c
+++ b/sound/soc/intel/boards/cht_bsw_nau8824.c
@@ -282,6 +282,9 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 static struct platform_driver snd_cht_mc_driver = {
 	.driver = {
 		.name = "cht-bsw-nau8824",
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+		.pm = &snd_soc_pm_ops,
+#endif
 	},
 	.probe = snd_cht_mc_probe,
 };
diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index e64eca56e426..22de138ffa33 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -680,6 +680,9 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 static struct platform_driver snd_cht_mc_driver = {
 	.driver = {
 		.name = "cht-bsw-rt5645",
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+		.pm = &snd_soc_pm_ops,
+#endif
 	},
 	.probe = snd_cht_mc_probe,
 };
diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index 097023a3ec14..7a43c70a1378 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -459,6 +459,9 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 static struct platform_driver snd_cht_mc_driver = {
 	.driver = {
 		.name = "cht-bsw-rt5672",
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_BAYTRAIL)
+		.pm = &snd_soc_pm_ops,
+#endif
 	},
 	.probe = snd_cht_mc_probe,
 };
-- 
2.20.1

